#!/bin/bash

helpers_dir="${HOME}/.otw_helpers"
GAME="$1"
ssh_port_file="ssh_port"
ssh_port_path_full="$helpers_dir/$GAME/$ssh_port_file"

if [[ $# < 1 ]]; then
	echo 'Cannot valiadate OTW game-no game given!'
	exit 1
fi

echo "[OTW:$GAME] Validating"

mkdir -p $helpers_dir
if ! [ -d "$helpers_dir/$GAME" ]; then
	echo "[OTW:$GAME] Invalid - no game directory"
	exit 1 
fi

if ! [ -f "$ssh_port_path_full" ]; then
	echo "[OTW:$GAME] Invalid - no $ssh_port_file file"
	exit 1
fi

port=`cat $ssh_port_path_full`

./validate_port.sh "$port"

# will exit with port_is_ok exit code
