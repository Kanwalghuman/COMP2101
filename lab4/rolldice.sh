#!/bin/bash

# This script will prompt the user to provide a count from 1 to 5, which will be the number of dice, defaulting to 2.
# The user will also be prompted for how many sides the dice should have in the range of 4-20 (each will have the same number of sides), defaulting to 6.
# The script will then roll the virtual dice and display the randomized value of each, along with the sum of the rolls.
# The user has the option to use the -h/--help switch at the command line, as well was setting the number of dice and number of sides as command line arguments.
#
# Michael Sartori - Feb 19, 2016



# get the filename of this script
filename=$(basename ${BASH_SOURCE[0]})


# display command help
cmdhelp() {
	cat <<-EOF
		Usage: $filename [OPTION...]
		Roll virtual dice for a random value.
		
		
		Optional arguments:
		
		-d, --dice=VALUE	specify the number of dice to be used [1-5]
		-s, --sides=VALUE	specify the number of sides to be used [4-20]
		
		
		Examples:
		
		$filename -d 1
		$filename --sides=4
		$filename --dice=5 -s 20
	EOF
}


# send information regarding incorrect syntax to STDERR
badsyntax() {
	echo "$filename: $1" >&2
	echo "Try '$filename --help' for more information" >&2
}


# prompt user with string at $1 for a value between $2 and $3,
#+ assiging the reply to the variable named at $4
# loop until user inputs a valid number (integer between $2 and $3, inclusive)
prompt() {
	while (true); do
		read -p "$1"
		if [ -z "$REPLY" ]; then
			eval "$4=2"
			break
		elif [[ $REPLY -ge $2 && $REPLY -le $3 ]] 2>/dev/null; then
			eval "$4=$REPLY"
			break
		else
			printf "\n%\n\n" "$REPLY is not a number from $2 to $3. Try again."
		fi
	done
}


# send the result of the virtual dice roll to STDOUT
output() {
	printf "\n%s " "You rolled"
	for (( i=1 ; i <= numdice ; i++ )); do
		roll=$(($RANDOM % $numsides + 1))
		let sum+=$roll
		echo -n "$roll"
		[ $i -lt $numdice ] && echo -n ","
	done
	printf " %s\n\n" "for a $sum"
}


# evaluate the value given with the [-d|--dice] option,
#+ assigning to $numdice if valid and passing appropriate
#+ information to badsyntax() if not
# script will exit with status 2 if invalid value is given
args_numdice() {
	if [[ "$2" =~ ^[1-5]$ ]]; then
		numdice=$2
	elif [ ! "$2" ]; then
		badsyntax "option requires an argument -- '$1'"
		exit 2
	else
		badsyntax "invalid number of dice"
		exit 2
	fi
}


# evaluate the value given with the [-s|--sides] option,
#+ assigning to $numsides if valid and passing appropriate
#+ information to badsyntax() if not
# script will exit wiith status 2 if invalid value is given
args_numsides() {
	if [[ "$2" =~ ^[[:digit:]][[:digit:]]?$ ]]; then
		if [[ $2 -ge 4 && $2 -le 20 ]]; then
			numsides=$2
		else
			badsyntax "invalid number of sides"
			exit 2	
		fi
	elif [ ! "$2" ]; then
		badsyntax "option requirees an argument -- '$1'"
		exit 2
	else
		badsyntax "invalid number of sides"			
		exit 2
	fi
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
	-d )
		if [ ! "$numdice" ]; then # if [-d|--dice] has not already been used
			args_numdice '-d' "$2"
			shift
		else
			badsyntax "duplicate argument -- '-d'"
			exit 2
		fi
		;;
	--dice=* )
		if [ ! "$numdice" ]; then # if [-d|--dice] has not already been used
			args_numdice '--dice' $(echo "$1" | cut -d'=' -f2)
		else
			badsyntax "duplicate argument -- '--dice'"
			exit 2
		fi
		;;
	-s )
		if [ ! "$numsides" ]; then # if [-s|--sides] has not already been used
			args_numsides '-s' $2
			shift
		else
			badsyntax "duplicate argument -- '-s'"
			exit 2
		fi
		;;
	--sides=* )
		if [ ! "$numsides" ]; then # if [-s|--sides] has not already been used
			args_numsides '--sides' $(echo $1 | cut -d'=' -f2)
		else
			badsyntax "duplicate argument -- '--sides'"
			exit 2
		fi
		;;	
	* )
		badsyntax "invalid argument -- '$1'"
		exit 2
		;;
	esac
	shift
done


# prompt user for input using prompt() if [$numdice|$numsides] was not already defined
#+ at the command line, displaying the results by calling output()
[ ! "$numdice" ] && prompt "Enter the number of dice to be used [1-5, default 2]: " '1' '5' 'numdice'
[ ! "$numsides" ] && prompt "Enter the number of sides the dice should have [4-20, default 6]: " '4' '20' 'numsides'
output
