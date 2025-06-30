#include<stdio.h>
#include<sys/stat.h>
#include<time.h>
int main(int argc,char *argv[]){
    struct stat file_stat;
    stat(argv[1], &file_stat);
    printf("File: %s\n", argv[1]);
    printf("size: %lld bytes \n", (long long)file_stat.st_size);
    printf("Links: %ld \n",(long) file_stat.st_nlink);
    printf("Permissions: %o \n",file_stat.st_mode & 0777);
    printf("Last accesstimr: %s", ctime(&file_stat.st_atime));
    printf("Ownwers gid:%ld \n uid?:%ld \n",(long)file_stat.st_gid, (long)file_stat.st_uid);
    return 0;

}