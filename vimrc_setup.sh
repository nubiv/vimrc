#!/bin/sh
set -e

if [ -f ~/.vimrc ]; then
    echo "~/.vimrc already exists. Exiting without making changes."
    exit 1
fi

curl https://raw.githubusercontent.com/nubiv/vimrc/main/.vimrc >> ~/.vimrc

# Set up NerdTree
git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q
echo "NerdTree setup done."

echo "Completed Vim configuration successfully! Enjoy :-)"
