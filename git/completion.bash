# Built-in git completion
GIT_COMPLETION=/opt/homebrew/etc/bash_completion.d/git-completion.bash
if [ -f $GIT_COMPLETION ]; then
	source $GIT_COMPLETION
fi
