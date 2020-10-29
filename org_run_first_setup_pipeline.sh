#!/bin/bash
#
# Start linux launcher...
#

case "$1" in
  start)
  #for rkisp plugin
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/gstreamer-1.0
  #for rescan rkisp plugin
  rm /.cache/gstreamer-1.0 -rf

  MEDIA_MAX=3
  for i in $(seq 0 $MEDIA_MAX); do
    MEDIA_DEV=/dev/media$i
    BAYER=`media-ctl -d $MEDIA_DEV --get-v4l2 '"rockchip-mipi-dphy-rx":0' |sed "s/^.*fmt:*\([^ ]*\).*/\1/" |cut -f 1 -d '/'`
    RES=`media-ctl -d $MEDIA_DEV --get-v4l2 '"rockchip-mipi-dphy-rx":0' |sed "s/^.*fmt:*\([^ ]*\).*/\1/" |cut -f 2 -d '/'`
    # fix RES
    RES=2112x1568
    NAME=`media-ctl -p -d $MEDIA_DEV |grep ENABLED |grep -v -E "rock|rkisp"|grep -o "\".*\""|tr -d \"`
    MP_NODE=`media-ctl -e "rkisp1_mainpath" -d $MEDIA_DEV`
    SP_NODE=`media-ctl -e "rkisp1_selfpath" -d $MEDIA_DEV`
    SENSOR=`media-ctl -p -d $MEDIA_DEV |grep ENABLED |grep -v -E "rock|rkisp"|grep -o "\".*\""|tr -d \"|cut -f 1 -d ' '| tr 'a-z' 'A-Z'`
    SPRES=1920x1200

    if [[ $MP_NODE =~ "/dev/video" ]]
    then
	    echo ./set_pipeline.sh --sensorbayer $BAYER --sensorname "$NAME"  --sensorres $RES --medianode $i --mpnode $MP_NODE --mpfmt NV12 --mpres 640x480 --spnode $SP_NODE --spfmt NV12 --spres $SPRES 

      ./set_pipeline.sh --sensorbayer $BAYER --sensorname "$NAME"  --sensorres $RES --medianode $i --mpnode $MP_NODE --mpfmt NV12 --mpres $RES --spnode $SP_NODE --spfmt NV12 --spres $SPRES
      if [[ $SENSOR ]]
      then
          cp /etc/iqfiles/$SENSOR*.xml /etc/cam_iq.xml
      fi
    fi
  done
  ;;
  stop)
  ;;
  *)
  echo "Usage: $0 {start|stop}"
  exit 1
  ;;
esac
exit 0
