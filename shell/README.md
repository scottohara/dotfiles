# Shell

The `shell` topic contains shared shell-agnostic configuration.

Put anything here that should be _common_ across all shell types (`zsh`, `bash`).

# Shell modes

A shell can be:

- **login** or **non-login**
- **interactive** or **non-interactive**

These are independent properties, so across two different axes there are four possible modes:

|               | Interactive                                                                                                                                                              | Non-interactive                                                                                                  |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------- |
| **Login**     | 1. Opening a new `Terminal.app` window/tab<br>2. Opening a new VS Code integrated terminal<br>3. Typing `zsh -l` at an existing shell prompt (creates a new login shell) | 1. `zsh -l <some script>`<br>2. `zsh -lc <some command>`<br>3. `sudo -i <some command>`                          |
| **Non-login** | 1. Typing `zsh` at an existing shell prompt (creates a new non-login shell)                                                                                              | 1. `zsh <some script>`<br>2. `zsh -c <some command>`<br>3. `$(…)` subshells<br>4. `ssh user@host <some command>` |

# Description of files

The file names loosely align to the conventions of `zsh` (`.zshenv`, `.zprofile`, `.zshrc`).

## `shellenv.symlink` (becomes `~/.shellenv`)

Configuration needed by ALL four shell modes.

As this file is loaded for every shell, subshell, script etc., anything in `.shellenv` should be cheap and not fork a subprocess. Otherwise it may cause performance issues.

Good candidates are things like:

- Environment variables
- PATH settings needed for all shell modes

This file loads the following files from all other topics:

- `env.shell` (environment variables)
- `paths.shell` (paths)

## `profile.symlink` (becomes `~/.profile`)

Configuration for login shells.

As this file is generally loaded once per session (e.g. opening new `Terminal.app` window or tab), this may include heavier one-time setup items.

Good candidates are things like:

- tool initialisations (`brew`, `asdf` etc.)
- setting `java_home`

This file loads the following files from all other topics:

- `init.shell` (topic initialisations)

## `shellrc.symlink` (becomes `~/.shellrc`)

Configuration for interactive shells.

Things here should be interactive niceties only.

Good candidates are things like:

- shell-agnostic completions
- aliases

This file loads the following files from all other topics:

- `completion.shell` (completions)
- `aliases.shell` (aliases)

# Local configuration

For shell-agnostic configuration that is:

- machine-specific
- not intended to be shared

Create a corresponding `*.local` file as per the table below in the home directory of the user.

The above files will load the file if it exists.

| Shared file   |       | Local file                      |
| ------------- | ----- | ------------------------------- |
| `~/.shellenv` | loads | `~/.shellenv.local` (if exists) |
| `~/.profile`  | loads | `~/.profile.local` (if exists)  |
| `~/.shellrc`  | loads | `~/.shellrc.local` (if exists)  |
