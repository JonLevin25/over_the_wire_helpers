
GAME=$1
LVL=$2
dir="$HOME/.otw_helpers/$GAME"
passFile="passwords.json"
ssh_port_file="ssh_port"

function help_and_exit()
{
	echo "Usage: $0 <game> <level> [password]"
	echo "	if password is not provided $passFile will be tried."
	exit 1
}

[[ $# < 2 ]] && help_and_exit
./validate_game.sh "$GAME" || help_and_exit

mkdir -p $dir
cd $dir

# check for missing dependencies
if [ ! sshpass &> /dev/null ] || [ ! jq --version &> /dev/null ]; then
	echo 'missing dependencies. run `sudo apt install sshpass jq`'
	exit 1
fi

# Get the password (from commandline args or pass file)
if [ $# -gt 2 ]; then
	PASS="$3"
	echo "Manual pass provided ($PASS). will not check file";
else
	if [ ! -s $passFile ]; then
		echo "no pass file created! either provide a manual pass as argument, or save it using save_pass"
		exit 1
	fi
	PASS=`jq -r ".[\"$LVL\"]" $passFile` # -r : raw output (no double quotes)
fi	 

port="`cat $ssh_port_file`"
echo "OTW $GAME (port: $port): logging into level ${LVL} with password [$PASS]"
sshpass -p "$PASS" ssh -p $port "${GAME}${LVL}@${GAME}.labs.overthewire.org"
