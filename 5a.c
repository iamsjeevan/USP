#include<stdio.h>
#include<stdlib.h>
#include<utime.h>
#include<sys/stat.h>
int main(int argc, char* argv[]){
    struct stat source_stat;
    stat(argv[1], &source_stat);
    struct utimbuf new_times;
    new_times.actime=source_stat.st_atime;
    new_times.modtime=source_stat.st_mtime;
    utime(argv[2], &new_times);
    return 0;

}