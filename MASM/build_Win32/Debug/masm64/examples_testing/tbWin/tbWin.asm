; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    include \masm64\include64\masm64rt.inc
    include include.inc

  ; -------------------------------------------------------------
  ; equates for controlling the toolbar button size and placement
  ; -------------------------------------------------------------
    rbht     equ <42>           ; rebar height in pixels
    tbbW     equ <32>           ; toolbar button width in pixels
    tbbH     equ <32>           ; toolbar button height in pixels
    vpad     equ <12>           ; vertical button padding in pixels
    hpad     equ  <8>           ; horizontal button padding in pixels
    lind     equ <10>           ; left side initial indent in pixels

    .data?
      hInstance dq ?
      hWnd      dq ?
      hIcon     dq ?
      hCursor   dq ?
      sWid      dq ?
      sHgt      dq ?
      hBitmap   dq ?
      tbTile    dq ?
      hRebar    dq ?
      hToolBar  dq ?
      hStatus   dq ?

    .data
      classname db "template_class",0
      caption db "Basic Toolbar Window",0

    .code

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

entry_point proc

    GdiPlusBegin                    ; initialise GDIPlus

    mov hInstance, rv(GetModuleHandle,0)
    mov hCursor,   rv(LoadCursor,0,IDC_ARROW)
    mov sWid,      rv(GetSystemMetrics,SM_CXSCREEN)
    mov sHgt,      rv(GetSystemMetrics,SM_CYSCREEN)
    mov hIcon,     rv(LoadImage,hInstance,10,IMAGE_ICON,48,48,LR_LOADTRANSPARENT)
    mov hBitmap,   rv(ResImageLoad,20)
    mov tbTile,    rv(LoadImage,hInstance,30,IMAGE_BITMAP,sWid,rbht,LR_DEFAULTCOLOR)

    call main

    GdiPlusEnd                      ; GdiPlus cleanup

    invoke ExitProcess,0

    ret

entry_point endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

main proc

    LOCAL wc      :WNDCLASSEX
    LOCAL lft     :QWORD
    LOCAL top     :QWORD
    LOCAL wid     :QWORD
    LOCAL hgt     :QWORD
    LOCAL pFile   :QWORD
    LOCAL buffer[128]:BYTE
    LOCAL pbuf    :QWORD
    LOCAL hBrush  :QWORD

    mov hBrush, rv(CreateSolidBrush,00D50000h)

    mov wc.cbSize,         SIZEOF WNDCLASSEX
    mov wc.style,          CS_BYTEALIGNCLIENT or CS_BYTEALIGNWINDOW
    mov wc.lpfnWndProc,    ptr$(WndProc)
    mov wc.cbClsExtra,     0
    mov wc.cbWndExtra,     0
    mrm wc.hInstance,      hInstance
    mrm wc.hIcon,          hIcon
    mrm wc.hCursor,        hCursor
    mrm wc.hbrBackground,  hBrush
    mov wc.lpszMenuName,   0
    mov wc.lpszClassName,  ptr$(classname)
    mrm wc.hIconSm,        hIcon

    invoke RegisterClassEx,ADDR wc

    mov wid, function(getpercent,sWid,65)   ; 65% screen width
    mov hgt, function(getpercent,sHgt,65)   ; 65% screen height

    invoke aspect_ratio,hgt,45              ; height + 45%
    cmp wid, rax                            ; if wid > rax
    jle @F
    mov wid, rax                            ; set wid to rax
  @@:
    mov rax, sWid                           ; calculate offset from left side
    sub rax, wid
    shr rax, 1
    mov lft, rax

    mov rax, sHgt                           ; calculate offset from top edge
    sub rax, hgt
    shr rax, 1
    mov top, rax

  ; ---------------------------------
  ; centre window at calculated sizes
  ; ---------------------------------
    invoke CreateWindowEx,WS_EX_LEFT or WS_EX_ACCEPTFILES, \
                          ADDR classname,ADDR caption, \
                          WS_OVERLAPPEDWINDOW or WS_VISIBLE,\
                          lft,top,wid,hgt,0,0,hInstance,0
    mov hWnd, rax

    mov hStatus, rv(StatusBar,hWnd)
    invoke SendMessage,hWnd,WM_SIZE,0,0
    invoke SendMessage,hStatus,SB_SETTEXT,0," Status bar message"

  ; --------------------------------------
  ; load file from command line if present
  ; --------------------------------------

    call cmd_tail                           ; get command tail
    mov pFile, rax                          ; store rax in variable
    cmp BYTE PTR [rax], 0                   ; test if its empty
    je rfout                                ; bypass loading file if empty

    invoke exist,pFile                      ; check if file exists
    test rax, rax
    jnz @F

    mov pbuf,ptr$(buffer)
    mcat pbuf,"Command line file '",pFile,"' cannot be found."
    invoke MsgboxI,hWnd,pbuf,"Whoops",MB_OK,10
    jmp rfout

  @@:
  ; ------------------------------------------------------
  ; perform file load action here with the address 'pFile'
  ; ------------------------------------------------------

  rfout:
    mfree pFile                             ; release the memory from cmd_tail

  ; --------------------------------------

    call msgloop

    ret

main endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

msgloop proc

    LOCAL msg    :MSG
    LOCAL pmsg   :QWORD

    mov pmsg, ptr$(msg)                     ; get the msg structure address
    jmp gmsg                                ; jump directly to GetMessage()

  mloop:
    .switch msg.message
      .case WM_KEYUP
        .switch msg.wParam
          .case VK_F1
            invoke SendMessage,hWnd,WM_COMMAND,300,0
        .endsw
    .endsw
    invoke TranslateMessage,pmsg
    invoke DispatchMessage,pmsg
  gmsg:
    test rax, rv(GetMessage,pmsg,0,0,0)     ; loop until GetMessage returns zero
    jnz mloop

    ret

msgloop endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

WndProc proc hWin:QWORD,uMsg:QWORD,wParam:QWORD,lParam:QWORD

    LOCAL dfbuff[260]:BYTE
    LOCAL sbh   :DWORD
    LOCAL rct   :RECT
    LOCAL pfn   :QWORD

    .switch uMsg
      .case WM_COMMAND
        .switch wParam
 ;           .case 50
 ;             ; unused
 ;           .case 51
 ;             ; unused
 ;           .case 52
 ;             ; unused
 ;           .case 53
 ;             ; unused
 ;           .case 54
 ;             ; unused
 ;           .case 55
 ;             ; unused
 ;           .case 56
 ;             ; unused
 ;           .case 57
 ;             ; unused
          .case 58
            jmp app_about
          .case 59
            jmp app_close

          .case 125
            app_close:
            invoke SendMessage,hWin,WM_SYSCOMMAND,SC_CLOSE,NULL

          .case 300
            app_about:
            invoke DialogBoxParam,hInstance,100,hWin,ADDR AboutDlg,0
        .endsw

      .case WM_SIZE
        invoke MoveWindow,hStatus,0,0,0,0,TRUE
        invoke GetClientRect,hStatus,ADDR rct           ; get the height of the status bar
        mrmd sbh, rct.bottom
        invoke GetClientRect,hWin,ADDR rct              ; get the client area size
        mov eax, rct.bottom
        sub eax, rbht                                   ; subtract the rebar height
        sub eax, sbh                                    ; subtract the status bar height
        mov rct.bottom, eax                             ; write it back to structure member

 ;       ; -------------------------------------------
 ;       ; size the client window into the client area
 ;       ; -------------------------------------------
 ;         invoke MoveWindow,hEdit,0,rbht,rct.right,rct.bottom,TRUE

      .case WM_CREATE
        mov hRebar,   rv(rebar,hInstance,hWin,rbht)     ; create the rebar control
        mov hToolBar, rv(addband,hInstance,hRebar)      ; add the toolbar band to it
        invoke LoadMenu,hInstance,100
        invoke SetMenu,hWin,rax
        .return 0

      .case WM_SETFOCUS
 ;         invoke SetFocus,hEdit

      .case WM_DROPFILES
        mov pfn, ptr$(dfbuff)
        invoke DragQueryFile,wParam,0,pfn,260
        invoke MessageBox,0,pfn,"WM_DROPFILES",MB_OK


      .case WM_CLOSE
        invoke SendMessage,hWin,WM_DESTROY,0,0

      .case WM_DESTROY
        invoke PostQuitMessage,NULL

    .endsw

    invoke DefWindowProc,hWin,uMsg,wParam,lParam

    ret

WndProc endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

TBcreate proc parent:DWORD

  ; -----------------------------
  ; run to toolbar creation macro
  ; -----------------------------
    ToolbarInit tbbW, tbbH, parent

  ; -----------------------------------
  ; Add toolbar buttons and spaces here
  ; arg1 bmpID (zero based)
  ; arg2 cmdID (1st is 50)
  ; -----------------------------------
    TBbutton  0,  50
    TBbutton  1,  51
    TBbutton  2,  52
    TBspace
    TBbutton  3,  53
    TBbutton  4,  54
    TBbutton  5,  55
    TBspace
    TBbutton  6,  56
    TBbutton  7,  57
    TBspace
    TBbutton  8,  58
    TBbutton  9,  59
  ; -----------------------------------

    mov rax, tbhandl

    ret

TBcreate endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

