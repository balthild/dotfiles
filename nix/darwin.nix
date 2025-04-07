{ inputs, config, pkgs, ... }:

{
  # Packages in the system profile.
  environment.systemPackages = with pkgs; [
    coreutils-full
    git
    git-credential-manager
    git-crypt
  ];

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Home Manager requires users being defined here.
  users.users."balthild" = {
    name = "balthild";
    home = "/Users/balthild";
  };

  # Replace nix with lix.
  nix.package = pkgs.lix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Scheduled tasks for the nix store.
  nix.gc.automatic = true;
  nix.optimise.automatic = true;

  # Locale.
  system.defaults.NSGlobalDomain.AppleICUForce24HourTime = true;
  system.defaults.NSGlobalDomain.AppleMeasurementUnits = "Centimeters";
  system.defaults.NSGlobalDomain.AppleTemperatureUnit = "Celsius";
  system.defaults.NSGlobalDomain.AppleMetricUnits = 1;

  # Keyboard.
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 30;
  system.defaults.NSGlobalDomain.KeyRepeat = 2;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;

  # Other.
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.AppleSpacesSwitchOnActivate = false;
}
