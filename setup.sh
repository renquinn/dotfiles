#!/usr/bin/env bash

echo "Installing dotfiles..."

function link() {
    echo -e "\nInstalling $1";
    ln -s $PWD/$1 $2
}

link bash_profile ~/.bash_profile
link git-completion.bash ~/.git-completion.bash
link gitconfig ~/.gitconfig
link gitignore ~/.gitignore
link inputrc ~/.inputrc
link vimrc ~/.vimrc
