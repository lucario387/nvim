#!/usr/bin/env bash

git clone --filter=blob:none https://github.com/NvChad/NvChad.git --branch=dev "$HOME/.config/nvim"

BACKUP_PATH=$(dirname $(readlink -f "$0"))

cd "$BACKUP_PATH" || exit 1
cp -r after ftplugin lua meta .luarc.json "$HOME/.config/nvim/"
cd - || exit 1
