#!/bin/bash

# This script uses a function to send arguments from the
#+ command line to STDERR
#
# Michael Sartori - Feb 19, 2016



# get the filename of this script
filename=$(basename $0)


# an interesting example of actually making a script
#+ longer by using a function :P
error-message() {
	>&2 echo "$filename: $1"	
}



#######
# MAIN
#######


# loop through all of the command line args and send
#+ them to STDERR by using error-message()
while [ $# -gt 0 ]; do 
	error-message "$1"
	shift
done
