# Balthild's dotfiles

Managed with [dotter](https://github.com/SuperCuber/dotter).

## Deploy in Windows

Install dependencies

```shell
scoop install git dotter
```

Clone the repository to `~/.dotfiles`

```shell
cd ~
git clone https://github.com/balthild/dotfiles .dotfiles
cd .dotfiles
```

Create `~/dotfiles/.dotter/local.toml` and include the packages to be deployed

```toml
includes = []
packages = ["elvish", "git", "rime", "flow", "nvim"]
```

Deploy them

```shell
dotter deploy
```

### Elvish

Requires [starship](https://github.com/starship/starship) and [carapace](https://github.com/rsteube/carapace-bin).

```shell
scoop install elvish starship carapace-bin
```
