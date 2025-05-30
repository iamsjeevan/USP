#!/bin/bash

# --- IMPORTANT: CONFIGURE THIS ON THE TARGET MACHINE (or here before serving) ---
# Replace "YOUR_CSELАB3_IP_ADDRESS_HERE" with the actual IP address
# of the computer running the Python HTTP server (cselab3).
# This IP is ONLY needed if setup.sh itself needs to be re-downloaded,
# or if other non-embedded files were to be downloaded.
# For this version, it's less critical if setup.sh is already on the target.
SERVER_IP="YOUR_CSELАB3_IP_ADDRESS_HERE"
SERVER_PORT="8080" # Not used for C file transfer in this version
# --- END OF CONFIGURATION ---

# Destination directory on the TARGET machine
DEST_DIR_ON_TARGET="${HOME}/snap/dev"

echo "----------------------------------------------------"
echo "Setup Script Started (Embedded Content Version)"
echo "----------------------------------------------------"
echo "Files will be created in: ${DEST_DIR_ON_TARGET}"
echo ""

# Check if SERVER_IP is set (optional check, as it's not strictly needed for this script's primary function)
if [ "${SERVER_IP}" == "YOUR_CSELАB3_IP_ADDRESS_HERE" ] || [ -z "${SERVER_IP}" ]; then
  echo "WARNING: SERVER_IP is not configured in this script."
  echo "         This might be an issue if this script needed to download other components."
  # For this specific script that embeds C files, we might not want to exit.
  # Consider if an exit is truly needed here. For now, it's a warning.
  # exit 1
fi

# Create the destination directory on the target machine if it doesn't exist
echo "Ensuring destination directory exists on target: ${DEST_DIR_ON_TARGET}"
mkdir -p "${DEST_DIR_ON_TARGET}"
if [ $? -ne 0 ]; then
    echo "Error: Could not create directory ${DEST_DIR_ON_TARGET} on target. Please check permissions."
    exit 1
fi
echo "Directory ${DEST_DIR_ON_TARGET} is ready on target."
echo ""

echo "Starting creation of .c files from embedded content..."
SUCCESS_COUNT=0
FAIL_COUNT=0

