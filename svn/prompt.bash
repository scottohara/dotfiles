# SVN prompt
__svn_ps1() {
	local info root
	info=$(svn info 2>/dev/null) || return
	root=$(sed -n 's/Repository\ Root:\ .*\///p' <<< "$info")
	sed -n "s/Revision: \([0-9]*\).*$/$root:\1/p" <<< "$info"
}
