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

    call RunExe

    ret

Plugin_Interface endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

RunExe proc

    LOCAL pbuf  :QWORD
    LOCAL buff[260]:BYTE

    mov pbuf, ptr$(buff)
    invoke GetWindowText,hWnd,pbuf,256

    invoke szCmp,pbuf,"Untitled"
    test rax, rax
    jz @F

    invoke MessageBox,hWnd,"No File Loaded","Sorry ....",MB_OK
    ret

  @@:
    invoke szLower,pbuf
    invoke szRep,pbuf,pbuf,".asm",".exe"
    exec pbuf

    ret

RunExe endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    end

