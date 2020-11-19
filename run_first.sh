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
BAYER_OV13850=SBGGR10_1X10
BAYER_AR0221=SGRBG10_1X10
NAME_OV13850="m00_b_ov13850 1-0036"
NAME_AR0221="ar0221 1-0036"
MP_NODE=/dev/video0
SP_NODE=/dev/video1

RES_OV13850=2112x1568
RES_AR0221=1080x1080


MEDIA_DEV2=/dev/media1
NAME2_OV13850="m01_b_ov13850 1-0046"
NAME2_AR0221="ar0221 1-0046"
MP_NODE2=/dev/video5
SP_NODE2=/dev/video6

BAYER=$BAYER_AR0221
NAME=$NAME_AR0221
NAME2=$NAME2_AR0221
RES=$RES_AR0221

if [ $# != 0 ]; then
	if [ "$1" == "ar0221" ]; then 
		echo "set pipeline for ar0221"
	elif [ "$1" == "ov13850" ]; then 
		echo "set pipeline for ov13850"
		BAYER=$BAYER_OV13850
		NAME=$NAME_OV13850
		NAME2=$NAME2_OV13850
		RES=$RES_OV13850
	else
		echo "$0 [ar0221|ov13850]"
		exit 1
	fi
else
	echo "set pipeline for ar0221"
fi

SPRES=$RES


./set_pipeline.sh --sensorbayer $BAYER --sensorname "$NAME"  --sensorres $RES --medianode 0 --mpnode $MP_NODE --mpfmt NV12 --mpres $RES --spnode $SP_NODE --spfmt NV12 --spres $SPRES

./set_pipeline.sh --sensorbayer $BAYER --sensorname "$NAME2"  --sensorres $RES --medianode 1 --mpnode $MP_NODE2 --mpfmt NV12 --mpres $RES --spnode $SP_NODE2 --spfmt NV12 --spres $SPRES
