#!/bin/bash
# stop ledticker and change text
#

# settings
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/settings.sh"


PARAM=$1
if [ -z "$PARAM" ]; then
	PARAM=" "
fi
if [ -z "$WDIR" ]; then
	echo "Error: no param for input file path"
	exit
fi
if [ -z "$IFILETMP" ]; then
	echo "Error: no param for tmp input file"
	exit
fi

PID=$(pidof ledticker)
if [ $PID ]; then
	kill $PID
fi

echo "$PARAM" > $WDIR/$IFILETMP
sleep 2

sh -c "$LEDTICKEREXEC $WDIR/$IFILETMP &"

sleep 2

PID=$(pidof ledticker)
if [ $PID ]; then
	kill $PID
fi

rm $WDIR/$IFILETMP

echo "Info: ledticker stopped with $PARAM"
