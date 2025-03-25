{ inputs, config, pkgs, ... }:

{
  # Packages in system profile.
  environment.systemPackages = with pkgs; [
    coreutils-full
    git
    git-credential-manager
    git-crypt
  ];

  # Packages in user profiles.
  users.users."balthild".packages = with pkgs; [
    # Shell
    elvish
    carapace
    starship

    # Generic
    dotter
    neovim
    ripgrep
    magic-wormhole-rs
    yt-dlp
    ffmpeg-full
    wget

    # Dev (compilers/runtimes)
    nodejs
    corepack
    go
    uv
    gcc
    ccls
    typst

    # Dev (tools)
    colima
    docker
    dprint
    direnv
    nixfmt
    watchexec
  ];

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
}
