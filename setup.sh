#!/bin/bash

# Default mode is to install, unless -u option passed
MODE="i"

while getopts 'u' OPTION
do
	case $OPTION in
	u)	MODE="u"
		;;
	esac
done

if [ $MODE = "i" ]; then
	# Get the name of this script
	THIS_SCRIPT=`basename "$0"`
	echo "Running $THIS_SCRIPT"

	# Change to the script directory
	echo "Changing to $(dirname "$0")"
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
	echo "Path to link targets: $SCRIPT_DIR"

	if [ ! -d ~/.vim ]; then
		echo "Creating .vim directory"
		mkdir ~/.vim
	fi

	echo "Symlinking .vim/autoload (pathogen)"
	ln -s $SCRIPT_DIR/.vim/autoload/autoload ~/.vim/autoload
	echo "Symlinking .vim/bundles.vim (vundler)"
	ln -s $SCRIPT_DIR/.vim/bundles.vim ~/.vim/bundles.vim
	echo "Symlinking .vim/bundle (plugins)"
	ln -s $SCRIPT_DIR/.vim/bundle ~/.vim/bundle
	echo "Symlinking .vimrc"
	ln -s $SCRIPT_DIR/.vimrc ~/.vimrc
	echo "Symlinking .gitconfig"
	ln -s $SCRIPT_DIR/.gitconfig ~/.gitconfig
	echo "Symlinking .zshrc"
	ln -s $SCRIPT_DIR/.zshrc ~/.zshrc
	echo "Symlinking .profile"
	ln -s $SCRIPT_DIR/.profile ~/.profile

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
	echo "Removing .vim directory"
	rm -rf ~/.vim
	echo "Removing symlink for .vimrc"
	rm ~/.vimrc
	echo "Removing symlink for .gitconfig"
	rm ~/.gitconfig
	echo "Removing symlink for .zshrc"
	rm ~/.zshrc
	echo "Removing symlink for .profile"
	rm ~/.profile

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
