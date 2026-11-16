# Balthild's dotfiles

Managed with [dotter](https://github.com/SuperCuber/dotter).

## Deploy

Prepare the environment:

```shell
# macOS
curl -sSf -L https://install.lix.systems/lix | sh -s -- install
nix shell 'nixpkgs#git' 'nixpkgs#git-crypt' 'nixpkgs#dotter'
```

```shell
# Windows
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop install git git-crypt dotter
```

Clone the repository to `~/.dotfiles`:

```shell
git clone https://github.com/balthild/dotfiles ~/.dotfiles
cd ~/.dotfiles
```

Unlock the encrypted files:

```shell
op read "op://Personal/dotfiles/dotfiles" --no-newline | git-crypt unlock /dev/stdin
# or with key file
git-crypt unlock ~/path/to/key
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

## Remarks

### Nix

- [nix-darwin](https://github.com/nix-darwin/nix-darwin)

First-time installation:

```shell
nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/.dotfiles
```

Check for changes:

```shell
darwin-rebuild build --dry-run --flake ~/.dotfiles
# or the shell alias
nix-plan
```

Apply changes:

```shell
darwin-rebuild -- switch --flake ~/.dotfiles
# or the shell alias
nix-apply
```

Search packages:

```shell
nix-search helix
```

### WSL

- [ArchWSL](https://github.com/yuk7/ArchWSL)

### Shell

- [elvish](https://github.com/elves/elvish)
- [starship](https://github.com/starship/starship)
- [carapace](https://github.com/rsteube/carapace-bin)

```shell
# Windows
scoop install elvish starship carapace-bin
```

### Rime

- [Rimeka](https://github.com/balthild/rimeka)
- [雾凇拼音](https://github.com/iDvel/rime-ice)
- [白霜拼音](https://github.com/gaboolic/rime-frost)
- [万象语法模型](https://github.com/amzxyz/rime-wanxiang-data)
- [墨奇语法模型](https://github.com/gaboolic/rime-build-grammar)

Install the schema:

```shell
rimeka iDvel/rime-ice:others/recipes/full
rimeka gaboolic/rime-frost:others/recipes/full
```

Install the model:

```shell
cd ~/Library/Rime
wget https://github.com/amzxyz/rime-wanxiang-data/releases/download/LTS/wanxiang-lts-zh-hans.gram
wget https://github.com/gaboolic/rime-build-grammar/releases/download/1.0.0/rime-moqi-zh.gram
```
