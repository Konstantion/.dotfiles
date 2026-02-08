#!/bin/bash

copy_if_exists() {
  if [ -e "$1" ]; then
    if [ -d "$1" ]; then
      cp -r "$1" "$2"
    else
      cp "$1" "$2"
    fi
  else
    echo "File or directory $1 does not exist."
  fi
}
mkdir -p ./.config/

copy_if_exists ~/.tmux.conf .
copy_if_exists ~/.ideavimrc .

copy_if_exists ~/.config/i3 ./.config/
copy_if_exists ~/.config/i3status ./.config/
copy_if_exists ~/.config/i3status-rust ./.config/
copy_if_exists ~/.config/alacritty ./.config/
copy_if_exists ~/.config/fish ./.config/

cd "$(dirname "$0")"

if [ ! -d .git ]; then
    echo "This is not a Git repository."
    exit 1
fi

git submodule update --remote
git add -A

COMMIT_MESSAGE="Update dotfiles $(date '+%Y-%m-%d %H:%M:%S')"
git commit -m "$COMMIT_MESSAGE"

git push origin master
