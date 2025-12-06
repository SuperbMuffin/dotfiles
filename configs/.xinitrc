#!/bin/sh

export PATH="$HOME/bin:$PATH"

# Redirect all stderr to /dev/null to prevent ly kill spam
exec 2>/dev/null

# Load Wallpaper
feh --bg-fill ~/suckless/wallpaper.jpg &

# Load PICOM for cool effects
picom &

# Load SLSTATUS for a status bar because I'm too lazy to do it the real way
slstatus &

# Load dunst for notifications
dunst &

# Load up the script to watch your wifi strength
~/suckless/slstatus/wifi_signal.sh &

# Load into DWM
exec dwm
