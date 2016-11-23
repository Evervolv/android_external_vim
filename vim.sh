#!/system/bin/sh

if [ "`ttysize`" = "0 0" ]; then

	# call busybox resize to allow vim fullscreen
	resize

	# export COLUMNS=`stty size | cut -d " " -f 2`
	# export LINES=`stty size | cut -d " " -f 1`
	# echo "$COLUMNS x $LINES"
fi

vim $*
