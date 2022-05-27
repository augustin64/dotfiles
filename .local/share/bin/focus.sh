#!/bin/bash

. $HOME/.cache/wal/colors.sh

if [[ "$1" == "-q" || "$1" == "--quit" ]]; then
	bspc wm -r
else
	if [[ "$1" == "-f" || "$1" == "--fullscreen" ]]; then
		killall polybar
		bspc config top_padding 0
	fi;
	convert "xc:$color0" /tmp/wp.png
	feh --bg-tile /tmp/wp.png
	rm /tmp/wp.png
	bspc config border_width 0
	bspc config border_radius 0
	bspc config window_gap 0
	killall picom
fi
