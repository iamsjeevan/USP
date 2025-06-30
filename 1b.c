#include<stdio.h>
#include<fcntl.h>
#include<unistd.h>
#include<sys/wait.h>
int main(){
    int fd=open("t2.txt",O_RDWR);
    pid_t pid=fork();
    if(pid==0){
        char buffer[10];
        read(fd,buffer,5);
        buffer[5]='\0'; // Null-terminate the string
        printf("child read: %s \n ",buffer);
    }else{
        char buffer[10];
        wait(NULL); // Wait for the child process to finish
        read(fd,buffer,5);
        buffer[5]='\0'; // Null-terminate the string
        printf("parent read: %s \n ",buffer);
    }
    close(fd);
    return 0;
}