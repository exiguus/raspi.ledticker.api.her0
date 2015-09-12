#!/bin/bash
# check if ledticker is running
# and start it if not

# settings
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/settings.sh"


# start
PID=$(pidof ledticker)


if [ -z "$WDIR" ]; then
	echo "Error: no param for input file path"
	exit
fi
if [ -z "$IFILE" ]; then
	echo "Error: no param for input file"
	exit
fi
if [ -z "$LEDTICKEREXEC" ]; then
	echo "Error: no param for ledticker executable"
	exit
fi

if [ -z "$PID" ]; then
	$LEDTICKEREXEC $WDIR/$IFILE &
	echo "Info: ledticker started"
else
	echo "Info: ledticker not started (there is currently running an instance with pid $PID)"
fi
