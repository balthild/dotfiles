use utils

# Nix
if (not (has-env __NIX_DARWIN_SET_ENVIRONMENT_DONE)) {
  # TODO: https://github.com/LnL7/nix-darwin/issues/1402
  var script = ~/.dotfiles/shell/elvish/lib/env/bashenv.sh
  bash --noprofile --norc $script | each {|line|
    use str
    if (str:contains $line '=') {
      var name value = (str:split &max=2 '=' $line)
      set-env $name $value
    }
  }
}

if (has-external direnv) {
  eval (direnv hook elvish | slurp)
}

# Homebrew
set-env HOMEBREW_PREFIX /opt/homebrew
set-env HOMEBREW_CELLAR /opt/homebrew/Cellar
set-env HOMEBREW_REPOSITORY /opt/homebrew

utils:append-paths /opt/homebrew/bin
utils:append-paths /opt/homebrew/sbin

set-env MANPATH $E:MANPATH':/opt/homebrew/share/man'
set-env INFOPATH $E:INFOPATH':/opt/homebrew/share/info'
