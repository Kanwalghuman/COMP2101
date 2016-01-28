#!/bin/bash

# This script will display the public IP address of the host
# Michael Sartori - Jan 22 2016


publicIP=`curl -s http://icanhazip.com`

echo -e "\nYour public IP address is $publicIP\n"
