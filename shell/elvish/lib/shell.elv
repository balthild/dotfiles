# Ghostty
if (and (eq $E:TERM xterm-ghostty) (not-eq $E:GHOSTTY_INTEGRATION_LOADED 1)) {
  use ghostty-integration
  set-env GHOSTTY_INTEGRATION_LOADED 1
}

# Carapace
eval (carapace _carapace elvish | slurp)
# Make the completions case-insensitive
set E:CARAPACE_MATCH = 'CASE_INSENSITIVE'
set edit:completion:matcher[argument] = {|seed| edit:match-prefix $seed &ignore-case=$true }

# Starship
eval (starship init elvish)
# Suppress timeout messages from starship
set E:STARSHIP_LOG = 'error'

fn source {|path|
  eval (slurp < $path)
}

var aliases = [&]

fn alias {|@def|
  use utils

  if (not (and (has-key $def 0..2) (eq $def[1] =))) {
    echo Usage: alias name = command arg1 arg2 ...
    fail 'alias syntax error'
  }

  var name _ cmd @rest = $@def
  var callable = (utils:callable $cmd)

  edit:add-var $name'~' {|@args|
    $callable $@rest $@args
  }

  var repr = $cmd
  if (eq (kind-of $cmd) 'fn') {
    set repr = (utils:fn-signature $cmd)
  }
  set aliases[$name] = (echo $repr $@rest)
}

fn which {|name|
  use str
  use utils

  if (has-key $aliases $name) {
    echo alias $name = $aliases[$name]
    return
  }
  if (str:has-prefix $name 'e:') {
    echo (search-external $name[2..])
    return
  }
  if (str:contains $name ':') {
    echo $name
    return
  }

  var expr = (resolve $name)
  if (str:has-prefix $expr '(external ') {
    echo (search-external $name)
  } elif (str:has-prefix $expr '$') {
    echo (utils:fn-signature (utils:get $expr))
  } else {
    echo $expr
  }
}

# https://github.com/elves/elvish/issues/438
var lwd
fn cd {|@args|
  use builtin

  if (has-key $args 1) {
    fail 'too many arguments'
  }

  var path = (try { put $args[0] } catch { put ~ })
  if (not-eq (kind-of $path) string) {
    fail 'invalid path'
  }

  if (not-eq $path -) {
    var cwd = $pwd
    builtin:cd $path
    set lwd = $cwd
  } elif (not-eq $lwd $nil) {
    echo $lwd
    cd $lwd
  } else {
    echo no cd history
  }
}
