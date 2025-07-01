#include<stdio.h>
#include<dirent.h>
#include<string.h>
#include<sys/stat.h>
#include<unistd.h>
#include<fcntl.h>
#include<stdlib.h>
void remove_empty(const char  *directory){
    DIR *dp=opendir(directory);
    struct dirent *entry;
    while((entry=readdir(dp))!=NULL){
        if(strcmp(entry->d_name,".")==0 || strcmp(entry->d_name,"..")==0){
            continue;
        }
        char path[1024];
        snprintf(path,sizeof(path),"%s/%s",directory,entry->d_name);
        int fd=open(path,O_RDONLY);
        off_t size=lseek(fd,0,SEEK_END);
        close(fd);
        if(size==0){
            if (unlink(path) == 0){
                printf("Remove empty file %s\n", path);
            }
        }
    }
    closedir(dp);
}
int main(int argc,char * argv[]){
    remove_empty(argv[1]);
    return 0;
}
