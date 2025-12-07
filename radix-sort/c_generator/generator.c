#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdint.h>
#include <string.h>

long my_atol(char * str) {
    size_t length = strlen(str) + 1;

    size_t movement = 0;
    size_t i = 0;
    while (i + movement < length) {
        if (str[i + movement] == '_') {
            movement++;
        } else {
            str[i] = str[i + movement];
            i++;
        }
    }

    return atol(str);
}

int main(int argc, char ** argv) {
    if (argc < 2) {
        fprintf(stderr, "Needs one argument, the number of items to generate\n");

        return 1;
    }

    long num = my_atol(argv[1]);

    int seed = time(NULL);
    srand(seed);

    FILE * radix = fopen("unsortedRadix.b", "w");
    FILE * shell = fopen("unsortedShell.b", "w");

    if (radix == NULL || shell == NULL) {
        fclose(radix);
        fclose(shell);

        fprintf(stderr, "Could not open files\n");

        return 0;
    }

    uint64_t longValue;
    int value;

    for (size_t i = 0; i < num; i++) {
        value = rand() & ((1 << 16) - 1);
        longValue = value;
        
        fwrite(&longValue, sizeof(longValue), 1, radix);
        fwrite(&value,     sizeof(value),     1, shell);
    }

    return 0;
}
