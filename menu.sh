#!/usr/bin/env bash

# Modules can be added here in the following format:
# Tail_of_GitHub_URL Short_Description Default_Checkbox_State
# The description must use underscores instead of spaces
ADDONS=( \
"julenvitoria/FreeplayGBAcm3-Actualizacion_del_sistema off" \
"julenvitoria/FreeplayGBAcm3-Emulators.cfg on" \
"julenvitoria/FreeplayGBAcm3-Configuraciones_de_juegos on" \
"julenvitoria/temperatureMonitor off" \
)

cmd=(dialog --title "Seleccionar modulos para instalar" \
	--separate-output \
	--ok-label "Instalar" \
	--checklist "Seleccionar opciones:" 0 0 0)

CHOICES=$("${cmd[@]}" ${ADDONS[@]} 2>&1 >/dev/tty)
clear

mkdir /home/pi/Freeplay

printf "Descargando addons seleccionados..."

pushd /home/pi/Freeplay &> /dev/null

DL_ERR=()
for ADDON in $CHOICES
do
	printf "\nDescargando modulo "$ADDON"...\u001b[0m\n"
	if git clone https://github.com/"$ADDON" ; then
		printf "\u001b[32mModulo "$ADDON" descargado satisfactoriamente\u001b[0m\n"
	else
		printf "\e[0;31;40mModulo "$ADDON" no fue descargado satisfactoriamente\u001b[0m\n"
		DL_ERR+=( "$ADDON" )
	fi
done

if [ ${#DL_ERR[@]} -eq 0 ]; then
	printf "\n\u001b[32mTodos los modulos seleccionados fueron descargados satisfactoriamente\u001b[0m\n"
else
	printf "\n\e[0;31;40mLos siguientes modulos no pudieron ser descargados de manera satisfactoria:\u001b[0m\n"
	for MODULE in ${DL_ERR[@]}
	do
		printf "\t\e[0;31;40m"$MODULE"\u001b[0m\n"
	done
fi
sleep 1

INST_ERR=()
printf "\n\u001b[36;1mInstalando modulos descargados...\u001b[0m\n"
for DIR in $(ls -d */)
do
	pushd $DIR &> /dev/null
	printf "\t\u001b[36;1m$DIR...\u001b[0m\n"

	if sudo ./install.sh; then
		printf "\u001b[36;1m$DIR Instalado de manera satisfactoria\u001b[0m\n"
	else
		printf "\e[0;31;40m$DIR NO INSTALADO de manera satisfactoria\u001b[0m\n"
		INST_ERR+=( "$DIR" )
	fi

	popd &> /dev/null
done
popd &> /dev/null

if [ ${#INST_ERR[@]} -eq 0 ]; then
	printf "\n\u001b[32mTodos los modulos descargados se instalaron satisfactoriamente\u001b[0m\n"
else
	printf "\n\e[0;31;40mLos siguientes modulos no pudieron ser instalados de manera satisfactoria:\u001b[0m\n"
	for MODULE in ${INST_ERR[@]}
	do
		printf "\t\e[0;31;40m"$MODULE"\u001b[0m\n"
	done
fi

#dialog --title "RxBrad Freeplay Theme" \
#	--yesno "Would you like to download and install RxBrad's Freeplay theme for EmulationStation?" 0 0

#RESP=$?
#case $RESP in
#	0) sudo git clone --recursive --depth 1 "https://github.com/rxbrad/es-theme-freeplay.git" "/etc/emulationstation/themes/freeplay"; \
#               sudo sed -i 's/<string name="ThemeSet" value=".*" \/>/<string name="ThemeSet" value="freeplay" \/>/g' /opt/retropie/configs/all/emulationstation/es_settings.cfg; \
#		sudo sed -i 's/<string name="TransitionStyle" value=".*" \/>/<string name="TransitionStyle" value="instant" \/>/' /opt/retropie/configs/all/emulationstation/es_settings.cfg;;
#	1) ;;
#	255) ;;
#esac

#mkdir -p "/home/pi/RetroPie/retropiemenu/Freeplay Options"
#cp /home/pi/Freeplay/Freeplay-Support/OptimalLCDSettings.sh "/home/pi/RetroPie/retropiemenu/Freeplay Options/OptimalLCDSettings.sh"

#if grep -q "Freeplay Optimal LCD Settings" /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml ; then
#	echo "Optimal LCD Settings Changer already in menu"
#else
#	sudo sed -i 's|</gameList>|\t<game>\n\t\t<path>./Freeplay Options/OptimalLCDSettings.sh</path>\n\t\t<name>Freeplay Optimal LCD Settings</name>\n\t\t<desc>Switch between optimal LCD settings and HDMI compatibility</desc>\n\t\t<image></image>\n\t\t<playcount>0</playcount>\n\t\t<lastplayed>20180514T205700</lastplayed>\n\t</game>\n</gameList>|' /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml
#fi

exit 0
