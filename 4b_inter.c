#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main(){
    pid_t pid = fork();
    if(pid ==0){
        execl("./textinterpreter","textinterpreter","arg1","arg2","arg3",(char *)0);
         
    }else{
        wait(NULL); // Wait for the child process to finish
        printf("parents saw");
    }
    return 0;
}