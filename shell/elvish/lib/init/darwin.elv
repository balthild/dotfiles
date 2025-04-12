use lib/utils

# Nix and Homebrew have their environment variables set for zsh.
sudo -u $E:USER -i zsh -c 'export | xargs printf "%s\n"' | each {|line|
  use str
  if (str:contains $line '=') {
    var name value = (str:split &max=2 '=' $line)
    if (not (str:has-prefix $name SUDO_)) {
      set-env $name $value
    }
  }
}

set-env HOMEBREW_NO_ENV_HINTS true
