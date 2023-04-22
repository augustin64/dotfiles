# Dotfiles

> **Note** This repo contains my config files and scripts for several WM (mainly bspwm & hyprland) \
  If you want to use them, only pick what is necessary for you. \
  Please note that I have not updated `packages.txt` and `extra-packages.txt` for a while. \
  They only contain stuff that was needed for bspwm **at the time I was using it**.

## Installation

```bash
# Refresh pacman cache
pacman -Syy
# Install packages
yay -S $(cat packages.txt)
yay -S $(cat extra-packages.txt)
# Enable services
systemctl enable cronie
systemctl enable lightdm
```

Edit crontab (`crontab -e`)
```
*/5	*	*	*	*	$HOME/.local/share/bin/battery.sh
```
