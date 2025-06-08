#!/bin/bash

SOURCE_DIR="$HOME/.config/git_configs/hyprland"
TARGET_DIR="$HOME/.config"

# Change to source directory
cd "$SOURCE_DIR"

for item in *; do
    src="$SOURCE_DIR/$item"
    dst="$TARGET_DIR/$item"

    if [ -L "$dst" ]; then
        echo "Removing existing symlink: $dst"
        rm "$dst"
    elif [ -e "$dst" ]; then
        echo "Skipping $dst – not a symlink"
        continue
    fi

    echo "Creating symlink: $dst -> $src"
    ln -s "$src" "$dst"
done
