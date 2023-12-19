; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

    include \masm32\include64\masm64rt.inc

    .code

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

cmd_tail proc

  ; ----------------------------------------------------------
  ; release the return value allocate memory with GlobalFree()
  ; ----------------------------------------------------------

    LOCAL pcmd  :QWORD
    LOCAL clen  :QWORD
    LOCAL pMem  :QWORD

    mov pcmd, function(GetCommandLine)
    mov clen, len(pcmd)
    mov pMem, alloc(clen)

    invoke mcopy,pcmd,pMem,clen

    mov r11, pcmd
    sub r11, 1

  lpst:
    add r11, 1
    cmp BYTE PTR [r11], 34              ; if lead character = "
    je stripquoted
    sub r11, 1

  notquoted:
    add r11, 1
    cmp BYTE PTR [r11], 0               ; exit on empty command tail
    je zeroexit
    cmp BYTE PTR [r11], 32              ; space
    jne notquoted
    jmp tailtrim

  stripquoted:
    add r11, 1
  @@:
    add r11, 1
    cmp BYTE PTR [r11], 0               ; exit on empty command tail
    je zeroexit
    cmp BYTE PTR [r11], 34
    jne @B
    add r11, 1

  tailtrim:
    add r11, 1
    cmp BYTE PTR [r11], 32              ; trim any spaces from front
    je tailtrim
    cmp BYTE PTR [r11], 9               ; trim any tabs from front
    je tailtrim

    mov r10, pMem                       ; load output buffer address
    xor rcx, rcx                        ; zero index
    sub rcx, 1
  copytail:
    add rcx, 1
    mov al, [r11+rcx]                   ; copy tail to output buffer
    mov [r10+rcx], al
    test al, al
    jnz copytail

    mov rax, pMem                       ; return output buffer in RAX
    ret

  zeroexit:
    mov rax, pMem
    mov BYTE PTR [rax], 0               ; zero 1st byte of pMem
    mov rax, pMem                       ; return zeroed buffer in RAX
    ret

cmd_tail endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

    end
