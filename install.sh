#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

files="gitconfig gvimrc vimrc vim gitignore_global tmux.conf zshrc zshenv"

mkdir -p ~/dotfiles.old

for file in $files; do
	mv ~/.$file ~/dotfiles.old/
	ln -s $DIR/$file ~/.$file
done

# Nvim specific
mkdir -p $HOME/.config/nvim
mv $HOME/.config/nvim $HOME/.config/nvim.old
ln -s $DIR/vim $HOME/.config/nvim
ln -s $DIR/vimrc $HOME/.config/nvim/init.vim

#Installs the bundles configured in .vimr using Vundle
nvim +BundleInstall +qa

#Use only the snippets defined in snipmate-snippets
if [ -d "$HOME/.vim/bundle/snipmate.vim/snippets" ]; then
	mv $HOME/.vim/bundle/snipmate.vim/snippets $HOME/.vim/bundle/snipmate.vim/old.snippets
fi
