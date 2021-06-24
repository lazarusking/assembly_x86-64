# assembly_x86-64

### Reading list

Say hello to x86_64 Assembly (2014)
 - [Part 1](https://0xax.github.io/asm_1/)
 - [Part 2](https://0xax.github.io/asm_2/)
 - [Part 3](https://0xax.github.io/asm_3/)
 - [Part 4](https://0xax.github.io/asm_4/)
 - [Part 5](https://0xax.github.io/asm_5/)
 - [Part 6](https://0xax.github.io/asm_6/)
 - [Part 7](https://0xax.github.io/asm_7/)
 - [Part 8](https://0xax.github.io/asm_8/)

### Loop
``` asm
section .data
    itr db "*" 
    num1 dq "1"
    num2 equ 1
    lf db 0xA
    msg db "Enter number of stars:", 0xA
    len_msg db $-msg

section .bss
    ; num resq 1
    end resq 2
section .text
    global _start

_start:
    ;input prompt
    mov rax, 1
    mov rdi, 1
    mov rsi,msg
    mov rdx, len_msg
    syscall
    
    ;input end
    mov rax, 0
    mov rdi, 0
    mov rsi,end
    mov rdx, 3
    syscall    
        
loop:
    mov rax, 1
    mov rdi, 1
    mov rsi,itr
    mov rdx, 1
    syscall
            
    cmp [end],byte "1";cmp rbx(num) with end
    
    jle exit ;jump if end is less/equal to "1"
    mov rbx,[end]
    sub rbx,'0' ;change to number
    dec rbx ;decrement rbx
    add rbx,'0' ; back to string
    mov [end],rbx ;move result back to [end] 
    jmp loop
    
exit:
    ;new line
    mov rax, 1
    mov rdi, 1
    mov rsi,lf
    mov rdx, 1
    syscall
    ;exit
    mov rax, 60
    mov rdi, 0
    syscall
    
```
