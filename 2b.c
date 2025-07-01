#include<stdio.h>
#include<sys/wait.h>
#include<stdlib.h>
#include<unistd.h>
int my_sys(const char *command){
    pid_t pid = fork();
    if(pid==0){
        execl("/bin/sh","sh","-c",command,(char *)NULL);
        printf("Error");
        exit(127);
    }else{
        int status;
        waitpid(pid,&status,0);
        if(WIFEXITED(status)){
            return WEXITSTATUS(status);
        }
        return -1;
    }

}
int main(){
    printf("Running command: ls -l\n");
    int return_status=my_sys("ls -l");
    printf("\n command finished with return code: %d\n",return_status);
    return 0;
}