#!/bin/bash

# Kiosk mode 활성화
# Turn off screen blanking and power saving
export DISPLAY=:0.0

xset s noblank # don't blank the video device
xset s off     # disable screen saver
xset –dpms     # disable DPMS (Energy Star) features.

# Hide the mouse cursor
unclutter -idle 0.01 -root &

# Remove previous config folders
CONF=/home/pi/.config/chrome1

if [ -d ${CONF} ]; then
    echo "Deleting the previous configuration folder: [${CONF}]"
    rm -fr ${CONF}
fi

/usr/bin/chromium-browser \
    --kiosk --remote-debugging-port=9221 \
    --no-first-run \
    --user-data-dir=/home/pi/.config/chrome \
    --window-position=0,0 'http://127.0.0.1:8000/' \
    --password-store=basic &
