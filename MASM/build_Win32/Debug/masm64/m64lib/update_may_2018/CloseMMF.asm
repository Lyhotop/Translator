; ��������������������������������������������������������������������������������������������������

    include \masm32\include64\masm64rt.inc

    .code

; ��������������������������������������������������������������������������������������������������

CloseMMF proc lpMem:QWORD,hndl:QWORD

    invoke UnmapViewOfFile,lpMem
    invoke CloseHandle,hndl

    ret

CloseMMF endp

; ��������������������������������������������������������������������������������������������������

    end