#!/bin/sh

export XAUTHORITY=/home/augustin64/.Xauthority
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')

if [ $battery_level -le 10 ]; then
    notify-send "Battery low" "Battery level is ${battery_level}% --urgency=critical"
fi
