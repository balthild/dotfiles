use platform
use lib/utils

if (eq $platform:os windows) {
  use init/windows
}

if (eq $platform:os darwin) {
  use init/darwin
}

utils:prepend-paths ~/.local/bin
utils:prepend-paths ~/.cargo/bin
