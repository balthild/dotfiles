use platform
use shell

# Set output styles and charset for GNU coreutils
set E:LC_ALL = 'C.UTF-8'
set E:QUOTING_STYLE = 'literal'

# Enable colored output for ls and grep
shell:alias ls = e:ls --color=auto
shell:alias ll = e:ls --color=auto -l
shell:alias la = e:ls --color=auto -la
shell:alias grep = e:grep --color
