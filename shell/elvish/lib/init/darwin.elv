use lib/utils

# Environment variables from nix
# TODO: https://github.com/LnL7/nix-darwin/issues/1402
sudo -u $E:USER -i zsh -c 'export | xargs printf "%s\n"' | each {|line|
  use str
  if (str:contains $line '=') {
    var name value = (str:split &max=2 '=' $line)
    if (not (str:has-prefix $name SUDO_)) {
      set-env $name $value
    }
  }
}

set-env LD_LIBRARY_PATH ~/.nix-profile/lib

# Homebrew
set-env HOMEBREW_PREFIX /opt/homebrew
set-env HOMEBREW_CELLAR /opt/homebrew/Cellar
set-env HOMEBREW_REPOSITORY /opt/homebrew

utils:append-paths /opt/homebrew/bin
utils:append-paths /opt/homebrew/sbin

set-env MANPATH $E:MANPATH':/opt/homebrew/share/man'
set-env INFOPATH $E:INFOPATH':/opt/homebrew/share/info'

set-env HOMEBREW_NO_ENV_HINTS true
