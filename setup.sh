#!/bin/bash

function make_link() {
	local source_file="$1"
	local target_file="$2"
	local valid_choice="N" 

	# Check if the target already exists
	if [ -e $target_file ]; then
		until [ $valid_choice = "Y" ]; do
			# Prompt the user to replace
			read -p "$target_file already exists. Replace with symlink to $source_file? (y)es, (n)o or (a)bort [enter = no]: " replace_target
			[ -z "$replace_target" ] && replace_target="N"

			case "$replace_target" in
				[yY])
					# User opted to replace, so remove the existing target
					rm -rf "$target_file"
					valid_choice="Y"
					;;
				[nN])
					# User declined to replace, so take no action and return
					echo "Leaving $target_file untouched."
					return
					valid_choice="Y"
					;;
				[aA])
					# User aborted
					echo "Leaving $target_file untouched. Aborting."
					valid_choice="Y"
					exit 1
					;;
			esac
		done
	fi

	# Create the symlink
	echo "Linking $source_file -> $target_file"
	ln -s $source_file $target_file
}

# Default mode is to install (i), unless -u option passed
MODE="i"

while getopts 'u' OPTION; do
	case $OPTION in
		u)	MODE="u"
			;;
	esac
done

# Get the name of this script
THIS_SCRIPT=`basename "$0"`

# Change to the script directory
cd `dirname "$0"`

# Iterate down a (possible) chain of symlinks
while [ -L "$THIS_SCRIPT" ]
do
	THIS_SCRIPT=`readlink $THIS_SCRIPT`
	cd `dirname $THIS_SCRIPT`
	THIS_SCRIPT=`basename $THIS_SCRIPT`
done

# Canonicalize the physical path
SCRIPT_DIR=`pwd -P`

if [ $MODE = "i" ]; then
	# Make the topics available at ~/.dotfiles
	DOTFILES_DIR=~/.dotfiles
	eval DOTFILES_DIR="$DOTFILES_DIR"		# expand to full path

	# If we're not already in ~/.dotfiles
	if [ "$SCRIPT_DIR" != "$DOTFILES_DIR" ]; then
		make_link $SCRIPT_DIR $DOTFILES_DIR
	fi
	
	# Symlink all {name}.symlink files in topics to ~/.{name}
	for symlink_file in $SCRIPT_DIR/**/*.symlink
	do
		symlink_basename=`basename $symlink_file`
		symlink_basename=~/.${symlink_basename%.symlink}
		make_link $symlink_file $symlink_basename
	done

	# Copy all {name}.launchagent files in topics to ~/Library/LaunchAgents/{name}.plist
	for launchagent_file in $SCRIPT_DIR/**/*.launchagent
	do
		launchagent_basename=`basename $launchagent_file`
		launchagent_basename=~/Library/LaunchAgents/${launchagent_basename%.launchagent}.plist
		cp $launchagent_file $launchagent_basename
	done

	if [ -d ~/.kde/share/apps/konsole ]; then
		echo "KDE detected, symlinking Konsole Solarized"
		ln -s $SCRIPT_DIR/konsole-colors-solarized/Solarized\ Dark.colorscheme ~/.kde/share/apps/konsole/Solarized\ Dark.colorscheme
		ln -s $SCRIPT_DIR/konsole-colors-solarized/Solarized\ Light.colorscheme ~/.kde/share/apps/konsole/Solarized\ Light.colorscheme
	fi

	if [ -d ~/.gconf/apps/gnome-terminal/profiles ]; then
		echo "Gnome detected, configuring Gnome Terminal Solarized"
		cd $SCRIPT_DIR/gnome-terminal-colors-solarized
		./install.sh
	fi
else
	# Remove any symlinks to the script directory
	symlinks=`ls -lah ~ | grep "^l.*->\ $SCRIPT_DIR" | awk '{print $9}'`
	for symlink_file in $symlinks; do
		echo "Unlinking $symlink_file"
		rm $symlink_file
	done

	if [ -d ~/.kde/share/apps/konsole ]; then
		echo "KDE detected, removing symlink for Konsole Solarized"
		rm ~/.kde/share/apps/konsole/Solarized\ Dark.colorscheme
		rm ~/.kde/share/apps/konsole/Solarized\ Light.colorscheme
	fi

	if [ -d ~/.gconf/apps/gnome-terminal/profiles ]; then
		echo "Gnome detected, sorry no uninstall option for Gnome Terminal Solarized"
	fi
fi
	
echo "Done"
exit
