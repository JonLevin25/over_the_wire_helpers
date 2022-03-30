#!/bin/bash

helpers_dir="${HOME}/.otw_helpers"
GAME="$1"
PORT="$2"
ssh_port_file="ssh_port"

function help_and_exit()
{
	echo "Usage: $0 <game_name> <port_num>"
	exit 1
}

[[ $# < 2 ]] && help_and_exit
./validate_port.sh "$PORT" || help_and_exit

mkdir -p $helpers_dir
cd $helpers_dir
[ -d "$GAME" ] && echo "[OTW:$GAME] dir exists"

mkdir -p "$GAME"
cd "$GAME"

[ -f "$ssh_port_file" ] && echo "[OTW:$GAME] $ssh_port_file file existed. will replace."
echo "$PORT" > "$ssh_port_file"

echo "[OTW:$GAME] finished adding game"
