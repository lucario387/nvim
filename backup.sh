#!/usr/bin/env bash

# TODO: Add better ways to control backup commands
if [ "$USER" = "root" ]; then
	echo "Running as root. Will not backup files"
	exit 1
fi

BACKUP_PATH=$(dirname $(readlink -f "$0"))
NVIM_PATH="$HOME/.config/nvchad"

backup() {
	if [ -d "$HOME/.config/nvim" ]; then
		rsync --delete --inplace --exclude-from="./.gitignore" --no-whole-file --recursive -ptU "$NVIM_PATH/lua" "$BACKUP_PATH/"
		rsync --delete --inplace --exclude-from="./.gitignore" --no-whole-file --recursive -ptU "$NVIM_PATH/ftplugin" "$BACKUP_PATH/"
		rsync --delete --inplace --exclude-from="./.gitignore" --no-whole-file --recursive -ptU "$NVIM_PATH/.luarc.json" "$BACKUP_PATH/"
		rsync --delete --inplace --exclude-from="./.gitignore" --no-whole-file --recursive -ptU "$NVIM_PATH/after" "$BACKUP_PATH/"
		rsync --delete --inplace --exclude-from="./.gitignore" --no-whole-file --recursive -ptU "$NVIM_PATH/plugin" "$BACKUP_PATH/"
		rsync --delete --inplace --exclude-from="./.gitignore" --no-whole-file --recursive -ptU "$NVIM_PATH/meta" "$BACKUP_PATH/"
	fi
	return 0
}
backup

unset -f backup 
exit 0
