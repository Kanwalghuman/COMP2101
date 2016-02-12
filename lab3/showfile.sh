#!/bin/bash

# this script will present the user with a menu, showing the names of the files in their home directory
# the user will be asked to choose a file and it will then be displayed on the screen
# Michael Sartori - Feb 13, 2016

filenames=(`ls -p ~ | grep -v /`)

PS3="Choose a file to display: "

select choice in "${filenames[@]}" "None of the above"; do
	if [[ $REPLY -ge 1 && $REPLY -le ${#filenames[@]} ]]; then
		more ~/$choice
		break
	elif [ $REPLY -eq $(( ${#filenames[@]} + 1 )) ] 2>/dev/null; then
		echo "Goodbye!"
		break
	else
		echo "That was not a valid choice. Try again."
	fi
done
