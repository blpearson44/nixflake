#!/run/current-system/sw/bin/bash
# If ~/.dotfiles exists, copy master hash in local dotfiles repo to current directory under ./dothash
# If not, clone the repo based on the hash located at ./dothash

# Directory for the dotfiles git repo
DIRECTORY=$HOME/.dotfiles
REPO=git@github.com:blpearson44/dotfiles.git
HEAD=$DIRECTORY/.git/refs/heads/master
CURHASH="$(< ./dothash)"

printf "Dotfile management...\nChecking if '$DIRECTORY' exists...\n"
if [ -d "$DIRECTORY" ]; then
	printf "'$DIRECTORY' exists, checking './dothash' against master...\n"
	cmp ./dothash $HEAD && printf "No change in hash, exiting...\n" && exit 1
	/run/current-system/sw/bin/cp $HEAD ./dothash
	printf "Done!\nMaster head set at "
	/run/current-system/sw/bin/cat $HEAD
else
	printf "'$DIRECTORY' does not exist, generating dotfiles repo...\n"
	git clone $REPO $DIRECTORY
	printf "Changing head to match './dothash...'\n"
	cd $DIRECTORY
	git reset --hard $CURHASH
	printf "Done!\nHead set at $CURHASH\n"
	printf "Symlinking contents of '$DIRECTORY'...\n"
	./symlinks.sh
fi
printf "Dotfiles are up to date!\n"
