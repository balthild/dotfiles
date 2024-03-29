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
packages = ["git", "elvish", "rime", "flow", "nvim"]
```

Deploy:

```shell
dotter deploy
```

## Package Dependencies

### Elvish

Requires [starship](https://github.com/starship/starship) and [carapace](https://github.com/rsteube/carapace-bin).

```shell
scoop install elvish starship carapace-bin
```

### Rime

Requires [rime-ice](https://github.com/iDvel/rime-ice).
