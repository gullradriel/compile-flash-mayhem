# compile-flash-mayhem

Repository for Aj's script for mayhem compilation setup on native linux host

# This script will:
1. update a Debian based OS
2. install the necessary ARM compiler to /opt/armbin (if not done before)
3. clone the eried's mayhem repository from GitHub (if not done before)
4. do required modification for python 3 on source
5. setup environmental variables for compiler
6. create makefile through cmake and compile
7. flash the firmware to HackRF

Feel free to edit / adjust to your need. Script is all thanks to @aj#3566 on discord
