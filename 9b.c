#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
int main(int argc, char *argv[]) {
int fd=open("t2.txt", O_RDWR);
char buf[21];
read(fd, buf, 20);
buf[20] = '\0';
printf("Read from file: %s\n", buf);
lseek(fd,10,SEEK_SET);
read(fd, buf, 20);
buf[20] = '\0';
printf("Read from file after lseek: %s\n", buf);
lseek(fd, 10, SEEK_CUR);
read(fd, buf, 20);
buf[20] = '\0';
printf("Read from file after lseek with SEEK_CUR: %s\n", buf);
off_t size=lseek(fd, 0, SEEK_END);
printf("Size of file: %ld bytes\n", (long)size);
return 0;
}