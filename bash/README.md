# Set default shell to bash

To set bash as the default shell for macOS Terminal.app:

1. Settings -> Users & Groups
2. Click the lock to make changes
3. Right-click your user account and select "Advanced Options..."
4. Set Login shell to `/bin/bash`

# User settings load order

When a login shell is created (e.g. new Terminal window), the following user files are loaded (in this order):

1. One of `~/.bash_profile` or `~/.bash_login` or `~/.profile` (in that order, whichever is found first)
2. `~/.bashrc`

When a non-login shell is created (e.g. a subshell created with `$(some command)`), the following user files are loaded (in this order):

1. `~/.bashrc`

# User settings descriptions

## `~/.profile`

This file should only contain settings that are:

1. Machine agnostic (shared across all the user's machines)
2. Shell agnostic (apply to `bash`, `zsh` or any other shell)

Shell-specific profiles (`~/bash_profile`, `~/.zprofile` etc.) should source this file if it exists, e.g.

```bash
# ~/.bash_profile

PROFILE=~/.profile
if [ -f $PROFILE ]; then
	source $PROFILE
fi
```

## `~/.bash_profile`

This file should only contain settings that are:

1. Machine agnostic (shared across all the user's machines)
2. Shell specific (only apply to `bash`)

## `./bashrc`

This file should only contain settings that are:

1. Machine specific (only apply to _this_ machine)
2. Shell specific (only apply to `bash`)

## `./bash_login`

Not used