echo "Creating ${DEST_DIR_ON_TARGET}/10a.c ..."
cat > "${DEST_DIR_ON_TARGET}/10a.c" <<'EOF_C_CONTENT_10ac_223131769'
#include<stdio.h>
#include<stdlib.h>
#include<sys/stat.h>
#include<sys/types.h>
#include<syslog.h>
#include<unistd.h>
#include<fcntl.h>
void create_daemon(){
pid_t pid=fork();
if(pid<0){
exit(EXIT_FAILURE);
}
if(pid>0){
exit(EXIT_SUCCESS);
}
if(setsid()<0){
exit(EXIT_FAILURE);

}
umask(0);
if(chdir("/")<0){
exit(EXIT_FAILURE);
}
open("/dev/null",O_RDONLY);
open("/dev/null",O_WRONLY);
open("/dev/null",O_RDWR);
close(STDIN_FILENO);
close(STDOUT_FILENO);
close(STDERR_FILENO);
}
int main(){
create_daemon();
openlog("daemon_ex",LOG_PID,LOG_DAEMON);
while(1){
syslog(LOG_NOTICE,"Daemon isrunning...\n");
sleep(30);
}
closelog();
return EXIT_SUCCESS;
}
EOF_C_CONTENT_10ac_223131769
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/10a.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/10a.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/10b.c ..."
cat > "${DEST_DIR_ON_TARGET}/10b.c" <<'EOF_C_CONTENT_10bc_226466029'
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/wait.h>
#include<sys/types.h>
int main(){
int st;
pid_t pid1=fork(); pid_t pid2=fork();
if(pid1==0){
printf("first pid:%d\n",getpid());
sleep(2);
exit(0);
}
if(pid2==0){
printf("second pid:%d\n",getpid());
sleep(4);
exit(0);
}
wait(&st);
printf("first wait\n");
sleep(1);
waitpid(pid2,&st,0);
printf("second wait\n");
return 0;

}
EOF_C_CONTENT_10bc_226466029
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/10b.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/10b.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/11a.c ..."
cat > "${DEST_DIR_ON_TARGET}/11a.c" <<'EOF_C_CONTENT_11ac_229790275'
dup()
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
int main() {
int fd1 = 0, fd2 = 0;
char buf[10] = "abcdef";
if ((fd1 = open("t12.txt", O_RDWR, 0)) < 0) {
printf("error");
}
fd2 = dup(fd1);
printf("%d %d \n", fd1, fd2);
write(fd1, buf, 6);
return 0;
}
dup2()
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
int main() {
int fd11 = 0, fd12 = 0;
char buf[10] = "abcdef";
if ((fd11 = open("t12.txt", O_RDWR, 0)) < 0) {
printf("error");
}
if (dup2(fd12, fd11) < 0) {
printf("error");
}
printf("%d %d \n", fd11, fd12);
write(fd11, buf, 6);
return 0;
}
EOF_C_CONTENT_11ac_229790275
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/11a.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/11a.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/11b.c ..."
cat > "${DEST_DIR_ON_TARGET}/11b.c" <<'EOF_C_CONTENT_11bc_232959432'
Main program.c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
int main(int argc, char *argv[]) {
if (argc != 3) {
printf("Usage: %s num1 num2\n", argv[0]);
exit(0);
}
pid_t pid = fork();
if (pid < 0) {
perror("fork failed");
exit(0);
} else if (pid == 0) {
execl("./p23", "p23", argv[1], argv[2], (char *)NULL);
perror("execl failed");
exit(EXIT_FAILURE);
} else {
int status;
waitpid(pid, &status, 0);
if (WIFEXITED(status)) {
printf("Child exited with status %d\n", WEXITSTATUS(status));
} else {
printf("Child terminated abnormally\n");
}
}
return 0;
}

