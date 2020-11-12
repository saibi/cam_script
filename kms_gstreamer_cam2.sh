#!/bin/bash

WIDTH=640
HEIGHT=480
SINK=kmssink

CAM1_DEVICE=/dev/video0
CAM2_DEVICE=/dev/video5

#gst-launch-1.0 rkisp device=$CAM1_DEVICE io-mode=1 analyzer=1 enable-3a=1 path-iqf=/etc/cam_iq.xml ! video/x-raw,format=NV12,width=${WIDTH},height=${HEIGHT}, framerate=30/1 ! videoconvert ! $SINK 

# the other camera
gst-launch-1.0 rkisp device=$CAM2_DEVICE io-mode=1 analyzer=1 enable-3a=1 path-iqf=/etc/cam_iq.xml ! video/x-raw,format=NV12,width=${WIDTH},height=${HEIGHT}, framerate=30/1 ! videoconvert ! $SINK 
