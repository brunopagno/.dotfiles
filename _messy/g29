#!/bin/bash

# get the path
TARGET="/sys$(udevadm info /dev/input/js0 | grep P: | cut -c 4-1000)"
# remove 'js0' from the end
TARGET=${TARGET::-4}
# append 'device'
TARGET="$TARGET/device"
echo "the target is $TARGET"

# cd into the target
cd "$TARGET"
# print the value of the 'range' file
echo "range is $(cat range)"

# update the range to 360
echo "updating range"
sudo echo 360 > range
echo "range is $(cat range)"

