#!/bin/bash

# this script does some amazing things with associative arrays
# Michael Sartori - Feb 5, 2016


colours=("red" "green" "white" "purple")
declare -A animals
animals=([red]="lobster" [green]="frog" [white]="shitehawk" [purple]="barney")

x=1
while [ $x -eq 1 ]; do
	read -p "Enter an integer from 1 to 4: " num

	if [ $num -ge 1 ] 2>/dev/null && [ $num -le 4 ] 2>/dev/null; then
		x=0
	else
		echo "$num is not an integer from 1 to 4"
	fi
done

colour=${colours[$(( $num - 1 ))]}
animal=${animals[$colour]}
cat <<EOF
Congratulations!
You have won a $colour $animal
EOF
