# Nix and Homebrew have their environment variables set for zsh.
sudo -u $env.USER -i zsh -c 'env'
| lines
| filter {|line| $line | str starts-with 'SUDO_' | not $in }
| each {|line| $line | split row -n 2 '=' }
| into record
| reject _ PWD OLDPWD SHLVL
| load-env

$env.HOMEBREW_NO_ENV_HINTS = true
