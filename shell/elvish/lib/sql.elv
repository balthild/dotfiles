use utils

fn sql {|@args|
  with E:JAVA_TOOL_OPTIONS = '-Duser.language=en' {
    e:sql $@args
  }
}

fn sqlcl-script {|name input|
  with E:JAVA_TOOL_OPTIONS = '-Duser.language=en' {
    echo "set echo on\n@"$input"\nquit\n" | e:sql -name $name
  }
}

utils:alias sql = $sql~
utils:alias sqlcl-script = $sqlcl-script~
