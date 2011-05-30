#!/bin/bash

SCRIPT_DIR=$(readlink -f "$(dirname "$0")")

if [ ! -d ~/.vim ]; then
	echo "Creating .vim directory"
	mkdir ~/.vim
fi

echo "Symlinking .vim/autoload (pathogen)"
ln -s $SCRIPT_DIR/.vim/autoload/autoload ~/.vim/autoload
echo "Symlinking ./vim/bundle (plugins)"
ln -s $SCRIPT_DIR/.vim/bundle ~/.vim/bundle
echo "Symlinking ./vimrc"
ln -s $SCRIPT_DIR/.vimrc ~/.vimrc
echo "Symlinking .gitconfig"
ln -s $SCRIPT_DIR/.gitconfig ~/.gitconfig
echo "Symlinking .bashrc"
ln -s $SCRIPT_DIR/.bashrc ~/.bashrc
echo "Symlinking .zshrc"
ln -s $SCRIPT_DIR/.zshrc ~/.zshrc

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

echo "Done"
exit
