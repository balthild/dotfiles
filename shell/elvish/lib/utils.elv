fn get {|name|
  eval 'put $'$name
}

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

fn callable {|cmd|
  var kind = (kind-of $cmd)
  if (eq $kind fn) {
    put $cmd
  } elif (eq $kind string) {
    try { get $cmd'~' } catch { external $cmd }
  } else {
    fail 'command '$cmd' does not exist'
  }
}

fn alias {|@def|
  if (not (and (has-key $def 0..2) (eq $def[1] =))) {
    echo Usage: alias name = command arg1 arg2 ...
    fail 'alias syntax error'
  }

  var name _ cmd @rest = $@def
  var fn = (callable $cmd)

  edit:add-var $name'~' {|@args|
    $fn $@rest $@args
  }
}
