#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
int main(int argc, char *argv[]) {
char* file_name = argv[1];
if(access(file_name, F_OK)==0){
    printf("File %s exists.\n", file_name);
} else {
    printf("File %s does not exist.\n", file_name);
    exit(EXIT_FAILURE);
}
}