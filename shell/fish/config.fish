set fish_pager_color_description '-d'

set -Ux QUOTING_STYLE 'literal'

alias ls 'ls --color=auto'
alias ll 'ls --color=auto -l'
alias la 'ls --color=auto -la'
alias grep 'grep --color'

abbr -a nix-apply 'darwin-rebuild switch --flake ~/.dotfiles/nix'

function cask
  brew $argv[1] --cask $argv[2..]
end
