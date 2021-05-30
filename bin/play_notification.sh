#!/bin/sh

if [[ $SILENT = true ]]; then
    echo "silent mode on"
else
    mpg123 $HOME/Sounds/simple_notification.mp3
fi
