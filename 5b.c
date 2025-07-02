#include<signal.h>
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
void s_h(int signum){
    printf("Signal %d received\n", signum);
    struct sigaction sa;
    sa.sa_handler= SIG_DFL; // Reset to default handler
    sa.sa_flags = 0; // No special flags
    sigemptyset(&sa.sa_mask); // No additional signals to block
    sigaction(SIGINT,&sa,NULL);
    printf("Signal handler reset to default\n");
}
int main(){
    struct sigaction sa;
    sa.sa_handler=s_h; // Set custom handler
    sa.sa_flags = 0; // No special flags
    sigemptyset(&sa.sa_mask); // No additional signals to block
    sigaction(SIGINT,&sa,NULL); // Register the handler for SIGINT
    printf("get pid :%d\n", getpid());
    while(1){
        printf("Running... Press Ctrl+C to send SIGINT\n");
        sleep(1); // Sleep for a while to simulate work
    }
}