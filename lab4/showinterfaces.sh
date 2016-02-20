#!/bin/bash

# This script will show the IP address assigned to each interface
# The user has the option to specify which interfaces to show
# The user also has the option to show the IPv4 address of the
#+ default route (gateway)
#
# Michael Sartori - Feb 20, 2016



declare -a interfaces # array of interface names
booleanShowGW=false # boolean variable of whether to dispay default route or not


# get the filename of this script
filename=$(basename $0)


# display command help
cmdhelp() {
	cat <<-EOF
		Usage: $filename [OPTION...] [INTERFACE]
		Display IPv4 addressing of local interfaces
                
                
		Optional arguments:
                
		-r, --route        display address of IPv4 default gateway
              
                
		Examples:
                
		$filename --route
		$filename --r eth0
		$filename eth0 wlan0 lo
	EOF
}


# send information regarding incorrect syntax to STDERR
error-message() {
        echo "$filename: $1" >&2
        echo "Try '$filename --help' for more information" >&2
}


# convert dotted-decimal subnet mask to CIDR notation
mask2cidr() {
        nbits=0
        IFS=.
        for dec in $1; do
                case $dec in
                        0) ;;
                        128) let nbits+=1 ;;
                        192) let nbits+=2 ;;
                        224) let nbits+=3 ;;
                        240) let nbits+=4 ;;
                        248) let nbits+=5 ;;
                        252) let nbits+=6 ;;
                        254) let nbits+=7 ;;
                        255) let nbits+=8 ;;
                        *) error-message "mask2cidr(): $dec not recognized"; exit 1 ;;
                esac
        done
        echo "/$nbits"
	unset nbits
}


# display IPv4 address and CIDR mask for each interface in interfaces[]
showaddr() {
	for (( i=0 ; i < ${#interfaces[@]} ; i++ )); do
		line="$(ifconfig "${interfaces[i]}" | grep "inet addr")" # find line
		if [ $? -eq 0 ]; then
			addr="$(echo $line | cut -d':' -f2 | cut -d' ' -f1)" # assign IPv4 address to $addr
			addr+="$(mask2cidr $(echo $line | sed 's/.*Mask://'))" # add CIDR mask to $addr
			echo "${interfaces[i]} has an IPv4 address of $addr"
			unset line
			unset addr
		else
			echo "${interfaces[i]} does not have an IPv4 address"
		fi
	done
}


# parse the route -n command to retrieve and display the default gateway
showgw() {
	gw=$(route -n | grep ^0.0.0.0 | awk '{print $2}')
	[ $gw ] && echo "The IPv4 default route is $gw" ||
		echo "There is no IPv4 defualt route"
	unset gw
}


# assign list of interface names to interfaces[]
findints() {
	for i in $(ifconfig | egrep '^[[:alpha:]]' | awk '{print $1}'); do
		interfaces+=("$i")
	done
}



#######
# MAIN
#######


# evaluate arguments passed from command line,
#+ looping until all arguments have been processed or
#+ an invalid argument is detected
# an invalid argument will cause the script to exit with status 2
while [ $# -gt 0 ]; do
	case "$1" in
		-h|--help )
			cmdhelp
			exit 0
			;;
		-r|--route )
			if ! $booleanShowGW; then
				booleanShowGW=true
			else
				error-message "duplicate argument -- '$1'"
				exit 2
			fi
			;;
		*)
			ifconfig "$1" &>/dev/null
			if [ $? -eq 0 ]; then
				interfaces+=("$1")
			else
				error-message "interface $1 does not exist"
				exit 1
			fi
			;;
	esac
	shift
done


# run findints() if no interfaces were specified on the command line
[ ${#interfaces[@]} -eq 0 ] && findints 

# display the addresses
showaddr

# run showgw() if the [-r|--route] option was given on the command line
$booleanShowGW && showgw
