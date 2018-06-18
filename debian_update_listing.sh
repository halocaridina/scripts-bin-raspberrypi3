#!/usr/bin/env bash

export XAUTHORITY=/home/srsantos/.Xauthority
export DISPLAY=:0
####export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/dbus/system_bus_socket"

UPDATES="`{ apt-get --just-print upgrade 2>&1 | perl -ne 'if (/Inst\s([\w,\-,\d,\.,~,:,\+]+)\s\[([\w,\-,\d,\.,~,:,\+]+)\]\s\(([\w,\-,\d,\.,~,:,\+]+)\)? /i) {print "$1 ($2 -> $3)\n"}';} | while read -r line; do echo -en "$line\n"; done;`"
NUM_UPDATES="`/usr/bin/apt-show-versions -u | /usr/bin/wc -l`"

if ! [ "`ping -4 -c 1 google.com`" ]; then
    notify-send -u critical "Currently offline." "Will check for Raspbian updates again in 2 hrs."
elif [ "$NUM_UPDATES" == 0 ]; then
    notify-send -u low -i /home/srsantos/.config/dunst/icons/updates-notifier-inactive.svg 'No updates for Raspbian.'
else
    notify-send -u critical -i /home/srsantos/.config/dunst/icons/software-update-available.svg 'Raspbian updates:' "${UPDATES}"
fi
exit

##{ apt-get --just-print upgrade 2>&1 | perl -ne 'if (/Inst\s([\w,\-,\d,\.,~,:,\+]+)\s\[([\w,\-,\d,\.,~,:,\+]+)\]\s\(([\w,\-,\d,\.,~,:,\+]+)\)? /i) {print "$1 (\e[1;34m$2\e[0m -> \e[1;32m$3\e[0m)\n"}';} | while read -r line; do echo -en "$line\n"; done;
