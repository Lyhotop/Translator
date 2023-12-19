; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

    include \masm64\include64\masm64rt.inc
    include FullEdit.inc

  ; -------------------------------------------------------------
  ; equates for controlling the toolbar button size and placement
  ; -------------------------------------------------------------
    rbht     equ <42>           ; rebar height in pixels
    tbbW     equ <32>           ; toolbar button width in pixels
    tbbH     equ <32>           ; toolbar button height in pixels
    vpad     equ <10>           ; vertical button padding in pixels
    hpad     equ  <8>           ; horizontal button padding in pixels
    lind     equ <10>           ; left side initial indent in pixels

  ; --------------------------------------------------
  ; equates to control the text and background colours
  ; --------------------------------------------------
    txt_colour equ <00F0F0F0h>
    bak_colour equ <00303030h>

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
      hEdit     dq ?

    ; ---------------------
    ; search dialog handles
    ; ---------------------
      BtnUp     dq ?
      BtnDn     dq ?
      BtnQt     dq ?
      Chk1      dq ?
      Chk2      dq ?
      FndEd     dq ?
      RepEd     dq ?
      fImage    dq ?
      lpFndEdProc   dq ?        ; search dlg edit subclass
      lpFndEdProc1  dq ?        ; replace dlg 1st edit control subclass
      lpRepEdProc   dq ?        ; replace dlg 2nd edit control subclass

      RepBtn    dq ?            ; replace text dialog only

    .data
      classname db "masm_edit_64_class",0
      caption   db "Untitled",0

    ; -------------------
    ; search option flags
    ; -------------------
      wwflag    dq 0            ; whole word flag
      csflag    dq 1            ; case sensitive flag
      sdflag    dq 1            ; search direction flag
      ssrch     dq 0            ; flag for single dialog

    ; --------------------
    ; replace option flags
    ; --------------------
      wwRep     dq 0            ; whole word flag
      csRep     dq 1            ; case sensitive flag
      sdRep     dq 0            ; search direction flag

    .code

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

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

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

 main proc

    LOCAL wc      :WNDCLASSEX
    LOCAL lft     :QWORD
    LOCAL top     :QWORD
    LOCAL wid     :QWORD
    LOCAL hgt     :QWORD
    LOCAL pFile   :QWORD
    LOCAL buffer[128]:BYTE
    LOCAL pbuf    :QWORD

    mov wc.cbSize,         SIZEOF WNDCLASSEX
    mov wc.style,          CS_BYTEALIGNCLIENT or CS_BYTEALIGNWINDOW
    mov wc.lpfnWndProc,    ptr$(WndProc)
    mov wc.cbClsExtra,     0
    mov wc.cbWndExtra,     0
    mrm wc.hInstance,      hInstance
    mrm wc.hIcon,          hIcon
    mrm wc.hCursor,        hCursor
    mrm wc.hbrBackground,  0
    mov wc.lpszMenuName,   0
    mov wc.lpszClassName,  ptr$(classname)
    mrm wc.hIconSm,        hIcon

    invoke RegisterClassEx,ADDR wc

    mov wid, rvcall(getpercent,sWid,65)     ; 65% screen width
    mov hgt, rvcall(getpercent,sHgt,65)     ; 65% screen height

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

    invoke LoadLibrary,"riched20.dll"
    mov hEdit, rv(rich_edit,hWnd,hInstance)
    invoke SendMessage,hWnd,WM_SIZE,0,0
    invoke SetFocus,hEdit

    invoke set_edit_colours

    mov hStatus, rv(StatusBar,hWnd)
    invoke SendMessage,hWnd,WM_SIZE,0,0
    invoke SendMessage,hStatus,SB_SETTEXT,0," Status bar message"

  ; --------------------------------------
  ; load file from command line if present
  ; --------------------------------------

    call cmd_tail                   ; get command tail
    mov pFile, rax                  ; store rax in variable
    cmp BYTE PTR [rax], 0           ; test if its empty
    je rfout                        ; bypass loading file if empty

    invoke exist,pFile              ; check if file exists
    test rax, rax
    jnz @F

    mov pbuf,ptr$(buffer)
    mcat pbuf,"Command line file '",pFile,"' cannot be found."
    invoke MsgboxI,hWnd,pbuf,"Whoops",MB_OK,10
    jmp rfout

  @@:
    invoke file_read,hEdit,pFile

  rfout:
    mfree pFile                     ; release the memory from cmd_tail

  ; --------------------------------------

    call msgloop

    ret

 main endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

 msgloop proc

    LOCAL msg    :MSG
    LOCAL pmsg   :QWORD

    mov pmsg, ptr$(msg)                                 ; get the msg structure address
    jmp gmsg                                            ; jump directly to GetMessage()

  mloop:
    .switch msg.message
      .case WM_KEYUP
        ; -----------------
        ; single press keys
        ; -----------------
        .switch msg.wParam
          .case VK_F1
            invoke SendMessage,hWnd,WM_COMMAND,300,0    ; help / about menu
          .case VK_F2
            invoke SendMessage,hWnd,WM_COMMAND,250,0    ; search dialog
          .case VK_F3
            invoke SendMessage,hWnd,WM_COMMAND,260,0    ; replace dialog
        .endsw
        ; -----------------

          IfRepeatKey VK_SHIFT                          ; bypass if SHIFT key
          je nokey1
          IfRepeatKey VK_CONTROL                        ; allow CONTROL key
          jne nokey1
          IfRepeatKey VK_MENU                           ; bypass on ALT key
          je nokey1

        ; -----------------------------------
        ; CONTROL + virtual key for file menu
        ; -----------------------------------
        .switch msg.wParam
          .case VK_N
            invoke SendMessage,hWnd,WM_COMMAND,101,0    ; new
          .case VK_O
            invoke SendMessage,hWnd,WM_COMMAND,102,0    ; open
          .case VK_S
            invoke SendMessage,hWnd,WM_COMMAND,103,0    ; save
          .case VK_A
            invoke SendMessage,hWnd,WM_COMMAND,104,0    ; save as
          .case VK_Q
            invoke SendMessage,hWnd,WM_COMMAND,125,0    ; close
        ; ---------------------
        .endsw
      nokey1:

    .endsw

    invoke TranslateMessage,pmsg
    invoke DispatchMessage,pmsg
  gmsg:
    test rax, rv(GetMessage,pmsg,0,0,0)                 ; loop until GetMessage returns zero
    jnz mloop

    ret

 msgloop endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

 WndProc proc hWin:QWORD,uMsg:QWORD,wParam:QWORD,lParam:QWORD

    LOCAL dfbuff[260]:BYTE
    LOCAL sbh   :DWORD
    LOCAL rct   :RECT
    LOCAL pfn   :QWORD
    LOCAL sbuff[260]:BYTE
    LOCAL pbuff :QWORD

    .switch uMsg
      .case WM_COMMAND
        .switch wParam
          .case 50
            jmp new_file
          .case 51
            jmp open_dlg
          .case 52
            jmp save_dlg
          .case 53
            jmp edit_cut
          .case 54
            jmp edit_copy
          .case 55
            jmp edit_paste
          .case 56
            jmp edit_undo
          .case 57
            jmp edit_redo
          .case 58
            jmp search_find
          .case 59
            jmp text_replace
          .case 60
            jmp app_about
          .case 61
            jmp app_close

          .case 101
            new_file:
            invoke confirmation,hWin,hEdit
            cmp rax, 1
            jz @F
            fn SetWindowText,hEdit,0
            invoke SetWindowText,hWin,"Untitled"
            @@:

          .case 102
            open_dlg:
            invoke confirmation,hWin,hEdit
            cmp rax, 1
            jz @F
            invoke open_file_dialog,hWin,hInstance,"Open File",chr$("*.*",0,0)
            mov pfn, rax
            cmp BYTE PTR [rax], 0
            je @F
            invoke file_read,hEdit,pfn
            invoke SetWindowText,hWin,pfn
          @@:

          .case 103
            save_dlg:
            mov pbuff, ptr$(sbuff)
            invoke GetWindowText,hWin,pbuff,260
            invoke szCmp,pbuff,"Untitled"
            test rax, rax
            jnz save_as
            invoke file_write,hEdit,pbuff
            invoke SetWindowText,hWin,pbuff
            invoke SendMessage,hEdit,EM_SETMODIFY,FALSE,0

          .case 104
            save_as:
            invoke save_file_dialog,hWin,hInstance,"Save File As ...",chr$("*.*",0,0)
            mov pfn, rax
            cmp BYTE PTR [rax], 0
            je @F
            invoke file_write,hEdit,pfn
            invoke SetWindowText,hWin,pfn
            invoke SendMessage,hEdit,EM_SETMODIFY,FALSE,0
          @@:

          .case 125
            app_close:
            invoke SendMessage,hWin,WM_SYSCOMMAND,SC_CLOSE,NULL

        ; ------------------
        ; edit menu commands
        ; ------------------
          .case 200
            edit_undo:
            invoke SendMessage,hEdit,WM_UNDO,0,0
          .case 201
            edit_redo:
            invoke SendMessage,hEdit,EM_REDO,0,0
          .case 202
            edit_cut:
            invoke SendMessage,hEdit,WM_CUT,0,0
          .case 203
            edit_copy:
            invoke SendMessage,hEdit,WM_COPY,0,0
          .case 204
            edit_paste:
            invoke SendMessage,hEdit,EM_PASTESPECIAL,CF_TEXT,NULL
          .case 205
            edit_clear:
            invoke SendMessage,hEdit,WM_CLEAR,0,0

        ; -----------
        ; search menu
        ; -----------
          .case 250
            search_find:
          ; --------------------------------------
          ; only allow 1 instance of search dialog
          ; --------------------------------------
            .if ssrch == 0
              mov ssrch, 1
              invoke CreateDialogParam,hInstance,1000,hWin,ADDR find_text,0
            .endif

          .case 260
            text_replace:
          ; ---------------------------------------
          ; only allow 1 instance of replace dialog
          ; ---------------------------------------
            .if ssrch == 0
              mov ssrch, 1
              invoke CreateDialogParam,hInstance,2000,hWin,ADDR replace_text,0
            .endif

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

      ; -------------------------------------------
      ; size the client window into the client area
      ; -------------------------------------------
        invoke MoveWindow,hEdit,0,rbht,rct.right,rct.bottom,TRUE

      .case WM_CREATE
        mov hRebar,   rv(rebar,hInstance,hWin,rbht)     ; create the rebar control
        mov hToolBar, rv(addband,hInstance,hRebar)      ; add the toolbar band to it
        invoke LoadMenu,hInstance,100
        invoke SetMenu,hWin,rax
        .return 0

      .case WM_SETFOCUS
        invoke SetFocus,hEdit

      .case WM_DROPFILES
        mov pfn, ptr$(dfbuff)
        invoke DragQueryFile,wParam,0,pfn,260
        invoke file_read,hEdit,pfn
        invoke SetWindowText,hWin,pfn

      .case WM_CLOSE
        invoke confirmation,hWin,hEdit
        invoke SendMessage,hWin,WM_DESTROY,0,0

      .case WM_DESTROY
        invoke PostQuitMessage,NULL

    .endsw

    invoke DefWindowProc,hWin,uMsg,wParam,lParam

    ret

 WndProc endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

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
    TBspace
    TBbutton 10,  60
    TBbutton 11,  61
  ; -----------------------------------

    mov rax, tbhandl

    ret

 TBcreate endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

 rich_edit proc hParent:QWORD,instance:QWORD

    LOCAL pEdit  :QWORD
    LOCAL hFont  :QWORD
    LOCAL styl   :QWORD

  ; ---------------------------
  ; create the richedit control
  ; ---------------------------
    mov styl, WS_VISIBLE or WS_CHILDWINDOW or WS_CLIPSIBLINGS or \
              ES_MULTILINE or WS_VSCROLL or WS_HSCROLL or ES_AUTOHSCROLL or \
              ES_AUTOVSCROLL or ES_NOHIDESEL or ES_DISABLENOSCROLL

    invoke CreateWindowEx,WS_EX_LEFT,"RichEdit20a", \         ; WS_EX_STATICEDGE
             0,styl,0,0,200,100,hParent,111,instance,0

    mov pEdit, rax
  ; ---------------------------

    invoke SendMessage,pEdit,EM_EXLIMITTEXT,0,1000000000
    invoke SendMessage,pEdit,EM_SETOPTIONS,ECOOP_XOR,ECO_SELECTIONBAR

    mov hFont, rv(font_handle,"fixedsys",9,600)   ; library procedure
    invoke SendMessage,pEdit,WM_SETFONT,hFont,TRUE

    mov ecx, 10
    mov edx, 5
    mov ax, dx
    rol eax, 16
    mov ax, cx
    invoke SendMessage,pEdit,EM_SETMARGINS,EC_LEFTMARGIN or EC_RIGHTMARGIN,eax

    invoke SendMessage,pEdit,EM_SETTEXTMODE,TM_PLAINTEXT or \
                             TM_MULTILEVELUNDO or TM_MULTICODEPAGE, 0
    mov rax, pEdit

    ret

 rich_edit endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

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

    mov DWORD PTR [r12+0], 200
    mov DWORD PTR [r12+4], 400
    mov DWORD PTR [r12+8], 600
    mov DWORD PTR [r12+12],-1

    invoke SendMessage,handl,SB_SETPARTS,4,ADDR sbParts

    mov r12, r12reg
    mov rax, handl

    ret

 StatusBar endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

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

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

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

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

 set_text_colour proc Edit:DWORD,txtcolour:DWORD

    .data?
      align 16
      cfm2 CHARFORMAT2 <?>
    .code

    mov cfm2.cbSize,            SIZEOF CHARFORMAT2
    mov cfm2.dwMask,            CFM_COLOR
    mov cfm2.dwEffects,         0
    mov cfm2.yHeight,           0
    mov cfm2.yOffset,           0
    mrmd cfm2.crTextColor,      txtcolour
    mov cfm2.bCharSet,          0
    mov cfm2.bPitchAndFamily,   0
    mov cfm2.szFaceName,        0
    mov cfm2.wWeight,           0
    mov cfm2.sSpacing,          0
    mov cfm2.crBackColor,       0
    mov cfm2.lcid,              0
    mov cfm2.dwReserved,        0
    mov cfm2.sStyle,            0
    mov cfm2.wKerning,          0
    mov cfm2.bUnderlineType,    0
    mov cfm2.bAnimation,        0
    mov cfm2.bRevAuthor,        0

    invoke PostMessage,Edit,EM_SETCHARFORMAT,SCF_ALL,ADDR cfm2

    ret

 set_text_colour endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

 set_edit_colours proc

    invoke SendMessage,hEdit,EM_SETBKGNDCOLOR,0,bak_colour
    invoke set_text_colour,hEdit,txt_colour

    ret

 set_edit_colours endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

 confirmation proc parent:QWORD,edit:QWORD

  ; ------------------------------------------------------
  ; return values
  ; 0 = proceed with following operation, new or open file
  ; 1 = cancel following operation
  ; ------------------------------------------------------
    LOCAL nbuff[260]:BYTE
    LOCAL pbuff :QWORD

    invoke SendMessage,edit,EM_GETMODIFY,0,0
    test rax, rax       ; test if EM_GETMODIFY = 0
    jnz continue        ; jump forward if edit control modified
    ret                 ; if unmodified, exit with RAX = 0

  continue:
    invoke MsgboxI,parent,"File is not saved, save it now ?","Confirmation",MB_YESNOCANCEL,10

    .switch rax
      .case IDYES
        mov pbuff, ptr$(nbuff)
        invoke GetWindowText,parent,pbuff,260
        invoke szCmp,pbuff,"Untitled"
        test rax, rax
        jnz @F
        invoke file_write,edit,pbuff
        invoke SetWindowText,parent,pbuff
        invoke SendMessage,edit,EM_SETMODIFY,FALSE,0
        xor rax, rax
        ret
      @@:
        invoke save_file_dialog,parent,hInstance,"Save File As ...",chr$("*.*",0,0)
        mov pbuff, rax
        cmp BYTE PTR [rax], 0
        je @F
        invoke file_write,edit,pbuff
        invoke SetWindowText,parent,pbuff
        invoke SendMessage,edit,EM_SETMODIFY,FALSE,0
        xor rax, rax
        ret
      @@:
      .case IDNO
        xor rax, rax
        ret
      .case IDCANCEL
        mov rax, 1
        ret
    .endsw

    ret

 confirmation endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤


