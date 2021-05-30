#!/bin/sh

if [[ $SILENT = "true" ]]; then
    export SILENT=false
else
    export SILENT=true
fi

echo "silent mode: $SILENT"
