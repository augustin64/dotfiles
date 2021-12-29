#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar
source "$HOME/.config/dotfiles/load.sh"
NETWORK_INTERFACE="$NETWORK_INTERFACE" INT="$INTERNAL" polybar -r top &

external_monitor=$(xrandr --query | grep "$EXTERNAL")
if [[ ! $external_monitor = *disconnected* ]]; then
	echo "starting [bar/top_external]"
  NETWORK_INTERFACE="$NETWORK_INTERFACE" EXT="$EXTERNAL" polybar -r top_external &
fi
