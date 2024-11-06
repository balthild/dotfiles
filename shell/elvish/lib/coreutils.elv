use utils

# Set output styles and charset for GNU coreutils
set E:LC_ALL = 'C.UTF-8'
set E:QUOTING_STYLE = 'literal'

# Use GNU coreutils from Git for Windows
utils:prepend-paths ~/scoop/apps/git/current/usr/bin

# Enable colored output for ls and grep
utils:alias ls = e:ls --color=auto
utils:alias ll = e:ls --color=auto -l
utils:alias la = e:ls --color=auto -la
utils:alias grep = e:grep --color
