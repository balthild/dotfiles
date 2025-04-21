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

fn move-prev-token {
  set edit:-dot = (find-prev-token)
}

fn move-next-token {
  set edit:-dot = (find-next-token)
}

fn delete-prev-token {
  var start = (find-prev-token)
  var end = $edit:-dot

  var before = $edit:current-command[..$start]
  var after = $edit:current-command[$end..]

  set edit:current-command = $before$after
  set edit:-dot = $start
}

fn delete-next-token {
  var start = $edit:-dot
  var end = (find-next-token)

  var before = $edit:current-command[..$start]
  var after = $edit:current-command[$end..]

  set edit:current-command = $before$after
  set edit:-dot = $start
}
