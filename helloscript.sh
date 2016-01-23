#!/bin/bash

# Yet another script to display Hello World! using sed and awk
# Michael Sartori - Jan 22 2016

echo -n "helb wold" |sed -e "s/b/o/g" -e "s/l/ll/" -e "s/ol/orl/" |tr "h" "H"|tr "w" "W"|awk '{print $1 "\x20" $2 "\41"}'

exit 0
