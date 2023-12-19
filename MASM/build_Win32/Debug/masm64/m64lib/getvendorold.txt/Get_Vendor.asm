; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    include \masm32\include64\masm64rt.inc

    .code

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

 NOSTACKFRAME

 Get_Vendor proc

    USING rbx,r15
    SaveRegs

    mov r15, rcx                        ; store buffer address in r15
   
    xor rax, rax                        ; set ID string for Intel
    cpuid

    mov rax, r15                        ; load buffer address

    mov DWORD PTR [rax],    ebx         ; write results to buffer
    mov DWORD PTR [rax+4],  edx
    mov DWORD PTR [rax+8],  ecx
    mov BYTE  PTR [rax+12], 0           ; terminate result

    RestoreRegs
   
    ret

 Get_Vendor endp

 STACKFRAME

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    end
