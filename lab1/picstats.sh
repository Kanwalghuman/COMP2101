#!/bin/bash

# This script will display the disk usage for the files in the ~/Pictures directory and also show the three largest files
# Michael Sartori - Jan 22 2016


numberOfFiles=`find ~/Pictures -type f | wc -l`
diskUsage=`du -h ~/Pictures | awk '{print $1}'`


cat <<EOF

There are $numberOfFiles files in the $HOME/Pictures directory, with a total disk usage of $diskUsage
Here are the three largest files, in order, with their respective file sizes:

EOF

du -h ~/Pictures/* | sort -hr | head -n3
echo ''
