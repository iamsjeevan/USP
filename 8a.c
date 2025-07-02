#include<stdio.h>
#include<stdlib.h>
#include <sys/stat.h>
int main(int argc,char * argv[]){
    struct stat buf;
    char* ptr;
    for (int i=1;i<argc;i++){
        lstat(argv[i], &buf);
        printf("File: %s\n", argv[i]);
        if(S_ISREG(buf.st_mode)) ptr="normal file";
        else if(S_ISDIR(buf.st_mode)) ptr="directory";
        else if(S_ISBLK(buf.st_mode))ptr="block file";
        else if(S_ISFIFO(buf.st_mode)) ptr="fifo pipe line";
        else if (S_ISLNK(buf.st_mode)) ptr="symbolic link";
        else if(S_ISCHR(buf.st_mode)) ptr="character file";
        else if(S_ISSOCK(buf.st_mode)) ptr="socket";
        else ptr="unknown type";
        printf("Type: %s\n", ptr);
    }
    return 0;
}