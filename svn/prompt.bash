# SVN prompt
function __svn_ps1() {
	SVN_ROOT=$(svn info | sed -n 's/Repository\ Root:\ .*\///p')
	svn info | sed -n "s/Revision: \([0-9]*\).*$/$SVN_ROOT:\1/p"
}
