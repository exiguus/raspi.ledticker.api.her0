#!/bin/bash
# script setting
#

LEDTICKEREXEC=/usr/local/bin/ledticker
# api
NAME=her0
WDIR=/tmp
IFILE=$NAME-input.txt
IFILETMP=$NAME-input-exit.txt
CIDFILE=$NAME-current.txt
CRLFILE=$NAME-curl.txt
APIURL="http://$NAME.be/inc/api.php?action=realtime&type=plain&item="
APIUSERAGENT="$NAME LedTicker A1.0"
# check if IP is reachable else stop ticker
# for example change it to the IP of your smartphone
# to start/stop the ticker when you are at home or
# leave the house
CHECKTARGET=
