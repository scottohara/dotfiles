PLATFORM=`uname`

# Only applicable for OS X 
if [ $PLATFORM == "Darwin" ]; then
	# Always use coloured ls
	alias ls='ls -G'
fi
