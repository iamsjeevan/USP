#include<stdio.h>
#include<fcntl.h>
#include<unistd.h>
int main(int argc, char *argv[]){
    int fd=open(argv[1],O_RDONLY);
    int filesize=lseek(fd,0,SEEK_END);
    for(int i=1;i<=filesize;i++){
        lseek(fd,-i,SEEK_END);
        char c;
        read(fd,&c,1);
        putchar(c);
    }
    printf("\n");
    close(fd);
    return 0;
}