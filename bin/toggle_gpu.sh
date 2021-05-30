#!/bin/bash

if lsmod | grep -q acpi_call; then

if [[ $1 = on ]]; then
    sudo echo \_SB.PCI0.PEG0.PEGP._ON > /proc/acpi/call
fi

if [[ $1 = off ]]; then
    sudo echo \_SB.PCI0.PEG0.PEGP._OFF > /proc/acpi/call
fi

result=$(tr -d '\0' </proc/acpi/call)
case "$result" in
    Error*)
        echo "failed {$result}"
    ;;
    *)
        echo "main GPU toggled to $1 {$result}"
    ;;
esac

else
    echo "acpi_call kernel module is not loaded"
    exit 1
fi
