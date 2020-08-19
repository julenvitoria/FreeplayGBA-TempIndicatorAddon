#!/bin/bash

cd /home/pi
#HACEMOS UPDATE Y UPGRADE PARA TENER EL SISTEMA ACTUALIZADO
sudo apt update && sudo apt upgrade -y
#CLONAMOS EL SCRIPT DE TEMPERATURA, INSTALAMOS SUS DEPENDENCIAS, CAMBIAMOS EL SCRIPT POR OTRO
#MODIFICADO PARA LA GBA Y CAMBIAMOS TAMBIEN EL CRONTAB PARA QUE LO CARGUE EN EL ARRANQUE
git clone https://github.com/LuisDiazUgena/temperatureMonitor
sudo apt install -y libpng-dev python-gpiozero python-pkg-resources python3-pkg-resources build-essential python-dev python-smbus python-pip
sudo chmod 755 /home/pi/temperatureMonitor/Pngview/pngview
#cd /home/pi/FreeplayGBAcm3Addons
wget -O- https://raw.githubusercontent.com/julenvitoria/FreeplayGBA-TempIndicatorAddon/master/tempMonitor.py>/home/pi/temperatureMonitor/tempMonitor.py
wget -O- https://raw.githubusercontent.com/julenvitoria/FreeplayGBA-TempIndicatorAddon/master/mycron>/home/pi/temperatureMonitor/mycron
crontab /home/pi/temperatureMonitor/mycron
if [ -f /home/pi/temperatureMonitor/tempMonitor.py ]; then
        echo "SHUTTING DOWN... PLEASE POWER ON BEFORE"
        sleep 1
        echo "SHUTTING DOWN... PLEASE POWER ON BEFORE"
        sleep 1
        echo "SHUTTING DOWN... PLEASE POWER ON BEFORE"
        sleep 1
        echo "SHUTTING DOWN... PLEASE POWER ON BEFORE"
        sleep 1
        echo "SHUTTING DOWN... PLEASE POWER ON BEFORE"
        sleep 1
        echo "SHUTTING DOWN... PLEASE POWER ON BEFORE"
        sleep 1
        echo "SHUTTING DOWN... PLEASE POWER ON BEFORE"
        sleep 1
        echo "SHUTTING DOWN... PLEASE POWER ON BEFORE"
        sleep 1
        sudo poweroff
else
        echo "SCRIPT WAS NOT INSTALLED PROPERLY"
        sleep 5
fi
