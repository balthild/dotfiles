use shell
use utils
use keybindings
use coreutils
use java
use sql

shell:alias alias = $shell:alias~

shell:alias which = $shell:which~
shell:alias cd = $shell:cd~
shell:alias source = $shell:source~
shell:alias . = $shell:source~

shell:alias clear = $edit:clear~

shell:alias jver = $java:jdk-version-use~
shell:alias sql = $sql:sql~
shell:alias sqlcl-script = $sql:sqlcl-script~

shell:alias vim = nvim
shell:alias read-key = python -c 'import msvcrt; print(msvcrt.getch())'