p23.c
#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[]) {
if (argc != 3) {
printf("Usage: %s num1 num2\n", argv[0]);
exit(0);
}
int num1 = atoi(argv[1]);
int num2 = atoi(argv[2]);
int sum = num1 + num2;
printf("Sum: %d\n",sum);
return 0;
}
EOF_C_CONTENT_11bc_232959432
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/11b.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/11b.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/12a.c ..."
cat > "${DEST_DIR_ON_TARGET}/12a.c" <<'EOF_C_CONTENT_12ac_236196533'
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<fcntl.h>
#include <sys/wait.h>
int main(void) {
pid_t pid,pid1,pid2;
if ((pid = fork()) < 0) {
printf("fork error");
} else if (pid == 0) { /* first child */
if ((pid3 = fork()) < 0)
printf("fork error");
else if (pid3==0) {
sleep(5);
printf("Child pid is: %d\n",getpid());
printf("second child, parent pid = %ld\n", (long)getppid());
exit(0);
}
else{

printf("Child pid: %d\n",getpid());
exit(0);
}
}
if ((pid2=waitpid(pid, NULL, 0)) != pid)
printf("waitpid error");
printf("terminated child's pid: %d\n",pid2);
exit(0);
}
EOF_C_CONTENT_12ac_236196533
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/12a.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/12a.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/12b.c ..."
cat > "${DEST_DIR_ON_TARGET}/12b.c" <<'EOF_C_CONTENT_12bc_239513560'
Main program
*** Remember to change the path in the first argument of both execle() and execlp(), set pat
according to the location of your echoall file ***
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
void err_sys(const char *message) {
perror(message);
exit(1);
}
int main(void) {
pid_t pid;

char *env_init[] = { "USER=unknown", "PATH=/tmp", NULL };
if ((pid = fork()) < 0) {
err_sys("fork error");
} else if (pid == 0) {
if (execle("/home/aneesh/echoall", "echoall", "myarg1", "MY ARG2", (char *)0, env_init) < 0) {
err_sys("execle error");
}
}
if (waitpid(pid, NULL, 0) < 0) {
err_sys("wait error");
}
if (execlp("/home/aneesh/echoall", "echoall", "only 1 arg", (char *)0) < 0) {
err_sys("execlp error");
}
return 0;
}
echoall.c file
#include<stdio.h>
#include<stdlib.h>
int main(int argc,char *argv[]){
int i;
for(i=0;i<argc;i++){
printf("argv[%d]= %s\n",i,argv[i]);
}
return 0;
}
EOF_C_CONTENT_12bc_239513560
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/12b.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/12b.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/1a.c ..."
cat > "${DEST_DIR_ON_TARGET}/1a.c" <<'EOF_C_CONTENT_1ac_242864793'
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
int main(int argc, char *argv[]) {
if (argc < 2) {
fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
return 1;
}
int fd = open(argv[1], O_RDONLY);
if (fd == -1) {
perror("open");
return 1;
}
int file_size = lseek(fd, 0, SEEK_END);
if (file_size == -1) {
perror("lseek");
return 1;
}
for (int i = 1; i <= file_size; i++) {
lseek(fd, -i, SEEK_END);
char c;
if (read(fd, &c, 1) != 1) {
perror("read");
return 1;
}
putchar(c);
}
printf("\n");
close(fd);
return 0;
}
EOF_C_CONTENT_1ac_242864793
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/1a.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/1a.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/1b.c ..."
cat > "${DEST_DIR_ON_TARGET}/1b.c" <<'EOF_C_CONTENT_1bc_246138518'
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>
int main() {
int fd = open("t2.txt", O_RDWR);
if (fd == -1) {
perror("open");
return 1;
}
pid_t pid = fork();
if (pid == -1) {
perror("fork");
return 1;
} else if (pid == 0) {
char buffer[10];
read(fd, buffer, 5);
buffer[5] = '\0';
printf("Child read: %s\n", buffer);
} else {
wait(NULL);
char buffer[10];
read(fd, buffer, 5);
buffer[5] = '\0';
printf("Parent read: %s\n", buffer);
}
close(fd);
return 0;
}
EOF_C_CONTENT_1bc_246138518
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/1b.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/1b.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/2a.c ..."
cat > "${DEST_DIR_ON_TARGET}/2a.c" <<'EOF_C_CONTENT_2ac_249438126'
#include <stdio.h>
#include <sys/stat.h>
int main(int argc, char *argv[]) {
if (argc < 2) {
fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
return 1;
}
struct stat file_stat;
if (stat(argv[1], &file_stat) == -1) {
perror("stat");
return 1;
}
printf("File: %s\n", argv[1]);
printf("Size: %lld bytes\n", (long long) file_stat.st_size);
printf("Permissions: %o\n", file_stat.st_mode & 0777);
printf("Number of Links: %ld\n", (long) file_stat.st_nlink);
printf("Owner: UID=%ld, GID=%ld\n", (long) file_stat.st_uid, (long) file_stat.st_gid);
printf("Last Access Time: %ld\n", (long) file_stat.st_atime);
return 0;
}
EOF_C_CONTENT_2ac_249438126
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/2a.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/2a.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/2b.c ..."
cat > "${DEST_DIR_ON_TARGET}/2b.c" <<'EOF_C_CONTENT_2bc_252486725'
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/wait.h>
#include<sys/types.h>
int my_sys(const char *cm){
if(cm==NULL){

return -1;}
pid_t pid=fork();
if(pid==-1){
printf("error\n");return -1;}
else if(pid==0){
execl("/bin/sh","sh","-c",cm,(char *)NULL);
printf("execerror\n");
exit(EXIT_FAILURE);
}
else{
int st;
if(waitpid(pid,&st,0)==-1){
return -1;}
if(WIFEXITED(st)){
return WEXITSTATUS(st);

}

else{
return -1;
}
}
}

