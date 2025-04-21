use lib/cursor

# Quick deletion
set edit:insert:binding[Alt-Backspace] = { cursor:delete-to-prev-token }
set edit:insert:binding[Alt-Delete] = { cursor:delete-to-prev-token }
set edit:insert:binding[Ctrl-Backspace] = { cursor:delete-to-prev-token }
set edit:insert:binding[Ctrl-Delete] = { cursor:delete-to-prev-token }

# Quick cursor moving
set edit:insert:binding[Alt-Left] = { cursor:move-to-prev-token }
set edit:insert:binding[Alt-Right] = { cursor:move-to-next-token }
set edit:insert:binding[Ctrl-Left] = { edit:move-dot-sol }
set edit:insert:binding[Ctrl-Right] = { edit:move-dot-eol }