AboutDlg proc hWin:QWORD,uMsg:QWORD,wParam:QWORD,lParam:QWORD

    LOCAL hStatic :QWORD
    LOCAL hButn   :QWORD
    LOCAL hText   :QWORD
    LOCAL osInf   :QWORD
    LOCAL wickd   :QWORD
    LOCAL rct     :RECT
    LOCAL buffer[1024]:BYTE
    LOCAL pbuff   :QWORD
    LOCAL vbuffr[64]:BYTE
    LOCAL vendor  :QWORD
    LOCAL cpubuf[128]:BYTE
    LOCAL cpustr  :QWORD
    LOCAL mstat   :QWORD
    LOCAL astat   :QWORD
    LOCAL mse     :MEMORYSTATUSEX
    LOCAL syi     :SYSTEM_INFOx
    LOCAL lpp     :QWORD

    .switch uMsg
      .case WM_INITDIALOG
        mov hStatic, rv(GetDlgItem,hWin,101)
        mov hButn,   rv(GetDlgItem,hWin,102)
        mov hText,   rv(GetDlgItem,hWin,103)
        mov osInf,   rv(GetDlgItem,hWin,104)
        mov wickd,   rv(GetDlgItem,hWin,105)

      .data
        tmsg db "Win 64 Text Editor (c) Copyright 1998 - 2016",13,10
             db "The MASM32 SDK All Rights Reserved.",13,10
             db "A small footprint pure ASCII code editor.",13,10,13,10
             db "The operating system reports...",0

        tail db "A 64 bit Portable Executable Application.",13,10
             db "Wickedly Crafted In Microsoft Assembler (ML64).",0
      .code

        invoke SetWindowText,hWin," About Text Editor"

        mov pbuff, ptr$(buffer)
        mcat pbuff,ADDR tmsg
        invoke SetWindowText,hText,pbuff

        mov vendor, ptr$(vbuffr)
        invoke Get_Vendor,vendor

        mov cpustr, ptr$(cpubuf)
        invoke get_cpu_id_string,cpustr

        mov mse.dwLength, SIZEOF MEMORYSTATUSEX                 ; initialise length
        invoke GlobalMemoryStatusEx,ADDR mse                    ; call API

        mov mstat, rv(intdiv,mse.ullTotalPhys,1024*1024)
        mov astat, rv(intdiv,mse.ullAvailPhys,1024*1024)

        mov pbuff, ptr$(buffer)

        invoke GetSystemInfo,ADDR syi

        xor rax, rax
        mov eax, syi.dwNumberOfProcessors
        mov lpp, rax

        mcat pbuff,"Your processor is ",vendor,lf, \
             cpustr,lf, \
             str$(lpp)," logical processors present.",lf, \
             "Physical memory    ",str$(mstat)," megabytes.",lf, \
             "Available memory   ",str$(astat)," megabytes.",lf,lf

        invoke SetWindowText,osInf,pbuff
        invoke SetWindowText,wickd,ADDR tail

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

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

 replace_text proc hWin:QWORD,uMsg:QWORD,wParam:QWORD,lParam:QWORD

    LOCAL nbuff[260]:BYTE
    LOCAL pbuff :QWORD
    LOCAL tln   :QWORD
    LOCAL cr    :CHARRANGE

    .switch uMsg
      .case WM_INITDIALOG
        mov FndEd,  rv(GetDlgItem,hWin,1001)
        invoke SetWindowLongPtr,FndEd,GWL_WNDPROC,ADDR FndEdProc1
        mov lpFndEdProc1, rax

        mov BtnUp,  rv(GetDlgItem,hWin,1002)
        mov BtnDn,  rv(GetDlgItem,hWin,1003)
        mov BtnQt,  rv(GetDlgItem,hWin,1005)
        mov Chk1,   rv(GetDlgItem,hWin,1006)
        mov Chk2,   rv(GetDlgItem,hWin,1007)
        mov fImage, rv(GetDlgItem,hWin,1008)

        mov RepEd,  rv(GetDlgItem,hWin,1009)
        invoke SetWindowLongPtr,RepEd,GWL_WNDPROC,ADDR RepEdProc
        mov lpRepEdProc, rax

        mov RepBtn, rv(GetDlgItem,hWin,1010)

      ; ---------------
      ; whole word flag
      ; ---------------
        .if wwRep == 1
          invoke SendMessage,Chk1,BM_SETCHECK,BST_CHECKED,0
        .endif

      ; -------------------
      ; case sensitive flag
      ; -------------------
        .if csRep == 1
          invoke SendMessage,Chk2,BM_SETCHECK,BST_CHECKED,0
        .endif


        invoke SendMessage,fImage,STM_SETIMAGE,IMAGE_ICON,hIcon     ; large icon
        invoke SendMessage,hWin,WM_SETICON,1,hIcon                  ; title bar icon
        mov rax, TRUE
        ret


      .case WM_COMMAND
        .switch wParam
          .case 1002
          search_up:
            mov pbuff, ptr$(nbuff)
            invoke GetWindowText,FndEd,pbuff,260
            mov rax, pbuff
            cmp BYTE PTR [rax], 0
            je @F
          ; ---------------------
          ; call search from here
          ; ---------------------
            mov sdflag, 0
            mov tln, rv(GetWindowTextLength,FndEd)
            add tln, 1
            invoke TextFind,pbuff,tln,hWin
            cmp rax, -1
            jne @F
            fn MessageBox,hWin,"No Further Matches","Search",MB_OK
          ; ---------------------
          @@:
            invoke SetFocus,FndEd

          .case 1003
          search_down:
            mov pbuff, ptr$(nbuff)
            invoke GetWindowText,FndEd,pbuff,260
            mov rax, pbuff
            cmp BYTE PTR [rax], 0
            je @F
          ; ---------------------
          ; call search from here
          ; ---------------------
            mov sdflag, 1
            mov tln, rv(GetWindowTextLength,FndEd)
            add tln, 1
            invoke TextFind,pbuff,tln,hWin
            cmp rax, -1
            jne @F
            fn MessageBox,hWin,"No Further Matches","Search",MB_OK
          ; ---------------------
          @@:
            invoke SetFocus,FndEd

          .case 1005
            jmp exit_dialog

          .case 1006
            .if rv(SendMessage,Chk1,BM_GETCHECK,0,0) == BST_CHECKED
              mov wwRep, 1
            .else
              mov wwRep, 0
            .endif
            invoke SetFocus,FndEd

          .case 1007
            .if rv(SendMessage,Chk2,BM_GETCHECK,0,0) == BST_CHECKED
              mov csRep, 1
            .else
              mov csRep, 0
            .endif
            invoke SetFocus,FndEd

          .case 1010                    ; replace text button
          ; -------------------------------------------
          ; test if both dlg edit controls have content
          ; -------------------------------------------
            .if rv(GetWindowTextLength,FndEd) == 0
              invoke SetFocus,FndEd
              xor rax, rax
              ret
            .endif
            .if rv(GetWindowTextLength,RepEd) == 0
              invoke SetFocus,RepEd
              xor rax, rax
              ret
            .endif

          ; --------------------------------------------------
          ; check if text is selected in the main edit control
          ; --------------------------------------------------
            invoke SendMessage,hEdit,EM_EXGETSEL,0,ADDR cr
            mov eax, cr.cpMin
            cmp eax, cr.cpMax
            jne @F
            fn MessageBox,hWin,"There is no text selected to replace.","Find the text first",MB_OK
            ret
          @@:
          ; ----------------
          ; replace the text
          ; ----------------
            mov pbuff, ptr$(nbuff)
            invoke GetWindowText,RepEd,pbuff,260
            invoke SendMessage,hEdit,EM_REPLACESEL,TRUE,pbuff
            invoke SetFocus,FndEd
        .endsw

      .case WM_CLOSE
        exit_dialog:
        mov ssrch, 0                    ; clear the single instance flag
        invoke EndDialog,hWin,0         ; exit from system menu

    .endsw

    xor rax, rax
    ret

 replace_text endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

