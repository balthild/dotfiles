{ inputs, config, pkgs, ... }:

let
  overlays = import ./overlays { inherit inputs; };
in {
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Overlays for custom packages.
  nixpkgs.overlays = [ overlays ];

  # Packages in the system profile.
  environment.systemPackages = with pkgs; [
    coreutils-full
    git
    git-credential-manager
    git-crypt
  ];

  # Home Manager requires users being defined here.
  users.users."balthild" = {
    name = "balthild";
    home = "/Users/balthild";
  };

  # Grant privileges of accessing the nix-daemon.
  nix.settings.trusted-users = [ "root" "@admin" ];

  # Replace nix with lix.
  nix.package = pkgs.lix;

  # Eliminate warnings of "Nix search path entry does not exist".
  nix.channel.enable = false;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Scheduled tasks for the nix store.
  nix.gc.automatic = true;
  nix.optimise.automatic = true;

  # Dock and Mission Control.
  system.defaults.dock.orientation = "left";
  system.defaults.dock.show-recents = false;
  system.defaults.dock.mru-spaces = false;
  system.defaults.dock.expose-group-apps = true;
  system.defaults.dock.wvous-bl-corner = 2;
  system.defaults.dock.wvous-br-corner = 11;
  system.defaults.NSGlobalDomain.AppleSpacesSwitchOnActivate = false;

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
}
