#!/bin/bash

export DISPLAY=:0
export XAUTHORITY=/home/saibi/.Xauthority
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
export LD_LIBRARY_PATH=/usr/lib/gstreamer-1.0

WIDTH=1080
HEIGHT=1080
SINK=gtksink

#/etc/init.d/S50set_pipeline start

# camera closed to the border of the board
gst-launch-1.0 rkisp device=/dev/video0 io-mode=1 analyzer=0 enable-3a=0 ! video/x-raw,format=NV12,width=${WIDTH},height=${HEIGHT},framerate=30/1 ! videoconvert ! $SINK 

#sleep 1

# the other camera
#gst-launch-1.0 rkisp device=/dev/video5 io-mode=1 analyzer=0 enable-3a=0 ! video/x-raw,format=NV12,width=${WIDTH},height=${HEIGHT}, framerate=30/1 ! videoconvert ! $SINK &

#wait
