#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

files="gitconfig gvimrc vimrc vim bash bashrc gitignore_global tmux.conf"

mkdir -p ~/dotfiles.old

for file in $files; do
	if [ -d $file ]; then
		cp ~/.$file ~/dotfiles.old/
		ln -s $DIR/$file ~/.$file
	fi
done

#Installs the bundles configured in .vimr using Vundle
vim +BundleInstall +qa

#Use only the snippets defined in snipmate-snippets
if [ -d "$HOME/.vim/bundle/snipmate.vim/snippets" ]; then
	mv $HOME/.vim/bundle/snipmate.vim/snippets $HOME/.vim/bundle/snipmate.vim/old.snippets
fi
