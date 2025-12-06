#include <stdio.h>
#include <string.h>
#include "../slstatus.h"

const char* wifi_signal(const char *unused) {
    static char buffer[16];
    FILE *fp = fopen("/tmp/wifi_signal", "r");
    if (!fp) { 
        buffer[0] = '\0'; 
        return buffer; 
    }

    if (!fgets(buffer, sizeof(buffer), fp)) {
        fclose(fp);
        buffer[0] = '\0';
        return buffer;
    }

    fclose(fp);

    // Remove trailing newline
    buffer[strcspn(buffer, "\n")] = 0;
    
    return get_icon(buffer, 'w');
}
