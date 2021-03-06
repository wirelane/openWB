#!/bin/bash

i3timer=$(</var/www/html/openWB/ramdisk/soctimer)
cd /var/www/html/openWB/modules/soc_i3
if (( i3timer < 60 )); then
	i3timer=$((i3timer+1))
	echo $i3timer > /var/www/html/openWB/ramdisk/soctimer
else
	re='^-?[0-9]+$'
	soclevel=$(sudo php index.php | jq .chargingLevel)
	if  [[ $soclevel =~ $re ]] ; then
		if (( $soclevel != 0 )) ; then
			echo $soclevel > /var/www/html/openWB/ramdisk/soc
		fi
	fi
	echo 0 > /var/www/html/openWB/ramdisk/soctimer
fi
