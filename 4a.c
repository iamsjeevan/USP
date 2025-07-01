#include <stdio.h>
#include<stdlib.h>
#include<unistd.h>
int main(int argc,char* argv[]){
    if(argc ==3){
        if(link(argv[1],argv[2])==0){
            printf("hard link created from %s to %s\n", argv[1], argv[2]);

        }

    }
    if(argc ==4){
        if(symlink(argv[2],argv[3])==0){
            printf("symbolic link created from %s to %s\n", argv[2], argv[3]);
        } 
    
    }
    return 0;
}