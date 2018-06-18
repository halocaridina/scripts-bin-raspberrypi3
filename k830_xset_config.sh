#!/usr/bin/env bash

# Increase the repeat rate of the keyboard
/usr/bin/xset r rate 400 44

# Turn off cap locks
/usr/bin/setxkbmap -option caps:none

# Enable killing X via key combo
/usr/bin/setxkbmap -option terminate:ctrl_alt_bksp

#/usr/bin/systemd-cat -t "Logitech" /usr/bin/echo "***** MODIFYING K830 KEYBOARD ATTRIBUTES ON $(date) *****"
