#include<stdio.h>
#include<fcntl.h>
#include<unistd.h>
int main(){
    int fd=open("t2.txt",O_RDWR);
    char buf[10];
    read(fd,buf,5);
    buf[5]='\0'; // Null-terminate the string
    lseek(fd,0,SEEK_END);
    dup2(fd, STDOUT_FILENO);
    printf("%s",buf);
    close(fd);
    return 0;
}
