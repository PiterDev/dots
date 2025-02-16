#!/usr/bin/env sh

cd ~/dotfiles || { echo "Dotfiles repo not found!"; exit 1; }
TIMESTAMP=$(date +"%Y-%m-%d %H:%M")
gen=$(nix-env --list-generations | grep current | awk '{print $1}')
git add .
git commit -m "Backup generation $gen: $TIMESTAMP"
git push