int main(){


printf("executing ls-li\n");
int res=my_sys("ls -li");
if(res==-1){
printf("error\n");
}
else{
printf("exited with status %d\n",res);
}
return 0;
}
EOF_C_CONTENT_2bc_252486725
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/2b.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/2b.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/3a.c ..."
cat > "${DEST_DIR_ON_TARGET}/3a.c" <<'EOF_C_CONTENT_3ac_255782323'
#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
void remove_empty_files(const char *directory) {
struct dirent *entry;
DIR *dp = opendir(directory);
if (dp == NULL) {
perror("opendir");
return;
}
while ((entry = readdir(dp)) != NULL) {
if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
continue;
}
char path[1024];
snprintf(path, sizeof(path), "%s/%s", directory, entry->d_name);
int fd = open(path, O_RDONLY);
if (fd == -1) {
perror("open");
continue;
}
off_t size = lseek(fd, 0, SEEK_END);
if (size == -1) {
perror("lseek");
close(fd);
continue;
}
if (size == 0) {
if (unlink(path) == 0) {
printf("Removed empty file: %s\n", path);
} else {
perror("unlink");
}
}
}
closedir(dp);
}
int main(int argc,char *argv[]) {
const char *directory = argv[1];
remove_empty_files(directory);
return 0;
}
EOF_C_CONTENT_3ac_255782323
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/3a.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/3a.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/3b.c ..."
cat > "${DEST_DIR_ON_TARGET}/3b.c" <<'EOF_C_CONTENT_3bc_259203528'
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
EOF_C_CONTENT_3bc_259203528
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/3b.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/3b.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/4a.c ..."
cat > "${DEST_DIR_ON_TARGET}/4a.c" <<'EOF_C_CONTENT_4ac_262498074'
#include<stdio.h>
#include<stdlib.h>
#include<fcntl.h>
#include<unistd.h>
#include<sys/stat.h>
#include<sys/types.h>
int main(int argc,char *argv[]){
if(argc==3){
if((link(argv[1],argv[2]))==0){
printf("Hard link created\n");
}
else{
}
}

printf("Hard link error\n");

else if(argc==4){
if((symlink(argv[2],argv[3]))==0){
printf("Soft link created\n");
}
else{
}
}

printf("Soft link error\n");

return 0;
}
EOF_C_CONTENT_4ac_262498074
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/4a.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/4a.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/4b_echoall.c ..."
cat > "${DEST_DIR_ON_TARGET}/4b_echoall.c" <<'EOF_C_CONTENT_4b_echoallc_265821592'
#include<stdio.h>
#include<stdlib.h>
int main(int argc,char *argv[]){
int i;
for(i=0;i<argc;i++){
printf("argv[%d]= %s\n",i,argv[i]);
}
return 0;
}
EOF_C_CONTENT_4b_echoallc_265821592
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/4b_echoall.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/4b_echoall.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/4b_inter.c ..."
cat > "${DEST_DIR_ON_TARGET}/4b_inter.c" <<'EOF_C_CONTENT_4b_interc_269091083'
#include<stdio.h>
#include<sys/stat.h>
#include<sys/types.h>
#include<unistd.h>
#include<fcntl.h>
int main(){
pid_t pid=fork();
if(pid<0){
printf("error\n");
}
else if(pid==0){
if(execl("textinterpreter","test","myarg1","myarg2","myarg4",(char *)0)<0)
printf("error\n");

}
return 0;
}

