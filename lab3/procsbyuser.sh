#!/bin/bash

# this script will display a summary of the number of running processes, grouped by username
# it will also show the specific processes, if any, being run by the user 'nobody'


echo -e "Here are the number of processes being run by each user:\n"
ps -hauxOu | awk '{print $1}' | uniq -c

ps -u nobody &>/dev/null
if [ $? -eq 0 ]; then
	echo -e "\n\nHere are the processes being run by the user 'nobody':\n"
	ps -u nobody
else
	echo -e "\n\nThere are no processes being run by the user 'nobody'"
fi
