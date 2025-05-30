#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <dirent.h>
#include <time.h>
#include<sys/stat.h>
int main(int argc,char *argv[]){
struct dirent *d;
struct stat m;
DIR *dp=(argc>1) ? argv[1] : ".";
dp = opendir(dp);
if(dp){
while(d = readdir(dp)){
stat(d->d_name,&m);
printf("%ld %o %d %d %s %s\n", m.st_ino, m.st_mode, m.st_uid, m.st_gid,

ctime(&m.st_atime),d->d_name);
}
}
}