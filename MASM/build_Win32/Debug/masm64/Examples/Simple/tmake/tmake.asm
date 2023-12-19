; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    include \masm64\include64\masm64rt.inc

    .data?
      hInstance dq ?
      hWnd      dq ?
      hIcon     dq ?
      hEdit1    dq ?
      hEdit2    dq ?

    .data
    ; ----------------------------------
    ; this file contains the DB format
    ; of the files to be written to disk
    ; ----------------------------------
      include datafile.asm

    .code

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

entry_point proc

    mov hInstance, rv(GetModuleHandle,0)
    mov hIcon,     rv(LoadIcon,hInstance,10)

    invoke DialogBoxParam,hInstance,100,0,ADDR DlgProc,hIcon

    invoke ExitProcess,0

    ret

entry_point endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

DlgProc proc hWin:QWORD,uMsg:QWORD,wParam:QWORD,lParam:QWORD

    LOCAL buffer[260]:BYTE
    LOCAL fbuffr[260]:BYTE
    LOCAL ptxt1 :QWORD
    LOCAL tpath :QWORD
    LOCAL ptrfn :QWORD

    .switch uMsg
      .case WM_INITDIALOG
        mrm hWnd, hWin                          ; set the global handle for the main dialog
        mov hEdit1, rv(GetDlgItem,hWin,102)     ; first edit control handle
        mov hEdit2, rv(GetDlgItem,hWin,105)     ; second edit control handle
        invoke SetWindowText,hEdit1,"project"   ; set a default project name
        invoke SendMessage,hWin, \
               WM_SETICON,1,lParam              ; set the icon for the dialog
        mov rax, TRUE
        ret
      .case WM_COMMAND
        .switch wParam

          .case 106
            invoke lBrowseForFolder,hWin,ADDR buffer, \
                   "Set Target Path For Project", \
                   "Create A New Directory If Necessary."
            mov tpath, ptr$(buffer)
            cmp BYTE PTR [rax], 0
            je @F
            invoke SetWindowText,hEdit2,tpath
            chdir tpath
          @@:

          .case 107
            call CreateProject
            
          .case 108
            mov ptxt1, ptr$(buffer)
            mov ptrfn, ptr$(fbuffr)
            invoke GetWindowText,hEdit1,ptrfn,260
            mcat ptxt1,ptrfn,".exe"

            invoke exist,ptxt1                  ; test if EXE file is built
            test rax, rax
            jz notbuilt

            invoke WinExec,ptxt1,SW_SHOW        ; run the file if it exists
            .return 0

          notbuilt:
            invoke MsgboxI,hWin,"The project must be built first","Problem",MB_OK,15
            .return 0

          .case 109
            invoke exist,"makeit.bat"
            test rax, rax
            jz nofile
            invoke WinExec,"makeit.bat",SW_SHOW
            .return 0
          nofile:
            invoke MsgboxI,hWin,"The project must be built first","Problem",MB_OK,15
            .return 0

          .case 110
            jmp exit_dialog
        .endsw

      .case WM_CLOSE
        exit_dialog:
        invoke EndDialog,hWin,0         ; exit from system menu
    .endsw

    xor rax, rax
    ret

DlgProc endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

CreateProject proc

    LOCAL buffer1[260]:BYTE
    LOCAL buffer2[260]:BYTE
    LOCAL nbuffer[128]:BYTE
    LOCAL ptxt1 :QWORD
    LOCAL ptxt2 :QWORD
    LOCAL pname :QWORD

    invoke GetWindowText,hEdit1,ADDR buffer1,260
    mov ptxt1, ptr$(buffer1)
    cmp BYTE PTR [rax], 0
    jne @F
    invoke MsgboxI,hWnd,"No Project Name Present","Missing Name",MB_OK,15
    ret
  @@:
    invoke GetWindowText,hEdit2,ADDR buffer2,260
    mov ptxt2, ptr$(buffer2)
    cmp BYTE PTR [rax], 0
    jne @F
    invoke MsgboxI,hWnd,"You must set a target path first","Missing Path",MB_OK,15
    ret
  @@:

    mov pname, ptr$(nbuffer)                                ; get pointer to buffer
    mov BYTE PTR [rax], 0                                   ; set buffer to zero length
    invoke szCatStr,pname,ptxt1                             ; append bare file name to zeroed buffer
    invoke szCatStr,pname,".asm"                            ; append the extension to the bare name
    invoke save_file,pname,pmain,lmain                      ; write main asm file
    invoke save_file,"icon.ico",picon,licon                 ; write the icon
    invoke save_file,"manifest.xml",pmanifest,lmanifest     ; write the manifest file
    invoke save_file,"rsrc.rc",prsrc,lrsrc                  ; write the RC script
  ; --------------------------------------------------
  ; replace dummy name with project name in batch file
  ; --------------------------------------------------
    invoke szRep,pbatfile,pbatfile,"xxxxxxxxxxxxxxxxxxxxxxxx",ptxt1
    invoke save_file,"makeit.bat",pbatfile,len(pbatfile)    ; write the MAKEIT.BAT file

    invoke MsgboxI,hWnd,"Project written to disk","CreateProject",MB_OK,10

    ret

CreateProject endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    end






















