// Restore Apple's pointer acceleration curve on Karabiner's virtual pointing device.
//
// With "modify events" on, the pointer is a DriverKit virtual HID device. Its driver publishes no
// HIDAccelCurves, so IOHIDPointerScrollFilter falls back to its compiled-in table instead of
// Apple's parametric curve, and the pointer stops feeling like it did on the physical mouse.
// Writing UserPointerAccelCurvesKey on that service makes the filter rebuild its accelerator with
// the curve we supply.
//
// Only a "typed" event system client may write it: CreateSimpleClient() is refused, the private
// CreateWithType(Monitor) is accepted. No root and no entitlement is involved, so this runs as a
// plain login agent.
//
// Karabiner destroys and recreates the service whenever it reloads its settings, which drops the
// property, so the curve is reapplied on every appearance.
//
// The result cannot be read back from the service itself; verify it with `hidutil dump services`
// (accelerator class IOHIDParametricAcceleration).

#include <CoreFoundation/CoreFoundation.h>
#include <IOKit/hidsystem/IOHIDEventSystemClient.h>
#include <IOKit/hidsystem/IOHIDParameter.h>
#include <IOKit/hidsystem/IOHIDServiceClient.h>
#include <dispatch/dispatch.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

// 16.16 fixed point. These are the entries of a physical mouse's HIDAccelCurves, copied verbatim.
// The filter selects the entry whose index matches the device's HIDPointerAccelerationType, which
// for Karabiner's virtual mouse is HIDMouseAcceleration (98304).
typedef struct {
	int32_t index;
	int32_t gain_linear;
	int32_t gain_parabolic;
	int32_t gain_cubic;
	int32_t gain_quartic;
	int32_t tangent_linear;
	int32_t tangent_parabolic_root;
} CurveEntry;

static const CurveEntry curve[] = {
	{ 0, 65536, 0, 0, 0, 524288, 0 },
	{ 8192, 60293, 26214, 5243, 0, 537395, 1245184 },
	{ 32768, 60948, 36045, 6554, 0, 543949, 1179648 },
	{ 45056, 61604, 46531, 7864, 0, 550502, 1114112 },
	{ 57344, 62259, 57672, 9830, 0, 557056, 1048576 },
	{ 65536, 62915, 69468, 11796, 0, 563610, 983040 },
	{ 98304, 63570, 81920, 14418, 0, 570163, 917504 },
	{ 131072, 64225, 95027, 17695, 0, 576717, 851968 },
	{ 163840, 64881, 108790, 21627, 0, 583270, 786432 },
	{ 196608, 65536, 123208, 26214, 0, 589824, 786432 },
};

typedef IOHIDEventSystemClientRef CreateClientFn(CFAllocatorRef, int, CFDictionaryRef);
typedef void (^MatchingBlock)(void* target, void* context, IOHIDServiceClientRef service);
typedef void RegisterBlockFn(IOHIDEventSystemClientRef, MatchingBlock, void*, void*);
typedef void SetQueueFn(IOHIDEventSystemClientRef, dispatch_queue_t);
typedef void ActivateFn(IOHIDEventSystemClientRef);

extern CreateClientFn IOHIDEventSystemClientCreateWithType;
extern RegisterBlockFn IOHIDEventSystemClientRegisterDeviceMatchingBlock;
extern SetQueueFn IOHIDEventSystemClientSetDispatchQueue;
extern ActivateFn IOHIDEventSystemClientActivate;

// kIOHIDEventSystemClientTypeMonitor.
static const int CLIENT_TYPE_MONITOR = 1;

// MARK: Curve

static void set_entry_value(CFMutableDictionaryRef entry, const char* key, int32_t value) {
	CFStringRef name = CFStringCreateWithCString(NULL, key, kCFStringEncodingUTF8);
	CFNumberRef number = CFNumberCreate(NULL, kCFNumberSInt32Type, &value);

	CFDictionarySetValue(entry, name, number);

	CFRelease(number);
	CFRelease(name);
}

