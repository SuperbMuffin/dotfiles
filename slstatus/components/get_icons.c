#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int is_charging(void) {
    FILE *fp = fopen("/sys/class/power_supply/BAT0/status", "r");
    if (!fp) return 0;  // fallback if file missing

    char status[16];
    if (fgets(status, sizeof(status), fp) == NULL) {
        fclose(fp);
        return 0;
    }
    fclose(fp);

    // remove trailing newline
    status[strcspn(status, "\n")] = 0;

    return strcmp(status, "Charging") == 0;
}


const char *get_icon(const char *value, char type) {
    int val = atoi(value);    

    // Volume icons
    if (type == 'v') {
        if (val ==  -1) return "";
        if (val > 66) return "";
        if (val > 33) return "";
        if (val > 0)  return "";
        if (val == 0) return "";
   }
   // Battery icons
   else if (type == 'b') {
        if (is_charging()) return "󰂄";
	if (val == 100) return "󰁹";
        if (val > 90) return "󰂂";
        if (val > 80) return "󰂁";
        if (val > 70) return "󰂀";
        if (val > 60) return "󰁿";
        if (val > 50) return "󰁾";
        if (val > 40) return "󰁽";
        if (val > 30) return "󰁼";
        if (val > 20) return "󰁻";
        if (val > 10) return "󰁺";
	if (val < 10) return "󰂎";
   }
   else if (type == 'w') {
       if (val > 75) return "󰤨";
       if (val > 50) return "󰤥";
       if (val > 25) return "󰤢";
       if (val > 0) return "󰤟";
       if (val == 0) return "󰤯";
       if (val == -1) return "󰤭";
   }
   return "?";
}
