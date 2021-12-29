#!/usr/bin/bash
SETTINGS_FILE="$HOME/.config/dotfiles/settings.sh"
AUTOSTART_FILE="$HOME/.config/dotfiles/autostart.sh"

if [ -x $SETTINGS_FILE ]; then
	source $SETTINGS_FILE
	WALLPAPER=$(cat $HOME/.config/dotfiles/WALLPAPER)
else
	echo "Aucun fichier de configuration trouvé"
	echo "-- Démarrage de l'installation --"
	echo "Quelques questions vont vous être posées,"
	echo "dont la réponse sera stockée dans le fichier"
	echo "$SETTINGS_FILE"
	echo ""
	echo "Interface réseau ? (exemple: wlp4s0, à vérifier avec la commande ip a)"
	read -r NETWORK_INTERFACE
	echo "Moniteur Principal ? (exemple: eDP-0, à vérifier avec la commande xrandr)"
	read -r INTERNAL
	echo "Dimensions du moniteur $INTERNAL ?"
	read -r INTERNAL_DIM
	echo "Moniteur secondaire ? (exemple: HDMI-1)"
	read -r EXTERNAL
	echo "Dimensions du moniteur $EXTERNAL ?"
	read -r EXTERNAL_DIM
	echo "Dossier contenant des fonds d'écran ? (chemin absolu, exemple: $HOME/Pictures/wallpaper)"
	read -r WALLPAPERS_PATH
	echo "Changer les fonds d'écran de manière dynamique ? [0/1]"
	read -r CHANGE_WALL
	echo "Fond d'écran par défaut ?"
	read -r DEFAULT_WALL
	echo "Fréquence de changement du fond d'écran ? (en secondes)"
	read -r WALL_UPDATE_FREQ
	echo "-- Séquence de configuration terminée --"
	echo "-- Enregistrement des paramètres --"
	echo ""

	echo "#!/usr/bin/bash" > "$SETTINGS_FILE"
	echo "NETWORK_INTERFACE=\"$NETWORK_INTERFACE\"" >> "$SETTINGS_FILE"
	echo "INTERNAL=\"$INTERNAL\"" >> "$SETTINGS_FILE"
	echo "INTERNAL_DIM=\"$INTERNAL_DIM\"" >> "$SETTINGS_FILE"
	echo "EXTERNAL=\"$EXTERNAL\"" >> "$SETTINGS_FILE"
	echo "EXTERNAL_DIM=\"$EXTERNAL_DIM\"" >> "$SETTINGS_FILE"
	echo "WALLPAPERS_PATH=\"$WALLPAPERS_PATH\"" >> "$SETTINGS_FILE"
	echo "CHANGE_WALL=\"$CHANGE_WALL\"" >> "$SETTINGS_FILE"
	echo "WALL_UPDATE_FREQ=\"$WALL_UPDATE_FREQ\"" >> "$SETTINGS_FILE"
	echo "DEFAULT_WALL=\"$DEFAULT_WALL\"" >> "$SETTINGS_FILE"

	chmod +x "$SETTINGS_FILE"
	source "$SETTINGS_FILE"

	if [ ! -x $AUTOSTART_FILE ]; then
		echo "Si vous souhaitez lancer un script au démarrage de votre bureau,"
		echo "veuillez le placer dans $AUTOSTART_FILE"

		touch "$HOME/.config/dotfiles/autostart.sh"
		echo "#!/usr/bin/bash" > "$AUTOSTART_FILE"
		echo "# Contient des scripts à lancer au démarrage de bspwm" >> "$AUTOSTART_FILE"
		chmod +x "$AUTOSTART_FILE"
	fi;
fi;
