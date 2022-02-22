#!/bin/bash

export XAUTHORITY=/home/augustin64/.Xauthority

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)' | sort -r | head -n 1)

power_supply_state=$(cat /sys/class/power_supply/AC*/online);

if [[ "$battery_level" -le 15 && "$power_supply_state" = 0 ]]; then
    notify-send "Battery low" "Battery level is ${battery_level}%" --urgency=critical;
    mpg123 "/home/augustin64/Sounds/low_battery.mp3";
fi
