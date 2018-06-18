#!/usr/bin/env python

import colorsys
import math
import time
from blinkt import set_clear_on_exit, set_brightness, set_pixel, show, clear
from sys import exit
from subprocess import PIPE, Popen

try:
    import psutil
except ImportError:
    exit("This script requires the psutil module\nInstall with: sudo pip install psutil")

# Set Initial Global Variables and Settings
set_clear_on_exit()
set_brightness(0.1)
hue_start = 240
hue_range = 145

# Clear LEDs from previous session or a boot up with undesirable outcomes
clear()
show()

# CPU Load Graph for 6 of 8 Pins
def show_graph(v, r, g, b):
    v *= 8
    for x in range(8):
        hue = ((hue_start + ((x/6.0) * hue_range)) % 360) / 360.0
        r, g, b = [int(c * 255) for c in colorsys.hsv_to_rgb(hue,1.0,1.0)]
        if v  < 0:
            r, g, b = 0, 0, 0
        else:
            r, g, b = [int(min(v,1.0) * c) for c in [r,g,b]]
        set_pixel(x, r, g, b)
        v -= 1

def get_cpu_temperature():
    process = Popen(['/opt/vc/bin/vcgencmd', 'measure_temp'], stdout=PIPE)
    output, _error = process.communicate()
    output = output.decode('utf8')
    return float(output[output.index('=') + 1:output.rindex("'")])

def status():
   v = psutil.cpu_percent() / 100.0
   show_graph(v, 0, 0, 0)
   temp = get_cpu_temperature() / 1.0
   if temp <= 60:
      set_pixel(6, 255, 215, 0, 0.1)
   elif temp >= 60.1 and temp <= 63:
      set_pixel(6, 255, 69, 0, 0.1)
   else:
      set_pixel(6, 255, 0, 1.0)
   mem = psutil.virtual_memory().percent / 1
   if mem <= 40:
      set_pixel(7, 0, 255, 0, 0.1)
   elif mem >= 40.1 and mem <= 60:
      set_pixel(7, 255, 215, 0, 0.1)
   else:
      set_pixel(7, 255, 0, 0, 1.0)

while True:
   status()
   show()
   time.sleep(0.2)
