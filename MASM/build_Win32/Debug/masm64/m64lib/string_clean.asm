; ��������������������������������������������������������������������������������������������������

    include binpath.inc

    .code

; ��������������������������������������������������������������������������������������������������

 string_clean proc pst:QWORD,ptbl:QWORD

    rcall chfilter,pst,ptbl
    rcall block_monospace,pst

    ret

 string_clean endp

; ��������������������������������������������������������������������������������������������������

    end