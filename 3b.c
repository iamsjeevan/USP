#include<stdio.h>
#include<stdlib.h>
#include<dirent.h>
#include<sys/stat.h>
#include <time.h>
#include<string.h>
int main(int argc , char* argv[]){
    struct dirent *dir;
	struct stat st;
	DIR *dp=opendir(".");
    while((dir=readdir(dp))!=NULL){
        stat(dir->d_name,&st);
        printf("\n %ld %o %ld %ld %ld %ld %s",(long)st.st_ino,st.st_mode & 0777,(long)st.st_nlink,(long)st.st_uid,(long)st.st_gid,(long)st.st_size,dir->d_name);
    }
    return 0;
}