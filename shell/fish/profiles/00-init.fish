# Nix have their environment variables set for zsh
for line in (sudo -u $USER -i zsh -c 'env' | grep -v -E '^(SUDO_.*|_|PWD|OLDPWD|SHLVL)=')
  set item (string split -m 1 '=' $line)
  set -gx $item[1] $item[2]
  # echo "Exported key $item[1] = $item[2]"
end

# Homebrew
eval $(/opt/homebrew/bin/brew shellenv)
set -gx HOMEBREW_NO_ENV_HINTS true
# Make it lowest priority in paths
fish_add_path -g --move --append --path /opt/homebrew/bin /opt/homebrew/sbin
