bind alt-left 'backward-word'
bind alt-right 'forward-word'
bind super-left 'beginning-of-line'
bind super-right 'end-of-line'

bind alt-delete 'backward-kill-word'
bind alt-shift-delete 'kill-word'

# https://github.com/fish-shell/fish-shell/issues/11193
bind tab '
  if commandline --search-field > /dev/null
    commandline -f complete
  else
    commandline -f complete-and-search
  end
'

bind super-r 'history-pager'
