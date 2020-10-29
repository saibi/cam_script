#!/bin/bash
set -e

error() {
    echo -e "ERROR: $*"
    exit 1
} >&2

usage() {
    error -e "Please run as root. Try: \n    sudo ./dual-camera-setup.sh"
}

[[ $UID = 0 ]] || usage

echo "Installing packages..."

wget -qO - http://wiki.t-firefly.com/firefly-rk3399-repo/PUBLIC.KEY | apt-key add -

cat <<EOF >/etc/apt/sources.list.d/firefly-rk3399.list
deb http://wiki.t-firefly.com/firefly-rk3399-repo bionic main
EOF

apt update

# force remove these two packages first
dpkg -r --force-depends libgstreamer-plugins-bad1.0-0 libgstreamer-plugins-good1.0-0
apt install -y -f

cat <<EOF | xargs apt install -y
gir1.2-gst-plugins-bad-1.0
gir1.2-gst-plugins-base-1.0
gir1.2-gstreamer-1.0
gstreamer1.0-alsa
gstreamer1.0-gl
gstreamer1.0-gtk3
gstreamer1.0-plugins-bad
gstreamer1.0-plugins-base
gstreamer1.0-plugins-base-apps
gstreamer1.0-plugins-base-doc
gstreamer1.0-plugins-good
gstreamer1.0-pulseaudio
gstreamer1.0-qt5
gstreamer1.0-rockchip1
gstreamer1.0-tools
gstreamer1.0-x
libcamera-engine-rkisp
libgstreamer-gl1.0-0
libgstreamer-opencv1.0-0
libgstreamer-plugins-base1.0-0
libgstreamer-plugins-bad1.0-0
libgstreamer1.0-0
libgstreamer1.0-dev
librockchip-mpp-dev
librockchip-mpp-static
librockchip-mpp1
librockchip-vpu0
EOF
#libdrm-rockchip1
apt install -y v4l-utils

echo "Installing scripts..."

rm -f S50set_pipeline set_pipeline.sh dual-camera-rkisp.sh
wget -O S50set_pipeline http://wiki.t-firefly.com/firefly-rk3399-repo/dualcamera/S50set_pipeline.txt
wget -O set_pipeline.sh http://wiki.t-firefly.com/firefly-rk3399-repo/dualcamera/set_pipeline.txt
wget -O dual-camera-rkisp.sh http://wiki.t-firefly.com/firefly-rk3399-repo/dualcamera/dual-camera-rkisp.txt
chmod 755 S50set_pipeline set_pipeline.sh dual-camera-rkisp.sh
mv S50set_pipeline /etc/init.d
mv set_pipeline.sh /usr/local/bin/
mv dual-camera-rkisp.sh /usr/local/bin/

wget -O play-4k.sh http://wiki.t-firefly.com/firefly-rk3399-repo/dualcamera/play-4k.txt
chmod 755 play-4k.sh
mv play-4k.sh /usr/local/bin

echo "Flashing kernel..."

rm -f boot.img md5sum.txt
wget http://wiki.t-firefly.com/firefly-rk3399-repo/dualcamera/boot.img
wget http://wiki.t-firefly.com/firefly-rk3399-repo/dualcamera/md5sum.txt
md5sum -c md5sum.txt || error "md5sum check of boot image failed!"
dd if=boot.img of=$(ls /dev/mmcblk?p3)
sync

# clean gstreamer cache
rm -rf /root/.cache/gstreamer-1.0/ /home/firefly/.cache/gstreamer-1.0/
rm -rf /etc/profile.d/gstreamerEnv.sh /etc/ld.so.conf.d/gstreamer.conf
unset LD_LIBRARY_PATH
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
ldconfig

cat <<\EOF
Installation complete!

Please REBOOT the system first.

Then run:

   sudo /etc/init.d/S50set_pipeline start
   sudo dual-camera-rkisp.sh

to start demo.

If it fails for the first time, please run `sudo dual-camera-rkisp.sh` again.
EOF
