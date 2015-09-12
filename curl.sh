#!/bin/bash
# curl her0 api ledticker
# api: prints the latest items aboth the given item-id
#      one item per line
#      last line first item-id and last item-id
#      api.php?action=realtime&type=plain&item=$ITEMID
#      for example plain/text response:
#        18:27:53 kevin Joins
#        18:28:29 sasche Quits
#        18:28:55 tobias Parts
#        18:29:31 Simon Quits
#        9077 9081

# settings
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/settings.sh"


# param check
if [ -z "$WDIR" ]; then
	echo "Param: not set"
	exit
fi
# check other
if [ -z "$CRLFILE" ]; then
	echo "Param: CRLFILE (curl-file) not set"
	exit
fi

if [ -z "$IFILE" ]; then
	echo "Param: IFILE (input-file) not set"
	exit
fi

if [ -z "$CIDFILE" ]; then
	echo "Param: CIDFILE (content-id-file) not set"
	exit
fi

if [ -z "$CHECKTARGET" ]; then
	CHECKTARGET="0"
fi

if [ "$CHECKTARGET" == "0" ]; then
	COUNT=1
else
	COUNT=$( ping -c 3 $CHECKTARGET | grep icmp | grep bytes | wc -l)
fi

# init
touch $WDIR/$IFILE $WDIR/$CRLFILE $WDIR/$CIDFILE || exit

DAYCHANGE=$(date "+%H%m")
if [ $DAYCHANGE -lt "10" ]; then
	OITEM=1
else
	OITEM=$(cat $WDIR/$CIDFILE)
fi

ITEM=$(tail -1 $WDIR/$CRLFILE | tr " " "\n" | tail -1)
if [ -z "$ITEM" ]; then
	ITEM=0
fi

if [ "$ITEM" -lt "1" ]; then
	ITEM=$OITEM
else
	OITEM=$ITEM
fi
curl -s -o $WDIR/$CRLFILE -A "$USERAGENT" $APIURL$ITEM

ITEM=$(tail -1 $WDIR/$CRLFILE | tr " " "\n" |tail -1)

if [ "$ITEM" -lt "1" ]; then
	echo "Info: no updates found"
else
	if [ $COUNT -eq "0" ]; then
		echo " " > $WDIR/$IFILE
		echo "Info: ledticker stopped ($CHECKTARGET not reachable)"
	else
		head -n -1 $WDIR/$CRLFILE > $WDIR/$IFILE
		echo $ITEM > $WDIR/$CIDFILE
		echo "Info successfull updated"
	fi
fi
