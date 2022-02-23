

LVL=$1
dir="$HOME/over_the_wire"
passFile="passwords.json"

mkdir -p $dir
cd $dir

if [ ! sshpass -h > /dev/null ] || [ ! jq --version > /dev/null ]; then
	echo 'missing dependencies. run `sudo apt install sshpass jq`'
	exit 1
fi

echo $#
# Get the password (from commandline args or pass file)
if [ $# -gt 1 ]; then
	PASS="$2"
	echo "Manual pass provided ($PASS). will not check file";
else
	if [ ! -s $passFile ]; then
		echo "no pass file created! either provide a manual pass as argument, or save it using save_pass"
		exit 1
	fi
	PASS=`jq -r ".[\"$LVL\"]" $passFile` # -r : raw output (no double quotes)
fi	 

# Make sure we have sshpass insatlled
sshpass &> /dev/null
if [ $? != 0 ]; then
echo "sshpass is not working. did you \"sudo apt install sshpass\"?"
exit
fi

echo "Bandit: Trying to log into level ${LVL} with password [$PASS]"
sshpass -p "$PASS" ssh -p 2220 "bandit${LVL}@bandit.labs.overthewire.org"
