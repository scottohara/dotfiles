# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export http_proxy=http://ns.proxy.nextgen.net:8000

# Git prompt
GIT_PS1_SHOWDIRTYSTATE="y"
GIT_PS1_SHOWSTASHSTATE="y"
GIT_PS1_SHOWUNTRACKEDFILES="y"
GIT_PS1_SHOWUPSTREAM="verbose"
#PS1=$(echo ${PS1%\\$ })'$(__git_ps1 " \[\033[1;32m\](%s)\[\033[0m\]")$ '

function replace_git_ps1_indicators() {
	local s=$1
	
	# Upstream diverged (u+n-n)=> ▶n◀n (\u25B6 & \u25C0)
	s=$(echo "$s" | sed 's/u+\([0-9]*\)-\([0-9]*\)/\1▶◀\2/')

	# Upstream ahead (u+n) => ▶ (\u25B6)
	s=$(echo "$s" | sed 's/u+\([0-9]*\)/\1▶/')

	# Upstream behind (u-n) => ◀ (\u25C0)
	s=$(echo "$s" | sed 's/u-/◀/')

	# Staged files (+) => ✔ (\u2714)
	s=$(echo "$s" | sed 's/+/✔/')

	# Unstaged files (*) => ✘ (\u2718)
	s=$(echo "$s" | sed 's/*/✘/')

	# Stashed files ($) => ⏏ (\u23CF)
	s=$(echo "$s" | sed 's/\$/⏏/')

	# Untracked files (%) => ★ (\u2605)
	s=$(echo "$s" | sed 's/%/★/')

	# Upstream same (u=) => (nothing)
	s=$(echo "$s" | sed 's/u=//')

	# Remove any trailing space
	s=${s/ \)/\)}

	echo -n "$s"
}

# Git aliases
alias gcl='git clone'
alias gco='git checkout'
alias gb='git branch'
alias ga='git add'
alias gd='git diff'
alias gst='git status'
alias gl='git log'
alias gc='git commit'
alias gca='git commit -a'
alias gcm='git commit -m'
alias gcma='git commit -am'
alias gp='git push'
alias gpu='git pull'
alias gsa='git submodule add'

# SVN prompt
function __svn_ps1() {
	SVN_ROOT=$(svn info | sed -n 's/Repository\ Root:\ .*\///p')
	svn info | sed -n "s/Revision: \([0-9]*\).*$/$SVN_ROOT:\1/p"
}

function __scm_ps1() {
	local s=
	if [[ -d .svn ]]; then
		s=" ($(__svn_ps1))"
	else
		# Replace the standard git-core indicators
		s=$(replace_git_ps1_indicators "$(__git_ps1 ' (%s)')")
	fi
	echo -n "$s"
}

PS1=$(echo ${PS1%\\$ })'\[\033[1;31m\]$(__scm_ps1)\[\033[0m\]$ '

# Use vi mode
#set -o vi

# Add rubygems to path
PATH=$PATH:/var/lib/gems/1.8/bin
