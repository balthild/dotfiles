# Not using `conf.d` to prevent them being loaded by $__fish_data_dir/config.fish
# and thus causing infinite recursion in carapace.
# https://github.com/carapace-sh/carapace-bin/issues/2781
for file in $__fish_config_dir/profiles/*.fish
  test -f $file -a -r $file
  and source $file
end

set fish_pager_color_description '-d'

set -gx QUOTING_STYLE 'literal'
alias ls 'ls --color=auto'
alias grep 'grep --color'

abbr -a ll 'ls -l'
abbr -a la 'ls -la'

abbr -a nix-apply 'sudo darwin-rebuild switch --flake ~/.dotfiles/nix'
abbr -a nix-locate 'nix run github:nix-community/nix-index-database'

function cask
  brew $argv[1] --cask $argv[2..]
end

function wuwa-gacha-records
  set path '~/Library/Containers/com.kurogame.mingchao/Data/Library/Logs/Client/Client.log'
  set pattern 'https://aki-gm-resources(-oversea)?.aki-game.(net|com)[^"]*'
  set url (grep -oE $pattern $path | tail -n 1)
  if [ -n "$url" ]
    echo $url
  else
    echo "URL not found in game log" >&2
    return 1
  end
end
