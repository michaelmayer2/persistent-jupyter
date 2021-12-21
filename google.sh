#!/bin/bash
killall /opt/python/3.9.5/bin/python
/opt/python/3.9.5/bin/jupyter-notebook --no-browser --NotebookApp.use_redirect_file=False --NotebookApp.browser="/opt/google/chrome/google-chrome -private-window --kiosk --full-screen --app" &

sleep 7 

url=`/opt/python/3.9.5/bin/jupyter notebook list --json | python3 -c 'import json; import sys; jdata=json.load(sys.stdin); print (jdata["url"]+jdata["base_url"]+"?token="+jdata["token"])'`

echo $url > /tmp/URL

#google-chrome-stable --persistent --app="$url"

#google-chrome-stable --persistent --disable-fre --no-startup-window --no-default-browser-check --no-first-run --chrome-frame --app --kiosk "$url"

/opt/google/chrome/google-chrome  -private-window --kiosk --full-screen "$url"
