use re

fn find-prev-token {
  var before = $edit:current-command[..$edit:-dot]
  var match = (re:find '[0-9A-Za-z]*[^0-9A-Za-z\s]*\s*$' $before)
  put $match[start]
}

fn find-next-token {
  var after = $edit:current-command[$edit:-dot..]
  var match = (re:find '^\s*[^0-9A-Za-z\s]*[0-9A-Za-z]*' $after)
  put (+ $edit:-dot $match[end])
}

fn move-to-prev-token {
  set edit:-dot = (find-prev-token)
}

fn move-to-next-token {
  set edit:-dot = (find-next-token)
}

fn delete-to-prev-token {
  var pos = (find-prev-token)

  var before = $edit:current-command[..$pos]
  var after = $edit:current-command[$edit:-dot..]

  set edit:current-command = $before$after
  set edit:-dot = $pos
}
