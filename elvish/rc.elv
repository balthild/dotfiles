eval (carapace _carapace elvish | slurp)
eval (starship init elvish)

# Make the completions case-insensitive
set E:CARAPACE_MATCH = 'CASE_INSENSITIVE'
set edit:completion:matcher[argument] = {|seed| edit:match-prefix $seed &ignore-case=$true }

# Quick cursor moving
set edit:insert:binding[Ctrl-Backspace] = { edit:kill-small-word-left }
set edit:insert:binding[Ctrl-Left] = { edit:move-dot-left-alnum-word }
set edit:insert:binding[Ctrl-Right] = { edit:move-dot-right-alnum-word }
set edit:insert:binding[Alt-Left] = { edit:move-dot-sol }
set edit:insert:binding[Alt-Right] = { edit:move-dot-eol }

# Enable colored output for GNU ls and grep
set E:LC_ALL = 'C.UTF-8'
set E:QUOTING_STYLE = 'literal'

fn add-path {|p|
  use path
  set paths = [$@paths (path:abs $p)]
}

# GNU coreutils shipped with Git for Windows
add-path ~/scoop/apps/git/current/usr/bin

fn ls {|@a| e:ls --color=auto $@a }
fn ll {|@a| e:ls --color=auto -l $@a }
fn la {|@a| e:ls --color=auto -la $@a }
fn grep {|@a| e:grep --color $@a }
fn vim {|@a| e:nvim $@a }
