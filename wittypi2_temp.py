#!/usr/bin/env python2

import smbus
import os

bus = smbus.SMBus(1)
address = 0x68

#os.system('sudo rmmod rtc_ds1307')
def getTemp(address):
   byte_tmsb = bus.read_byte_data(address,0x11)
   byte_tlsb = bin(bus.read_byte_data(address,0x12))[2:].zfill(8)
   return byte_tmsb+int(byte_tlsb[0])*2**(-1)+int(byte_tlsb[1])*2**(-2)

#print getTemp(address)
Celsius = getTemp(address)
Fahrenheit = 9.0/5.0 * Celsius + 32
print Fahrenheit, "*F /", Celsius, "*C"
#os.system('sudo modprobe rtc_ds1307')
