#!/bin/sh

while true; do
    # Get current Wi-Fi signal (empty if not connected)
    SIGNAL=$(/usr/bin/nmcli -t -f ACTIVE,SIGNAL dev wifi | /usr/bin/awk -F: '/^yes:/ {print $2}')

    # Default output
    OUTPUT=0

    if [ -n "$SIGNAL" ]; then
        # Check connectivity
        CONNECTIVITY=$(/usr/bin/nmcli -t -f CONNECTIVITY general status 2>/dev/null)

        case "$CONNECTIVITY" in
            full)
                OUTPUT=$SIGNAL   # Internet OK
                ;;
            limited|portal)
                OUTPUT=-1        # Connected but no internet
                ;;
            *)
                OUTPUT=0         # Not connected
                ;;
        esac
    fi

    echo "$OUTPUT" > /tmp/wifi_signal.tmp
    mv /tmp/wifi_signal.tmp /tmp/wifi_signal
    kill -45 $(pidof slstatus)
    sleep 5
done
