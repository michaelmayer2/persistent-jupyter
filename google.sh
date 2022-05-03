#!/bin/bash

killall /opt/python/3.9.5/bin/python
/opt/python/3.9.5/bin/jupyter-notebook --no-browser &

sleep 7 

url=`/opt/python/3.9.5/bin/jupyter notebook list --json | python3 -c 'import json; import sys; jdata=json.load(sys.stdin); print (jdata["url"]+jdata["base_url"]+"?token="+jdata["token"])'`

echo $url > /tmp/URL

/opt/google/chrome/google-chrome --no-default-browser-check --disable-infobars --kiosk --full-screen "$url"
