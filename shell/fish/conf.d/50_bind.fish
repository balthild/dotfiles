bind alt-left 'backward-word'
bind alt-right 'forward-word'
bind super-left 'beginning-of-line'
bind super-right 'end-of-line'

bind alt-delete 'backward-kill-word'
bind alt-shift-delete 'kill-word'

# `complete-and-search` moves backward in pager, so we need to move forward twice with `complete`
# But it still has a side effect that makes the initial selected item being the second one
bind tab 'complete-and-search' 'complete' 'complete'
bind super-r 'history-pager'
