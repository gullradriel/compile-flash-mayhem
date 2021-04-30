#!/bin/bash

# This script will:
# 1. update a Debian based OS
# 2. install the necessary ARM compiler to /opt/armbin (if not done before)
# 3. clone the eried's mayhem repository from GitHub (if not done before)
# 4. do required modification for python 3 on source
# 5. setup environmental variables for compiler
# 6. create makefile through cmake and compile
# 7. flash the firmware to HackRF!

# Update the system and install arm compiler if non-existant
if [ ! -d /opt/build ]; then
	echo "--- Updating system - installing packages ---"
	sleep 1
	apt-get update
	apt-get install -y git tar wget dfu-util cmake python3 bzip2 curl hackrf python3-distutils python3-setuptools
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py; python3 get-pip.py
	pip install pyyaml

	echo "--- Updating system - installing ARM compiler ---"
	sleep 1
	mkdir /opt/build; cd /opt/build
	wget -O gcc-arm-none-eabi.tar.bz2 'https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2?revision=05382cca-1721-44e1-ae19-1e7c3dc96118&la=en&hash=D7C9D18FCA2DD9F894FD9F3C3DC9228498FA281A'
	mkdir armbin
	tar --strip=1 -xjvf gcc-arm-none-eabi.tar.bz2 -C armbin
fi

# Clone the GitHub repository if non-existant
cd /opt
if [ ! -d /opt/portapack-mayhem ]; then
	echo "--- Cloning Mayhem Portapack repository from GitHub ---"
	sleep 1
	git clone --recurse-submodules https://github.com/eried/portapack-mayhem.git
	# Replace the python version in libopencm3 to use python3
	sed -i 's/env python/env python3/g' portapack-mayhem/hackrf/firmware/libopencm3/scripts/irq2nvic_h
fi

cd portapack-mayhem

# Compile
cd firmware
mkdir build; cd build
PATH=/opt/build/armbin/bin:/opt/build/armbin/lib:$PATH
cmake -B./ -S../../
make firmware

# Flash if compiled
if [[ -f firmware/portapack-h1_h2-mayhem.bin ]]; then
	# Flash
	clear
	echo "FIRMWARE COMPILED! WARNING: DISCONNECT DEVICE TO AVOID FLASHING."
	echo "--- Firmware was compiled! Please connect HackRF in the next 20 seconds to flash (update firmware) or press CTRL+C to cancel flashing HackRF! ---"
	sleep 20
	hackrf_spiflash -w firmware/portapack-h1_h2-mayhem.bin
fi

#git checkout -b name_of_app_warning_fix upstream/next
