; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    include \masm64\include64\masm64rt.inc

    include parts.inc
    includelib parts.lib

    .data?
      hInstance dq ?
      hWnd      dq ?
      hIcon     dq ?
      hEdit1    dq ?
      hEdit2    dq ?
      lpEdit2Proc dq ?

    .code

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

entry_point proc

    mov hInstance, rv(GetModuleHandle,0)
    mov hIcon,     rv(LoadImage,hInstance,10,IMAGE_ICON,48,48,LR_LOADTRANSPARENT)
    invoke DialogBoxParam,hInstance,100,0,ADDR main,hIcon
    invoke ExitProcess,0

    ret

entry_point endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

main proc hWin:QWORD,uMsg:QWORD,wParam:QWORD,lParam:QWORD

    LOCAL buffer[260]:BYTE
    LOCAL tpath :QWORD
    LOCAL ptxt  :QWORD
    LOCAL picon :QWORD

    .switch uMsg
      .case WM_INITDIALOG
        mov hEdit1, rv(GetDlgItem,hWin,106)
        mov hEdit2, rv(GetDlgItem,hWin,107)
        invoke SetWindowLongPtr,hEdit2,GWL_WNDPROC,ADDR Edit2Proc
        mov lpEdit2Proc, rax
        mov picon,  rv(GetDlgItem,hWin,110)
        invoke SetWindowText,hEdit2,"project"
        invoke SendMessage,hWin,WM_SETICON,1,lParam
        invoke SendMessage,picon,STM_SETIMAGE,IMAGE_ICON,lParam
        mov rax, TRUE
        ret

      .case WM_COMMAND
        .switch wParam
          .case 101
            invoke lBrowseForFolder,hWin,ADDR buffer, \
                   "Set Target Path For Project", \
                   "Create A New Directory If Necessary."
            mov tpath, ptr$(buffer)
            cmp BYTE PTR [rax], 0
            je @F
            invoke SetWindowText,hEdit1,tpath
            chdir tpath
            fn SetFocus,hEdit2
            fn SendMessage,hEdit2,WM_KEYDOWN,VK_END,0
          @@:

          .case 102
            fn GetWindowTextLength,hEdit1
            test rax, rax
            jne @F
            fn MsgboxI,hWin,"You must set the target directory first.","No Target",MB_OK,10
            .return 0
          @@:
            fn create_target,hWin

          .case 103
            fn exist,"makeit.bat"
            .if rax {} 0
              fn WinExec,"makeit.bat",1
            .else
              fn MsgboxI,hWin,"You must create the project first","No Project",MB_OK,10
            .endif

          .case 104
            mov ptxt, ptr$(buffer)
            fn GetWindowText,hEdit2,ptxt,260
            fn szCatStr,ptxt,".exe"
            fn exist,ptxt
            .if rax == 0
              fn MsgboxI,hWin,"The Project Must Be Built First","Project Not Built",MB_OK,10
            .else
              fn WinExec,ptxt,1
            .endif

          .case 105
            jmp exit_dialog

        .endsw

      .case WM_CLOSE
        exit_dialog:
        invoke EndDialog,hWin,0         ; exit from system menu
    .endsw

  .return 0

main endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

