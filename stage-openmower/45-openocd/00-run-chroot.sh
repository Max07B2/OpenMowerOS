#!/bin/bash -e

export DEBIAN_FRONTEND=noninteractive

# Install dependencies
apt-get update
apt-get install -y --no-install-recommends autoconf automake build-essential curl libftdi-dev libtool libusb-1.0-0-dev git pkg-config rpi.gpio-common texinfo libgpiod-dev libjim-dev

# Create directory for OpenOCD
mkdir -p /opt
cd /opt

# Clone OpenOCD repository
git clone https://github.com/raspberrypi/openocd.git --recursive

# Bootstrap, configure, compile, and install OpenOCD
cd openocd
./bootstrap
./configure --enable-ftdi --enable-sysfsgpio --enable-bcm2835gpio --enable-linuxgpiod
make -j$(nproc)
make install