#!/bin/bash 
##
IP="google.com"
delay="10"
echo "*script is running*"

while true
do
	traceroute "$IP"|grep -oE "^  [0-9] *[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" >old.tmp&
	sleep $delay
	traceroute "$IP"|grep -oE "^  [0-9] *[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" >new.tmp&
	wait
	diff -u old.tmp new.tmp >/dev/null
	if [ $? -eq 0 ];then
		echo "**route OK**"
	else 
		echo -e "(here the traceroute is changed)\n**ALERT: route was changed !** $IP"
	fi
done
