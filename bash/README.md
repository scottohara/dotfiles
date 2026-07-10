# Bash

The `bash` topic contains shared bash configuration.

Refer to the [shell topic](../shell/README.md) for more details on shell modes.

# Set default shell to bash

To set bash as the default shell for macOS Terminal.app:

1. Settings -> Users & Groups
2. Click the lock to make changes
3. Right-click your user account and select "Advanced Options..."
4. Set Login shell to `/bin/bash`

# Description of files

The file names loosely align to the conventions of `zsh` (`.zshenv`, `.zprofile`, `.zshrc`).

## `bashenv.symlink` (becomes `~/.bashenv`)

Configuration needed by ALL four shell modes.

As this file is loaded for every shell, subshell, script etc., anything in `.bashenv` should be cheap and not fork a subprocess. Otherwise it may cause performance issues.

Unlike `.zshenv`, bash does not load `.bashenv` automatically for all shells. Instead, we explicitly load it from both `.bash_profile` and `.bashrc` (as well as point `BASH_ENV` at it, for non-login, non-interactive shells), and set the `_BASHENV_ALREADY_SOURCED` variable to avoid double-loading.

This file loads the following files:

- `~/.shellenv` (shell-agnostic configuration for all shell modes)

## `bash_profile.symlink` (becomes `~/.bash_profile`)

Configuration for login shells.

As this file is generally loaded once per session (e.g. opening new `Terminal.app` window or tab), this may include heavier one-time setup items.

This file loads the following files:

- `~/.bashenv` (see above)
- `~/.bashrc` (see below)
- `~/.profile` (shell-agnostic settings for login shells)

## `bashrc.symlink` (becomes `~/.bashrc`)

Configuration for interactive shells.

Things here should be interactive niceties only.

Good candidates are things like:

- prompts
- completions
- history settings

This file loads the following files from all other topics:

- `prompt.bash` (prompts)
- `completion.bash` (completions)

This file also loads the following files:

- `~/.bashenv` (see above)
- `~/.shellrc` (shell-agnostic settings for interactive shells)

# Local configuration

For bash configuration that is:

- machine-specific
- not intended to be shared

Create a corresponding `*.local` file as per the table below in the home directory of the user.

The above files will load the file if it exists.

| Shared file       |       | Local file                          |
| ----------------- | ----- | ----------------------------------- |
| `~/.bashenv`      | loads | `~/.bashenv.local` (if exists)      |
| `~/.bash_profile` | loads | `~/.bash_profile.local` (if exists) |
| `~/.bashrc`       | loads | `~/.bashrc.local` (if exists)       |
