use platform
use env
use shell
use keybindings
use coreutils
use pyvenv

shell:alias alias = $shell:alias~

shell:alias which = $shell:which~
shell:alias cd = $shell:cd~
shell:alias source = $shell:source~
shell:alias . = $shell:source~

shell:alias clear = $edit:clear~

shell:alias vim = nvim

shell:alias activate = $pyvenv:activate~

if (eq $platform:os windows) {
  use java
  use sql

  shell:alias read-key = python -c 'import msvcrt; print(msvcrt.getch())'

  shell:alias jver = $java:jdk-version-use~
  shell:alias sql = $sql:sql~
  shell:alias sqlcl-script = $sql:sqlcl-script~
}

if (eq $platform:os darwin) {
  shell:alias nix-apply = darwin-rebuild switch --flake ~/.dotfiles/nix

  shell:alias cask = {|task @args|
    brew $task --cask $@args
  }
}
