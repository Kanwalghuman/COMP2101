#!/bin/bash

# this script will display some text to the screen using a combination of local and environment variables
# Michael Sartori - Feb 5, 2016

export MYNAME="Michael"
mytitle="Grand Master"
hostname=`hostname`
weekday=`date +%A`


echo -e "Welcome to planet $hostname, $mytitle $MYNAME!\nToday is $weekday."
