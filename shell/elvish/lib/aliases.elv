use platform
use lib/shell

shell:alias alias = $shell:alias~
shell:alias which = $shell:which~
shell:alias cd = $shell:cd~
shell:alias source = $shell:source~
shell:alias . = $shell:source~

shell:alias clear = $edit:clear~

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

shell:alias kill-elvish-daemon = {
  ps aux |
    grep -e '^balthild' |
    grep 'elvish -daemon ' |
    grep -v grep |
    awk '{ print $2 }' |
    each {|pid| kill $pid }
}

# with-stty raw { read-upto . } | put (one)[..-1]
shell:alias with-stty = {|@args cmd~ &tty=/dev/tty|
  #: Usage: with-stty $@stty-args $cmd
  #: Runs $cmd with tty settings temporarily set according to $@stty-args
  var orig = (stty -g <$tty)
  defer { stty $orig <$tty }
  stty $@args <$tty
  cmd
}
