# Over the Wire Helpers
A helper for saving OverTheWire passwords, and easier login.
<br> Also for learning bash scripting / git cmdline.
<br>
<br> NOTE: Since learning the ssh command is part of the game, it's recommended to do it yourself for the first few levels!

## Installation
1. Install dependencies: `sudo apt install jq sshpass`
1. clone locally
2. make scripts executable
```bash
sudo chmod +x bandit.sh
sudo chmod +x savepass.sh
```

## Usage

`cd` into dir, and run using `./<scriptname>`
<br> NOTE: `./` is required before the scripts to run (or use `bash <scriptname>` instead)

### Saving passwords
`./savepass.sh <level-number> <password>`
<br>
<br>I.e. if you just finished level `3`, and got the password `IamAPassForLvl4`
You'd run `./savepass.sh 4 IamAPassForLvl4`.

### Logging in
`./bandit.sh <level-number> [password]`
<br>If `password` is explicitly specified, the password file will be ignored.
<br>Otherwise - the password file will be queried for the level you're trying to enter.
<br>
<br>I.e. `./bandit.sh 4` - will try to login to level 4 using a previously saved password


## Structure
`.otw_helpers` contains both a password json file and a backup json file.
<br>If you mess up your password file, you can replace it with the backup using `mv`
