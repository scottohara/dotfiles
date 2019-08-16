# Set default shell to zsh
To set zsh as the default shell for macOS Terminal.app:

1. Settings -> Users & Groups
2. Click the lock to make changes
3. Right-click your user account and select "Advanced Options..."
4. Set Login shell to `/bin/zsh`

# User settings load order
When a login shell is created (e.g. new Terminal window), the following user files are loaded (in this order):

1. `~/.zprofile`
2. `~/.zshrc`

When a non-login shell is created (e.g. a subshell created with `$(some command)`), the following user files are loaded (in this order):

1. `~/.zshrc`

# User settings descriptions 

## `~/.profile`
This file should only contain settings that are:

1. Machine agnostic (shared across all the user's machines)
2. Shell agnostic (apply to `bash`, `zsh` or any other shell)

Shell-specific profiles (`~/bash_profile`, `~/.zprofile` etc.) should source this file if it exists, e.g.

```zsh
# ~/.zprofile

PROFILE=~/.profile
if [ -f $PROFILE ]; then
	source $PROFILE
fi
```

## `~/.zprofile`
This file should only contain settings that are:

1. Machine agnostic (shared across all the user's machines)
2. Shell specific (only apply to `zsh`)

## `./zshrc`
This file should only contain settings that are:

1. Machine specific (only apply to *this* machine)
2. Shell specific (only apply to `zsh`)