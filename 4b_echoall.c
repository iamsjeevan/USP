#include<stdio.h>
#include<stdlib.h>
int main(int argc,char *argv[]){
    for(int i=0;i<argc;i++){
        printf("argmuent = %s \n",argv[i]);
    }
    return 0;
}