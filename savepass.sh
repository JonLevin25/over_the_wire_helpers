#!/bin/bash

LVL="$1"
PASS="$2"
dir="$HOME/.otw_helpers"
passFile="passwords.json"
oldPassFile="bkp_passwords.json"
tmpFile="/tmp/overthewire_savepass.tmp"

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
