#!/bin/bash
set -u

function make_link() {
	local source_file="$1"
	local target_file="$2"
	local valid_choice="N" 

	# Check if the target already exists
	if [ -e "$target_file" ]; then
		until [ "$valid_choice" = "Y" ]; do
			# Prompt the user to replace
			read -rp "$target_file already exists. Replace with symlink to $source_file? (y)es, (n)o or (a)bort [enter = no]: " replace_target
			[ -z "$replace_target" ] && replace_target="N"

			case "$replace_target" in
				[yY])
					# User opted to replace, so remove the existing target
					echo "Removing existing $target_file"
					rm -rf "$target_file"
					valid_choice="Y"
					;;
				[nN])
					# User declined to replace, so take no action and return
					echo "Leaving $target_file untouched."
					return
					;;
				[aA])
					# User aborted
					echo "Leaving $target_file untouched. Aborting."
					exit 1
					;;
				*)
					# Invalid choice, prompt again
					echo "Invalid choice. Please enter 'y', 'n', or 'a'."
					;;
			esac
		done
	fi

	# Create the symlink
	echo "Linking $source_file -> $target_file"
	ln -s "$source_file" "$target_file" || {
		echo "Failed to create symlink from $source_file to $target_file" >&2
		exit 1
	}
}

# Default mode is to install (i), unless -u option passed
MODE="i"

while getopts 'u' OPTION; do
	case $OPTION in
		u)	MODE="u"
			;;
		?)	echo "Usage: $0 [-u]" 1>&2
			exit 1
			;;
	esac
done

# Get the name of this script
THIS_SCRIPT="$(basename "$0")"

# Change to the script directory
cd "$(dirname "$0")" || exit 1

# Iterate down a (possible) chain of symlinks
while [ -L "$THIS_SCRIPT" ]
do
	THIS_SCRIPT="$(readlink "$THIS_SCRIPT")"
	cd "$(dirname "$THIS_SCRIPT")" || exit 1
	THIS_SCRIPT="$(basename "$THIS_SCRIPT")"
done

# Canonicalize the physical path
SCRIPT_DIR="$(pwd -P)"

if [ "$MODE" = "i" ]; then
	# Make the topics available at ~/.dotfiles
	DOTFILES_DIR="$HOME/.dotfiles"

	# If we're not already in ~/.dotfiles
	if [ "$SCRIPT_DIR" != "$DOTFILES_DIR" ]; then
		make_link "$SCRIPT_DIR" "$DOTFILES_DIR"
	fi
	
	# Symlink all {name}.symlink files in topics to ~/.{name}
	while IFS= read -r symlink_file; do
		symlink_basename="$(basename "$symlink_file")"
		symlink_basename="$HOME/.${symlink_basename%.symlink}"
		make_link "$symlink_file" "$symlink_basename"
	done < <(find "$SCRIPT_DIR" -name "*.symlink" -type f)

	# Special case symlink for vscode files
	VSCODE_DIR="$HOME/Library/Application Support/Code/User"
	if [ -d "$VSCODE_DIR" ]; then
		make_link "$SCRIPT_DIR/vscode/projects.json" "$VSCODE_DIR/projects.json"
		make_link "$SCRIPT_DIR/vscode/settings.json" "$VSCODE_DIR/settings.json"
		make_link "$SCRIPT_DIR/vscode/snippets" "$VSCODE_DIR/snippets"
	fi

	# Special case symlink for Maven settings
	M2_DIR="$HOME/.m2"
	if [ -d "$M2_DIR" ]; then
		make_link "$SCRIPT_DIR/maven/settings.xml" "$M2_DIR/settings.xml"
	fi

	# Copy all {name}.launchagent files in topics to ~/Library/LaunchAgents/{name}.plist
	while IFS= read -r launchagent_file; do
		launchagent_basename="$(basename "$launchagent_file")"
		launchagent_basename="$HOME/Library/LaunchAgents/${launchagent_basename%.launchagent}.plist"
		echo "Copying $launchagent_file -> $launchagent_basename"
		cp "$launchagent_file" "$launchagent_basename"
	done < <(find "$SCRIPT_DIR" -name "*.launchagent" -type f)
else
	# Remove any symlinks to the script directory
	for symlink_file in "$HOME"/.[!.]* "$HOME"/*; do
		# Skip if file does not exist
		[ -e "$symlink_file" ] || [ -L "$symlink_file" ] || continue

		# Check if it's a symlink pointing to the script directory
		if [ -L "$symlink_file" ]; then
			target="$(readlink "$symlink_file")"
			case "$target" in
				"$SCRIPT_DIR"/*)
					echo "Unlinking $(basename "$symlink_file")"
					rm "$symlink_file"
					;;
			esac
		fi
	done
fi
	
echo "Done"
exit 0
