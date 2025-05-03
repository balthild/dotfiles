# Nix and Homebrew have their environment variables set for zsh
for line in (sudo -u $USER -i zsh -c 'env' | grep -E -v '^(SUDO_.*|_|PWD|OLDPWD|SHLVL)=')
  set item (string split -m 1 '=' $line)
  set -gx $item[1] $item[2]
  # echo "Exported key $item[1] = $item[2]"
end

set -Ux HOMEBREW_NO_ENV_HINTS true
