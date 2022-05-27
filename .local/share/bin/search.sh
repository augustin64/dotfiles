#!/usr/bin/sh

IFS=':' read -ra PATHS <<< "$PATH"
for i in "${PATHS[@]}"; do
	ls "$i" | grep "$1"
done
