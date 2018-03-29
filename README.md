# x86-64 Buffer Overflow
This is a buffer overflow for a x86-64 Mach-O binary with PIE, stack protection, stack NX and source fortification disabled.

It's mostly stable but the location of the array varies considerably depending on factors such as changing terminal emulators or the terminal prompt. It is advised to try to compile a version of target with printf or use lldb to find out the array address first, but it isn't purely random. Otherwise this would have been an exercise in futility.

Anyhow, it works quite nicely otherwise.

# License
The Unlicense. Check 'UNLICENSE'.

# References
[0] XNU Kernel Syscall Listing https://github.com/opensource-apple/xnu/blob/master/bsd/kern/syscalls.master
[1] UNIX System V Application Binary Interface AMD64 Architecture Processor Supplement https://www.uclibc.org/docs/psABI-x86_64.pdf