FndEdProc1 proc hWin:QWORD,uMsg:QWORD,wParam:QWORD,lParam:QWORD

  ; -------------------------------------------
  ; First edit control subclass for replace dlg
  ; -------------------------------------------

    .if uMsg == WM_CHAR
      .switch wParam
        .case 9
          invoke SetFocus, RepEd
          xor rax, rax
          ret
        .case 13
          invoke SetFocus, RepEd
          xor rax, rax
          ret
        .case 27
          invoke SendMessage,rv(GetParent,hWin),WM_CLOSE,0,0        ; close parent
          xor rax, rax
          ret
      .endsw

    .elseif uMsg == WM_KEYDOWN
      .switch wParam
        .case VK_UP
          invoke SendMessage,rv(GetParent,hWin),WM_COMMAND,1002,0   ; up button
          xor rax, rax
          ret
        .case VK_DOWN
          invoke SendMessage,rv(GetParent,hWin),WM_COMMAND,1003,0   ; down button
          xor rax, rax
          ret
      .endsw

    .endif

    invoke CallWindowProc,lpFndEdProc1,hWin,uMsg,wParam,lParam

    ret

FndEdProc1 endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

RepEdProc proc hWin:QWORD,uMsg:QWORD,wParam:QWORD,lParam:QWORD

  ; -----------------------------
  ; Process control messages here
  ; -----------------------------

    .if uMsg == WM_CHAR
      .switch wParam
        .case 9
          invoke SetFocus, RepEd
          xor rax, rax
          ret
        .case 13

        .case 27
          invoke SendMessage,rv(GetParent,hWin),WM_CLOSE,0,0        ; close parent
          xor rax, rax
          ret
      .endsw

    .elseif uMsg == WM_KEYDOWN
      .switch wParam
        .case VK_UP
          invoke SendMessage,rv(GetParent,hWin),WM_COMMAND,1002,0   ; up button
          xor rax, rax
          ret
        .case VK_DOWN
          invoke SendMessage,rv(GetParent,hWin),WM_COMMAND,1003,0   ; down button
          xor rax, rax
          ret
      .endsw

    .endif

    invoke CallWindowProc,lpRepEdProc,hWin,uMsg,wParam,lParam

    ret

