#!/bin/bash
GAME=$1
passFile="${HOME}/.otw_helpers/${GAME}/passwords.json"

function help_and_exit()
{
	echo "Usage: $0 <game>"
	echo '	Prints all saved passwords for the game given'
	exit 1
}

[[ $# < 1 ]] && help_and_exit
[ -f $passFile ] &&  cat $passFile || echo "no pass file created!"
