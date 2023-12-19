; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    public main_inc

    .data

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

  main_inc \
    db 13,10
    db "    IFNDEF CHARFORMAT2",13,10
    db "      CHARFORMAT2 STRUCT QWORD",13,10
    db "        cbSize dd ?",13,10
    db "        dwMask dd ?",13,10
    db "        dwEffects dd ?",13,10
    db "        yHeight dd ?",13,10
    db "        yOffset dd ?",13,10
    db "        crTextColor dd ?",13,10
    db "        bCharSet db ?",13,10
    db "        bPitchAndFamily db ?",13,10
    db "        szFaceName db LF_FACESIZE dup (?)",13,10
    db "        wWeight dw ?",13,10
    db "        sSpacing dw ?",13,10
    db "        crBackColor dd ?",13,10
    db "        lcid dd ?",13,10
    db "        dwReserved dd ?",13,10
    db "        sStyle dw ?",13,10
    db "        wKerning dw ?",13,10
    db "        bUnderlineType db ?",13,10
    db "        bAnimation db ?",13,10
    db "        bRevAuthor db ?",13,10
    db "      CHARFORMAT2 ENDS",13,10
    db "    ENDIF",13,10
    db 13,10
    db "      IfRepeatKey MACRO vk_key",13,10
    db "        invoke GetAsyncKeyState,vk_key",13,10
    db "        and eax, 00000000000000001000000000000000b",13,10
    db "        rol eax, 17",13,10
    db "        cmp eax, 1",13,10
    db "      ENDM",13,10
    db 13,10
    db "    ; ---------------------------",13,10
    db "    ; macros for creating toolbar",13,10
    db "    ; ---------------------------",13,10
    db 13,10
    db "      TBbutton MACRO bID, cID",13,10
    db "        mov tbb.iBitmap,   bID  ;; button  ID number",13,10
    db "        mov tbb.idCommand, cID  ;; command ID number",13,10
    db "        mov tbb.fsStyle,   TBSTYLE_BUTTON",13,10
    db "        invoke SendMessage,tbhandl,TB_ADDBUTTONS,1,ADDR tbb",13,10
    db "      ENDM",13,10
    db 13,10
    db "    ; ------------------------------",13,10
    db 13,10
    db "      TBspace MACRO",13,10
    db "        mov tbb.iBitmap,   0",13,10
    db "        mov tbb.idCommand, 0",13,10
    db "        mov tbb.fsStyle,   TBSTYLE_SEP",13,10
    db "        invoke SendMessage,tbhandl,TB_ADDBUTTONS,1,ADDR tbb",13,10
    db "      ENDM",13,10
    db 13,10
    db "    ; ------------------------------",13,10
    db 13,10
    db "      mLOCAL equ <LOCAL>",13,10
    db 13,10
    db "      ToolbarInit MACRO Wd, Ht, parent",13,10
    db 13,10
    db "        mLOCAL tbhandl   :QWORD",13,10
    db "        mLOCAL bSize     :DWORD",13,10
    db "        mLOCAL tbab      :TBADDBITMAP",13,10
    db "        mLOCAL tbb       :TBBUTTON",13,10
    db 13,10
    db "        fn CreateWindowEx,0,",34,"ToolbarWindow32",34,", \",13,10
    db "                          ADDR caption, \",13,10
    db "                          WS_CHILD or WS_VISIBLE or TBSTYLE_FLAT or \",13,10
    db "                          TBSTYLE_TRANSPARENT or CCS_NODIVIDER, \",13,10
    db "                          0,0,500,40, \",13,10
    db "                          parent,NULL, \",13,10
    db "                          hInstance,NULL",13,10
    db "        mov tbhandl, rax",13,10
    db 13,10
    db "      ; ------------------------------------------------------------------",13,10
    db "      ; set vertical and horizontal padding for buttons (units are pixels)",13,10
    db "      ; ------------------------------------------------------------------",13,10
    db "        mov ax, vpad            ; vertical padding",13,10
    db "        rol eax, 16",13,10
    db "        mov ax, hpad            ; horizontal padding",13,10
    db "        invoke SendMessage,tbhandl,TB_SETPADDING,0,eax",13,10
    db 13,10
    db "        invoke SendMessage,tbhandl,TB_BUTTONSTRUCTSIZE,sizeof TBBUTTON,0",13,10
    db "    ",13,10
    db "      ; ---------------------------------------",13,10
    db "      ; Put width & height of bitmap into DWORD",13,10
    db "      ; ---------------------------------------",13,10
    db "        mov  ecx,Wd  ;; loword = bitmap Width",13,10
    db "        mov  eax,Ht  ;; hiword = bitmap Height",13,10
    db "        shl  eax,16",13,10
    db "        mov  ax, cx",13,10
    db 13,10
    db "        mov bSize, eax",13,10
    db 13,10
    db "        invoke SendMessage,tbhandl,TB_SETBITMAPSIZE,0,bSize",13,10
    db "        invoke SendMessage,tbhandl,TB_SETBUTTONSIZE,0,bSize",13,10
    db 13,10
    db "      ; --------------------------------------------------------",13,10
    db "      ; set left side indent for first button (units are pixels)",13,10
    db "      ; --------------------------------------------------------",13,10
    db "        invoke SendMessage,tbhandl,TB_SETINDENT,lind,0",13,10
    db "        ",13,10
    db "        mov tbab.hInst, 0",13,10
    db 13,10
    db "        mov rax, hBitmap",13,10
    db "        mov tbab.nID, eax",13,10
    db 13,10
    db "        invoke SendMessage,tbhandl,TB_ADDBITMAP,12,ADDR tbab",13,10
    db 13,10
    db "        mov tbb.fsState,   TBSTATE_ENABLED",13,10
    db "        mov tbb.dwData,    0",13,10
    db "        mov tbb.iString,   0",13,10
    db 13,10
    db "      ENDM",13,10
    db 13,10,0

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    end