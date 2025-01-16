use utils

eval (carapace _carapace elvish | slurp)

# Make the completions case-insensitive
set E:CARAPACE_MATCH = 'CASE_INSENSITIVE'

set edit:completion:matcher[argument] = {|seed| edit:match-prefix $seed &ignore-case=$true }

eval (starship init elvish)

# Suppress timeout messages from starship
set E:STARSHIP_LOG = 'error'

fn source {|path|
  eval (slurp < $path)
}

utils:alias source = $source~
utils:alias . = $source~

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

utils:alias cd = $cd~
