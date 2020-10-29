#!/bin/bash
#
# simple setup script 
#

# MEDIA_DEV=/dev/media0 or /dev/media1
# BAYER=`media-ctl -d $MEDIA_DEV --get-v4l2 '"rockchip-mipi-dphy-rx":0' |sed "s/^.*fmt:*\([^ ]*\).*/\1/" |cut -f 1 -d '/'`
# RES=`media-ctl -d $MEDIA_DEV --get-v4l2 '"rockchip-mipi-dphy-rx":0' |sed "s/^.*fmt:*\([^ ]*\).*/\1/" |cut -f 2 -d '/'` // not work
# NAME=`media-ctl -p -d $MEDIA_DEV |grep ENABLED |grep -v -E "rock|rkisp"|grep -o "\".*\""|tr -d \"`
# MP_NODE=`media-ctl -e "rkisp1_mainpath" -d $MEDIA_DEV`
# SP_NODE=`media-ctl -e "rkisp1_selfpath" -d $MEDIA_DEV`
# SENSOR=`media-ctl -p -d $MEDIA_DEV |grep ENABLED |grep -v -E "rock|rkisp"|grep -o "\".*\""|tr -d \"|cut -f 1 -d ' '| tr 'a-z' 'A-Z'`
# SPRES=1920x1200


MEDIA_DEV=/dev/media0
BAYER=SBGGR10_1X10
RES=2112x1568
NAME="m00_b_ov13850 1-0036"
MP_NODE=/dev/video0
SP_NODE=/dev/video1
SPRES=$RES

./set_pipeline.sh --sensorbayer $BAYER --sensorname "$NAME"  --sensorres $RES --medianode 0 --mpnode $MP_NODE --mpfmt NV12 --mpres $RES --spnode $SP_NODE --spfmt NV12 --spres $SPRES


MEDIA_DEV2=/dev/media1
NAME2="m01_b_ov13850 1-0046"
MP_NODE2=/dev/video5
SP_NODE2=/dev/video6

./set_pipeline.sh --sensorbayer $BAYER --sensorname "$NAME2"  --sensorres $RES --medianode 1 --mpnode $MP_NODE2 --mpfmt NV12 --mpres $RES --spnode $SP_NODE2 --spfmt NV12 --spres $SPRES
