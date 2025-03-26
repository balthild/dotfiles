use utils

# TODO: https://github.com/LnL7/nix-darwin/issues/1402
zsh -c 'export' | each {|export|
  use str
  use re

  var name value = (str:split &max=2 '=' $export)
  if (re:match '^(PATH)$|^(NIX|XDG)_' $name) {
    set-env $name $value
  }
}

if (has-external direnv) {
  # The module is generated with
  # direnv hook elvish > ~/.dotfiles/shell/elvish/lib/direnv.elv
  use direnv
}

# Homebrew
set-env HOMEBREW_PREFIX /opt/homebrew
set-env HOMEBREW_CELLAR /opt/homebrew/Cellar
set-env HOMEBREW_REPOSITORY /opt/homebrew

utils:append-paths /opt/homebrew/bin
utils:append-paths /opt/homebrew/sbin

set-env MANPATH $E:MANPATH":/opt/homebrew/share/man"
set-env INFOPATH $E:INFOPATH":/opt/homebrew/share/info"
