# Quick deletion
set edit:insert:binding[Alt-Backspace] = { edit:kill-alnum-word-left }
set edit:insert:binding[Alt-Delete] = { edit:kill-alnum-word-left }
set edit:insert:binding[Ctrl-Backspace] = { edit:kill-alnum-word-left }
set edit:insert:binding[Ctrl-Delete] = { edit:kill-alnum-word-left }

# Quick cursor moving
set edit:insert:binding[Alt-Left] = { edit:move-dot-left-alnum-word }
set edit:insert:binding[Alt-Right] = { edit:move-dot-right-alnum-word }
set edit:insert:binding[Ctrl-Left] = { edit:move-dot-sol }
set edit:insert:binding[Ctrl-Right] = { edit:move-dot-eol }
