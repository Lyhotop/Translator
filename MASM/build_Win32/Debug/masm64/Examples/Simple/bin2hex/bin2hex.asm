; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    include \masm64\include64\masm64rt.inc

    .code

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

entry_point proc

    LOCAL hMem  :QWORD
    LOCAL lMem  :QWORD
    LOCAL pMem  :QWORD
    LOCAL aLen  :QWORD
    LOCAL wLen  :QWORD

    mov hMem, rv(load_file,"bin2hex.asm")       ; load the file
    mov lMem, rcx                               ; get its length
    mov rax, lMem

    lea rax, [rax*4]                            ; mul length by 4
    mov aLen, rax

    mov pMem, alloc(aLen)                       ; allocate the output buffer
    mov wLen, rv(bin2hex,hMem,lMem,pMem)        ; convert the source to hex
    invoke save_file,"bin2hex.txt",pMem,wLen    ; write the file to disk

    mfree pMem                                  ; free the allocated memory
    mfree hMem                                  ; free the file memory

    invoke WinExec,"\masm64\qeditor.exe bin2hex.txt",1

    invoke ExitProcess,0

    ret

entry_point endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    end
