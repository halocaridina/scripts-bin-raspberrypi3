#!/bin/bash

/usr/bin/kweb &

sleep 3

for i in {1..8}; do xvkbd -window Kweb -text "\A+"; done

