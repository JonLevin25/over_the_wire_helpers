#!/bin/bash

GAME="$1"
LVL="$2"
PASS="$3"
dir="$HOME/.otw_helpers/$GAME"
passFile="passwords.json"
oldPassFile="bkp_passwords.json"
tmpFile="/tmp/overthewire_savepass.tmp"

function help_and_exit()
{
	echo "Usage: $0 <game> <level> <password>"
	exit 1
}

[[ $# < 3 ]] && help_and_exit

if ! ./validate_game.sh "$GAME"; then
	echo "[OTW:$GAME] Invalid game! Create using ./add_game <game> <port>"
	exit 1
fi

# Create and move to dir
mkdir -p $dir
cd $dir

if [ ! jq  ]; then
	echo 'missing dependencies. run `sudo apt install jq`'
	exit 1
fi

# create missing files - backup pass file
if [ ! -s $passFile ]; then
	echo "Creating pass file ($passFile)"
	echo '{}' > $passFile
else
	echo "Backing up passes in $oldPassFile"
	cp $passFile $oldPassFile
fi

# modify json to store password, copy it to a temp file first
# (writing straight to json fails since jq already has it open)
jq ".[\"$LVL\"] |= \"$PASS\"" $passFile > $tmpFile
echo "Temp json saved to $tmpFile"
cp $tmpFile $passFile
echo "$passFile: Saved [$LVL => $PASS]"
rm $tmpFile
