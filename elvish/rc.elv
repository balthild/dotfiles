eval (carapace _carapace elvish | slurp)
eval (starship init elvish)

# Make the completions case-insensitive
set E:CARAPACE_MATCH = 'CASE_INSENSITIVE'
set edit:completion:matcher[argument] = {|seed| edit:match-prefix $seed &ignore-case=$true }

# Quick cursor moving
set edit:insert:binding[Ctrl-Backspace] = { edit:kill-left-alnum-word }
set edit:insert:binding[Ctrl-Delete] = { edit:kill-left-alnum-word }
set edit:insert:binding[Ctrl-Left] = { edit:move-dot-left-alnum-word }
set edit:insert:binding[Ctrl-Right] = { edit:move-dot-right-alnum-word }
set edit:insert:binding[Alt-Left] = { edit:move-dot-sol }
set edit:insert:binding[Alt-Right] = { edit:move-dot-eol }

# Set output styles and charset for GNU coreutils
set E:LC_ALL = 'C.UTF-8'
set E:QUOTING_STYLE = 'literal'

# Utility functions
fn append-paths {|p|
  use path
  set paths = [$@paths (path:abs $p)]
}

fn prepend-paths {|p|
  use path
  set paths = [(path:abs $p) $@paths]
}

fn pad-right {|len s|
  use str
  if (<= $len (count $s)) {
    put $s
  } else {
    pad-right $len $s' '
  }
}

# Use GNU coreutils from Git for Windows
prepend-paths ~/scoop/apps/git/current/usr/bin

# Aliases
# Enable colored output for ls and grep
fn ls {|@a| e:ls --color=auto $@a }
fn ll {|@a| e:ls --color=auto -l $@a }
fn la {|@a| e:ls --color=auto -la $@a }
fn grep {|@a| e:grep --color $@a }

fn vim {|@a| e:nvim $@a }

fn read-key { python -c 'import msvcrt; print(msvcrt.getch())' }

# JDK version manager for Windows
fn reg-subkeys {|prefix|
  use str
  reg query $prefix /k /f '' | findstr HKEY | each {|k| put (str:trim-prefix $k $prefix) }
}

fn jdk-version-list {
  use str

  var versions = [&]
  var prefixes = [
    'HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Development Kit\'
    'HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\JDK\'
  ]

  for prefix $prefixes {
    reg-subkeys $prefix | each {|ver|
      var value = (reg query $prefix$ver /v JavaHome | findstr JavaHome)
      var home = (str:trim-space [(str:split REG_SZ $value)][1])
      set versions[$ver] = $home
    }
  }

  put $versions
}

fn jver {|@args|
  use math
  use path

  var versions = (jdk-version-list)

  if (eq $args []) {
    var len = (keys $versions | each $count~ | math:max (all))

    for ver [(keys $versions | order)] {
      print (pad-right $len $ver) ' '
      echo $versions[$ver]
    }
  } else {
    echo Setting JAVA_HOME = $versions[$args[0]]
    set E:JAVA_HOME = $versions[$args[0]]

    echo Setting PATH
    prepend-paths (path:join $E:JAVA_HOME bin)
  }

  echo
  echo '>' java -version
  java -version
}

set edit:completion:arg-completer[jver] = {|@args|
  var versions = (jdk-version-list)
  for ver [(keys $versions | order)] {
    var desc = (styled ' ('$versions[$ver]')' dim)
    edit:complex-candidate &display=$ver$desc $ver
  }
}
