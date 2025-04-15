# Nix and Homebrew have their environment variables set for zsh.
sudo -u $env.USER -i zsh -c 'export | xargs printf "%s\n"'
| lines
| filter {|line| $line | str contains '=' }
| filter {|line| $line | str starts-with 'SUDO_' | not $in }
| each {|line| $line | split row -n 2 '=' }
| into record
| reject PWD OLDPWD
| load-env

$env.HOMEBREW_NO_ENV_HINTS = true
