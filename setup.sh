#!/bin/bash

if [ ! -d ~/.vim ]; then
	echo "Creating .vim directory"
	mkdir ~/.vim
fi

echo "Symlinking .vim/autoload (pathogen)"
ln -s $(dirname "$0")/.vim/autoload/autoload ~/.vim/autoload
echo "Symlinking ./vim/bundle (plugins)"
ln -s $(dirname "$0")/.vim/bundle ~/.vim/bundle
echo "Symlinking ./vimrc"
ln -s $(dirname "$0")/.vimrc ~/.vimrc
echo "Symlinking .gitconfig"
ln -s $(dirname "$0")/.gitconfig ~/.gitconfig
echo "Symlinking .bashrc"
ln -s $(dirname "$0")/.bashrc ~/.bashrc
echo "Symlinking .zshrc"
ln -s $(dirname "$0")/.zshrc ~/.zshrc

if [ -d ~/.kde/share/apps/konsole ]; then
	echo "KDE detected, symlinking Konsole Solarized"
	ln -s $(dirname "$0")/konsole-colors-solarized/Solarized\ Dark.colorscheme ~/.kde/share/apps/konsole/Solarized\ Dark.colorscheme
	ln -s $(dirname "$0")/konsole-colors-solarized/Solarized\ Light.colorscheme ~/.kde/share/apps/konsole/Solarized\ Light.colorscheme
fi

if [ -d ~/.gconf/apps/gnome-terminal/profiles ]; then
	echo "Gnome detected, configuring Gnome Terminal Solarized"
	cd $(dirname "$0")/gnome-terminal-colors-solarized
	./install.sh
fi

echo "Done"
exit
