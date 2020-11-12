#!/bin/bash

WIDTH=640
HEIGHT=480
SINK=kmssink

# camera closed to the border of the board
gst-launch-1.0 rkisp device=/dev/video0 io-mode=1 analyzer=1 enable-3a=1 path-iqf=/etc/cam_iq.xml ! video/x-raw,format=NV12,width=${WIDTH},height=${HEIGHT}, framerate=30/1 ! videoconvert ! $SINK 

# the other camera
#gst-launch-1.0 rkisp device=/dev/video5 io-mode=1 analyzer=1 enable-3a=1 path-iqf=/etc/cam_iq.xml ! video/x-raw,format=NV12,width=${WIDTH},height=${HEIGHT}, framerate=30/1 ! videoconvert ! $SINK &
