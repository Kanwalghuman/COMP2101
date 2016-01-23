#!/bin/bash

# This script will list all of the setuid and setgid regular files in the /usr directory tree
# Michael Sartori - Jan 22 2016


find /usr -name setuid* -o -name setgid*
