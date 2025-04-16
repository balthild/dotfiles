use str

# Nix and Homebrew have their environment variables set for zsh.
sudo -u $E:USER -i zsh -c 'env' |
  keep-if {|line| not (str:has-prefix $line 'SUDO_') } |
  each {|line| str:split &max=2 '=' $line | put [(all)] } |
  keep-if {|entry| not (has-value [_ PWD OLDPWD SHLVL] $entry[0]) } |
  each {|entry| set-env $entry[0] $entry[1] }

set-env HOMEBREW_NO_ENV_HINTS true
