#!/bin/bash
. /var/www/html/openWB/openwb.conf
re='^-?[0-9]+$'
rekwh='^[-+]?[0-9]+\.?[0-9]*$'

output=$(curl --connect-timeout $evsewifitimeoutlp2 -s http://$evsewifiiplp2/getParameters)
watt=$(echo $output | jq '.list[] | .actualPower')
lla1=$(echo $output | jq '.list[] | .currentP1')
lla2=$(echo $output | jq '.list[] | .currentP2')
lla3=$(echo $output | jq '.list[] | .currentP3')
llkwh=$(echo $output | jq '.list[] | .meterReading')
watt=$(echo "scale=0;$watt * 1000 /1" |bc)
if [[ $watt =~ $re ]] ; then
	echo $watt > /var/www/html/openWB/ramdisk/llaktuells1
fi
if [[ $lla1 =~ $re ]] ; then
	echo $lla1 > /var/www/html/openWB/ramdisk/llas11
fi
if [[ $lla2 =~ $re ]] ; then
	echo $lla2 > /var/www/html/openWB/ramdisk/llas12
fi
if [[ $lla3 =~ $re ]] ; then
	echo $lla3 > /var/www/html/openWB/ramdisk/llas13
fi
if [[ $llkwh =~ $rekwh ]] ; then
	echo $llkwh > /var/www/html/openWB/ramdisk/llkwhs1
fi
