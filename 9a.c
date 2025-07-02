#include <stdio.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
int main() {
    const char* file_path = "example.txt";
    umask(0022);
    int fd=open(file_path,O_CREAT |O_WRONLY | O_TRUNC, 0666);
    getchar();
    chmod(file_path, 0700);
    return 0;
}