#!/bin/bash

# This script will list all of the setuid and setgid regular files in the /usr directory tree
# Michael Sartori - Jan 22 2016

echo "setuid:"
find /usr -perm -4000 -ls
echo -e "\nsetgid:"
find /usr -perm -6000 -ls
