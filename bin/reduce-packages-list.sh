#!/bin/bash
# Reduce a dependencies list for Arch Linux

if [[ ! "$1" ]]; then
	echo "Please provide an input file"
	exit 0
fi

PACKAGES=$(cat "$1")

deps=""

for package in $PACKAGES; do
	additional=$(pactree -u "$package" | grep -v "$package")
	deps="$deps $additional"
done

for package in $PACKAGES; do
	if ! [[ "$deps" == *"$package"* ]]; then
		echo "$package"
	fi
done
