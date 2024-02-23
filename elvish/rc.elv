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

fn append-paths {|p|
  use path
  set paths = [$@paths (path:abs $p)]
}

fn prepend-paths {|p|
  use path
  set paths = [(path:abs $p) $@paths]
}

# Use GNU coreutils from Git for Windows
prepend-paths ~/scoop/apps/git/current/usr/bin

# Enable colored output for ls and grep
fn ls {|@a| e:ls --color=auto $@a }
fn ll {|@a| e:ls --color=auto -l $@a }
fn la {|@a| e:ls --color=auto -la $@a }
fn grep {|@a| e:grep --color $@a }

fn vim {|@a| e:nvim $@a }
