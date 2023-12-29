#!/bin/sh
set -e

if [ -f ~/.vimrc ]; then
    echo "~/.vimrc already exists. Exiting without making changes."
    exit 1
fi

curl https://raw.githubusercontent.com/nubiv/vimrc/main/.vimrc >> ~/.vimrc

echo "Completed Vim configuration successfully! Enjoy :-)"
