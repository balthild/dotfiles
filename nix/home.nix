{ lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "balthild";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Packages in the user profile.
  home.packages = with pkgs; [
    # Shell
    fish
    elvish
    nushell
    carapace
    starship

    # Generic
    nix-search-cli
    hyfetch-rs
    dotter
    helix
    htop
    ripgrep
    magic-wormhole-rs
    yt-dlp
    ffmpeg-full
    wget
    okular

    # Dev (language-specific)
    rustup
    nodejs
    corepack
    go
    uv
    gcc
    ccls
    typst
    nixd
    nixfmt-rfc-style

    # Dev (generic)
    devenv
    lima
    colima
    docker
    dprint
    watchexec
  ];

  # Environment variables to be set at login.
  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Shells require zsh to export the environment variables set by nix.
  programs.zsh.enable = true;

  # Enable direnv, as well as nix-direnv, which requires modern bash.
  programs.bash.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.activation.okular-droplet = lib.hm.dag.entryAfter [ "installPackages" ] ''
    $DRY_RUN_CMD rm -rf ~/Applications/okular_droplet.app
    $DRY_RUN_CMD cp -r ${pkgs.okular}/libexec/okular_droplet.app ~/Applications/okular_droplet.app
  '';
}
