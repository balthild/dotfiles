function wuwa-gacha-records
  set -l path ~/Library/Containers/com.kurogame.mingchao/Data/Library/Logs/Client/Client.log
  set -l pattern 'https://aki-gm-resources(-oversea)?.aki-game.(net|com)[^"]*'
  set -l url (grep -oE $pattern $path | tail -n 1)
  if [ -n "$url" ]
    echo $url
  else
    echo "URL not found in game log" >&2
    return 1
  end
end

function genshin-gacha-records
  set -l path ~/Library/Containers/com.miHoYo.Yuanshen/Data/Library/Caches/WebKit/NetworkCache
  set -l pattern 'https://webstatic.mihoyo.com/hk4e/.*gacha.*/.*authkey=.*/log'
  set -l url (rg --text --max-count 1 $pattern $path | strings | rg $pattern | tail -n 1)
  if [ -n "$url" ]
    echo $url
  else
    echo "URL not found in game cache" >&2
    return 1
  end
end

function zzz-gacha-records
  set -l path ~/Library/Containers/com.miHoYo.Nap/Data/Library/Caches/com.miHoYo.Nap/Cache.db
  set -l pattern 'https://webstatic.mihoyo.com/nap/*gacha*/*authkey=*'
  set -l url (sqlite3 $path "SELECT request_key FROM cfurl_cache_response WHERE request_key GLOB '$pattern' ORDER BY time_stamp DESC LIMIT 1;")
  if [ -n "$url" ]
    echo $url
  else
    echo "URL not found in game cache" >&2
    return 1
  end
end

function re1999-gacha-records
  set -l path ~/Library/Containers/com.bluepoch.m.reverse1999/Data/Library/Caches/com.bluepoch.m.reverse1999/Cache.db
  set -l pattern 'https://game-re-service.sl916.com/query/summon?userId=*'
  set -l url (sqlite3 $path "SELECT request_key FROM cfurl_cache_response WHERE request_key GLOB '$pattern' ORDER BY time_stamp DESC LIMIT 1;")
  if [ -n "$url" ]
    echo $url
  else
    echo "URL not found in game cache" >&2
    return 1
  end
end
