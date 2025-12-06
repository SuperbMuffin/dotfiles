#!/bin/bash
# dmenu-bluetooth: A clean Bluetooth manager for dmenu with Nerd Font icons
# Requires: bluez, bluez-utils, dmenu, and a Nerd Font
# Optional: dunst for notify-send messages

# Icons
ICON_BT=""
ICON_SCAN="󰍉"
ICON_CONNECT="󰤄"
ICON_DISCONNECT="󰤂"
ICON_TRUST=""
ICON_REMOVE="󰆴"
ICON_POWER_OFF=""
ICON_EXIT="󰅙"
ICON_DEVICE="󰂱"

# Optional notification wrapper
notify() {
    if command -v notify-send &>/dev/null; then
        notify-send "Bluetooth" "$1"
    fi
}

# Ensure Bluetooth is powered on
if ! bluetoothctl show | grep -q "Powered: yes"; then
    bluetoothctl power on >/dev/null
    notify "Powering on Bluetooth adapter..."
    sleep 1
fi

# Build device list
devices=$(bluetoothctl devices | awk -v icon="$ICON_DEVICE" '{mac=$2; name=substr($0, index($0,$3)); printf "%s  %s (%s)\n", icon, name, mac}')

# Build main dmenu options
options=$(printf "%s\n%s\n%s\n%s" \
    "$ICON_SCAN  Scan for new devices" \
    "$ICON_POWER_OFF  Turn Off Bluetooth" \
    "$ICON_EXIT  Exit" \
    "$devices")

# Show main menu
choice=$(echo "$options" | dmenu -i -p "$ICON_BT  Bluetooth")

case "$choice" in
    *"Scan for new devices"*)
        bluetoothctl scan on &>/dev/null &
        notify "Scanning for new devices (15s)..."
        sleep 15
        bluetoothctl scan off &>/dev/null || true
        ;;
    *"Turn Off Bluetooth"*)
        bluetoothctl power off >/dev/null
        notify "Bluetooth turned off"
        ;;
    *"Exit"*)
        exit 0
        ;;
    *)
        mac=$(echo "$choice" | sed -n 's/.*(\(.*\)).*/\1/p')
        [ -z "$mac" ] && exit 0

        # Device action menu
        actions=$(printf "%s\n%s\n%s\n%s\n%s" \
            "$ICON_CONNECT  Connect" \
            "$ICON_DISCONNECT  Disconnect" \
            "$ICON_TRUST  Trust" \
            "$ICON_REMOVE  Remove" \
            "$ICON_EXIT  Back")

        action=$(echo "$actions" | dmenu -i -p "$ICON_DEVICE  $mac")

        case "$action" in
            *"Connect"*) bluetoothctl connect "$mac" ;;
            *"Disconnect"*) bluetoothctl disconnect "$mac" ;;
            *"Trust"*) bluetoothctl trust "$mac" ;;
            *"Remove"*) bluetoothctl remove "$mac" ;;
            *) exit 0 ;;
        esac
        ;;
esac