if(waitpid(pid,NULL,0)<0)
printf("error\n");
EOF_C_CONTENT_4b_interc_269091083
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/4b_inter.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/4b_inter.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/5a.c ..."
cat > "${DEST_DIR_ON_TARGET}/5a.c" <<'EOF_C_CONTENT_5ac_272261268'
#include <stdio.h>
#include <utime.h>
#include <sys/stat.h>
int main(int argc, char *argv[]) {
if (argc < 3) {
fprintf(stderr, "Usage: %s <source> <destination>\n", argv[0]);
return 1;
}
struct stat file_stat;
if (stat(argv[1], &file_stat) == -1) {
perror("stat");
return 1;
}
struct utimbuf new_times;
new_times.actime = file_stat.st_atime;
new_times.modtime = file_stat.st_mtime;
if (utime(argv[2], &new_times) == -1) {
perror("utime");
return 1;

}
return 0;
}
EOF_C_CONTENT_5ac_272261268
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/5a.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/5a.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/5b.c ..."
cat > "${DEST_DIR_ON_TARGET}/5b.c" <<'EOF_C_CONTENT_5bc_275445140'
#include<stdio.h>
#include<stdlib.h>
#include<signal.h>
#include<unistd.h>
void s_h(int sn){
printf("\ncaughtsigint %d\n",sn);
struct sigaction sa;
sa.sa_handler=SIG_DFL;
sa.sa_flags=0;

sigemptyset(&sa.sa_mask);
if(sigaction(SIGINT,&sa,NULL)==-1){
printf("error\n");
exit(EXIT_FAILURE);
}
}
int main(){
struct sigaction sa;
sa.sa_handler=s_h;
sa.sa_flags=0;
sigemptyset(&sa.sa_mask);
if(sigaction(SIGINT,&sa,NULL)==-1){
printf("error\n");
exit(EXIT_FAILURE);
}
while(1){
printf("press ctrl+c to trigger\n");
pause();
}
return 0;
}
EOF_C_CONTENT_5bc_275445140
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/5b.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/5b.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/6a.c ..."
cat > "${DEST_DIR_ON_TARGET}/6a.c" <<'EOF_C_CONTENT_6ac_278688674'
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
int main() {
int fd1, fd2;

char buf[50];
fd1 = open("example.txt", O_RDWR, 0);
fd2 = open("sample.txt", O_CREAT | O_RDWR, 0777);
// Duplicate fd1 to fd2 using dup2
fd2 = dup2(fd1, fd2);
if (fd2 < 0) {
printf("dup2 error\n");
close(fd1);
return 1;
}
printf("File descriptors: %d %d \n", fd1, fd2);
if (read(fd1, buf, 20) < 0) {
printf("read error\n");
close(fd1);
close(fd2);
return 1;
}
if (lseek(fd2, 0, SEEK_END) < 0) {
printf("lseek error\n");
close(fd1);
close(fd2);
return 1;
}
if (write(fd2, buf, 20) < 0) {
printf("write error\n");
close(fd1);
close(fd2);
return 1;
}
printf("%s\n", buf);
close(fd1);
close(fd2);
return 0;
}
EOF_C_CONTENT_6ac_278688674
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/6a.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/6a.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/6b.c ..."
cat > "${DEST_DIR_ON_TARGET}/6b.c" <<'EOF_C_CONTENT_6bc_281853332'
#include<stdio.h>
#include<stdlib.h>
#include<errno.h>
#include<fcntl.h>
#include<unistd.h>
int main(int argc,char *argv[]){
int fd; char buf[255]; struct flock fv;
if(argc<2){
printf("usage %s <filename>\n",argv[0]);
exit(0);
}
if((fd=open(argv[1],O_RDWR))==-1){
printf("error\n");
exit(1);
}
fv.l_type=F_WRLCK; fv.l_whence=SEEK_END;
fv.l_start=SEEK_END-100; fv.l_len=100;
printf("press enter to set lock\n");
getchar();
printf("trying to get lock\n");
if((fcntl(fd,F_SETLK,&fv))==-1){
fcntl(fd,F_GETLK,&fv);
printf("file is locked by process pid: %d \n",fv.l_pid);
return -1;
}
printf("locked\n");
if((lseek(fd,SEEK_END-50,SEEK_END))==-1){
printf("lseek\n");
exit(1);

}
if((read(fd,buf,100))==-1){
printf("read\n");
exit(1);
}
printf("data from file:\n");
puts(buf);
printf("press enter to unlock\n");
getchar();
fv.l_type=F_UNLCK; fv.l_whence=SEEK_SET;
fv.l_start=0; fv.l_len=0;
if((fcntl(fd,F_UNLCK,&fv))==-1){
printf("error\n");
exit(0);
}
printf("unlocked\n");
close(fd);
return 0;
}
EOF_C_CONTENT_6bc_281853332
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/6b.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/6b.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/7a.c ..."
cat > "${DEST_DIR_ON_TARGET}/7a.c" <<'EOF_C_CONTENT_7ac_285125639'
#include<setjmp.h>
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<fcntl.h>
static void f1(int,int,int,int);
static void f2(void);
static int gv;
static jmp_buf jb;
int main(void){
int av=2;register int rv=3; volatile int vv=4;static int sv=5;gv=1;
if(setjmp(jb)!=0){
printf("after longjmp\n");
printf("gv=%d,av=%d,rv=%d,vv=%d,sv=%d \n",gv,av,rv,vv,sv);
exit(0);
}
gv=95;av=96;rv=97;vv=98;sv=99;
f1(av,rv,vv,sv);
exit(0);
}
static void f1(int i,int j,int k,int l){
printf("in f1() \n");
printf("gv=%d,av=%d,rv=%d,vv=%d,sv=%d \n",gv,i,j,k,l);
f2();
}
static void f2(void){
longjmp(jb,1);
}
EOF_C_CONTENT_7ac_285125639
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/7a.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/7a.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/7b.c ..."
cat > "${DEST_DIR_ON_TARGET}/7b.c" <<'EOF_C_CONTENT_7bc_288411285'
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#define BUFFER_SIZE 1024
int main(int argc, char *argv[]) {
if (argc < 3) {
fprintf(stderr, "Usage: %s <source> <destination>\n", argv[0]);
return 1;
}
int src_fd = open(argv[1], O_RDONLY);
if (src_fd == -1) {
perror("open source");
return 1;
}
int dst_fd = open(argv[2], O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);
if (dst_fd == -1) {
perror("open destination");
return 1;
}
char buffer[BUFFER_SIZE];
ssize_t bytes_read;
while ((bytes_read = read(src_fd, buffer, BUFFER_SIZE)) > 0) {
if (write(dst_fd, buffer, bytes_read) != bytes_read) {
perror("write");
return 1;
}
}
if (bytes_read == -1) {
perror("read");
}
close(src_fd);
close(dst_fd);
return 0;
}
EOF_C_CONTENT_7bc_288411285
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/7b.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/7b.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/8a.c ..."
cat > "${DEST_DIR_ON_TARGET}/8a.c" <<'EOF_C_CONTENT_8ac_291653986'
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdlib.h>
void err_ret(const char *msg) {
perror(msg);
}
int main(int argc, char *argv[]) {
int i;
structstat buf;
char *ptr;
for (i = 1; i < argc; i++) {
printf("%s: ", argv[i]);
if (lstat(argv[i], &buf) < 0) {
err_ret("lstat error");
continue;
}
if (S_ISREG(buf.st_mode))
ptr = "regular";
else if (S_ISDIR(buf.st_mode))
ptr = "directory";
else if (S_ISCHR(buf.st_mode))
ptr = "character special";

else if (S_ISBLK(buf.st_mode))
ptr = "block special";
else if (S_ISFIFO(buf.st_mode))
ptr = "fifo";
else if (S_ISLNK(buf.st_mode))
ptr = "symbolic link";
else if (S_ISSOCK(buf.st_mode))
ptr = "socket";
else
ptr = "** unknown mode **";
printf("%s\n", ptr);
}
exit(0);
}
EOF_C_CONTENT_8ac_291653986
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/8a.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/8a.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/8b_main.c ..."
cat > "${DEST_DIR_ON_TARGET}/8b_main.c" <<'EOF_C_CONTENT_8b_mainc_294955298'
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>
int main() {
pid_t pid;
int status;
pid_t parent_pid = getpid();

pid = fork();
if (pid == -1) {
perror("fork");
exit(EXIT_FAILURE);
} else if (pid == 0) {
pid_t child_pid = getpid();
printf("Child process (PID: %d) executing...\n", child_pid);
execl("./p1", "p1", "example.txt", (char *)NULL);
perror("execl");
exit(EXIT_FAILURE);
} else {
printf("Parent process (PID: %d) executing...\n", parent_pid);
waitpid(pid, &status, 0);
printf("Parent process: Child process (PID: %d) has exited.\n", pid);
}
return 0;
}
EOF_C_CONTENT_8b_mainc_294955298
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/8b_main.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/8b_main.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/8b_p1.c ..."
cat > "${DEST_DIR_ON_TARGET}/8b_p1.c" <<'EOF_C_CONTENT_8b_p1c_298150691'
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
int main(int argc, char *argv[]) {
if (argc != 2) {
fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
exit(EXIT_FAILURE);
}
char *filename = argv[1];
if (access(filename, F_OK) == 0) {
printf("File '%s' exists and can be accessed.\n", filename);
} else {
printf("File '%s' does not exist or cannot be accessed.\n", filename);
}
return 0;
}
EOF_C_CONTENT_8b_p1c_298150691
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/8b_p1.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/8b_p1.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/9a.c ..."
cat > "${DEST_DIR_ON_TARGET}/9a.c" <<'EOF_C_CONTENT_9ac_301496989'
#include <stdio.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
int main() {
mode_t new_umask = 0022;
mode_t old_umask;
const char *file_path = "t1.txt";
mode_t new_mode = 0644;
old_umask = umask(new_umask);
printf("Old umask was: %03o, new umask is: %03o\n", old_umask, new_umask);
int fd = open(file_path, O_CREAT | O_WRONLY, 0777);
if (fd == -1) {
perror("open");
return 1;
}
close(fd);
if (chmod(file_path, new_mode) == -1) {
perror("chmod");
return 1;
}
printf("Changed permissions of %s to %03o\n", file_path, new_mode);
return 0;
}
EOF_C_CONTENT_9ac_301496989
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/9a.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/9a.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi

