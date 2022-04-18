# Dotfiles

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
*/5	*	*	*	*	$HOME/bin/battery.sh
```
