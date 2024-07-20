# Balthild's dotfiles

Managed with [dotter](https://github.com/SuperCuber/dotter).

## Deploy in Windows

Install dependencies:

```shell
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
includes = []
packages = ["wsl", "git", "elvish", "rime", "flow", "nvim"]
```

Deploy:

```shell
dotter deploy
```

## Packages

### WSL

[ArchWSL](https://github.com/yuk7/ArchWSL)

### Elvish

Requires [starship](https://github.com/starship/starship) and [carapace](https://github.com/rsteube/carapace-bin).

```shell
scoop install elvish starship carapace-bin
```

### Rime

Requires [rime-ice](https://github.com/iDvel/rime-ice).

```shell
bash rime-install iDvel/rime-ice:others/recipes/full
```

Weasel 0.11+ has plum (rime-install) out of the box, located at ｢输入法设定｣ — ｢获取更多输入方案｣. After bootstrapping:

```shell
cd ~/AppData/Roaming/plum
rime-install iDvel/rime-ice:others/recipes/full
```
