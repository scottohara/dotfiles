dotfiles
========
My personal dotfiles collection.

Conventions
===========
Each topic (eg. bash, git, etc.) is in a separate subfolder.
Within each topic:
- All `*.shell` files will be sourced into login shells (in this order)
    - `init.shell` contains initialisation specific to the topic
    - `paths.shell` contains paths specific to the topic
    - `aliases.shell` contains shell aliases specific to the topic
- All `*.bash` files will be sourced into bash login shells
    - `completion.bash` contains shell completions specific to the topic
    - `prompt.bash` contains shell prompt customisations specific to the topic
- All `*.zsh` files will be sourced into zsh login shells
    - `completion.zsh` contains shell completions specific to the topic
    - `prompt.zsh` contains shell prompt customisations specific to the topic
- All `*.launchagent` files are copied to `~/Library/LaunchAgents/*.plist`
- All `*.symlink` files (and directories) will be symlinked to `~/.{file}` eg.

```
~/.mystuff			 -> ~/.dotfiles/mystuff/mystuff.symlink
~/.myotherstuff	 -> ~/.dotfiles/myotherstuff/myotherstuff.symlink
```

Installation
============
1. Clone the repo somewhere (eg. `cd ~/ && git clone --recursive git://github.com/scottohara/dotfiles.git`). Doesn't matter where, as the installer will automatically symlink the repo to `~/.dotfiles`.
2. Change to checkout directory and run the install script (`cd ~/dotfiles && ./setup.sh`)

Uninstallation
==============
1. Change to the checkout directory and run the uninstall script (`cd ~/dotfiles && ./setup.sh -u`)

Setting up a new Mac
====================
1. Install [Homebrew](http://mxcl.github.com/homebrew/)
2. Install Git (`brew install git`)
4. Install [VSCode](https://code.visualstudio.com/Download)
5. Edit `/etc/paths`; move `/usr/local/bin` to top (ie. prefer Homebrew installed versions over default system versions; eg. Git)
6. Import Solarized profiles into Terminal.app; set as startup settings; change font to Menlo; drop opacity to 95%; increase window size to at least 250x75; change Bright Black text colour from rbg(0,43,54) to rgb(0,44,54)
7. In Settings => Users & Groups, unlock and right-click user account and choose Advanced Options...; set the login shell as desired (/bin/bash or /bin/zsh)

Thanks
======
* Inspiration taken from [Zach Holman](https://github.com/holman/dotfiles)'s dotfiles collection.
* Also, https://dotfiles.github.com.