StatusBar proc hParent:QWORD

    LOCAL handl :QWORD
    LOCAL sbParts[4] :DWORD
    LOCAL r12reg :QWORD

    mov r12reg, r12

    mov handl, rv(CreateStatusWindow,WS_CHILD or WS_VISIBLE or SBS_SIZEGRIP,NULL,hParent,200)

  ; --------------------------------------------
  ; set the width of each part, -1 for last part
  ; --------------------------------------------

    lea r12, sbParts

    mov DWORD PTR [r12+0], 150
    mov DWORD PTR [r12+4], 300
    mov DWORD PTR [r12+8], 450
    mov DWORD PTR [r12+12],-1

    invoke SendMessage,handl,SB_SETPARTS,4,ADDR sbParts

    mov r12, r12reg
    mov rax, handl

    ret

StatusBar endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

AboutDlg proc hWin:QWORD,uMsg:QWORD,wParam:QWORD,lParam:QWORD

    LOCAL hStatic :QWORD
    LOCAL hButn   :QWORD
    LOCAL hText   :QWORD
    LOCAL rct     :RECT

    .switch uMsg
      .case WM_INITDIALOG
        mov hStatic, rv(GetDlgItem,hWin,101)
        mov hButn,   rv(GetDlgItem,hWin,102)
        mov hText,   rv(GetDlgItem,hWin,103)

      .data
        tmsg db 13,10,"Edit this dialog with Ketil Olsen's RESED.",13,10,13,10
             db "This dialog is in the file 'dlgs.rc'.",0
      .code

        invoke SetWindowText,hWin,"About Default Template"
        invoke SetWindowText,hText,ADDR tmsg

      ; -------------------------------------
      ; load the icon into the static control
      ; -------------------------------------
        invoke SendMessage,hStatic,STM_SETIMAGE,IMAGE_ICON,hIcon

      ; ---------------------------
      ; set the icon for the dialog
      ; ---------------------------
        invoke SendMessage,hWin,WM_SETICON,1,hIcon
        mov rax, TRUE
        ret

      .case WM_COMMAND
        .switch wParam
          .case 102                     ; the OK button
            jmp exit_dialog
        .endsw

      .case WM_CLOSE
        exit_dialog:
        invoke EndDialog,hWin,0         ; exit from system menu
    .endsw

    xor rax, rax
    ret

AboutDlg endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

rebar proc instance:QWORD,hParent:QWORD,htrebar:QWORD

    LOCAL hrbar :QWORD

    fn CreateWindowEx,WS_EX_LEFT,"ReBarWindow32",NULL, \
                      WS_VISIBLE or WS_CHILD or \
                      WS_CLIPCHILDREN or WS_CLIPSIBLINGS or \
                      RBS_VARHEIGHT or CCS_NOPARENTALIGN or CCS_NODIVIDER, \
                      -2,0,sWid,htrebar,hParent,NULL,instance,NULL
    mov hrbar, rax

    invoke ShowWindow,hrbar,SW_SHOW
    invoke UpdateWindow,hrbar

    mov rax, hrbar

    ret

rebar endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

addband proc instance:QWORD,hrbar:QWORD

    LOCAL tbhandl   :QWORD
    LOCAL rbbi      :REBARBANDINFO

    mov tbhandl, rv(TBcreate,hrbar)

    mov rbbi.cbSize,      sizeof REBARBANDINFO
    mov rbbi.fMask,       RBBIM_ID or RBBIM_STYLE or \
                          RBBIM_BACKGROUND or RBBIM_CHILDSIZE or RBBIM_CHILD
    mov rbbi.wID,         125
    mov rbbi.fStyle,      RBBS_FIXEDBMP
    mrm rbbi.hbmBack,     tbTile
    mov rbbi.cxMinChild,  0
    mrmd rbbi.cyMinChild, rbht
    mrm rbbi.hwndChild,   tbhandl

    invoke SendMessage,hrbar,RB_INSERTBAND,0,ADDR rbbi

    mov rax, tbhandl

    ret

addband endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

ResImageLoad proc ResID:QWORD

    LOCAL hRes  :QWORD
    LOCAL pRes  :QWORD
    LOCAL lRes  :QWORD
    LOCAL pbmp  :QWORD
    LOCAL hBmp  :QWORD
    LOCAL npng  :QWORD

    mov hRes, rv(FindResource,0,ResID,RT_RCDATA)        ; find the resource
    mov pRes, rv(LoadResource,0,hRes)                   ; load the resource
    mov lRes, rv(SizeofResource,0,hRes)                 ; get its size
    mrm npng, "@@@@.@@@"                                ; temp file name

    invoke save_file,npng,pRes,lRes                     ; create the temp file

    invoke GdipCreateBitmapFromFile,L(npng),ADDR pbmp   ; create a GDI+ bitmap
    invoke GdipCreateHBITMAPFromBitmap,pbmp,ADDR hBmp,0 ; create normal bitmap handle from it
    invoke GdipDisposeImage,pbmp                        ; remove the GDI+ bitmap

    invoke DeleteFile,npng                              ; delete the temp file

    mov rax, hBmp                                       ; return the bitmap handle in RAX

    ret

ResImageLoad endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    end

