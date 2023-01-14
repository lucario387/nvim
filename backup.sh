#!/usr/bin/env bash

# TODO: Add better ways to control backup commands
if [ "$USER" = "root" ]; then
	echo "Running as root. Will not backup files"
	exit 1
fi

BACKUP_PATH=$(dirname $(readlink -f "$0"))

backup() {
	if [ -d "$HOME/.config/nvim" ]; then
		# rsync --delete --inplace --no-whole-file --recursive --qtmUp "$HOME/.config/nvim" "$PWD/.config/nvim"
		rsync --delete --inplace --exclude-from="./.gitignore" --no-whole-file --recursive -ptU "$HOME/.config/nvim/lua" "$BACKUP_PATH/"
		rsync --delete --inplace --exclude-from="./.gitignore" --no-whole-file --recursive -ptU "$HOME/.config/nvim/ftplugin" "$BACKUP_PATH/"
		rsync --delete --inplace --exclude-from="./.gitignore" --no-whole-file --recursive -ptU "$HOME/.config/nvim/.luarc.json" "$BACKUP_PATH/"
		rsync --delete --inplace --exclude-from="./.gitignore" --no-whole-file --recursive -ptU "$HOME/.config/nvim/after" "$BACKUP_PATH/"
		rsync --delete --inplace --exclude-from="./.gitignore" --no-whole-file --recursive -ptU "$HOME/.config/nvim/plugin" "$BACKUP_PATH/"
		rsync --delete --inplace --exclude-from="./.gitignore" --no-whole-file --recursive -ptU "$HOME/.config/nvim/meta" "$BACKUP_PATH/"

		# rm -rf "$cwd/.config/nvim/"
		# cp -rf "$HOME/.config/nvim/" "$cwd/.config/"
	fi
	return 0
}
backup

unset -f backup 
exit 0
