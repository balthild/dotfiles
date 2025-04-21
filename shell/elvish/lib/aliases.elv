use platform
use lib/shell

shell:alias alias = $shell:alias~
shell:alias which = $shell:which~
shell:alias cd = $shell:cd~
shell:alias source = $shell:source~
shell:alias . = $shell:source~

shell:alias clear = $edit:clear~
shell:alias vim = nvim

use lib/utils
shell:alias kill-elvish-daemon = $utils:kill-daemon~

use lib/pyvenv
shell:alias activate = $pyvenv:activate~

if (eq $platform:os windows) {
  shell:alias read-key = python -c 'import msvcrt; print(msvcrt.getch())'

  use lib/java
  shell:alias jver = $java:jdk-version-use~
  java:enable-completion jver

  use lib/sql
  shell:alias sql = $sql:sql~
  shell:alias sqlcl-script = $sql:sqlcl-script~
}

if (eq $platform:os darwin) {
  shell:alias nix-apply = darwin-rebuild switch --flake ~/.dotfiles/nix

  shell:alias cask = {|task @args|
    brew $task --cask $@args
  }

  shell:alias ssh-copy-terminfo = {|server @args|
    infocmp -x | ssh $server $@args -- tic -x -
  }
}
