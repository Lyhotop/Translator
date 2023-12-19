; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    include \masm32\include64\masm64rt.inc

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    ; -------------------------------------------
    ; Build this DLL with the provided MAKEIT.BAT
    ; -------------------------------------------

      .data?
        DLLinstance dq ?
        hInstance   dq ?
        hWnd        dq ?
        hMenu       dq ?
        hToolBar    dq ?
        hStatus     dq ?
        hEdit       dq ?
        hIcon       dq ?

      .code

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

LibMain proc instance:QWORD,reason:QWORD,unused:QWORD 

    .if reason == DLL_PROCESS_ATTACH
      mrm DLLinstance, instance             ; copy local to global
      mov rax, TRUE                         ; return TRUE so DLL will start

    .elseif reason == DLL_PROCESS_DETACH

    .elseif reason == DLL_THREAD_ATTACH

    .elseif reason == DLL_THREAD_DETACH

    .endif

    ret

LibMain endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

Plugin_Interface proc \
                 Instance :QWORD, \
                 Wnd      :QWORD, \
                 Menu     :QWORD, \
                 ToolBar  :QWORD, \
                 Status   :QWORD, \
                 Edit     :QWORD, \
                 Icon     :QWORD

  ; ---------------------------
  ; load arguments into globals
  ; ---------------------------
    mrm hInstance,  Instance
    mrm hWnd,       Wnd
    mrm hMenu,      Menu
    mrm hToolBar,   ToolBar
    mrm hStatus,    Status
    mrm hEdit,      Edit
    mrm hIcon,      Icon
  ; ---------------------------

    call RemoveTrailingSpaces

    ret

Plugin_Interface endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

RemoveTrailingSpaces proc

    LOCAL cr    :CHARRANGE
    LOCAL oMem  :QWORD
    LOCAL pMem  :QWORD
    LOCAL tlen  :QWORD
    LOCAL aPtr  :QWORD
    LOCAL lcnt  :QWORD
    LOCAL .r15  :QWORD
    LOCAL .r14  :QWORD
    LOCAL cloc  :QWORD
    LOCAL pbuf  :QWORD
    LOCAL buff[260]:BYTE

    mov .r15, r15
    mov .r14, r14

    invoke SendMessage,hEdit,EM_EXGETSEL,0,ADDR cr          ; get the current selection
    mov eax, cr.cpMax
    sub eax, cr.cpMin
    mov tlen, rax                                           ; get the selected text length

    .if tlen == 0                                           ; exit with error message if no selection
      .data
        message db "Use the left side selection bar to select the text",0
        pmsg dq message
      .code
      invoke MessageBox,hWnd,pmsg,"No Text Selected",MB_OK
      ret
    .endif

    mov pMem, alloc(tlen)                                   ; allocate memory for selected text
    invoke SendMessage,hEdit,EM_GETSELTEXT,0,pMem           ; load selected text into allocated memory

  ; ----------------------------------------------------

    mov rax, tlen
    mov oMem, alloc(rax)                                    ; allocate output memory

    mov lcnt, rv(richedtok,pMem,ADDR aPtr)                  ; tokenise source text

    mov r15, aPtr
    sub r15, 8
    mov r14, oMem
    mov cloc, 0

  @@:
    add r15, 8
  ; --------------------------------------------
    mov QWORD PTR [r15], rtrim$(QWORD PTR [r15])            ; action performed on each line
  ; --------------------------------------------
    mov cloc, rv(szappend,oMem,QWORD PTR [r15],cloc)        ; write line of text
    mov cloc, rv(szappend,oMem,chr$(13),cloc)               ; write ascii 13
    sub lcnt, 1
    jns @B

    mfree aPtr

  ; ----------------------------------------------------

    invoke SendMessage,hEdit,EM_REPLACESEL,TRUE,oMem        ; replace selection

    mov eax, cr.cpMin
    mov cr.cpMax, eax
    mov rdx, len(oMem)
    add cr.cpMax, edx

    invoke SendMessage,hEdit,EM_EXSETSEL,0,ADDR cr          ; set the current selection
    mfree pMem                                              ; release allocated memory
    mfree oMem                                              ; release allocated memory

    mov r15, .r15
    mov r14, .r14

    ret

RemoveTrailingSpaces endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

 richedtok proc psrc:QWORD,parr:QWORD
  ; -----------------------------------------------------------------
  ;
  ; |||||||||||||||||||||||||||||||||||||||||||||
  ;
  ; in place line tokeniser preserving formatting
  ;
  ; |||||||||||||||||||||||||||||||||||||||||||||
  ;
  ; psrc = address of multiline text to tokenise into lines
  ; parr = address of variable to receive the allocated array address
  ; lcnt = return value in rax
  ; allocated memory written to address "parr" should be released
  ; after use with the macro "mfree" or the API "GlobalFree()"
  ; -----------------------------------------------------------------
    LOCAL lcnt  :QWORD
    LOCAL asiz  :QWORD
    LOCAL pMem  :QWORD
    LOCAL aMem  :QWORD
    LOCAL .r15  :QWORD
    LOCAL .r14  :QWORD
    LOCAL cntr  :QWORD

    mov .r15, r15                                   ; preserve registers
    mov .r14, r14

    mov lcnt, rvcall(crcnt@@@,psrc)                 ; count ascii 13 to get line count
    lea rax, [rax*8]                                ; multiply by 8 to get array size
    mov asiz, rax

    mov aMem, alloc(asiz)                           ; allocate pointer array
    mov r14, aMem                                   ; load pointer address into r14
    mov r15, psrc                                   ; load source address into r15
    mov [r14], r15                                  ; load src address as 1st pointer
    sub lcnt, 1
    add r14, 8                                      ; set the next pointer location

    mov cntr, 0

  ; -------------------------------------------------

    sub r15, 1
  @@:
    add r15, 1
    cmp BYTE PTR [r15], 0                           ; exit loop on 0
    je @F
    cmp BYTE PTR [r15], 13                          ; test if ascii 13
    jne @B                                          ; loop back if not 0
    mov BYTE PTR [r15], 0                           ; terminate line with zero
    add cntr, 1
    add r15, 1                                      ; increment r15
    mov [r14], r15                                  ; write line offset to array member
    add r14, 8                                      ; set next array location
    jmp @B                                          ; jump back for next byte

  @@:

  ; -------------------------------------------------

    mov rax, parr                                   ; load pointer array address variable
    mov rcx, aMem                                   ; load pointer array into rcx
    mov [rax], rcx                                  ; write pointer array to "parr" address

    sub cntr, 1
    mov rax, cntr                                   ; return the line count

    mov r15, .r15                                   ; restore registers
    mov r14, .r14

    ret

 richedtok endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

 NOSTACKFRAME

 crcnt@@@ proc
  ; ---------
  ; rcx = src
  ; ---------
    xor rax, rax
    sub rcx, 1
  @@:
    add rcx, 1
    cmp BYTE PTR [rcx], 0
    je @F
    cmp BYTE PTR [rcx], 13
    jne @B
    add rax, 1
    jmp @B

  @@:
    ret

 crcnt@@@ endp

 STACKFRAME

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい


    end

