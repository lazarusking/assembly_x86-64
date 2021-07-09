section .data
		SYS_WRITE equ 1
		STD_IN    equ 1
		SYS_EXIT  equ 60
		EXIT_CODE equ 0
        num1 dq "743"
        num2 dd "257"
		NEW_LINE   db 0xa
    
section .bss
    ; num1 resb 40
    ; num2 resb 40
    large resb 2
    sum resb 40 ; 40 Bytes for an ASCII string
    sum_len resd 1
section .text
        global _start

_start:

    ; mov rax,0
    ; mov rdi,0
    ; mov rsi,num1
    ; mov rdx,5
    ; syscall
    ; mov rax,0
    ; mov rdi,0
    ; mov rsi,num2
    ; mov rdx,5
    ; syscall

    mov rsi,num1
    call str_to_int ;the result int is stored in rax
    ; add rax,48
    mov r10,rax

    mov rsi, num2
    call str_to_int ;int stored in rax
    mov r11,rax
    add r10,r11
    mov rax,r10
    xor r12,r12
    ; mov rdi,$-exit
    ; jmp int_to_str
    
    mov rdi, sum                ; Argument: Address of the target string

    call int2str
    sub rdi, sum                ; EDI (pointer to the terminating NULL) - pointer to sum = length of the string
    mov [sum_len], rdi

    ; mov [large],rdi
    mov rax, SYS_WRITE
    mov rdi, STD_IN
    mov rsi, sum
    mov rdx, sum_len
    syscall
    mov rax, SYS_WRITE
    mov rdi, STD_IN
    mov rsi, NEW_LINE
    mov rdx, 3
    syscall
    
    exit:
  	mov rax, SYS_EXIT
  ; 	exit code
  	mov rdi, EXIT_CODE
  	syscall
		

str_to_int:
            xor rax, rax ;set rax to zero
            mov rcx,  10 ;move 10 unto rcx
    next:
            cmp [rsi], byte 0x0
            je return_str ;exit loop if at null terminator of string
            mov bl, [rsi] ; move 1 char of rsi(the value) in 8bit bl
                sub bl, 48 ;change into number by sub 48 or "0"  (so "6" into 6)
            imul rcx ; store product of rax * rcx into rax
                    ; so 0*10=0                                                     | next 10*6=60                    
            add rax, rbx ; add rax+=rbx(which is the 64 bit register of bl), 0+6=6  | then 60+5=65   
            inc rsi ;inc rsi to next char in string (so first loop is 6 then 5)
            jmp next ; continues loop from next again till je equals 0

    return_str:
            ret
	    
;

int2str:    ; Converts an positive integer in EAX to a string pointed to by EDI
    xor rcx, rcx
    mov rbx, 10
    .LL1:                   ; First loop: Save the remainders
    xor rdx, rdx            ; Clear EDX for div
    div rbx                 ; EDX:EAX/EBX -> EAX Remainder EDX
    push dx                 ; Save remainder
    inc rcx                 ; Increment push counter
    test rax, rax           ; Anything left to divide?
    jnz .LL1                ; Yes: loop once more

    .LL2:                   ; Second loop: Retrieve the remainders
    pop dx                  ; In DL is the value
    or dl, '0'              ; To ASCII
    mov [rdi], dl           ; Save it to the string
    inc rdi                 ; Increment the pointer to the string
    loop .LL2               ; Loop ECX times

    mov byte [rdi], 0       ; Termination character
    ret 
