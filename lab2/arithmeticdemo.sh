#!/bin/bash

# This script will prompt the user for 2 number, perform each of the 5 arithmetic operations on them and output the results
# Michael Sartori - Feb 5, 2016


# loops to ask for 2 integers, assigning each to num[]
for i in `seq 0 1`; do
	x=1
	while [ $x -eq 1 ]; do #loops until a valid integer is input
		read -p "Please enter an integer: " num[i]
		
		if [ ${num[i]} -eq ${num[i]} ] 2>/dev/null; then #tests whether input is a valid integer
			x=0
		else
			echo "${num[i]} is not an integer"
		fi
	done
done

#perform the 5 arithmetic operations and display the results
cat <<EOF

${num[0]} + ${num[1]} = $(( ${num[0]}+${num[1]} ))
${num[0]} - ${num[1]} = $(( ${num[0]}-${num[1]} ))
${num[0]} x ${num[1]} = $(( ${num[0]}*${num[1]} ))
${num[0]} / ${num[1]} = $(( ${num[0]}/${num[1]} )) with a remainder of $(( ${num[0]}%${num[1]} ))
EOF
