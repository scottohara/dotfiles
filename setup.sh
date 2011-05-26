#!/bin/bash

echo "Symlinking .vim/autoload (pathogen)"
ln -s ./.vim/autoload/autoload ~/.vim/autoload
echo "Symlinking ./vim/bundle (plugins)"
ln -s ./.vim/bundle ~/.vim/bundle
echo "Symlinking ./vimrc"
ln -s ./.vimrc ~/.vimrc
echo "Symlinking .gitconfig"
ln -s ./.gitconfig ~./gitconfig
echo "Symlinking .bashrc"
ln -s ./.bashrc ~/.bashrc
echo "Symlinking .zshrc"
ln -s ./.zshrc ~/.zshrc
echo "Done"
exit 0
