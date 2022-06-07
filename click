#
# android timelapse runs under LADB
#

if [ -z ${ANDROID_ROOT+x} ]; then
    currenthost=mac
else
    currenthost=android
fi


if [ -z "$*" ]; then
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

#echo min=$min
#echo sec=$sec
echo currenthost = $currenthost
echo interval = $interval seconds

shots=0

click_shutter() {

    shot=$(( $shot + 1 ))

    echo shot $shot
    if [ $currenthost = "android" ] ; then
        input keyevent 24
    fi
}

sleep 15

while :
do
    click_shutter
    sleep $interval
done
