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
    ;input start
    ; mov rax, 0
    ; mov rdi, 0
    ; mov rsi,num
    ; mov rdx, 3
    ; syscall
    ;input end
    mov rax, 0
    mov rdi, 0
    mov rsi,end
    mov rdx, 3
    syscall
    
    
    ; call str_to_int
    
    
    ; mov rax,[num1]
    ; sub rax, "0"
    ; mov [num1],ax

    ; mov rax,[num]
    ; sub rax, "0"
    ; mov [num],ax
    
    ; mov rax,[end]
    ; add ax, "0"
    ; mov [end],ax
    
        
loop:
    mov rax, 1
    mov rdi, 1
    mov rsi,itr
    mov rdx, 1
    syscall
    
    ; mov rbx,[num]
        
    cmp [end],byte "1";cmp rbx(num) with end
    
    jle exit ;jump if end is less/equal to "1"
    mov rbx,[end]
    sub rbx,'0' ;change to number
    dec rbx ;decrement rbx
    add rbx,'0' ; back to string
    mov [end],rbx ;move result back to [end] 
    ; mov [num],rbx
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
    