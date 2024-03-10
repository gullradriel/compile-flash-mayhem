# compile-flash-mayhem

## This script will:
- update a Debian based OS
- install the necessary ARM compiler to /opt/armbin (if not done before)
- clone the eried's mayhem repository from GitHub (if not done before)
- setup environmental variables for compiler
- flash the firmware to HackRF

# One liner download & use
```bash -c "$(wget https://raw.githubusercontent.com/gullradriel/compile-flash-mayhem/main/compile-flash-mayhem-deb.sh -O-)"```

# Additional note
- Feel free to edit / adjust to your need. 
- All the various Portapack Mayhem's firmware build instructions are [here](https://github.com/eried/portapack-mayhem/wiki/Compile-firmware)
- If you just want to call the installed version, don't forget to ```export PATH=/opt/build/armbin/bin:/opt/build/armbin/lib:$PATH```

## Special mention
- Original script is all thanks to @aj#3566 on discord

