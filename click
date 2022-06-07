#
# android timelapse runs under LADB
#

click_shutter() {

    shot=$(( $shot + 1 ))

    echo shot $shot
    if [ $currenthost = "android" ] ; then
        input keyevent 24
    fi
}


if [ -z ${ANDROID_ROOT+x} ]; then
    currenthost=mac
else
    currenthost=android
fi

if [ -z "$*" ]; then
    echo Usage: click [min:]sec
    echo presses the 'volume down' key at a given interval for taking timelapse photos
    echo These are equivalent:
    echo $ click 1:30
    echo $ click 90

    echo "\nNo interval provided, using default (60 seconds)"

    INPUT=60
else
    INPUT=$1
fi

if $(`echo "${INPUT}" | grep -q  ":"`); then
    min=`echo $1 | sed 's/:.*// ' | bc`
    sec=`echo $1 | sed 's/.*://' | bc`
else
    min=0
    sec=$1
fi

interval=$((60*min+sec))
shot=0

echo currenthost = $currenthost
echo interval    = $interval seconds

sleep 15

while :
do
    click_shutter
    sleep $interval
done
