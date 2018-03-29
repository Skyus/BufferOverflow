#include <stdio.h>
#include <strings.h>

main(int argc, char** argv) {
    char s[1000];
    strcpy(s, argv[1]);
    puts(s);
    
    //printf("%p", &s);
    /*
    // DEEP MODE: For intense finding
    void* returnaddr; void* returnaddraddr;
    asm("mov 8(%%rbp),%0" : "=r"(returnaddr) : : );
    asm("mov %%rbp,%0" : "=r"(returnaddraddr) : : );
    returnaddraddr = (unsigned long long)returnaddraddr + 8;
    printf("%p, %p, %p, %p\n", returnaddr, returnaddraddr, s, (unsigned long long)returnaddraddr - (unsigned long long)s);
    */

}
/*
Helpful LLDB commands:

Breakpoint:
    breakpoint set -f target.c -l 14

Launch Process:
    process launch

Dump Registers:
    register read --all

List:
    x/i $pc --count 8 # Instructions
    x/x <address> --count n # eight byte array
    x/b <address> --count n # bytes
*/