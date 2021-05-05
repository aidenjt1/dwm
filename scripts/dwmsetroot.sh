#!/usr/local/bin/zsh 
while true; do 
	
	xsetroot -name "| MPD $(mpc --host ~/.mpd/socket current) | $(ifconfig | grep ssid | awk '{print$2}') | BAT $(acpiconf -i 0 | grep 'Remaining capacity' | awk '{print $3}') $(apm -a) |  RAM $(sysinfo mem | grep 'Logically used memory:' | awk '{print $4,$5}') |  $(date | awk '{print $2,$3,$4,$6}') 
	"

        sleep 1 
done 
