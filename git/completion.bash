# Built-in git completion
GIT_COMPLETION=/usr/local/etc/bash_completion.d/git-completion.bash
if [ -f $GIT_COMPLETION ]; then
	source $GIT_COMPLETION
fi
