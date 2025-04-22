fn get {|expr &type=$nil|
  var value = (eval 'put '$expr)
  if (not-eq $type $nil) {
    if (not-eq $type (kind-of $value)) {
      fail 'variable $'$expr' is not in type '$type
    }
  }
  put $value
}

fn get-var {|name|
  get '$'$name
}

fn get-command {|name|
  get &type=fn (resolve $name)
}

fn fn-signature {|callable|
  use str
  use re

  var repr = (repr $callable)
  if (str:has-prefix $repr '<builtin <') {
    put (str:replace '>:' ':' $repr[10..-1])
    return
  }
  if (str:has-prefix $repr '<builtin ') {
    put 'builtin:'$repr[9..-1]
    return
  }
  if (str:has-prefix $repr '<external ') {
    put 'e:'$repr[10..-1]
    return
  }

  var args = [(for x $callable[arg-names] { styled $x bold })]
  var opts = [(for x $callable[opt-names] { styled '&'$x'=…' italic dim })]

  var rest = $callable[rest-arg]
  if (>= $rest 0) {
    set args[$rest] = '@'(styled $args[$rest] underlined)
  }

  echo $@args $@opts | put 'fn['(one)']'
}

fn append-paths {|p|
  use path
  set paths = [$@paths (path:abs $p)]
}

fn prepend-paths {|p|
  use path
  set paths = [(path:abs $p) $@paths]
}

fn drop-paths {|p|
  use path
  var abs = (path:abs $p)
  set paths = [(put $@paths | keep-if {|x| not-eq $x $abs })]
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
    try { get-command $cmd } catch { external $cmd }
  } else {
    fail 'wrong type: need string or fn, got '$kind
  }
}
