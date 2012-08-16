# If hub is installed, use it (http://defunkt.github.com/hub/)
hub_path=$(which hub)
if [[ -f $hub_path ]]
then
  alias git=$hub_path
fi

# Quick git commands
alias gcl='git clone'
alias gco='git checkout'
alias gb='git branch'
alias ga='git add'
alias gd='git diff'
alias gst='git status'
alias gl='git log'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset" --abbrev-commit --date=relative'
alias gc='git commit'
alias gca='git commit -a'
alias gcm='git commit -m'
alias gcma='git commit -am'
alias gp='git push'
alias gpu='git pull'
alias gsa='git submodule add'
