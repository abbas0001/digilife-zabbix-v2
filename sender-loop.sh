#!/bin/bash

while true
do
	./sender.sh
	sleep 20
	sync
done
