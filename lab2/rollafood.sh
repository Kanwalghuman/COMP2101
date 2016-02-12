#!/bin/bash

# this script does some immensely intersting things with arrays
# Michael Sartori - Feb 5, 2016


food=("apple" "black cherry" "coconut" "dragonfruit" "elderberry" "fig" "guava" "honeydew" "imbe" "jujube" "kiwifruit")
num1=$(( $RANDOM % 6 + 1 ))
num2=$(( $RANDOM % 6 + 1 ))
i=$(( $num1 + $num2 - 2))

echo "The food at food[$i] is ${food[i]}"
