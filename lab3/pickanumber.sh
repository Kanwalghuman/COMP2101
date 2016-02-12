#!/bin/bash

# this script will ask the user to pick a number from 1 to 10 and compare it to a random number that is generated at execution
# the user will be informed if the number matches he random number and will continue to ask the user for a number until the 
# correct number is guessed

# Michael Sartori - Feb 12, 2016


rnum=$(( $RANDOM % 10 + 1 ))
echo $rnum
while true; do
	while true; do
		read -p "Guess an integer from 1 to 10: " unum
		if [[ $unum -ge 1 && $unum -le 10 ]] 2>/dev/null; then
			break	
		else
			echo "$unum is not an integer from 1 to 10"
		fi
	done
	
	if [ $unum -eq $rnum ]; then
		echo "Correct!"
		exit 0
	else
		echo "You're a terrible guesser!"
	fi
done
