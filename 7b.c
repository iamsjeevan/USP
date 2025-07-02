#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include <fcntl.h>

int main(int argc, char *argv[]) {
    char buf[10];
    int src = open(argv[1], O_RDONLY);
    int dest = open(argv[2], O_WRONLY | O_CREAT | O_TRUNC, 0644);
    read(src,buf,10);
    write(dest, buf, 10);
    printf("Copied first 10 bytes from %s to %s\n", argv[1], argv[2]);

    close(src);
    close(dest);
    return 0;
}