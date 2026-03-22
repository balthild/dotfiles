# https://github.com/fish-shell/fish-shell/issues/11193
bind tab '
  if commandline --search-field > /dev/null
    commandline -f complete
  else
    commandline -f complete-and-search
  end
'

bind super-r 'history-pager'
