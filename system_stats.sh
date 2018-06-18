#!/bin/bash
#Simple motd script for Centos 5/6
#created by Vitalijus Ryzakovas

b=`tput bold`
n=`tput sgr0`

cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))
cpuTemp2=$(($cpuTemp0/100))
cpuTempM=$(($cpuTemp2 % $cpuTemp1))

gpuTemp0=$(/opt/vc/bin/vcgencmd measure_temp)
gpuTemp0=${gpuTemp0//\'/º}
gpuTemp0=${gpuTemp0//temp=/}

echo -e "\n${b}Hostname:${n} `hostname` \t\t ${b}IP address:${n} `ifconfig eth0 | grep "inet" | grep -v "inet6" | awk '{print $2}' | cut -d: -f2`"
echo -e "${b}CPU load:${n} `cat /proc/loadavg | cut -d" " -f1-3` \t ${b}Uptime:${n} `uptime | cut -d" " -f 4-7 | cut -d"," -f1-2`"
echo -e "\n${b}CPU Temp:${n} $cpuTemp1"."$cpuTempM"ºC" \t\t ${b}GPU Temp:${n} $gpuTemp0"
echo -e "\n${b}Free memory:${n} `cat /proc/meminfo | grep MemFree | awk {'print int($2/1000)'}` MB \t\t ${b}Avail. memory:${n} `cat /proc/meminfo | grep MemAvailable | awk {'print int($2/1000)'}` MB"
echo -e "${b}Cached memory:${n} `cat /proc/meminfo | grep Cached | grep -v SwapCached | awk {'print int($2/1000)'}` MB \t\t ${b}Buffer memory:${n} `cat /proc/meminfo | grep Buffers | awk {'print int($2/1000)'}` MB"
echo -e "\n${b}Active sessions:${n} \t\t ${b}Process number:${n} `cat /proc/loadavg | cut -d"/" -f2| cut -d" " -f1`"
echo -e "`w | tail -n +2`"

