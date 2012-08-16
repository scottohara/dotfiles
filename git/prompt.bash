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
