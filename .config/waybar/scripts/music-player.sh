#!/bin/sh

show_metadata () {
  printf "Titre:   $(playerctl metadata title | sed "s/&/./g" | head -c 50)" #| sed "s/'/ /g"
  if [[ ! $(playerctl metadata album) ==  "Unknown album" ]]; then
    printf "\rAlbum:   $(playerctl metadata album | sed "s/&/./g" | head -c 50)" #| sed "s/'/ /g"
  fi
  printf "\rArtiste: $(playerctl metadata artist | sed "s/&/./g" | head -c 50)" #| sed "s/'/ /g"
}


player_status=$(playerctl status 2>/dev/null)

if [ -z "$(playerctl metadata album)" ]; then
    if [ "$player_status" = "Playing" ]; then
        echo " 喇 "
        show_metadata
    elif [ "$player_status" = "Paused" ]; then
        echo "  "
        show_metadata
    else
        echo ""
    fi
else
    if [ "$player_status" = "Playing" ]; then
        echo "<span color='#89B4FA'>  </span>"
        show_metadata
    elif [ "$player_status" = "Paused" ]; then
        echo "  "
        show_metadata
    else
        echo ""
    fi
fi

# kill "$(<"$XDG_RUNTIME_DIR/waybar-playerctl.pid")"
