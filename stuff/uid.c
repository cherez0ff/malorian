#define _POSIX_SOURCE
#include <sys/types.h>
#include <stdio.h>
#include <unistd.h>

main() {
  printf("before: ruid=%d, euid=%d\n", (int) getuid(), (int) geteuid());
  if (setuid(0) != 0) perror("setuid() error");
  if (setreuid(0) != 0) perror("setuid() error");
  else printf("after: ruid=%d, euid=%d\n",(int) getuid(), (int) geteuid());
}
// gcc -o uid -static uid.c
// https://www.ibm.com/docs/en/aix/7.2?topic=s-setuid-setruid-seteuid-setreuid-setuidx-subroutine
