#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>
int main(){
    pid_t pid=fork();
    if(pid==0){
        execl("./p1","p1","dest.txt");
        printf("error");
        exit(EXIT_FAILURE);
    }else{
        int status;
        waitpid(pid, &status, 0);
        printf("Parent process finished with status: %d\n", WEXITSTATUS(status));

    }
    return 0;
}
