#include "insert_sort.h"
#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>


void print_list(int64_t *list, int size) {
    // Print all elements of a list.
    for (int i = 0; i < size; i++) {
        printf("%ld ", list[i]);
    }
    printf("\n");
}

int input_array(int64_t ** arr) {
    // get an array of integers from the user

    // If the array is not NULL, then their is an issue
    if (*arr != NULL) {
        return -1;
    }

    char * input; // the intput
    int cont = 1; // if only numbers have been entered
    int i = 0;    // the index we are checking to be a number (or negitive sign)
    int size = 0; // the total size of the array

    // loop until a none number char is found
    while (cont) {
        // input a number safely.
        if (!scanf("%ms", &input)) {
            return -1;
        }
        
        // check if all of the chars are numbers.
        i = 0;
        while (input[i]) {
            if (((input[i] < '0') || (input[i] > '9')) && (input[i] != '-')) {
                cont = 0;
                free(input);
                break;
            }
            i++;
        }
        
        // Add an element to the array
        if (cont) {
            // increase the size of the array
            *arr = reallocarray(*arr, size + 1, sizeof(int64_t));
            if (*arr == NULL)
                return -1;
            
            // add the new item to the array
            (*arr)[size] = strtol(input, NULL, 0);
            size++;
            free(input);
        }
    }
    
    // return the size
    return size;
}

int main() {
    // get the array from the user
    int64_t * to_sort = NULL;
    int size = input_array(&to_sort);

    // print error
    if (size < 0) {
        printf("Error in inputting. You probably added to many elements.\n");
        return 1;
    }
     
    // Print the unsorted list
    print_list(to_sort, size);

    // sort then print the list.
    insert_sort(to_sort, size);
    print_list(to_sort, size);

    return 0;
}
