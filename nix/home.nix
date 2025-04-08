{ config, pkgs, ... }:

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
    elvish
    carapace
    starship

    # Generic
    nix-search-cli
    hyfetch
    fastfetch
    dotter
    neovim
    ripgrep
    magic-wormhole-rs
    yt-dlp
    ffmpeg-full
    wget

    # Dev (language-specific)
    nodejs
    corepack
    go
    uv
    gcc
    ccls
    typst
    nixfmt-rfc-style

    # Dev (generic)
    direnv
    devenv
    colima
    docker
    dprint
    watchexec
  ];

  # Environment variables to be set at login.
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Elvish requires bash to export the environment variables set by nix.
  programs.bash.enable = true;
  programs.bash.profileExtra = ''
    . "$HOME/.cargo/env"
  '';
}
