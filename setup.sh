#!/usr/bin/env bash

function help() {
    echo "usage: ./setup.sh <command>";
    echo "";
    echo "Commands:";
    echo "    install       Create symlinks";
    echo "    update        Update symlinks";
    echo "    help          Display this help";
}

function link() {
    echo -e "\nInstalling $1";

    ARGS="-s$3"

    if ! ( ln $ARGS $PWD/$1 $2 ) ; then
        echo "Try using the update command (see help)"
    else
        echo "OK"
    fi
}

function perform() {
    echo "Installing dotfiles...";

    link bash_profile ~/.bash_profile $1
    link inputrc ~/.inputrc $1

    # Git
    link git-completion.bash ~/.git-completion.bash $1
    link gitconfig ~/.gitconfig $1
    link gitignore ~/.gitignore $1

    # Vim
    link vimrc ~/.vimrc $1
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    vim +PluginInstall +qall
}

CMD=$1;

case "$CMD" in
    install)
        perform;
        exit $?;
    ;;
    update)
        perform f;
        exit $?;
    ;;
    help)
        help;
        exit $?;
    ;;
    *)
        help;
        exit $?;
    ;;
esac
