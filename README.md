# dotfiles

My personal dotfiles collection.

[![Maintainability](https://qlty.sh/gh/scottohara/projects/dotfiles/maintainability.svg)](https://qlty.sh/gh/scottohara/projects/dotfiles)

# Conventions

Each topic (eg. `git`, `java`, etc.) is in a separate subfolder.

Files within a topic are loaded according to their extension, which determines both **which
shells** load them (shell-agnostic, `bash`-only or `zsh`-only) and **which shell
modes** they apply to (all shells, login shells or interactive shells).

See the [shell topic](shell/README.md) for an explanation of shell modes, and
the per-shell READMEs ([shell](shell/README.md), [bash](bash/README.md),
[zsh](zsh/README.md)) for the exact order in which the loader files source these.

`*.shell` files are shell-agnostic and are loaded by both `bash` and `zsh`:

| File               | Applies to         | Contains                                                                              |
| ------------------ | ------------------ | ------------------------------------------------------------------------------------- |
| `env.shell`        | all shell modes    | environment variables (must be cheap — no subprocesses)                               |
| `paths.shell`      | all shell modes    | `PATH` additions (via `prepend_path`; also re-asserted for login shells)              |
| `init.shell`       | login shells       | topic initialisation, including heavier one-time / forking setup (eg. `brew`, `asdf`) |
| `completion.shell` | interactive shells | shell-agnostic completions                                                            |
| `aliases.shell`    | interactive shells | aliases                                                                               |

`*.bash` files are loaded by `bash` interactive shells only:

| File              | Applies to         | Contains              |
| ----------------- | ------------------ | --------------------- |
| `completion.bash` | interactive shells | completions           |
| `prompt.bash`     | interactive shells | prompt customisations |

`*.zsh` files are loaded by `zsh` interactive shells only:

| File             | Applies to         | Contains              |
| ---------------- | ------------------ | --------------------- |
| `completion.zsh` | interactive shells | completions           |
| `prompt.zsh`     | interactive shells | prompt customisations |

Other files:

- All `*.launchagent` files are copied to `~/Library/LaunchAgents/*.plist`
- All `*.symlink` files (and directories) will be symlinked to `~/.{file}` eg.

```plaintext
~/.foo -> ~/.dotfiles/topic-a/foo.symlink
~/.bar -> ~/.dotfiles/topic-b/bar.symlink
```

# Installation

1. Clone the repo somewhere (eg. `cd ~/ && git clone --recursive git://github.com/scottohara/dotfiles.git`). Doesn't matter where, as the installer will automatically symlink the repo to `~/.dotfiles`.
2. Change to checkout directory and run the install script (`cd ~/dotfiles && ./setup.sh`)

# Uninstallation

1. Change to the checkout directory and run the uninstall script (`cd ~/dotfiles && ./setup.sh -u`)

# Setting up a new Mac

1. Install [Homebrew](http://mxcl.github.com/homebrew/)
2. Install Git (`brew install git`)
3. Install [VSCode](https://code.visualstudio.com/Download)
4. Import [Catppuccin Mocha profile](https://github.com/catppuccin/Terminal.app) into Terminal.app

- Set as startup profile
- Set as default theme
- Change font to Monaspace Neon Medium 11
- Set opacity to 95% and blur to 100%
- Increase window size to at least 250x75 and enable smooth resize
- Add desired items to title bar
- Set shell to close the window if exits cleanly
- Change Bright Black text colour from rbg(0,43,54) to rgb(0,44,54)

5. In Settings => Users & Groups, unlock and right-click user account and choose Advanced Options...; set the login shell as desired (/bin/bash or /bin/zsh)

# Thanks

- Inspiration taken from [Zach Holman](https://github.com/holman/dotfiles)'s dotfiles collection.
- Also, <https://dotfiles.github.com>.
