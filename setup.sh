#!/usr/bin/env bash

set -x

# Make sure we have pulled in and updated any modules

echo $(pwd)

git submodule init
git submodule update

# what directories should be installable by all users including the root user
base=(
        astyle
	bash
	git
	Xresources
	gtk
	alacritty
	sway
        waybar
        vim
        yay
        tmux
        zsh
)

# run the stow command for the passed in directory ($2) in location ($1)

stowit() {
	usr=$1
	app=$2
	# -v verbose
	# -R recurseive
	# -t target
	stow -R -t ${usr} ${app}
}

echo ""
echo "Stowing apps for user: $(whoami)"

cd configs

for app in ${base[@]}; do
	stowit $HOME $app
done 

echo ""
echo "###### ALL DONE"
