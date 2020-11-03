#!/bin/bash 
export QTDIR=/opt/qt-5.15.1-base-rk3399-mali-1102
if [ ! -d $QTDIR ]; then
    echo "QT Not found"
fi
export QT_QPA_PLATFORM=eglfs
export QT_QPA_EGLFS_HIDECURSOR=0
export QT_QPA_EGLFS_INTEGRATION=eglfs_kms
export QT_QPA_EGLFS_ROTATION=0
export QT_QPA_EVDEV_TOUCHSCREEN_PARAMETERS=/dev/input/event1:rotate=0
#export QT_QPA_EGLFS_PHYSICAL_WIDTH=217
#export QT_QPA_EGLFS_PHYSICAL_HEIGHT=136
export QT_QPA_EGLFS_WIDTH=1280
export QT_QPA_EGLFS_HEIGHT=800

# export QTWEBENGINE_DISABLE_SANDBOX=1

export XDG_RUNTIME_DIR="/tmp/xdg"
#export QT_QPA_FONTDIR=/usr/share/fonts/truetype/ubuntu-font-family
export QT_QPA_PLATFORM_PLUGIN_PATH=$QTDIR/plugins/
export QT_QPA_EGLFS_TSLIB=0
export QT_QPA_GENERIC_PLUGINS=evdevmouse,evdevkeyboard
export QT_PLUGIN_PATH=$QTDIR/plugins
export QML2_IMPORT_PATH=$QTDIR/qml
export LD_LIBRARY_PATH=$QTDIR/lib:/usr/rk3399-libs/lib64:/usr/lib/aarch64-linux-gnu:/lib/aarch64-linux-gnu:

