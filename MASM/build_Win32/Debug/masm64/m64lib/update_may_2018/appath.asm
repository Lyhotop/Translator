; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�

    include \masm32\include64\masm64rt.inc

    .code

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�

GetAppPath proc

  ; rcx = address path buffer

    LOCAL pBuf  :QWORD

    mov pBuf, rcx

    invoke GetModuleFileName,0,pBuf,256
    add rax, pBuf                   ; add buffer address for string end

  lpst:
    sub rax, 1
    cmp BYTE PTR [rax], "\"         ; scan backwards to find "\"
    jne lpst

    mov BYTE PTR [rax+1], 0         ; write zero terminator 1 byte past "\"
    mov rax, pBuf

    ret

GetAppPath endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�

    end
