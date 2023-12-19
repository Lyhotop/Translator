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

    call BuildModule

    ret

Plugin_Interface endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

 BuildModule proc

    LOCAL flen  :QWORD
    LOCAL bwrt  :QWORD
    LOCAL pbuf  :QWORD
    LOCAL buff[260]:BYTE

    LOCAL tbuf  :QWORD
    LOCAL text[260]:BYTE

    mov pbuf, ptr$(buff)

    invoke GetWindowText,hWnd,pbuf,260                              ; get source name from titlebar

    invoke szCmp,pbuf,"Untitled"
    test rax, rax
    jz @F
    invoke MessageBox,hWnd,"No Saved File To Assemble","Whoops",MB_OK
    ret
  @@:

    mov tbuf, ptr$(text)
    mov pbuf, lcase$(pbuf)
    invoke szRight,pbuf,tbuf,4

    invoke szCmp,tbuf,".asm"                                        ; test extension for file type
    test rax, rax
    jnz @F
    invoke MessageBox,hWnd,"Not An ASM Source File","Wrong File Type",MB_OK
    ret
  @@:

    invoke NameFromPath,pbuf,pbuf                                   ; get the bare file name
    invoke szRemove,pbuf,pbuf,".asm"                                ; remove the extension

    .data
      batch \
      db "    @echo off",13,10
      db "    set module=[123456789012345678901234567890]",13,10
      db 13,10
      db "    \masm32\bin64\ml64.exe /c %module%.asm",13,10
      db 13,10
      db "    dir %module%.*",13,10
      db "    pause",13,10,0
      pbat dq batch
    .code

    invoke szRep,pbat,pbat,"[123456789012345678901234567890]",pbuf  ; replace dummy string with data
    mov flen, len(pbat)                                             ; get length to write
    mov bwrt, savefile("makemod.bat",pbat,flen)                     ; write file to disk
    shell "makemod.bat"                                             ; run it synchronously
    invoke DeleteFile,"makemod.bat"                                 ; delete after run

    ret

 BuildModule endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    end
