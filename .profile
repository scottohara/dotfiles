# Source .bashrc file
BASHRC=~/.bashrc
if [ -f $BASHRC ]; then
	. $BASHRC
fi

# Source Git completion
GIT_COMPLETION=/usr/local/etc/bash_completion.d/git-completion.bash
if [ -f $GIT_COMPLETION ]; then
	. $GIT_COMPLETION
fi

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

export http_proxy=http://ns.proxy.nextgen.net:8000

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
