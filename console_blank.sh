#!/bin/bash 

if [ $# == 0 ]; then
	echo -e '\033[9;0]' > /dev/tty1
else
	echo -e '\033[9;1]' > /dev/tty1
fi



