#include <stdio.h>
#include <stdlib.h>
#include "radix_sort.h"

void print_array(uint64_t * array, size_t size) {
    for (size_t i = 0; i < size; i++) {
        printf("%lu ", array[i]);
    }
    printf("\n");
}

uint64_t * load_array(char * filename, size_t * size) {
    FILE * file = fopen(filename, "r");
    if (file == NULL) {
        return NULL;
    }

    fseek(file, 0, SEEK_END);
    *size = (ftell(file)) / sizeof(uint64_t);
    rewind(file);

    uint64_t * array = calloc(*size, sizeof(uint64_t));
    if (array == NULL) {
        fclose(file);
        return NULL;
    }

    if (fread((void *) array, sizeof(uint64_t), *size, file) != *size) {
        free(array);
        fclose(file);
        return NULL;
    }

    fclose(file);
    return array;
}

size_t save_array(char * filename, uint64_t * array, size_t size) {
    if (array == NULL) {
        return 0;
    }
    FILE * file = fopen(filename, "w");
    if (file == NULL) {
        return 0;
    }

    size = fwrite((void *)array, sizeof(uint64_t), size, file);

    fclose(file);
    return size;
}

int main(int argc, char ** argv) {
    if (argc < 4) {
        fprintf(stderr, "Needs sort type and input and output file names\n.");
        return 1;
    }

    char * type    = argv[1];
    char * inFile  = argv[2];
    char * outFile = argv[3];


    size_t size;
    uint64_t * array = load_array(inFile, &size);
    if (array == NULL) {
        fprintf(stderr, "Could not load array from file %s.\n", argv[1]);
        return 1;
    }

    if (type[0] == '-' && type[1] == 'l') {
        radix_sort(array, size);
    } else if (type[0] == '-' && type[1] == 'm') {
        radix_sort_msb(array, size);
    } else {
        free(array);
        fprintf(stderr, "Invalid sort type \"%s\".\n", type);
        return 1;
    }

    size_t numSaved = save_array(outFile, array, size);

    free(array);

    if (numSaved != size) {
        fprintf(stderr, "Could not save array to file %s.\n", argv[2]);
        return 1;
    }

    return 0;
}
