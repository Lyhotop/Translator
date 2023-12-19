; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

;       This is a test of a technique to prototype API functions with argument count checking.

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    include \masm64\include64\masm64rt.inc

    cnterr MACRO mname,cnt,args:VARARG
      IF argcount(args) NE cnt
      echo ****************************************************
      echo mname Incorrect Argument Count, cnt Expected
      echo ****************************************************
      .err <mname Incorrect Argument Count, cnt Expected>
      ENDIF
    ENDM

    api MACRO args:VARARG
      args
      EXITM <rax>
    ENDM

    .MessageBox MACRO args:VARARG
      .ma cnterr .MessageBox,4,args # invoke __imp_MessageBoxA,args
    ENDM

    .SendMessage MACRO args:VARARG
      .ma cnterr .SendMessage,4,args # invoke __imp_SendMessageA,args
    ENDM

    .PostMessage MACRO args:VARARG
      .ma cnterr .PostMessage,4,args # invoke __imp_PostMessageA,args
    ENDM

    .CreateWindowEx MACRO args:VARARG
      .ma cnterr .CreateWindowEx,12,args # invoke __imp_CreateWindowExA,args
    ENDM

    .ExitProcess MACRO args:VARARG
      .ma cnterr .ExitProcess,1,args # invoke __imp_ExitProcess,args
    ENDM

    .code

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

entry_point proc

    LOCAL rval :QWORD

    .MessageBox 0,"Statement Version","Test 1",MB_OK

    mov rval, api(.MessageBox 0,"Function Version","Test 2",MB_OK)

    .ExitProcess 0

    ret

entry_point endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    end
