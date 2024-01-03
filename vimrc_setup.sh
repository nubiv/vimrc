#!/bin/sh
set -e

VIMRC_PATH=~/.vimrc

if [ -f "$VIMRC_PATH" ]; then
    echo "~/.vimrc already exists. Exiting without making changes."
    exit 1
fi

eval curl https://raw.githubusercontent.com/nubiv/vimrc/main/.vimrc >> "$VIMRC_PATH"
if [ $? -ne 0 ]; then
    echo "Failed to download vimrc. Exiting without making changes."
    exit 1
else
    echo "Vimrc downloaded successfully."
fi

# Set up Vim theme
COLOR_DIR=~/.vim/colors/
MG_VIM_PATH="$COLOR_DIR/mountaineer-grey.vim"

eval mkdir -p "$COLOR_DIR"
if [ -f "$MG_VIM_PATH" ]; then
    echo "Theme mountaineer-grey scheme already exists."
    eval sed -i 's/torte/mountaineer-grey/g' "$VIMRC_PATH"
    echo "Theme mountaineer-grey activated."
else
    eval curl https://raw.githubusercontent.com/TheNiteCoder/mountaineer.vim/master/colors/mountaineer-grey.vim >> "$MG_VIM_PATH"
    if [ $? -eq 0 ]; then
        echo "Theme mountaineer-grey downloaded successfully."
        eval sed -i 's/torte/mountaineer-grey/g' "$VIMRC_PATH"
        echo "Theme mountaineer-grey activated."
    else
        echo "Failed to download theme mountaineer-grey."
    fi
fi

# Set up NerdTree
NERDTREE_DIR=~/.vim/pack/vendor/pack/start/nerdtree

if [ -d "$NERDTREE_DIR" ]; then
    echo "NerdTree pack already exists."
    eval vim -u NONE -c "helptags $NERDTREE_DIR/doc" -c q
    echo "NerdTree setup done."
else
    eval git clone https://github.com/preservim/nerdtree.git "$NERDTREE_DIR"
    if [ $? -eq 0 ]; then
        eval vim -u NONE -c "helptags $NERDTREE_DIR/doc" -c q
        echo "NerdTree setup done."
    else
        echo "Failed to set up NerdTree."
    fi
fi

echo "Completed Vim configuration successfully! Enjoy :-)"
