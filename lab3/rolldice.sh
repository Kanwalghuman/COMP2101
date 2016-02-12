#!/bin/bash

# this script will prompt the user to provide a count from 1 to 5 which will be the number of dice, defaulting to 2
# the user will also be prompted for how many sides the dice should have in the range of 4-20 (each will have the same number of sides), defaulting to 6
# the script will then roll the virtual dice and display the randomized value of each, along with the sum of the rolls
#
# Michael Sartori - Feb 13, 2016


while true; do
	read -p "Enter the number of dice to be used from 1 to 5 [2]: "
	if [ -z "$REPLY" ]; then
		numdice=2
		break
	elif [[ $REPLY -ge 1 && $REPLY -le 5 ]] 2>/dev/null; then
		numdice=$REPLY
		break
	else
		echo -e "\n$REPLY is not a number from 1 to 5. Try again.\n"
	fi
done


while true; do
	read -p "Enter the number of sides the dice should have from 4 to 20 [6]: "
	if [ -z "$REPLY" ]; then
		numsides=6
		break
	elif [[ $REPLY -ge 4 && $REPLY -le 20 ]] 2>/dev/null; then
		numsides=$REPLY
		break
	else
		echo -e "\n$REPLY is not a number from 4 to 20. Try again.\n"
	fi
done


echo -en "\nYou rolled "
for (( i=1 ; i <= numdice ; i++ )); do
	roll=$(($RANDOM % $numsides + 1))
	sum=$(($sum + $roll))
	echo -n "$roll"
	test $i -lt $numdice && echo -n ","
done
echo -e " for a $sum\n"
