#!/usr/bin/env sh

# This directory
DOTFILES_DIR="$HOME/dotfiles"

# Directories to stow to ~/.config
HOME_STOW_DIRS = ( "awesome" "home-manager" "kitty" )

echo "Stowing home directory dots..."

for dir in "${STOW_DIRS[@]}"; do
    if [ -d "$DOTFILES_DIR/$dir" ]; then
        echo "Stowing $dir..."
        stow -t "$HOME/.config/$dir/" "$dir"
    else
        echo "Skipping $dir (not found)"
    fi
done

# TODO: Stow nix files as sudo (scary)

echo "Done!"
