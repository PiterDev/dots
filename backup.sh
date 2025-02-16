#!/usr/bin/env sh

cd ~/dotfiles || { echo "Dotfiles repo not found!"; exit 1; }
TIMESTAMP=$(date +"%Y-%m-%d %H:%M")
git add .
git commit -m "Backup: $TIMESTAMP"
git push

