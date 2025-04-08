# JDK version switcher for Windows

use lib/utils

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

fn jdk-version-use {|@args|
  use math
  use path

  var versions = (jdk-version-list)

  if (eq $args []) {
    var len = (keys $versions | each $count~ | math:max (all))

    for ver [(keys $versions | order)] {
      print (utils:pad-right $len $ver) ' '
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

fn enable-completion {|cmd|
  set edit:completion:arg-completer[$cmd] = {|@args|
    var versions = (jdk-version-list)
    for ver [(keys $versions | order)] {
      var desc = (styled ' ('$versions[$ver]')' dim)
      edit:complex-candidate &display=$ver$desc $ver
    }
  }
}
