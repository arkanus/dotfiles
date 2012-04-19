#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

files="gitconfig gvimrc vimrc vim bash bashrc"

mkdir -p ~/dotfiles.old

for file in $files; do
	mv ~/.$file ~/dotfiles.old/
	ln -s $DIR/$file ~/.$file
done

#Installs the bundles configured in .vimr using Vundle
vim +BundleInstall +qa
