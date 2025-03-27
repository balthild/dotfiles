use os
use str
use re
use path

fn activate {|venv|
  if (has-env VIRTUAL_ENV) {
    fail "A venv is already activated. Please deactivate it first"
  }

  var cfg = (path:join $venv pyvenv.cfg)
  if (not (os:is-regular $cfg)) {
    fail "Invalid or non-existent config: "$cfg
  }

  var prompt
  cat $cfg | each {|line|
    if (re:match '^prompt\s*=' $line) {
      set prompt = (str:trim-space (re:replace '^prompt\s*=' '' $line))
      break
    }
  }

  var bin = (path:join $venv bin)

  var paths-bak = $paths
  set paths = [$bin $@paths]

  set-env VIRTUAL_ENV $venv
  set-env VIRTUAL_ENV_PROMPT $prompt

  edit:add-var deactivate~ {
    set paths = $paths-bak
    unset-env VIRTUAL_ENV
    unset-env VIRTUAL_ENV_PROMPT
    edit:del-var deactivate~
  }
}
