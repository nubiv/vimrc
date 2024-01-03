#!/bin/sh
set -e

if [ -f ~/.vimrc ]; then
    echo "~/.vimrc already exists. Exiting without making changes."
    exit 1
fi

curl https://raw.githubusercontent.com/nubiv/vimrc/main/.vimrc >> ~/.vimrc
if [ $? -ne 0 ]; then
    echo "Failed to download vimrc. Exiting without making changes."
    exit 1
else
    echo "Vimrc downloaded successfully."
fi

VIM80_DIR=/usr/share/vim/vim80
VIM90_DIR=/usr/share/vim/vim90
TARGET_DIR=""

if [ -d "$VIM80_DIR" ]; then
    TARGET_DIR="$VIM80_DIR"
fi
if [ -d "$VIM90_DIR" ]; then
    TARGET_DIR="$VIM90_DIR"
fi

if [ -z "$TARGET_DIR" ]; then
    echo "Vim directory not found. Skipping color scheme download."
else
    MG_VIM_PATH="$TARGET_DIR/colors/mountaineer-grey.vim"
    if [ -f "$MG_VIM_PATH" ]; then
        echo "Theme mountaineer-grey scheme already exists."
        sed -i 's/torte/mountaineer-grey/g' ~/.vimrc
        echo "Theme mountaineer-grey activated."
    else
        curl https://raw.githubusercontent.com/TheNiteCoder/mountaineer.vim/master/colors/mountaineer-grey.vim >> "$MG_VIM_PATH"
        if [ $? -eq 0 ]; then
            echo "Theme mountaineer-grey downloaded successfully."
            sed -i 's/torte/mountaineer-grey/g' ~/.vimrc
            echo "Theme mountaineer-grey activated."
        else
            echo "Failed to download theme mountaineer-grey."
        fi
    fi
fi


# Set up NerdTree
NERDTREE_DIR=~/.vim/pack/vendor/pack/start/nerdtree

if [ -d "$NERDTREE_DIR" ]; then
    echo "NerdTree pack already exists."
else
    git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
    if [ $? -eq 0 ]; then
        vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q
        echo "NerdTree setup done."
    else
        echo "Failed to set up NerdTree."
    fi
fi

echo "Completed Vim configuration successfully! Enjoy :-)"
