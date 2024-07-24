#!/bin/bash
### msg2desktop.sh / rb / 2024
### sende eine kurze Nachricht an den Desktop des angemeldeten Benutzers
### braucht 3 Variablen
while getopts t:m:d: flag
do
   case "${flag}" in
        t) t=${OPTARG};;
        m) m=${OPTARG};;
        d) d=${OPTARG};;
   esac
done
###
function usage()
{
echo "script to send a message to users on the Desktop"
echo "usage: $0 -t mytitle -m mymessage -d 3000"
echo "variablen: $t $m $d"
}
###
if [[ -z "${t}" || -z "${m}" || -z "${d}" ]]
then
    usage
    exit 0
fi
###
which gdbus >/dev/null
if [ $? -ne 0 ]; then echo "executable not found" ; exit 1;fi
#title="Title of the Maintenance Message"
#body="please read the newest Message on our Homepage<br><a href=https://myportal>https://myportal</a>"
#duration=0
title=$t
body=$m
duration=$d
who | awk '{print $1, $NF}' | tr -d "()" | grep ":" | sort -u |
while read XUSER DISPNUM; do

if [ $DISPNUM != ':' ]; then
    echo "try to send a message to $XUSER on DISPLAY: $DISPNUM"
fi
    sudo -u $XUSER DISPLAY=$DISPNUM \
                   DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u $XUSER)/bus \
                    /usr/bin/gdbus call --session     \
                    --dest=org.freedesktop.Notifications \
                    --object-path=/org/freedesktop/Notifications \
                    --method=org.freedesktop.Notifications.Notify \
                    "" 0 "" \
                    "$t" \
                    "$m" \
                    '[]' \
                    '{"urgency": <2>}' \
                    $d \
                    2>&1 >/dev/null
done
