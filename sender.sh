#!/bin/bash

COUNT=0
TIME=""
for i in $(seq 1 6)
do
	echo "============="
	echo "STAGE $i OF 6"
	echo "============="
	./digilife.sh > tmp.txt
	grep '1 passing' tmp.txt
	if [ $? -eq 0 ]
	then
	  TIME=$(grep '1 passing' tmp.txt | awk '{print $7}' | tr -d '()s' | sed 's/[^0-9.]//g' | sed 's/..$//')
		COUNT=$((COUNT + 1))
	fi
	# grep '1 passing' tmp.txt
	# if [ $? -eq 0 ]
	# then
	# 	COUNT=$((COUNT + 1))
	# fi
	sleep 60
	sync
done
if [ $COUNT -gt 0 ]
then
	zabbix_sender -z 127.0.0.1 -p 10051 -s "digilife" -k time -o $TIME
	zabbix_sender -z 127.0.0.1 -p 10051 -s "digilife" -k log -o 'login successful'
else
	zabbix_sender -z 127.0.0.1 -p 10051 -s "digilife" -k time -o $TIME
	zabbix_sender -z 127.0.0.1 -p 10051 -s "digilife" -k log -o 'login successful'
fi
rm tmp.txt
# ./digilife.sh > tmp.txt
# TIME=$(grep '1 passing' tmp.txt | awk '{print $7}' | tr -d '()s' | sed 's/[^0-9.]//g' | sed 's/..$//')
# grep '1 passing' tmp.txt
# if [ $? -eq 0 ]
# then
# 	zabbix_sender -z 127.0.0.1 -p 10051 -s "digilife" -k time -o $TIME
# 	zabbix_sender -z 127.0.0.1 -p 10051 -s "digilife" -k log -o 'login successful'
# else
# 	zabbix_sender -z 127.0.0.1 -p 10051 -s "digilife" -k time -o 0
# 	zabbix_sender -z 127.0.0.1 -p 10051 -s "digilife" -k log -o 'login unsuccessful'
# fi
# rm tmp.txt
