# Zsh

The `zsh` topic contains shared zsh configuration.

Refer to the [shell topic](../shell/README.md) for more details on shell modes.

# Set default shell to zsh

To set zsh as the default shell for macOS Terminal.app:

1. Settings -> Users & Groups
2. Click the lock to make changes
3. Right-click your user account and select "Advanced Options..."
4. Set Login shell to `/bin/zsh`

# Description of files

## `zshenv.symlink` (becomes `~/.zshenv`)

Configuration needed by ALL four shell modes.

As this file is loaded for every shell, subshell, script etc., anything in `.zshenv` should be cheap and not fork a subprocess. Otherwise it may cause performance issues.

This file loads the following files:

- `~/.shellenv` (shell-agnostic configuration for all shell modes)

## `zprofile.symlink` (becomes `~/.zprofile`)

Configuration for login shells.

As this file is generally loaded once per session (e.g. opening new `Terminal.app` window or tab), this may include heavier one-time setup items.

This file loads the following files:

- `~/.profile` (shell-agnostic settings for login shells)

## `zshrc.symlink` (becomes `~/.zshrc`)

Configuration for interactive shells.

Things here should be interactive niceties only.

Good candidates are things like:

- prompts
- completions
- history settings

This file loads the following files from all other topics:

- `prompt.zsh` (prompts)
- `completion.zsh` (completions)

This file also loads the following files:

- `~/.shellrc` (shell-agnostic settings for interactive shells)

# Local configuration

For zsh configuration that is:

- machine-specific
- not intended to be shared

Create a corresponding `*.local` file as per the table below in the home directory of the user.

The above files will load the file if it exists.

| Shared file   |       | Local file                      |
| ------------- | ----- | ------------------------------- |
| `~/.zshenv`   | loads | `~/.zshenv.local` (if exists)   |
| `~/.zprofile` | loads | `~/.zprofile.local` (if exists) |
| `~/.zshrc`    | loads | `~/.zshrc.local` (if exists)    |
