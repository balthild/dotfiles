alias ll = ls -l
alias la = ls -al
alias vim = nvim

if $nu.os-info.name == 'macos' {
  alias nix-apply = darwin-rebuild switch --flake ~/.dotfiles/nix

  def cask [task, ...args] {
    brew $task --cask ...$args
  }
}

module ssh-copy-terminfo {
  def completer [context: string] {
    carapace ssh nushell ($context | split row -r '\s+' | get -i 1) | from json
  }

  export def main [server: string@completer] {
    infocmp -x | ssh $server -- tic -x -
  }
}

use ssh-copy-terminfo
