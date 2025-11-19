# Nix and Homebrew have their environment variables set for zsh
for line in (sudo -u $USER -i zsh -c 'env' | grep -v -E '^(SUDO_.*|_|PWD|OLDPWD|SHLVL)=')
  set item (string split -m 1 '=' $line)
  set -gx $item[1] $item[2]
  # echo "Exported key $item[1] = $item[2]"
end

set -gx HOMEBREW_NO_ENV_HINTS true

# Re-add the paths to make them take precedence over Homebrew.
for profile in (string split ' ' $NIX_PROFILES)
  fish_add_path -g --move --prepend "$profile"/bin
end
fish_add_path -g --move --prepend ~/.local/bin
fish_add_path -g --move --prepend ~/.cargo/bin
