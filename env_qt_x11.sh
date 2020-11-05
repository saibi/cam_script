#!/bin/bash 
export QTDIR=/opt/qt-5.15.1-base-rk3399-x11-1105
if [ ! -d $QTDIR ]; then
    echo "QT Not found"
fi
export QT_PLUGIN_PATH=$QTDIR/plugins
export QML2_IMPORT_PATH=$QTDIR/qml
export LD_LIBRARY_PATH=$QTDIR/lib:/usr/rk3399-libs/lib64:/usr/lib/aarch64-linux-gnu:/lib/aarch64-linux-gnu:
export DISPLAY=:0
export XAUTHORITY=/home/saibi/.Xauthority
export QT_GSTREAMER_CAMERABIN_VIDEOSRC=rkisp

