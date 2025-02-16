#!/bin/bash

# This directory
DOTFILES_DIR="$HOME/dotfiles"

# Directories to stow to home
HOME_STOW_DIRS = ( "awesome" "home-manager" "kitty" )

echo "Stowing home directory dots..."

for dir in "${STOW_DIRS[@]}"; do
    if [ -d "$DOTFILES_DIR/$dir" ]; then
        echo "Stowing $dir..."
        stow -t "$HOME" "$dir"
    else
        echo "Skipping $dir (not found)"
    fi
done



echo "Done!"