echo "Creating ${DEST_DIR_ON_TARGET}/9b.c ..."
cat > "${DEST_DIR_ON_TARGET}/9b.c" <<'EOF_C_CONTENT_9bc_304771467'
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
int main(int argc, char *argv[]) {
if (argc < 2) {
fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
return 1;
}
int fd = open(argv[1], O_RDONLY);
if (fd == -1) {
perror("open");
return 1;
}
char buffer[21];
if (read(fd, buffer, 20) != 20) {
perror("read");
close(fd);
return 1;
}
buffer[20] = '\0';
printf("First 20 characters: %s\n", buffer);
lseek(fd, 10, SEEK_SET);
if (read(fd, buffer, 20) != 20) {
perror("read");
close(fd);
return 1;
}
buffer[20] = '\0';
printf("20 characters from 10th byte: %s\n", buffer);
lseek(fd, 10, SEEK_CUR);
if (read(fd, buffer, 20) != 20) {
perror("read");
close(fd);
return 1;
}

buffer[20] = '\0';
printf("20 characters from current offset: %s\n", buffer);
off_t file_size = lseek(fd, 0, SEEK_END);
if (file_size == -1) {
perror("lseek");
close(fd);
return 1;
}
printf("File size: %lld bytes\n", (long long) file_size);
close(fd);
return 0;
}
EOF_C_CONTENT_9bc_304771467
if [ $? -eq 0 ]; then
    echo "  Successfully created ${DEST_DIR_ON_TARGET}/9b.c"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
else
    echo "  FAILED to create ${DEST_DIR_ON_TARGET}/9b.c"
    FAIL_COUNT=$((FAIL_COUNT + 1))
fi


echo ""
echo "----------------------------------------------------"
echo "File Creation Summary:"
echo "  Successfully created: ${SUCCESS_COUNT} files"
echo "  Failed to create:     ${FAIL_COUNT} files"
echo "----------------------------------------------------"
echo ""

if [ ${FAIL_COUNT} -gt 0 ]; then
    echo "Some files failed to be created. Please check the output above."
else
    echo "All specified .c files have been successfully created in ${DEST_DIR_ON_TARGET}"
fi

echo ""
echo "Contents of ${DEST_DIR_ON_TARGET} on target machine:"
ls -l "${DEST_DIR_ON_TARGET}"
echo ""
echo "Setup script finished."

exit 0