RepEdProc endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

 find_text proc hWin:QWORD,uMsg:QWORD,wParam:QWORD,lParam:QWORD

    LOCAL nbuff[260]:BYTE
    LOCAL pbuff :QWORD
    LOCAL tln   :QWORD

    .switch uMsg
      .case WM_INITDIALOG
        mov FndEd,  rv(GetDlgItem,hWin,1001)

       ; ------------------------------------------------
       ; subclass the edit control to process key strokes
       ; ------------------------------------------------
        invoke SetWindowLongPtr,FndEd,GWL_WNDPROC,ADDR FndEdProc
        mov lpFndEdProc, rax

        mov BtnUp,  rv(GetDlgItem,hWin,1002)
        mov BtnDn,  rv(GetDlgItem,hWin,1003)
        mov BtnQt,  rv(GetDlgItem,hWin,1005)
        mov Chk1,   rv(GetDlgItem,hWin,1006)
        mov Chk2,   rv(GetDlgItem,hWin,1007)
        mov fImage, rv(GetDlgItem,hWin,1008)

      ; ---------------
      ; whole word flag
      ; ---------------
        .if wwflag == 1
          invoke SendMessage,Chk1,BM_SETCHECK,BST_CHECKED,0
        .endif

      ; -------------------
      ; case sensitive flag
      ; -------------------
        .if csflag == 1
          invoke SendMessage,Chk2,BM_SETCHECK,BST_CHECKED,0
        .endif

        invoke SendMessage,fImage,STM_SETIMAGE,IMAGE_ICON,hIcon     ; large icon
        invoke SendMessage,hWin,WM_SETICON,1,hIcon                  ; title bar icon
        mov rax, TRUE
        ret

      .case WM_COMMAND
        .switch wParam
          .case 1002
          search_up:
            mov pbuff, ptr$(nbuff)
            invoke GetWindowText,FndEd,pbuff,260
            mov rax, pbuff
            cmp BYTE PTR [rax], 0
            je @F
          ; ---------------------
          ; call search from here
          ; ---------------------
            mov sdflag, 0
            mov tln, rv(GetWindowTextLength,FndEd)
            add tln, 1
            invoke TextFind,pbuff,tln,hWin
            cmp rax, -1
            jne @F
            fn MessageBox,hWin,"No Further Matches","Search",MB_OK
          ; ---------------------
          @@:
            invoke SetFocus,FndEd

          .case 1003
          search_down:
            mov pbuff, ptr$(nbuff)
            invoke GetWindowText,FndEd,pbuff,260
            mov rax, pbuff
            cmp BYTE PTR [rax], 0
            je @F
          ; ---------------------
          ; call search from here
          ; ---------------------
            mov sdflag, 1
            mov tln, rv(GetWindowTextLength,FndEd)
            add tln, 1
            invoke TextFind,pbuff,tln,hWin
            cmp rax, -1
            jne @F
            fn MessageBox,hWin,"No Further Matches","Search",MB_OK
          ; ---------------------
          @@:
            invoke SetFocus,FndEd

          .case 1005
            jmp exit_dialog

          .case 1006
            .if rv(SendMessage,Chk1,BM_GETCHECK,0,0) == BST_CHECKED
              mov wwflag, 1
            .else
              mov wwflag, 0
            .endif
            invoke SetFocus,FndEd

          .case 1007
            .if rv(SendMessage,Chk2,BM_GETCHECK,0,0) == BST_CHECKED
              mov csflag, 1
            .else
              mov csflag, 0
            .endif
            invoke SetFocus,FndEd

        .endsw

      .case WM_CLOSE
        exit_dialog:
        mov ssrch, 0                    ; clear the single instance flag
        invoke EndDialog,hWin,0         ; exit from system menu

    .endsw

    xor rax, rax
    ret

 find_text endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

