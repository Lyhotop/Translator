; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    public main_asm

    .data

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

  main_asm \
    db "; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい",13,10
    db 13,10
    db "    include \masm32\include64\masm64rt.inc",13,10
    db "    include xxxxxxxxxxxxxxxxxxxxxxxx.inc",13,10
    db 13,10
    db "  ; -------------------------------------------------------------",13,10
    db "  ; equates for controlling the toolbar button size and placement",13,10
    db "  ; -------------------------------------------------------------",13,10
    db "    rbht     equ <42>           ; rebar height in pixels",13,10
    db "    tbbW     equ <32>           ; toolbar button width in pixels",13,10
    db "    tbbH     equ <32>           ; toolbar button height in pixels",13,10
    db "    vpad     equ <10>           ; vertical button padding in pixels",13,10
    db "    hpad     equ  <8>           ; horizontal button padding in pixels",13,10
    db "    lind     equ <10>           ; left side initial indent in pixels",13,10
    db 13,10
    db "  ; --------------------------------------------------",13,10
    db "  ; equates to control the text and background colours",13,10
    db "  ; --------------------------------------------------",13,10
    db "    txt_colour equ <00F0F0F0h>",13,10
    db "    bak_colour equ <00303030h>",13,10
    db 13,10
    db "    .data?",13,10
    db "      hInstance dq ?",13,10
    db "      hWnd      dq ?",13,10
    db "      hIcon     dq ?",13,10
    db "      hCursor   dq ?",13,10
    db "      sWid      dq ?",13,10
    db "      sHgt      dq ?",13,10
    db "      hBitmap   dq ?",13,10
    db "      tbTile    dq ?",13,10
    db "      hRebar    dq ?",13,10
    db "      hToolBar  dq ?",13,10
    db "      hStatus   dq ?",13,10
    db "      hEdit     dq ?",13,10
    db 13,10
    db "    .data",13,10
    db "      classname db ",34,"template_class",34,",0",13,10
    db "      caption db ",34,"Default Template",34,",0",13,10
    db 13,10
    db "    .code",13,10
    db 13,10
    db "; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい",13,10
    db 13,10
    db "entry_point proc",13,10
    db 13,10
    db "    mov hInstance, rv(GetModuleHandle,0)",13,10
    db "    mov hCursor,   rv(LoadCursor,0,IDC_ARROW)",13,10
    db "    mov sWid,      rv(GetSystemMetrics,SM_CXSCREEN)",13,10
    db "    mov sHgt,      rv(GetSystemMetrics,SM_CYSCREEN)",13,10
    db "    mov hIcon,     rv(LoadImage,hInstance,10,IMAGE_ICON,48,48,LR_LOADTRANSPARENT)",13,10
    db 13,10
    db "  ; -------------------------------------------------",13,10
    db "  ; load the toolbar button strip at its default size",13,10
    db "  ; -------------------------------------------------",13,10
    db "    invoke LoadImage,hInstance,20,IMAGE_BITMAP,0,0, \",13,10
    db "           LR_DEFAULTSIZE or LR_LOADTRANSPARENT or LR_LOADMAP3DCOLORS",13,10
    db "    mov hBitmap, rax",13,10
    db 13,10
    db "  ; ----------------------------------------------------------------",13,10
    db "  ; load the rebar background tile stretching it to the rebar height",13,10
    db "  ; ----------------------------------------------------------------",13,10
    db "    mov tbTile, rv(LoadImage,hInstance,30,IMAGE_BITMAP,sWid,rbht,LR_DEFAULTCOLOR)",13,10
    db 13,10
    db "    call main",13,10
    db 13,10
    db "    invoke ExitProcess,0",13,10
    db 13,10
    db "    ret",13,10
    db 13,10
    db "entry_point endp",13,10
    db 13,10
    db "; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい",13,10
    db 13,10
    db "main proc",13,10
    db 13,10
    db "    LOCAL wc      :WNDCLASSEX",13,10
    db "    LOCAL lft     :QWORD",13,10
    db "    LOCAL top     :QWORD",13,10
    db "    LOCAL wid     :QWORD",13,10
    db "    LOCAL hgt     :QWORD",13,10
    db "    LOCAL pFile   :QWORD",13,10
    db "    LOCAL buffer[128]:BYTE",13,10
    db "    LOCAL pbuf    :QWORD",13,10
    db 13,10
    db "    mov wc.cbSize,         SIZEOF WNDCLASSEX",13,10
    db "    mov wc.style,          CS_BYTEALIGNCLIENT or CS_BYTEALIGNWINDOW",13,10
    db "    mov wc.lpfnWndProc,    ptr$(WndProc)",13,10
    db "    mov wc.cbClsExtra,     0",13,10
    db "    mov wc.cbWndExtra,     0",13,10
    db "    mrm wc.hInstance,      hInstance",13,10
    db "    mrm wc.hIcon,          hIcon",13,10
    db "    mrm wc.hCursor,        hCursor",13,10
    db "    mrm wc.hbrBackground,  0",13,10
    db "    mov wc.lpszMenuName,   0",13,10
    db "    mov wc.lpszClassName,  ptr$(classname)",13,10
    db "    mrm wc.hIconSm,        hIcon",13,10
    db 13,10
    db "    invoke RegisterClassEx,ADDR wc",13,10
    db 13,10
    db "    mov wid, function(getpercent,sWid,65)   ; 65% screen width",13,10
    db "    mov hgt, function(getpercent,sHgt,65)   ; 65% screen height",13,10
    db 13,10
    db "    invoke aspect_ratio,hgt,45              ; height + 45%",13,10
    db "    cmp wid, rax                            ; if wid > rax",13,10
    db "    jle @F",13,10
    db "    mov wid, rax                            ; set wid to rax",13,10
    db "  @@:",13,10
    db "    mov rax, sWid                           ; calculate offset from left side",13,10
    db "    sub rax, wid",13,10
    db "    shr rax, 1",13,10
    db "    mov lft, rax",13,10
    db 13,10
    db "    mov rax, sHgt                           ; calculate offset from top edge",13,10
    db "    sub rax, hgt",13,10
    db "    shr rax, 1",13,10
    db "    mov top, rax",13,10
    db 13,10
    db "  ; ---------------------------------",13,10
    db "  ; centre window at calculated sizes",13,10
    db "  ; ---------------------------------",13,10
    db "    invoke CreateWindowEx,WS_EX_LEFT or WS_EX_ACCEPTFILES, \",13,10
    db "                          ADDR classname,ADDR caption, \",13,10
    db "                          WS_OVERLAPPEDWINDOW or WS_VISIBLE,\",13,10
    db "                          lft,top,wid,hgt,0,0,hInstance,0",13,10
    db "    mov hWnd, rax",13,10
    db 13,10
    db "    invoke LoadLibrary,",34,"riched20.dll",34,13,10
    db "    mov hEdit, rv(rich_edit,hWnd,hInstance)",13,10
    db "    invoke SendMessage,hWnd,WM_SIZE,0,0",13,10
    db "    invoke SetFocus,hEdit",13,10
    db 13,10
    db "    invoke set_edit_colours",13,10
    db 13,10
    db "    mov hStatus, rv(StatusBar,hWnd)",13,10
    db "    invoke SendMessage,hWnd,WM_SIZE,0,0",13,10
    db "    invoke SendMessage,hStatus,SB_SETTEXT,3,",34,"Status bar message",34,13,10
    db 13,10
    db "  ; --------------------------------------",13,10
    db "  ; load file from command line if present",13,10
    db "  ; --------------------------------------",13,10
    db 13,10
    db "    call cmd_tail                   ; get command tail",13,10
    db "    mov pFile, rax                  ; store rax in variable",13,10
    db "    cmp BYTE PTR [rax], 0           ; test if its empty",13,10
    db "    je rfout                        ; bypass loading file if empty",13,10
    db 13,10
    db "    invoke exist,pFile              ; check if file exists",13,10
    db "    test rax, rax",13,10
    db "    jnz @F",13,10
    db 13,10
    db "    mov pbuf,ptr$(buffer)",13,10
    db "    mcat pbuf,",34,"Command line file ",39,34,",pFile,",34,39," cannot be found.",34,13,10
    db "    invoke MsgboxI,hWnd,pbuf,",34,"Whoops",34,",MB_OK,10",13,10
    db "    jmp rfout",13,10
    db 13,10
    db "  @@:",13,10
    db "    invoke file_read,hEdit,pFile",13,10
    db 13,10
    db "  rfout:",13,10
    db "    mfree pFile                     ; release the memory from cmd_tail",13,10
    db 13,10
    db "  ; --------------------------------------",13,10
    db 13,10
    db "    call msgloop",13,10
    db 13,10
    db "    ret",13,10
    db 13,10
    db "main endp",13,10
    db 13,10
    db "; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい",13,10
    db 13,10
    db "msgloop proc",13,10
    db 13,10
    db "    LOCAL msg    :MSG",13,10
    db "    LOCAL pmsg   :QWORD",13,10
    db 13,10
    db "    mov pmsg, ptr$(msg)                     ; get the msg structure address",13,10
    db "    jmp gmsg                                ; jump directly to GetMessage()",13,10
    db 13,10
    db "  mloop:",13,10
    db "    .switch msg.message",13,10
    db "      .case WM_KEYUP",13,10
    db "        .switch msg.wParam",13,10
    db "          .case VK_F1",13,10
    db "            invoke SendMessage,hWnd,WM_COMMAND,300,0",13,10
    db "        .endsw",13,10
    db "    .endsw",13,10
    db "    invoke TranslateMessage,pmsg",13,10
    db "    invoke DispatchMessage,pmsg",13,10
    db "  gmsg:",13,10
    db "    test rax, rv(GetMessage,pmsg,0,0,0)     ; loop until GetMessage returns zero",13,10
    db "    jnz mloop",13,10
    db 13,10
    db "    ret",13,10
    db 13,10
    db "msgloop endp",13,10
    db 13,10
    db "; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい",13,10
    db 13,10
    db "WndProc proc hWin:QWORD,uMsg:QWORD,wParam:QWORD,lParam:QWORD",13,10
    db 13,10
    db "    LOCAL dfbuff[260]:BYTE",13,10
    db "    LOCAL sbh   :DWORD",13,10
    db "    LOCAL rct   :RECT",13,10
    db "    LOCAL pfn   :QWORD",13,10
    db 13,10
    db "    .switch uMsg",13,10
    db "      .case WM_COMMAND",13,10
    db "        .switch wParam",13,10
    db "          .case 50",13,10
    db "            jmp new_file",13,10
    db "          .case 51",13,10
    db "            jmp open_dlg",13,10
    db "          .case 52",13,10
    db "            jmp save_dlg",13,10
    db "          .case 53",13,10
    db "            jmp edit_cut",13,10
    db "          .case 54",13,10
    db "            jmp edit_copy",13,10
    db "          .case 55",13,10
    db "            jmp edit_paste",13,10
    db "          .case 56",13,10
    db "            jmp edit_undo",13,10
    db "          .case 57",13,10
    db "            jmp edit_redo",13,10
    db "          .case 58",13,10
    db "            jmp app_about",13,10
    db "          .case 59",13,10
    db "            jmp app_close",13,10
    db 13,10
    db "          .case 101",13,10
    db "            new_file:",13,10
    db "            fn SetWindowText,hEdit,0",13,10
    db 13,10
    db "          .case 102",13,10
    db "            open_dlg:",13,10
    db "            invoke open_file_dialog,hWin,hInstance,",34,"Open File",34,",chr$(",34,"*.*",34,",0,0)",13,10
    db "            mov pfn, rax",13,10
    db "            cmp BYTE PTR [rax], 0",13,10
    db "            je @F",13,10
    db "            invoke file_read,hEdit,pfn",13,10
    db "          @@:",13,10
    db 13,10
    db "          .case 103",13,10
    db "            save_dlg:",13,10
    db "            invoke save_file_dialog,hWin,hInstance,",34,"Save File As ...",34,",chr$(",34,"*.*",34,",0,0)",13,10
    db "            mov pfn, rax",13,10
    db "            cmp BYTE PTR [rax], 0",13,10
    db "            je @F",13,10
    db "            invoke file_write,hEdit,pfn",13,10
    db "          @@:",13,10
    db 13,10
    db "          .case 125",13,10
    db "            app_close:",13,10
    db "            invoke SendMessage,hWin,WM_SYSCOMMAND,SC_CLOSE,NULL",13,10
    db 13,10
    db "        ; ------------------",13,10
    db "        ; edit menu commands",13,10
    db "        ; ------------------",13,10
    db "          .case 200",13,10
    db "            edit_undo:",13,10
    db "            invoke SendMessage,hEdit,WM_UNDO,0,0",13,10
    db "          .case 201",13,10
    db "            edit_redo:",13,10
    db "            invoke SendMessage,hEdit,EM_REDO,0,0",13,10
    db "          .case 202",13,10
    db "            edit_cut:",13,10
    db "            invoke SendMessage,hEdit,WM_CUT,0,0",13,10
    db "          .case 203",13,10
    db "            edit_copy:",13,10
    db "            invoke SendMessage,hEdit,WM_COPY,0,0",13,10
    db "          .case 204",13,10
    db "            edit_paste:",13,10
    db "            invoke SendMessage,hEdit,EM_PASTESPECIAL,CF_TEXT,NULL",13,10
    db "          .case 205",13,10
    db "            edit_clear:",13,10
    db "            invoke SendMessage,hEdit,WM_CLEAR,0,0",13,10
    db 13,10
    db "          .case 300",13,10
    db "            app_about:",13,10
    db "            invoke DialogBoxParam,hInstance,100,hWin,ADDR AboutDlg,0",13,10
    db "        .endsw",13,10
    db "        .return 0",13,10
    db 13,10
    db "      .case WM_SIZE",13,10
    db "        invoke MoveWindow,hStatus,0,0,0,0,TRUE",13,10
    db "        invoke GetClientRect,hStatus,ADDR rct           ; get the height of the status bar",13,10
    db "        mrmd sbh, rct.bottom",13,10
    db "        invoke GetClientRect,hWin,ADDR rct              ; get the client area size",13,10
    db "        mov eax, rct.bottom",13,10
    db "        sub eax, rbht                                   ; subtract the rebar height",13,10
    db "        sub eax, sbh                                    ; subtract the status bar height",13,10
    db "        mov rct.bottom, eax                             ; write it back to structure member",13,10
    db "      ; -------------------------------------------",13,10
    db "      ; size the client window into the client area",13,10
    db "      ; -------------------------------------------",13,10
    db "        invoke MoveWindow,hEdit,0,rbht,rct.right,rct.bottom,TRUE",13,10
    db "        .return 0",13,10
    db 13,10
    db "      .case WM_CREATE",13,10
    db "        mov hRebar,   rv(rebar,hInstance,hWin,rbht)     ; create the rebar control",13,10
    db "        mov hToolBar, rv(addband,hInstance,hRebar)      ; add the toolbar band to it",13,10
    db "        invoke LoadMenu,hInstance,100",13,10
    db "        invoke SetMenu,hWin,rax",13,10
    db "        .return 0",13,10
    db 13,10
    db "      .case WM_SETFOCUS",13,10
    db "        invoke SetFocus,hEdit",13,10
    db "        .return 0",13,10
    db 13,10
    db "      .case WM_DROPFILES",13,10
    db "        mov pfn, ptr$(dfbuff)",13,10
    db "        invoke DragQueryFile,wParam,0,pfn,260",13,10
    db "        invoke file_read,hEdit,pfn",13,10
    db "        invoke SetWindowText,hWin,pfn",13,10
    db "        .return 0",13,10
    db 13,10
    db "      .case WM_CLOSE",13,10
    db "        invoke SendMessage,hWin,WM_DESTROY,0,0",13,10
    db "        .return 0",13,10
    db 13,10
    db "      .case WM_DESTROY",13,10
    db "        invoke PostQuitMessage,NULL",13,10
    db 13,10
    db "    .endsw",13,10
    db 13,10
    db "    invoke DefWindowProc,hWin,uMsg,wParam,lParam",13,10
    db 13,10
    db "    ret",13,10
    db 13,10
    db "WndProc endp",13,10
    db 13,10
    db "; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい",13,10
    db 13,10
    db "TBcreate proc parent:DWORD",13,10
    db 13,10
    db "  ; -----------------------------",13,10
    db "  ; run to toolbar creation macro",13,10
    db "  ; -----------------------------",13,10
    db "    ToolbarInit tbbW, tbbH, parent",13,10
    db 13,10
    db "  ; -----------------------------------",13,10
    db "  ; Add toolbar buttons and spaces here",13,10
    db "  ; arg1 bmpID (zero based)",13,10
    db "  ; arg2 cmdID (1st is 50)",13,10
    db "  ; -----------------------------------",13,10
    db "    TBbutton  0,  50",13,10
    db "    TBbutton  1,  51",13,10
    db "    TBbutton  2,  52",13,10
    db "    TBspace",13,10
    db "    TBbutton  3,  53",13,10
    db "    TBbutton  4,  54",13,10
    db "    TBbutton  5,  55",13,10
    db "    TBspace",13,10
    db "    TBbutton  6,  56",13,10
    db "    TBbutton  7,  57",13,10
    db "    TBspace",13,10
    db "    TBbutton  8,  58",13,10
    db "    TBbutton  9,  59",13,10
    db "  ; -----------------------------------",13,10
    db 13,10
    db "    mov rax, tbhandl",13,10
    db 13,10
    db "    ret",13,10
    db 13,10
    db "TBcreate endp",13,10
    db 13,10
    db "; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい",13,10
    db 13,10
    db "rich_edit proc hParent:QWORD,instance:QWORD",13,10
    db 13,10
    db "    LOCAL pEdit  :QWORD",13,10
    db "    LOCAL hFont  :QWORD",13,10
    db "    LOCAL styl   :QWORD",13,10
    db 13,10
    db "  ; ---------------------------",13,10
    db "  ; create the richedit control",13,10
    db "  ; ---------------------------",13,10
    db "    mov styl, WS_VISIBLE or WS_CHILDWINDOW or WS_CLIPSIBLINGS or \",13,10
    db "              ES_MULTILINE or WS_VSCROLL or WS_HSCROLL or ES_AUTOHSCROLL or \",13,10
    db "              ES_AUTOVSCROLL or ES_NOHIDESEL or ES_DISABLENOSCROLL",13,10
    db 13,10
    db "    invoke CreateWindowEx,WS_EX_LEFT,",34,"RichEdit20a",34,", \         ; WS_EX_STATICEDGE",13,10
    db "             0,styl,0,0,200,100,hParent,111,instance,0",13,10
    db 13,10
    db "    mov pEdit, rax",13,10
    db "  ; ---------------------------",13,10
    db 13,10
    db "    invoke SendMessage,pEdit,EM_EXLIMITTEXT,0,1000000000",13,10
    db "    invoke SendMessage,pEdit,EM_SETOPTIONS,ECOOP_XOR,ECO_SELECTIONBAR",13,10
    db 13,10
    db "    mov hFont, rv(font_handle,",34,"fixedsys",34,",9,600)   ; library procedure",13,10
    db "    invoke SendMessage,pEdit,WM_SETFONT,hFont,TRUE",13,10
    db 13,10
    db "    mov ecx, 10",13,10
    db "    mov edx, 5",13,10
    db "    mov ax, dx",13,10
    db "    rol eax, 16",13,10
    db "    mov ax, cx",13,10
    db "    invoke SendMessage,pEdit,EM_SETMARGINS,EC_LEFTMARGIN or EC_RIGHTMARGIN,eax",13,10
    db 13,10
    db "    invoke SendMessage,pEdit,EM_SETTEXTMODE,TM_PLAINTEXT or \",13,10
    db "                             TM_MULTILEVELUNDO or TM_MULTICODEPAGE, 0",13,10
    db "    mov rax, pEdit",13,10
    db 13,10
    db "    ret",13,10
    db 13,10
    db "rich_edit endp",13,10
    db 13,10
    db "; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい",13,10
    db 13,10
    db "StatusBar proc hParent:QWORD",13,10
    db 13,10
    db "    LOCAL handl :QWORD",13,10
    db "    LOCAL sbParts[4] :DWORD",13,10
    db "    LOCAL r12reg :QWORD",13,10
    db 13,10
    db "    mov r12reg, r12",13,10
    db 13,10
    db "    mov handl, rv(CreateStatusWindow,WS_CHILD or WS_VISIBLE or SBS_SIZEGRIP,NULL,hParent,200)",13,10
    db 13,10
    db "  ; --------------------------------------------",13,10
    db "  ; set the width of each part, -1 for last part",13,10
    db "  ; --------------------------------------------",13,10
    db 13,10
    db "    lea r12, sbParts",13,10
    db 13,10
    db "    mov DWORD PTR [r12+0], 150",13,10
    db "    mov DWORD PTR [r12+4], 300",13,10
    db "    mov DWORD PTR [r12+8], 450",13,10
    db "    mov DWORD PTR [r12+12],-1",13,10
    db 13,10
    db "    invoke SendMessage,handl,SB_SETPARTS,4,ADDR sbParts",13,10
    db 13,10
    db "    mov r12, r12reg",13,10
    db "    mov rax, handl",13,10
    db 13,10
    db "    ret",13,10
    db 13,10
    db "StatusBar endp",13,10
    db 13,10
    db "; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい",13,10
    db 13,10
    db "AboutDlg proc hWin:QWORD,uMsg:QWORD,wParam:QWORD,lParam:QWORD",13,10
    db 13,10
    db "    LOCAL hStatic :QWORD",13,10
    db "    LOCAL hButn   :QWORD",13,10
    db "    LOCAL hText   :QWORD",13,10
    db "    LOCAL rct     :RECT",13,10
    db 13,10
    db "    .switch uMsg",13,10
    db "      .case WM_INITDIALOG",13,10
    db "        mov hStatic, rv(GetDlgItem,hWin,101)",13,10
    db "        mov hButn,   rv(GetDlgItem,hWin,102)",13,10
    db "        mov hText,   rv(GetDlgItem,hWin,103)",13,10
    db 13,10
    db "      .data",13,10
    db "        tmsg db 13,10,",34,"Edit this dialog with Ketil Olsen",39,"s RESED.",34,",13,10,13,10",13,10
    db "             db ",34,"This dialog is in the file ",39,"dlgs.rc",39,".",34,",0",13,10
    db "      .code",13,10
    db 13,10
    db "        invoke SetWindowText,hWin,",34,"About Default Template",34,13,10
    db "        invoke SetWindowText,hText,ADDR tmsg",13,10
    db 13,10
    db "      ; -------------------------------------",13,10
    db "      ; load the icon into the static control",13,10
    db "      ; -------------------------------------",13,10
    db "        invoke SendMessage,hStatic,STM_SETIMAGE,IMAGE_ICON,hIcon",13,10
    db 13,10
    db "      ; ---------------------------",13,10
    db "      ; set the icon for the dialog",13,10
    db "      ; ---------------------------",13,10
    db "        invoke SendMessage,hWin,WM_SETICON,1,hIcon",13,10
    db "        mov rax, TRUE",13,10
    db "        ret",13,10
    db 13,10
    db "      .case WM_COMMAND",13,10
    db "        .switch wParam",13,10
    db "          .case 102                     ; the OK button",13,10
    db "            jmp exit_dialog",13,10
    db "        .endsw",13,10
    db 13,10
    db "      .case WM_CLOSE",13,10
    db "        exit_dialog:",13,10
    db "        invoke EndDialog,hWin,0         ; exit from system menu",13,10
    db "    .endsw",13,10
    db 13,10
    db "    xor rax, rax",13,10
    db "    ret",13,10
    db 13,10
    db "AboutDlg endp",13,10
    db 13,10
    db "; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい",13,10
    db 13,10
    db "rebar proc instance:QWORD,hParent:QWORD,htrebar:QWORD",13,10
    db 13,10
    db "    LOCAL hrbar :QWORD",13,10
    db 13,10
    db "    fn CreateWindowEx,WS_EX_LEFT,",34,"ReBarWindow32",34,",NULL, \",13,10
    db "                      WS_VISIBLE or WS_CHILD or \",13,10
    db "                      WS_CLIPCHILDREN or WS_CLIPSIBLINGS or \",13,10
    db "                      RBS_VARHEIGHT or CCS_NOPARENTALIGN or CCS_NODIVIDER, \",13,10
    db "                      0,0,sWid,htrebar,hParent,NULL,instance,NULL",13,10
    db "    mov hrbar, rax",13,10
    db 13,10
    db "    invoke ShowWindow,hrbar,SW_SHOW",13,10
    db "    invoke UpdateWindow,hrbar",13,10
    db 13,10
    db "    mov rax, hrbar",13,10
    db 13,10
    db "    ret",13,10
    db 13,10
    db "rebar endp",13,10
    db 13,10
    db "; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい",13,10
    db 13,10
    db "addband proc instance:QWORD,hrbar:QWORD",13,10
    db 13,10
    db "    LOCAL tbhandl   :QWORD",13,10
    db "    LOCAL rbbi      :REBARBANDINFO",13,10
    db 13,10
    db "    mov tbhandl, rv(TBcreate,hrbar)",13,10
    db 13,10
    db "    mov rbbi.cbSize,      sizeof REBARBANDINFO",13,10
    db "    mov rbbi.fMask,       RBBIM_ID or RBBIM_STYLE or \",13,10
    db "                          RBBIM_BACKGROUND or RBBIM_CHILDSIZE or RBBIM_CHILD",13,10
    db "    mov rbbi.wID,         125",13,10
    db "    mov rbbi.fStyle,      RBBS_FIXEDBMP",13,10
    db "    mrm rbbi.hbmBack,     tbTile",13,10
    db "    mov rbbi.cxMinChild,  0",13,10
    db "    mrmd rbbi.cyMinChild, rbht",13,10
    db "    mrm rbbi.hwndChild,   tbhandl",13,10
    db 13,10
    db "    invoke SendMessage,hrbar,RB_INSERTBAND,0,ADDR rbbi",13,10
    db 13,10
    db "    mov rax, tbhandl",13,10
    db 13,10
    db "    ret",13,10
    db 13,10
    db "addband endp",13,10
    db 13,10
    db "; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい",13,10
    db 13,10
    db "set_text_colour proc Edit:DWORD,txtcolour:DWORD",13,10
    db 13,10
    db "    .data?",13,10
    db "      align 16",13,10
    db "      cfm2 CHARFORMAT2 <?>",13,10
    db "    .code",13,10
    db 13,10
    db "    mov cfm2.cbSize,            SIZEOF CHARFORMAT2",13,10
    db "    mov cfm2.dwMask,            CFM_COLOR",13,10
    db "    mov cfm2.dwEffects,         0",13,10
    db "    mov cfm2.yHeight,           0",13,10
    db "    mov cfm2.yOffset,           0",13,10
    db "    mrmd cfm2.crTextColor,      txtcolour",13,10
    db "    mov cfm2.bCharSet,          0",13,10
    db "    mov cfm2.bPitchAndFamily,   0",13,10
    db "    mov cfm2.szFaceName,        0",13,10
    db "    mov cfm2.wWeight,           0",13,10
    db "    mov cfm2.sSpacing,          0",13,10
    db "    mov cfm2.crBackColor,       0",13,10
    db "    mov cfm2.lcid,              0",13,10
    db "    mov cfm2.dwReserved,        0",13,10
    db "    mov cfm2.sStyle,            0",13,10
    db "    mov cfm2.wKerning,          0",13,10
    db "    mov cfm2.bUnderlineType,    0",13,10
    db "    mov cfm2.bAnimation,        0",13,10
    db "    mov cfm2.bRevAuthor,        0",13,10
    db 13,10
    db "    invoke PostMessage,Edit,EM_SETCHARFORMAT,SCF_ALL,ADDR cfm2",13,10
    db 13,10
    db "    ret",13,10
    db 13,10
    db "set_text_colour endp",13,10
    db 13,10
    db "; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい",13,10
    db 13,10
    db "set_edit_colours proc",13,10
    db 13,10
    db "    invoke SendMessage,hEdit,EM_SETBKGNDCOLOR,0,bak_colour",13,10
    db "    invoke set_text_colour,hEdit,txt_colour",13,10
    db 13,10
    db "    ret",13,10
    db 13,10
    db "set_edit_colours endp",13,10
    db 13,10
    db "; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい",13,10
    db 13,10
    db "    end",13,10
    db 13,10,0

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    end