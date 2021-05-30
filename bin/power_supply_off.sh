#!/usr/bin/env bash

export XAUTHORITY=/home/augustin64/.Xauthority
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

# /usr/bin/sudo -u augustin64 /usr/bin/mpg123 --server=/run/user/1000/pulse/native /home/augustin64/Sounds/low_battery.mp3 > /dev/null 2>&1

# /usr/bin/notify-send -c low "Battery is no longer charging" "Your power supply is now disconnected"