create_target proc hWin:QWORD

    LOCAL buffer[260]:BYTE
    LOCAL pbuf  :QWORD
    LOCAL fname[260]:BYTE
    LOCAL pfn   :QWORD
    LOCAL pfile :QWORD
    LOCAL plen  :QWORD
    LOCAL hFile :QWORD
    LOCAL bwrt  :QWORD

  ; ----------------------------
  ; write the three binary files
  ; ----------------------------
    mov pfile, ptr$(gradient_bmp)
    mrm plen,  gradient_len
    mov hFile, flcreate("gradient.bmp")
    mov bwrt, flwrite(hFile,pfile,plen)
    flclose hFile

    mov pfile, ptr$(icon_ico)
    mrm plen,  icon_len
    mov hFile, flcreate("icon.ico")
    mov bwrt, flwrite(hFile,pfile,plen)
    flclose hFile

    mov pfile, ptr$(toolbar_bmp)
    mrm plen,  toolbar_len
    mov hFile, flcreate("toolbar.bmp")
    mov bwrt, flwrite(hFile,pfile,plen)
    flclose hFile

  ; -------------------------------
  ; write the unmodified text files
  ; -------------------------------
    mov pfile, ptr$(dlgs_rc)
    mov plen, len(pfile)
    mov hFile, flcreate("dlgs.rc")
    mov bwrt, flwrite(hFile,pfile,plen)
    flclose hFile

  ; -------------------------
  ; get the project file name
  ; -------------------------
    mov pfn, ptr$(fname)
    fn GetWindowText,hEdit2,pfn,128

    mov pfile, ptr$(main_asm)
    invoke szRep,pfile,pfile,"xxxxxxxxxxxxxxxxxxxxxxxx",pfn     ; replace 24 * "x" with name
    mov plen, len(pfile)
    mov pbuf, ptr$(buffer)
    mov BYTE PTR [rax], 0
    invoke szCatStr,pbuf,pfn
    invoke szCatStr,pbuf,".asm"                                 ; append extension to file name
    mov hFile, flcreate(pbuf)
    mov bwrt, flwrite(hFile,pfile,plen)
    flclose hFile

    mov pfile, ptr$(main_inc)
    invoke szRep,pfile,pfile,"xxxxxxxxxxxxxxxxxxxxxxxx",pfn     ; replace 24 * "x" with name
    mov plen, len(pfile)
    mov pbuf, ptr$(buffer)
    mov BYTE PTR [rax], 0
    invoke szCatStr,pbuf,pfn
    invoke szCatStr,pbuf,".inc"                                 ; append extension to file name
    mov hFile, flcreate(pbuf)
    mov bwrt, flwrite(hFile,pfile,plen)
    flclose hFile

    mov pfile, ptr$(manifest_xml)
    invoke szRep,pfile,pfile,"xxxxxxxxxxxxxxxxxxxxxxxx",pfn     ; replace 24 * "x" with name
    mov plen, len(pfile)
    mov hFile, flcreate("manifest.xml")
    mov bwrt, flwrite(hFile,pfile,plen)
    flclose hFile

  ; -------------------------------------------------------------
    mov pfile, ptr$(rsrc_rc)
    invoke szRep,pfile,pfile,"xxxxxxxxxxxxxxxxxxxxxxxx",pfn     ; replace 24 * "x" with name
    mov plen, len(pfile)
    mov pbuf, ptr$(buffer)
    mov BYTE PTR [rax], 0
    mov hFile, flcreate("rsrc.rc")
    mov bwrt, flwrite(hFile,pfile,plen)
    flclose hFile
  ; -------------------------------------------------------------

    mov pfile, ptr$(makeit_bat)
    invoke szRep,pfile,pfile,"xxxxxxxxxxxxxxxxxxxxxxxx",pfn     ; replace 24 * "x" with name
    mov plen, len(pfile)
    mov hFile, flcreate("makeit.bat")
    mov bwrt, flwrite(hFile,pfile,plen)
    flclose hFile

    fn MsgboxI,hWin,"Project written to disk","Result",MB_OK,10

    ret

create_target endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

Edit2Proc proc hWin:QWORD,uMsg:QWORD,wParam:QWORD,lParam:QWORD

    .if uMsg == WM_CHAR
      .switch wParam
        .case "."
          fn MsgboxI,hWin, \
             "Extensions are not allowed or needed in this context"," Sorry ...",MB_OK,10
          .return 0
      .endsw
    .endif

    invoke CallWindowProc,lpEdit2Proc,hWin,uMsg,wParam,lParam

    ret

Edit2Proc endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    end

comment #





#
