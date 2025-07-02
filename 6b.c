#include<stdio.h>
#include<stdlib.h>
#include<fcntl.h>
#include<sys/types.h>
#include<sys/stat.h>
#include<unistd.h>
int main(int argc,char *argv[]){
int fd=open(argv[1],O_RDWR|O_CREAT,0644);
struct flock li;
li.l_type=F_WRLCK;
li.l_whence=SEEK_END;
li.l_start=-100;
li.l_len=100; // Lock the last 100 bytes
printf("Locking the last 100 bytes of %s\n", argv[1]);
printf("just press enter");
getchar();
if(fcntl(fd,F_SETLK,&li)==-1){
    fcntl(fd,F_GETLK,&li);
    printf("the process pid %d is holdin lock by %d \n", getpid(), li.l_pid);
return 1;
}
printf("locking");
lseek(fd,-50,SEEK_END);
char buf[101];
int bytes_read=read(fd,buf,100);
buf[bytes_read]='\0'; // Null-terminate the string
printf("Read from locked region: %s\n", buf);
printf("just press enter");
getchar();
li.l_type=F_UNLCK; // Unlock the region
fcntl(fd, F_SETLK, &li);
printf("Unlocked the last 100 bytes of %s\n", argv[1]);
close(fd);
return 0;
}