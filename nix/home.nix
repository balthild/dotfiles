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
    carapace
    starship

    # Generic
    nix-search-cli
    hyfetch
    fastfetch
    dotter
    helix
    htop
    ripgrep
    magic-wormhole-rs
    yt-dlp
    ffmpeg-full
    wget
    mitmproxy

    # Dev (language-specific)
    rustup
    nodejs
    # https://github.com/NixOS/nixpkgs/issues/482918
    # corepack
    go
    delve
    uv
    clang
    clang-tools
    typst
    nixd
    nixfmt

    # Dev (generic)
    devenv
    colima
    docker
    dprint
    watchexec
    dive
  ];

  # Environment variables to be set at login.
  home.sessionVariables = {
    EDITOR = "hx";
    LIBRARY_PATH = "$HOME/.nix-profile/lib:$LIBRARY_PATH";
    LD_LIBRARY_PATH = "$HOME/.nix-profile/lib:$LD_LIBRARY_PATH";
  };
  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
    "$HOME/.local/share/uv/tools"
    "$HOME/.local/share/npm/global/bin/"
    "$HOME/go/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Set environment variables for the shells.
  programs.bash.enable = true;
  programs.zsh.enable = true;

  # Enable direnv.
  # Note: nix-direnv requires modern bash.
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
