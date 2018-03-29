#include <stdio.h>
#include <strings.h>

main(int argc, char** argv) {
    char s[1000];
    strcpy(s, argv[1]);
    puts(s);
}