#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {

    if(argc == 3) {
        char *phy = NULL;
        char *stat = NULL;
        char *filename = NULL;
        FILE *f = NULL;
        phy = basename(argv[1]);
        stat = basename(argv[2]);
        if(asprintf(&filename, "/sys/kernel/debug/ieee80211/%s/statistics/%s", phy, stat) > 0)
            f = fopen(filename, "r");

        if(f != NULL) {
            char temp[256];
            while (fgets(temp, 256, f) != NULL)
                printf("%s",temp);

            fclose(f);
        }
        free(filename);
    } else {
        fprintf(stderr, "Usage: %s PHY STAT\n",argv[0]);
        fprintf(stderr, " cat /sys/kernel/debug/ieee80211/PHY/statistics/STAT as root\n");
        return 1;
    } 
    return 0;
}
