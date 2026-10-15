#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin main;

EXCLUDES=(
	--exclude ".git/"
	--exclude ".DS_Store"
	--exclude ".osx"
	--exclude ".macos"
	--exclude "brew.sh"
	--exclude "extra-brew.sh"
	--exclude "extra-cask.sh"
	--exclude "init/"
	--exclude "bootstrap.sh"
	--exclude "README.md"
	--exclude "LICENSE-MIT.txt"
)

function copyMissingFiles() {
	rsync "${EXCLUDES[@]}" -avh --no-perms --ignore-existing . ~;
}

function changedFiles() {
	rsync "${EXCLUDES[@]}" -rn --checksum --existing --out-format="%n" . ~ | grep -v '/$';
}

function askPerChangedFile() {
	while IFS= read -r file <&3; do
		if [ "$FORCE" != true ]; then
			diff -u --color=auto ~/"$file" "$file";
			read -p "Overwrite ~/$file with the version above? (y/n) " -n 1;
			echo "";
			[[ $REPLY =~ ^[Yy]$ ]] || continue;
		fi;
		cp "$file" ~/"$file" && echo "Updated ~/$file";
	done 3< <(changedFiles);
}

# The ponytail and oh-my-opencode-slim plugins are npm packages listed in
# ~/.config/opencode/opencode.json; opencode installs them on first start.
function installAgentTools() {
	command -v codegraph >/dev/null || curl -fsSL https://raw.githubusercontent.com/colbymchenry/codegraph/main/install.sh | sh;
	command -v rtk >/dev/null || curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh;
}

[ "$1" == "--force" -o "$1" == "-f" ] && FORCE=true;

copyMissingFiles;
askPerChangedFile;
installAgentTools;
source ~/.bash_profile;

unset EXCLUDES FORCE copyMissingFiles changedFiles askPerChangedFile installAgentTools;