FndEdProc proc hWin:QWORD,uMsg:QWORD,wParam:QWORD,lParam:QWORD

  ; -----------------------------
  ; Process control messages here
  ; -----------------------------

    .if uMsg == WM_CHAR
      .switch wParam
        .case 13
          invoke SendMessage,rv(GetParent,hWin),WM_COMMAND,1003,0   ; down button
          xor rax, rax
          ret
        .case 27
          invoke SendMessage,rv(GetParent,hWin),WM_CLOSE,0,0        ; close parent
          xor rax, rax
          ret
      .endsw

    .elseif uMsg == WM_KEYDOWN
      .switch wParam
        .case VK_UP
          invoke SendMessage,rv(GetParent,hWin),WM_COMMAND,1002,0   ; up button
          xor rax, rax
          ret
        .case VK_DOWN
          invoke SendMessage,rv(GetParent,hWin),WM_COMMAND,1003,0   ; down button
          xor rax, rax
          ret
      .endsw

    .endif

    invoke CallWindowProc,lpFndEdProc,hWin,uMsg,wParam,lParam

    ret

FndEdProc endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

TextFind proc lpBuffer:QWORD, tlen:QWORD, hDlg:QWORD

    LOCAL tp :DWORD
    LOCAL tl :DWORD
    LOCAL sch:QWORD
    LOCAL ft :FINDTEXTEX
    LOCAL Cr :CHARRANGE

    invoke SendMessage,hEdit,WM_GETTEXTLENGTH,0,0
    mov tl, eax

    invoke SendMessage,hEdit,EM_EXGETSEL,0,ADDR Cr

    inc Cr.cpMin                    ; inc starting pos by 1 so not searching same position repeatedly

    mrmd ft.chrg.cpMin, Cr.cpMin    ; start pos
    mrmd ft.chrg.cpMax, tl          ; end of text
    mrm ft.lpstrText, lpBuffer      ; string to search for
    mrmd ft.chrgText.cpMin, Cr.cpMax
    mrmd ft.chrgText.cpMax, tl

    ; 0 = case insensitive
    ; 1 = FR_DOWN                   ; search backwards
    ; 2 = FT_WHOLEWORD
    ; 4 = FT_MATCHCASE
    ; 6 = FT_WHOLEWORD or FT_MATCHCASE

    mov sch, FR_DOWN

    .if sdflag == 1
      mov sch, FR_DOWN              ; search backwards
    .else
      mov sch, 0                    ; search forward
    .endif

    .if csflag == 1
      or sch, 4
    .endif
    .if wwflag == 1
      or sch, 2
    .endif

    invoke SendMessage,hEdit,EM_FINDTEXTEX,sch,ADDR ft
    mov tp, eax

    invoke SetFocus,hDlg

    .if tp == -1
      mov rax, -1
      ret
    .endif

    mrmd Cr.cpMin,tp                ; put start pos into structure
    dec tlen                        ; dec length for zero terminator
    mov rax, tlen
    add tp,eax                      ; add length to character pos
    mrmd Cr.cpMax,tp                ; put end pos into structure

    ; ------------------------------------
    ; set the selection to the search word
    ; ------------------------------------
    invoke SendMessage,hEdit,EM_EXSETSEL,0,ADDR Cr

    xor rax, rax

    ret

TextFind endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

    end

