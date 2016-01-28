#!/bin/bash

# This script will bacup the ~/bin directory to ~/backups using rsync


rsync -av --delete ~/bin ~/backups

if [ $? == 0 ]; then
	echo -e "\n\nBACKUP SUCCESSFUL"
else
	echo -e "\n\nBACKUP FAILED!!!!"
fi
