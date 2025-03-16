# Balthild's dotfiles

Managed with [dotter](https://github.com/SuperCuber/dotter).

## Deploy

Prepare the environment:

```shell
# macOS
curl -sSf -L https://install.lix.systems/lix | sh -s -- install
nix shell 'nixpkgs#git' 'nixpkgs#dotter'
```

```shell
# Windows
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop install git dotter
```

Clone the repository to `~/.dotfiles`:

```shell
cd ~
git clone https://github.com/balthild/dotfiles .dotfiles
cd .dotfiles
```

Create `~/.dotfiles/.dotter/local.toml` and specify the packages to be deployed:

```toml
# macOS
includes = [".dotter/macos.toml"]
packages = ["default"]
```

```toml
# Windows
includes = [".dotter/windows.toml"]
packages = ["default"]
```

Confirm what will be deployed:

```shell
dotter deploy --dry-run
# or shorter
dotter deploy -d
```

Deploy:

```shell
dotter deploy
```

## Packages

### Nix

Requires [nix-darwin](https://github.com/LnL7/nix-darwin).

First-time installation:

```shell
nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/.dotfiles/nix
```

Apply changes:

```shell
darwin-rebuild -- switch --flake ~/.dotfiles/nix
```

### WSL

[ArchWSL](https://github.com/yuk7/ArchWSL)

### Shell

Requires [elvish](https://github.com/elves/elvish), [starship](https://github.com/starship/starship), and [carapace](https://github.com/rsteube/carapace-bin).

```shell
# Windows
scoop install elvish starship carapace-bin
```

### Rime

Requires [rime-ice](https://github.com/iDvel/rime-ice).

```shell
# Install with Rimeka
rimeka iDvel/rime-ice:others/recipes/full

# Install with /plum/
bash rime-install iDvel/rime-ice:others/recipes/full
```

Weasel 0.11+ has plum (rime-install) out of the box, located at ｢输入法设定｣ — ｢获取更多输入方案｣. After bootstrapping:

```shell
cd ~/AppData/Roaming/plum
./rime-install iDvel/rime-ice:others/recipes/full
```
