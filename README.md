dotfiles
========
My personal dotfiles collection.

Conventions
===========
Each topic (eg. bash, git, etc.) is in a separate subfolder.
Within each topic:
- All `*.bash` files are sourced into your shell
    - `aliases.bash` contains shell aliases specific to the topic
    - `completion.bash` contains shell completions specific to the topic
    - `prompt.bash` contains shell prompt customisations specific to the topic
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
3. Install Hub (`brew install hub`)
4. Install [VSCode](https://code.visualstudio.com/Download)
5. Edit `/etc/paths`; move `/usr/local/bin` to top (ie. prefer Homebrew installed versions over default system versions; eg. Git)
6. Import Solarized profiles into Terminal.app; set as startup settings; change font to Menlo; drop opacity to 95%; increase window size to at least 250x75; change Bright Black text colour from rbg(0,43,54) to rgb(0,44,54)

Thanks
======
* Inspiration taken from [Zach Holman](https://github.com/holman/dotfiles)'s dotfiles collection.
* Also, https://dotfiles.github.com.
