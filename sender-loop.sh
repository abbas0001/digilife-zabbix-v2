#!/bin/bash

while true
do
	./sender.sh
	pkill chrome
	sync
	sleep 300
done
