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