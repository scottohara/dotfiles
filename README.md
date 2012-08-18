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

Dependencies
============
* Preview plugin requires bluecloth gem (`sudo gem install bluecloth`)
* Tagbar plugin requires exuberant-ctags (`sudo apt-get install exuberant-ctags`)

Setting up a new Mac
====================
1. Install [Homebrew](http://mxcl.github.com/homebrew/)
2. Install Git (`brew install git`)
3. Install Hub (`brew install hub`)
4. Install MacVim (`brew install macvim && brew linkapps`)
5. Enable experimental renderer in MacVim (for transparency)
6. Edit `/etc/paths`; move `/usr/local/bin` to top (ie. prefer Homebrew installed versions over default system versions; eg. Git)
7. Import Solarized profiles into Terminal.app; set as startup settings; change font to Menlo; drop opacity to 95%

Thanks
======
* Inspiration taken from [Zach Holman](https://github.com/holman/dotfiles)'s dotfiles collection.
* Also, https://dotfiles.github.com.
