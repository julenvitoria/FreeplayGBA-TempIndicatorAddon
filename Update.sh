#!/bin/bash

cd ~
git clone https://github.com/julenvitoria/FreeplayGBAcm3Addons
cd FreeplayGBAcm3Addons
cp emulators.cfg /opt/retropie/configs/all
cd ~
git clone https://github.com/LuisDiazUgena/temperatureMonitor
sudo apt update
sudo apt install libpng-dev -y
sudo apt-get install python-gpiozero -y
sudo apt-get install python-pkg-resources python3-pkg-resources -y
sudo apt-get install build-essential python-dev python-smbus python-pip -y
sudo chmod 755 /home/pi/temperatureMonitor/Pngview/pngview
cd ~/FreeplayGBAcm3Addons
crontab mycron
