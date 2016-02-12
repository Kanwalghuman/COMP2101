#!/bin/bash

# this script will display all of the command line arguments passed to it at execution, on per line


for arg in $@; do
	echo $arg
done