static CFArrayRef build_curve(void) {
	CFMutableArrayRef entries = CFArrayCreateMutable(NULL, 0, &kCFTypeArrayCallBacks);

	for (size_t i = 0; i < sizeof curve / sizeof *curve; i++) {
		const CurveEntry* source = &curve[i];
		CFMutableDictionaryRef entry = CFDictionaryCreateMutable(
			NULL,
			0,
			&kCFTypeDictionaryKeyCallBacks,
			&kCFTypeDictionaryValueCallBacks
		);

		set_entry_value(entry, kHIDAccelIndexKey, source->index);
		set_entry_value(entry, kHIDAccelGainLinearKey, source->gain_linear);
		set_entry_value(entry, kHIDAccelGainParabolicKey, source->gain_parabolic);
		set_entry_value(entry, kHIDAccelGainCubicKey, source->gain_cubic);
		set_entry_value(entry, kHIDAccelGainQuarticKey, source->gain_quartic);
		set_entry_value(entry, kHIDAccelTangentSpeedLinearKey, source->tangent_linear);
		set_entry_value(entry, kHIDAccelTangentSpeedParabolicRootKey, source->tangent_parabolic_root);

		CFArrayAppendValue(entries, entry);
		CFRelease(entry);
	}

	return entries;
}

// MARK: Service

static void copy_product_name(IOHIDServiceClientRef service, char* buffer, size_t size) {
	buffer[0] = '\0';

	CFTypeRef value = IOHIDServiceClientCopyProperty(service, CFSTR("Product"));
	if (value && CFGetTypeID(value) == CFStringGetTypeID()) {
		CFStringGetCString((CFStringRef) value, buffer, size, kCFStringEncodingUTF8);
	}
	if (value) {
		CFRelease(value);
	}
}

static void report(const char* phase, const char* product, Boolean applied) {
	time_t now = time(NULL);
	struct tm local;
	localtime_r(&now, &local);

	fprintf(
		stderr,
		"%02d:%02d:%02d  %s  %s  curve %s\n",
		local.tm_hour,
		local.tm_min,
		local.tm_sec,
		phase,
		product,
		applied ? "applied" : "REFUSED"
	);
}

static void apply_curve(IOHIDServiceClientRef service, CFArrayRef curve, const char* phase) {
	char product[128];
	copy_product_name(service, product, sizeof product);

	if (!strstr(product, "VirtualHIDPointing")) {
		return;
	}

	CFStringRef key = CFSTR("UserPointerAccelCurvesKey");
	Boolean applied = IOHIDServiceClientSetProperty(service, key, curve);

	report(phase, product, applied);
}

// The matching block only fires for services that appear after it is registered, so whatever
// already exists at startup has to be collected separately.
static void apply_existing(IOHIDEventSystemClientRef client, CFArrayRef curve) {
	CFArrayRef services = IOHIDEventSystemClientCopyServices(client);
	if (!services) {
		return;
	}

	for (CFIndex i = 0; i < CFArrayGetCount(services); i++) {
		IOHIDServiceClientRef service = (IOHIDServiceClientRef) CFArrayGetValueAtIndex(services, i);
		apply_curve(service, curve, "present");
	}

	CFRelease(services);
}

// MARK: Main

int main(void) {
	CFArrayRef curve = build_curve();

	IOHIDEventSystemClientRef client =
		IOHIDEventSystemClientCreateWithType(kCFAllocatorDefault, CLIENT_TYPE_MONITOR, NULL);
	if (!client) {
		fprintf(stderr, "Error: cannot create IOHID event system client\n");
		return 1;
	}

	dispatch_queue_t queue = dispatch_queue_create("mouse-accel", DISPATCH_QUEUE_SERIAL);
	IOHIDEventSystemClientSetDispatchQueue(client, queue);

	IOHIDEventSystemClientRegisterDeviceMatchingBlock(
		client,
		^(void* target, void* context, IOHIDServiceClientRef service) {
			(void) target;
			(void) context;
			apply_curve(service, curve, "appeared");
		},
		NULL,
		NULL
	);

	IOHIDEventSystemClientActivate(client);

	dispatch_async(queue, ^{
		apply_existing(client, curve);
	});

	dispatch_main();
}
