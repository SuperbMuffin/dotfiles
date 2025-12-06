// components/volume_pactl.c
#include <stdio.h>
#include <string.h>
#include "../slstatus.h"

const char *
get_volume_pactl(const char *unused)
{
    static char buf[16];       // final output buffer
    char vol_str[8] = {0};     // temporary string for volume
    char muted[4] = {0};

    // --- get mute state ---
    FILE *mute_fp = popen("pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}'", "r");
    if (!mute_fp) return "N/A";
    if (!fgets(muted, sizeof(muted), mute_fp)) {
        pclose(mute_fp);
        return "N/A";
    }
    pclose(mute_fp);
    muted[strcspn(muted, "\n")] = 0;

    // --- get volume ---
    FILE *vol_fp = popen("pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}'", "r");
    if (!vol_fp) return "N/A";
    if (!fgets(vol_str, sizeof(vol_str), vol_fp)) {
        pclose(vol_fp);
        return "N/A";
    }
    pclose(vol_fp);
    vol_str[strcspn(vol_str, "\n")] = 0;

    // if muted, set volume to -1
    if (strcmp(muted, "yes") == 0)
        strcpy(vol_str, "-1%");

    // --- get icon ---
    const char *volume_icon = get_icon(vol_str, 'v');

    // --- combine icon + volume ---
    snprintf(buf, sizeof(buf), "%s %s", volume_icon, vol_str);

    return buf;
}

