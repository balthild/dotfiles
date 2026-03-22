abbr -a nix-apply 'sudo darwin-rebuild switch --flake ~/.dotfiles/nix'
abbr -a nix-plan 'darwin-rebuild build --dry-run --flake ~/.dotfiles/nix'
abbr -a nix-browse 'nix-tree --derivation ~/.dotfiles/nix#darwinConfigurations.Balthild-Mac.system'
abbr -a nix-locate 'nix run github:nix-community/nix-index-database'

function nix-wtf -w 'nix-shell -p' -a name
  if [ -z "$name" ]
    echo "Usage: nix-wtf <package>" >&2
    return 1
  end

  set -l revision (jq '.nodes.nixpkgs.locked.rev' ~/.dotfiles/nix/flake.lock --raw-output)
  set -l output (nix eval --inputs-from ~/.dotfiles/nix --raw "nixpkgs#$name.outPath")
  set -l builds "https://hydra.nixos.org/job/nixpkgs/unstable/$name.aarch64-darwin"
  set -l releases "https://hydra.nixos.org/job/nixpkgs/unstable/unstable"

  echo "$(set_color --bold blue)Revision:$(set_color normal)  $revision"
  echo "$(set_color --bold blue)Output:$(set_color normal)    $output"
  echo "$(set_color --bold blue)Builds:$(set_color normal)    $builds"
  echo "$(set_color --bold blue)Releases:$(set_color normal)  $releases"
end
