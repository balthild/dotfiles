use lib/cursor

# Quick deletion
set edit:insert:binding[Alt-Backspace] = { cursor:delete-prev-token }
set edit:insert:binding[Alt-Delete] = { cursor:delete-prev-token }
set edit:insert:binding[Ctrl-Backspace] = { cursor:delete-prev-token }
set edit:insert:binding[Ctrl-Delete] = { cursor:delete-prev-token }

# set edit:insert:binding[Alt-Shift-Backspace] = { cursor:delete-next-token }
# set edit:insert:binding[Alt-Shift-Delete] = { cursor:delete-next-token }
# set edit:insert:binding[Ctrl-Shift-Backspace] = { cursor:delete-next-token }
# set edit:insert:binding[Ctrl-Shift-Delete] = { cursor:delete-next-token }

# TODO: Why these don't work?
set edit:insert:binding[Ctrl-Shift-Backspace] = { echo ctrl+shift+backspace }
set edit:insert:binding[Alt-Shift-Backspace] = { echo alt+shift+backspace }

# Quick cursor moving
set edit:insert:binding[Alt-Left] = { cursor:move-prev-token }
set edit:insert:binding[Alt-Right] = { cursor:move-next-token }
set edit:insert:binding[Ctrl-Left] = { edit:move-dot-sol }
set edit:insert:binding[Ctrl-Right] = { edit:move-dot-eol }
