use utils

# Lix
utils:prepend-paths /nix/var/nix/profiles/default/bin
# Nix-Darwin System
utils:prepend-paths /run/current-system/sw/bin
# Nix-Darwin User
utils:prepend-paths /etc/profiles/per-user/balthild/bin
# Nix Profile
utils:prepend-paths ~/.nix-profile/bin/

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
