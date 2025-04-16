use std/util "path add"

# Nix and Homebrew have their environment variables set for zsh.
sudo -u $env.USER -i zsh -c 'env'
| lines
| filter {|line| $line | str starts-with 'SUDO_' | not $in }
| parse "{name}={value}"
| transpose --header-row --as-record
| reject _ PWD OLDPWD SHLVL
| load-env

path add ~/.local/bin
path add ~/.cargo/bin

$env.HOMEBREW_NO_ENV_HINTS = true
