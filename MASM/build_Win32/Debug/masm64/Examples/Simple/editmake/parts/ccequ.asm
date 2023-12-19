; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    public ccequates_inc

    .data

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

  ccequates_inc \
    db "; **************************************************************************************************",13,10
    db ";                           ---- common control equates and structures ----",13,10
    db "; **************************************************************************************************",13,10
    db 13,10
    db "  CCS_TOP equ 00000001h",13,10
    db "  CCS_NOMOVEY equ 00000002h",13,10
    db "  CCS_BOTTOM equ 00000003h",13,10
    db "  CCS_NORESIZE equ 00000004h",13,10
    db "  CCS_NOPARENTALIGN equ 00000008h",13,10
    db "  CCS_ADJUSTABLE equ 00000020h",13,10
    db "  CCS_NODIVIDER equ 00000040h",13,10
    db "  CCS_VERT equ 00000080h",13,10
    db "  CCS_LEFT equ CCS_VERT or CCS_TOP",13,10
    db "  CCS_RIGHT equ CCS_VERT or CCS_BOTTOM",13,10
    db "  CCS_NOMOVEX equ CCS_VERT or CCS_NOMOVEY",13,10
    db 13,10
    db "  IFNDEF CBEMAXSTRLEN",13,10
    db "    CBEMAXSTRLEN equ <260>",13,10
    db "  ENDIF",13,10
    db 13,10
    db "; --------------",13,10
    db "; rebar messages",13,10
    db "; --------------",13,10
    db "  RB_INSERTBAND equ WM_USER+1",13,10
    db "  RB_DELETEBAND equ WM_USER+2",13,10
    db "  RB_GETBARINFO equ WM_USER+3",13,10
    db "  RB_SETBARINFO equ WM_USER+4",13,10
    db "  RB_SETPARENT equ WM_USER+7",13,10
    db "  RB_HITTEST equ WM_USER+8",13,10
    db "  RB_GETRECT equ WM_USER+9",13,10
    db "  RB_INSERTBANDW equ WM_USER+10",13,10
    db "  RB_SETBANDINFOW equ WM_USER+11",13,10
    db "  RB_GETBANDCOUNT equ WM_USER+12",13,10
    db "  RB_GETROWCOUNT equ WM_USER+13",13,10
    db "  RB_GETROWHEIGHT equ WM_USER+14",13,10
    db "  RB_IDTOINDEX equ WM_USER+16",13,10
    db "  RB_GETTOOLTIPS equ WM_USER+17",13,10
    db "  RB_SETTOOLTIPS equ WM_USER+18",13,10
    db "  RB_SETBKCOLOR equ WM_USER+19",13,10
    db "  RB_GETBKCOLOR equ WM_USER+20",13,10
    db "  RB_SETTEXTCOLOR equ WM_USER+21",13,10
    db "  RB_GETTEXTCOLOR equ WM_USER+22",13,10
    db "  RB_SIZETORECT equ WM_USER+23",13,10
    db "  RB_SETCOLORSCHEME equ CCM_SETCOLORSCHEME",13,10
    db "  RB_GETCOLORSCHEME equ CCM_GETCOLORSCHEME",13,10
    db "  RB_BEGINDRAG equ WM_USER+24",13,10
    db "  RB_ENDDRAG equ WM_USER+25",13,10
    db "  RB_DRAGMOVE equ WM_USER+26",13,10
    db "  RB_GETBARHEIGHT equ WM_USER+27",13,10
    db "  RB_GETBANDINFOW equ WM_USER+28",13,10
    db "  RB_GETBANDINFO equ WM_USER+29",13,10
    db "  RB_MINIMIZEBAND equ WM_USER+30",13,10
    db "  RB_MAXIMIZEBAND equ WM_USER+31",13,10
    db "  RB_GETDROPTARGET equ CCM_GETDROPTARGET",13,10
    db "  RB_GETBANDBORDERS equ WM_USER+34",13,10
    db "  RB_SHOWBAND equ WM_USER+35",13,10
    db "  RB_SETPALETTE equ WM_USER+37",13,10
    db "  RB_GETPALETTE equ WM_USER+38",13,10
    db "  RB_MOVEBAND equ WM_USER+39",13,10
    db "  RB_SETUNICODEFORMAT equ CCM_SETUNICODEFORMAT",13,10
    db "  RB_GETUNICODEFORMAT equ CCM_GETUNICODEFORMAT",13,10
    db "  RB_GETBANDMARGINS equ WM_USER+40",13,10
    db "  RB_SETWINDOWTHEME equ CCM_SETWINDOWTHEME",13,10
    db "  RB_SETEXTENDEDSTYLE equ WM_USER+41",13,10
    db "  RB_GETEXTENDEDSTYLE equ WM_USER+42",13,10
    db "  RB_PUSHCHEVRON equ WM_USER+43",13,10
    db "  RB_SETBANDWIDTH equ WM_USER+44",13,10
    db 13,10
    db "  RBBIM_STYLE equ 00000001h",13,10
    db "  RBBIM_COLORS equ 00000002h",13,10
    db "  RBBIM_TEXT equ 00000004h",13,10
    db "  RBBIM_IMAGE equ 00000008h",13,10
    db "  RBBIM_CHILD equ 00000010h",13,10
    db "  RBBIM_CHILDSIZE equ 00000020h",13,10
    db "  RBBIM_SIZE equ 00000040h",13,10
    db "  RBBIM_BACKGROUND equ 00000080h",13,10
    db "  RBBIM_ID equ 00000100h",13,10
    db "  RBBIM_IDEALSIZE equ 00000200h",13,10
    db "  RBBIM_LPARAM equ 00000400h",13,10
    db "  RBBIM_HEADERSIZE equ 00000800h",13,10
    db "  RBBIM_CHEVRONLOCATION equ 00001000h",13,10
    db "  RBBIM_CHEVRONSTATE equ 00002000h",13,10
    db 13,10
    db "  RBBS_BREAK equ 00000001h",13,10
    db "  RBBS_FIXEDSIZE equ 00000002h",13,10
    db "  RBBS_CHILDEDGE equ 00000004h",13,10
    db "  RBBS_HIDDEN equ 00000008h",13,10
    db "  RBBS_NOVERT equ 00000010h",13,10
    db "  RBBS_FIXEDBMP equ 00000020h",13,10
    db "  RBBS_VARIABLEHEIGHT equ 00000040h",13,10
    db "  RBBS_GRIPPERALWAYS equ 00000080h",13,10
    db "  RBBS_NOGRIPPER equ 00000100h",13,10
    db "  RBBS_USECHEVRON equ 00000200h",13,10
    db "  RBBS_HIDETITLE equ 00000400h",13,10
    db "  RBBS_TOPALIGN equ 00000800h",13,10
    db 13,10
    db "  RBHT_NOWHERE equ 0001h",13,10
    db "  RBHT_CAPTION equ 0002h",13,10
    db "  RBHT_CLIENT equ 0003h",13,10
    db "  RBHT_GRABBER equ 0004h",13,10
    db "  RBHT_CHEVRON equ 0008h",13,10
    db "  RBHT_SPLITTER equ 0010h",13,10
    db 13,10
    db "  RBN_FIRST equ 0U-831U",13,10
    db "  RBN_LAST equ 0U-859U",13,10
    db "  RBN_HEIGHTCHANGE equ RBN_FIRST - 0",13,10
    db "  RBN_GETOBJECT equ RBN_FIRST - 1",13,10
    db "  RBN_LAYOUTCHANGED equ RBN_FIRST - 2",13,10
    db "  RBN_AUTOSIZE equ RBN_FIRST - 3",13,10
    db "  RBN_BEGINDRAG equ RBN_FIRST - 4",13,10
    db "  RBN_ENDDRAG equ RBN_FIRST - 5",13,10
    db "  RBN_DELETINGBAND equ RBN_FIRST - 6",13,10
    db "  RBN_DELETEDBAND equ RBN_FIRST - 7",13,10
    db "  RBN_CHILDSIZE equ RBN_FIRST - 8",13,10
    db "  RBN_CHEVRONPUSHED equ RBN_FIRST - 10",13,10
    db "  RBN_SPLITTERDRAG equ RBN_FIRST - 11",13,10
    db "  RBN_MINMAX equ RBN_FIRST - 21",13,10
    db "  RBN_AUTOBREAK equ RBN_FIRST - 22",13,10
    db 13,10
    db "  RBS_TOOLTIPS equ 00000100h",13,10
    db "  RBS_VARHEIGHT equ 00000200h",13,10
    db "  RBS_BANDBORDERS equ 00000400h",13,10
    db "  RBS_FIXEDORDER equ 00000800h",13,10
    db "  RBS_REGISTERDROP equ 00001000h",13,10
    db "  RBS_AUTOSIZE equ 00002000h",13,10
    db "  RBS_VERTICALGRIPPER equ 00004000h",13,10
    db "  RBS_DBLCLKTOGGLE equ 00008000h",13,10
    db 13,10
    db "; ---------------",13,10
    db "; rebar strutures",13,10
    db "; ---------------",13,10
    db "  NMRBAUTOSIZE STRUCT QWORD",13,10
    db "    hdr NMHDR <>",13,10
    db "    fChanged dd ?",13,10
    db "    rcTarget RECT <>",13,10
    db "    rcActual RECT <>",13,10
    db "  NMRBAUTOSIZE ENDS",13,10
    db 13,10
    db "  NMREBAR STRUCT QWORD",13,10
    db "    hdr NMHDR <>",13,10
    db "    dwMask dd ?",13,10
    db "    uBand dd ?",13,10
    db "    fStyle dd ?",13,10
    db "    wID dd ?",13,10
    db "    lParam dq ?",13,10
    db "  NMREBAR ENDS",13,10
    db 13,10
    db "  NMREBARCHEVRON STRUCT QWORD",13,10
    db "    hdr NMHDR <>",13,10
    db "    uBand dd ?",13,10
    db "    wID dd ?",13,10
    db "    lParam dq ?",13,10
    db "    rc RECT <>",13,10
    db "    lParamNM dq ?",13,10
    db "  NMREBARCHEVRON ENDS",13,10
    db 13,10
    db "  NMREBARCHILDSIZE STRUCT QWORD",13,10
    db "    hdr NMHDR <>",13,10
    db "    uBand dd ?",13,10
    db "    wID dd ?",13,10
    db "    rcChild RECT <>",13,10
    db "    rcBand RECT <>",13,10
    db "  NMREBARCHILDSIZE ENDS",13,10
    db 13,10
    db "  RBHITTESTINFO STRUCT QWORD",13,10
    db "    pt POINT <>",13,10
    db "    flags dd ?",13,10
    db "    iBand dd ?",13,10
    db "  RBHITTESTINFO ENDS",13,10
    db 13,10
    db "  REBARBANDINFO STRUCT QWORD",13,10
    db "    cbSize dd ?",13,10
    db "    fMask dd ?",13,10
    db "    fStyle dd ?",13,10
    db "    clrFore dd ?",13,10
    db "    clrBack dd ?",13,10
    db "    lpText dq ?",13,10
    db "    cch dd ?",13,10
    db "    iImage dd ?",13,10
    db "    hwndChild dq ?",13,10
    db "    cxMinChild dd ?",13,10
    db "    cyMinChild dd ?",13,10
    db "    _cx dd ?",13,10
    db "    hbmBack dq ?",13,10
    db "    wID dd ?",13,10
    db "    cyChild dd ?",13,10
    db "    cyMaxChild dd ?",13,10
    db "    cyIntegral dd ?",13,10
    db "    cxIdeal dd ?",13,10
    db "    lParam dq ?",13,10
    db "    cxHeader dd ?",13,10
    db "  REBARBANDINFO ENDS",13,10
    db 13,10
    db "  REBARINFO STRUCT QWORD",13,10
    db "    cbSize dd ?",13,10
    db "    fMask dd ?",13,10
    db "    himl HIMAGELIST <>",13,10
    db "  REBARINFO ENDS",13,10
    db 13,10
    db "; ----------------",13,10
    db "; toolbar messages",13,10
    db "; ----------------",13,10
    db "  TB_ENABLEBUTTON equ WM_USER+1",13,10
    db "  TB_CHECKBUTTON equ WM_USER+2",13,10
    db "  TB_PRESSBUTTON equ WM_USER+3",13,10
    db "  TB_HIDEBUTTON equ WM_USER+4",13,10
    db "  TB_INDETERMINATE equ WM_USER+5",13,10
    db "  TB_MARKBUTTON equ WM_USER+6",13,10
    db "  TB_ISBUTTONENABLED equ WM_USER+9",13,10
    db "  TB_ISBUTTONCHECKED equ WM_USER+10",13,10
    db "  TB_ISBUTTONPRESSED equ WM_USER+11",13,10
    db "  TB_ISBUTTONHIDDEN equ WM_USER+12",13,10
    db "  TB_ISBUTTONINDETERMINATE equ WM_USER+13",13,10
    db "  TB_ISBUTTONHIGHLIGHTED equ WM_USER+14",13,10
    db "  TB_SETSTATE equ WM_USER+17",13,10
    db "  TB_GETSTATE equ WM_USER+18",13,10
    db "  TB_ADDBITMAP equ WM_USER+19",13,10
    db "  TB_ADDBUTTONS equ WM_USER+20",13,10
    db "  TB_INSERTBUTTON equ WM_USER+21",13,10
    db "  TB_DELETEBUTTON equ WM_USER+22",13,10
    db "  TB_GETBUTTON equ WM_USER+23",13,10
    db "  TB_BUTTONCOUNT equ WM_USER+24",13,10
    db "  TB_COMMANDTOINDEX equ WM_USER+25",13,10
    db "  TB_SAVERESTORE equ WM_USER+26",13,10
    db "  TB_SAVERESTOREW equ WM_USER+76",13,10
    db "  TB_CUSTOMIZE equ WM_USER+27",13,10
    db "  TB_ADDSTRING equ WM_USER+28",13,10
    db "  TB_ADDSTRINGW equ WM_USER+77",13,10
    db "  TB_GETITEMRECT equ WM_USER+29",13,10
    db "  TB_BUTTONSTRUCTSIZE equ WM_USER+30",13,10
    db "  TB_SETBUTTONSIZE equ WM_USER+31",13,10
    db "  TB_SETBITMAPSIZE equ WM_USER+32",13,10
    db "  TB_AUTOSIZE equ WM_USER+33",13,10
    db "  TB_GETTOOLTIPS equ WM_USER+35",13,10
    db "  TB_SETTOOLTIPS equ WM_USER+36",13,10
    db "  TB_SETPARENT equ WM_USER+37",13,10
    db "  TB_SETROWS equ WM_USER+39",13,10
    db "  TB_GETROWS equ WM_USER+40",13,10
    db "  TB_SETCMDID equ WM_USER+42",13,10
    db "  TB_CHANGEBITMAP equ WM_USER+43",13,10
    db "  TB_GETBITMAP equ WM_USER+44",13,10
    db "  TB_GETBUTTONTEXT equ WM_USER+45",13,10
    db "  TB_GETBUTTONTEXTW equ WM_USER+75",13,10
    db "  TB_REPLACEBITMAP equ WM_USER+46",13,10
    db "  TB_SETINDENT equ WM_USER+47",13,10
    db "  TB_SETIMAGELIST equ WM_USER+48",13,10
    db "  TB_GETIMAGELIST equ WM_USER+49",13,10
    db "  TB_LOADIMAGES equ WM_USER+50",13,10
    db "  TB_GETRECT equ WM_USER+51",13,10
    db "  TB_SETHOTIMAGELIST equ WM_USER+52",13,10
    db "  TB_GETHOTIMAGELIST equ WM_USER+53",13,10
    db "  TB_SETDISABLEDIMAGELIST equ WM_USER+54",13,10
    db "  TB_GETDISABLEDIMAGELIST equ WM_USER+55",13,10
    db "  TB_SETSTYLE equ WM_USER+56",13,10
    db "  TB_GETSTYLE equ WM_USER+57",13,10
    db "  TB_GETBUTTONSIZE equ WM_USER+58",13,10
    db "  TB_SETBUTTONWIDTH equ WM_USER+59",13,10
    db "  TB_SETMAXTEXTROWS equ WM_USER+60",13,10
    db "  TB_GETTEXTROWS equ WM_USER+61",13,10
    db "  TB_GETOBJECT equ WM_USER+62",13,10
    db "  TB_GETHOTITEM equ WM_USER+71",13,10
    db "  TB_SETHOTITEM equ WM_USER+72",13,10
    db "  TB_SETANCHORHIGHLIGHT equ WM_USER+73",13,10
    db "  TB_GETANCHORHIGHLIGHT equ WM_USER+74",13,10
    db "  TB_MAPACCELERATOR equ WM_USER+78",13,10
    db "  TB_GETINSERTMARK equ WM_USER+79",13,10
    db "  TB_SETINSERTMARK equ WM_USER+80",13,10
    db "  TB_INSERTMARKHITTEST equ WM_USER+81",13,10
    db "  TB_MOVEBUTTON equ WM_USER+82",13,10
    db "  TB_GETMAXSIZE equ WM_USER+83",13,10
    db "  TB_SETEXTENDEDSTYLE equ WM_USER+84",13,10
    db "  TB_GETEXTENDEDSTYLE equ WM_USER+85",13,10
    db "  TB_GETPADDING equ WM_USER+86",13,10
    db "  TB_SETPADDING equ WM_USER+87",13,10
    db "  TB_SETINSERTMARKCOLOR equ WM_USER+88",13,10
    db "  TB_GETINSERTMARKCOLOR equ WM_USER+89",13,10
    db "  TB_SETCOLORSCHEME equ CCM_SETCOLORSCHEME",13,10
    db "  TB_GETCOLORSCHEME equ CCM_GETCOLORSCHEME",13,10
    db "  TB_SETUNICODEFORMAT equ CCM_SETUNICODEFORMAT",13,10
    db "  TB_GETUNICODEFORMAT equ CCM_GETUNICODEFORMAT",13,10
    db "  TB_MAPACCELERATORW equ WM_USER+90",13,10
    db "  TB_GETBITMAPFLAGS equ WM_USER+41",13,10
    db "  TB_GETBUTTONINFOW equ WM_USER+63",13,10
    db "  TB_SETBUTTONINFOW equ WM_USER+64",13,10
    db "  TB_GETBUTTONINFO equ WM_USER+65",13,10
    db "  TB_SETBUTTONINFO equ WM_USER+66",13,10
    db "  TB_INSERTBUTTONW equ WM_USER+67",13,10
    db "  TB_ADDBUTTONSW equ WM_USER+68",13,10
    db "  TB_HITTEST equ WM_USER+69",13,10
    db "  TB_SETDRAWTEXTFLAGS equ WM_USER+70",13,10
    db "  TB_GETSTRINGW equ WM_USER+91",13,10
    db "  TB_GETSTRING equ WM_USER+92",13,10
    db "  TB_SETHOTITEM2 equ WM_USER+94",13,10
    db "  TB_SETLISTGAP equ WM_USER+96",13,10
    db "  TB_GETIMAGELISTCOUNT equ WM_USER+98",13,10
    db "  TB_GETIDEALSIZE equ WM_USER+99",13,10
    db "  TB_TRANSLATEACCELERATOR equ CCM_TRANSLATEACCELERATOR",13,10
    db "  TB_GETMETRICS equ WM_USER+101",13,10
    db "  TB_SETMETRICS equ WM_USER+102",13,10
    db "  TB_GETITEMDROPDOWNRECT equ WM_USER+103",13,10
    db "  TB_SETPRESSEDIMAGELIST equ WM_USER+104",13,10
    db "  TB_GETPRESSEDIMAGELIST equ WM_USER+105",13,10
    db "  TB_SETWINDOWTHEME equ CCM_SETWINDOWTHEME",13,10
    db "  TB_LINEUP equ 0",13,10
    db "  TB_LINEDOWN equ 1",13,10
    db "  TB_PAGEUP equ 2",13,10
    db "  TB_PAGEDOWN equ 3",13,10
    db "  TB_THUMBPOSITION equ 4",13,10
    db "  TB_THUMBTRACK equ 5",13,10
    db "  TB_TOP equ 6",13,10
    db "  TB_BOTTOM equ 7",13,10
    db "  TB_ENDTRACK equ 8",13,10
    db 13,10
    db "  TBM_GETPOS equ WM_USER",13,10
    db "  TBM_GETRANGEMIN equ WM_USER+1",13,10
    db "  TBM_GETRANGEMAX equ WM_USER+2",13,10
    db "  TBM_GETTIC equ WM_USER+3",13,10
    db "  TBM_SETTIC equ WM_USER+4",13,10
    db "  TBM_SETPOS equ WM_USER+5",13,10
    db "  TBM_SETRANGE equ WM_USER+6",13,10
    db "  TBM_SETRANGEMIN equ WM_USER+7",13,10
    db "  TBM_SETRANGEMAX equ WM_USER+8",13,10
    db "  TBM_CLEARTICS equ WM_USER+9",13,10
    db "  TBM_SETSEL equ WM_USER+10",13,10
    db "  TBM_SETSELSTART equ WM_USER+11",13,10
    db "  TBM_SETSELEND equ WM_USER+12",13,10
    db "  TBM_GETPTICS equ WM_USER+14",13,10
    db "  TBM_GETTICPOS equ WM_USER+15",13,10
    db "  TBM_GETNUMTICS equ WM_USER+16",13,10
    db "  TBM_GETSELSTART equ WM_USER+17",13,10
    db "  TBM_GETSELEND equ WM_USER+18",13,10
    db "  TBM_CLEARSEL equ WM_USER+19",13,10
    db "  TBM_SETTICFREQ equ WM_USER+20",13,10
    db "  TBM_SETPAGESIZE equ WM_USER+21",13,10
    db "  TBM_GETPAGESIZE equ WM_USER+22",13,10
    db "  TBM_SETLINESIZE equ WM_USER+23",13,10
    db "  TBM_GETLINESIZE equ WM_USER+24",13,10
    db "  TBM_GETTHUMBRECT equ WM_USER+25",13,10
    db "  TBM_GETCHANNELRECT equ WM_USER+26",13,10
    db "  TBM_SETTHUMBLENGTH equ WM_USER+27",13,10
    db "  TBM_GETTHUMBLENGTH equ WM_USER+28",13,10
    db "  TBM_SETTOOLTIPS equ WM_USER+29",13,10
    db "  TBM_GETTOOLTIPS equ WM_USER+30",13,10
    db "  TBM_SETTIPSIDE equ WM_USER+31",13,10
    db "  TBM_SETBUDDY equ WM_USER+32",13,10
    db "  TBM_GETBUDDY equ WM_USER+33",13,10
    db "  TBM_SETPOSNOTIFY equ WM_USER+34",13,10
    db "  TBM_SETUNICODEFORMAT equ CCM_SETUNICODEFORMAT",13,10
    db "  TBM_GETUNICODEFORMAT equ CCM_GETUNICODEFORMAT",13,10
    db 13,10
    db "  TBN_FIRST equ 0U-700U",13,10
    db "  TBN_LAST equ 0U-720U",13,10
    db "  TBN_GETBUTTONINFO equ TBN_FIRST-0",13,10
    db "  TBN_BEGINDRAG equ TBN_FIRST-1",13,10
    db "  TBN_ENDDRAG equ TBN_FIRST-2",13,10
    db "  TBN_BEGINADJUST equ TBN_FIRST-3",13,10
    db "  TBN_ENDADJUST equ TBN_FIRST-4",13,10
    db "  TBN_RESET equ TBN_FIRST-5",13,10
    db "  TBN_QUERYINSERT equ TBN_FIRST-6",13,10
    db "  TBN_QUERYDELETE equ TBN_FIRST-7",13,10
    db "  TBN_TOOLBARCHANGE equ TBN_FIRST-8",13,10
    db "  TBN_CUSTHELP equ TBN_FIRST-9",13,10
    db "  TBN_DROPDOWN equ TBN_FIRST - 10",13,10
    db "  TBN_GETOBJECT equ TBN_FIRST - 12",13,10
    db "  TBN_HOTITEMCHANGE equ TBN_FIRST - 13",13,10
    db "  TBN_DRAGOUT equ TBN_FIRST - 14",13,10
    db "  TBN_DELETINGBUTTON equ TBN_FIRST - 15",13,10
    db "  TBN_GETDISPINFO equ TBN_FIRST - 16",13,10
    db "  TBN_GETDISPINFOW equ TBN_FIRST - 17",13,10
    db "  TBN_GETINFOTIP equ TBN_FIRST - 18",13,10
    db "  TBN_GETINFOTIPW equ TBN_FIRST - 19",13,10
    db "  TBN_GETBUTTONINFOW equ TBN_FIRST - 20",13,10
    db "  TBN_RESTORE equ TBN_FIRST - 21",13,10
    db "  TBN_SAVE equ TBN_FIRST - 22",13,10
    db "  TBN_INITCUSTOMIZE equ TBN_FIRST - 23",13,10
    db "  TBN_WRAPHOTITEM equ TBN_FIRST - 24",13,10
    db "  TBN_DUPACCELERATOR equ TBN_FIRST - 25",13,10
    db "  TBN_WRAPACCELERATOR equ TBN_FIRST - 26",13,10
    db "  TBN_DRAGOVER equ TBN_FIRST - 27",13,10
    db "  TBN_MAPACCELERATOR equ TBN_FIRST - 28",13,10
    db 13,10
    db "  TBSTATE_CHECKED equ 01h",13,10
    db "  TBSTATE_PRESSED equ 02h",13,10
    db "  TBSTATE_ENABLED equ 04h",13,10
    db "  TBSTATE_HIDDEN equ 08h",13,10
    db "  TBSTATE_INDETERMINATE equ 10h",13,10
    db "  TBSTATE_WRAP equ 20h",13,10
    db "  TBSTATE_ELLIPSES equ 40h",13,10
    db "  TBSTATE_MARKED equ 80h",13,10
    db 13,10
    db "  TBSTYLE_BUTTON equ 0000h",13,10
    db "  TBSTYLE_SEP equ 0001h",13,10
    db "  TBSTYLE_CHECK equ 0002h",13,10
    db "  TBSTYLE_GROUP equ 0004h",13,10
    db "  TBSTYLE_CHECKGROUP equ TBSTYLE_GROUP or TBSTYLE_CHECK",13,10
    db "  TBSTYLE_DROPDOWN equ 0008h",13,10
    db "  TBSTYLE_AUTOSIZE equ 0010h",13,10
    db "  TBSTYLE_NOPREFIX equ 0020h",13,10
    db "  TBSTYLE_TOOLTIPS equ 0100h",13,10
    db "  TBSTYLE_WRAPABLE equ 0200h",13,10
    db "  TBSTYLE_ALTDRAG equ 0400h",13,10
    db "  TBSTYLE_FLAT equ 0800h",13,10
    db "  TBSTYLE_LIST equ 1000h",13,10
    db "  TBSTYLE_CUSTOMERASE equ 2000h",13,10
    db "  TBSTYLE_REGISTERDROP equ 4000h",13,10
    db "  TBSTYLE_TRANSPARENT equ 8000h",13,10
    db "  TBSTYLE_EX_DRAWDDARROWS equ 00000001h",13,10
    db "  TBSTYLE_EX_MIXEDBUTTONS equ 00000008h",13,10
    db "  TBSTYLE_EX_HIDECLIPPEDBUTTONS equ 00000010h",13,10
    db "  TBSTYLE_EX_DOUBLEBUFFER equ 00000080h",13,10
    db 13,10
    db "; ------------------",13,10
    db "; toolbar structures",13,10
    db "; ------------------",13,10
    db "  COLORMAP STRUCT QWORD",13,10
    db "    from dd ?",13,10
    db "    to dd ?",13,10
    db "  COLORMAP ENDS",13,10
    db 13,10
    db "  NMCUSTOMDRAW STRUCT QWORD",13,10
    db "    hdr NMHDR <>",13,10
    db "    dwDrawStage dd ?",13,10
    db "    hdc dq ?",13,10
    db "    rc RECT <>",13,10
    db "    dwItemSpec dd ?",13,10
    db "    uItemState dd ?",13,10
    db "    lItemlParam dq ?",13,10
    db "  NMCUSTOMDRAW ENDS",13,10
    db 13,10
    db "  NMTBCUSTOMDRAW STRUCT QWORD",13,10
    db "    nmcd NMCUSTOMDRAW <>",13,10
    db "    hbrMonoDither dq ?",13,10
    db "    hbrLines dq ?",13,10
    db "    hpenLines dq ?",13,10
    db "    clrText dd ?",13,10
    db "    clrMark dd ?",13,10
    db "    clrTextHighlight dd ?",13,10
    db "    clrBtnFace dd ?",13,10
    db "    clrBtnHighlight dd ?",13,10
    db "    clrHighlightHotTrack dd ?",13,10
    db "    rcText RECT <>",13,10
    db "    nStringBkMode dd ?",13,10
    db "    nHLStringBkMode dd ?",13,10
    db "  NMTBCUSTOMDRAW ENDS",13,10
    db 13,10
    db "  NMTBDISPINFO STRUCT QWORD",13,10
    db "    hdr NMHDR <>",13,10
    db "    dwMask dd ?",13,10
    db "    idCommand dd ?",13,10
    db "    lParam dq ?",13,10
    db "    iImage dd ?",13,10
    db "    pszText dq ?",13,10
    db "    cchText dd ?",13,10
    db "  NMTBDISPINFO ENDS",13,10
    db 13,10
    db "  NMTBGETINFOTIP STRUCT QWORD",13,10
    db "    hdr NMHDR <>",13,10
    db "    pszText dq ?",13,10
    db "    cchTextMax dd ?",13,10
    db "    iItem dd ?",13,10
    db "    lParam dq ?",13,10
    db "  NMTBGETINFOTIP ENDS",13,10
    db 13,10
    db "  NMTBHOTITEM STRUCT QWORD",13,10
    db "    hdr NMHDR <>",13,10
    db "    idOld dd ?",13,10
    db "    idNew dd ?",13,10
    db "    dwFlags dd ?",13,10
    db "  NMTBHOTITEM ENDS",13,10
    db 13,10
    db "  TBBUTTON STRUCT QWORD",13,10
    db "    iBitmap dd ?",13,10
    db "    idCommand dd ?",13,10
    db "    fsState db ?",13,10
    db "    fsStyle db ?",13,10
    db "    dwData dd ?",13,10
    db "    iString dq ?",13,10
    db "  TBBUTTON ENDS",13,10
    db 13,10
    db "  NMTBRESTORE STRUCT QWORD",13,10
    db "    nmhdr NMHDR <>",13,10
    db "    pData dd ?",13,10
    db "    pCurrent dd ?",13,10
    db "    cbData dd ?",13,10
    db "    iItem dd ?",13,10
    db "    cButtons dd ?",13,10
    db "    cbBytesPerRecord dd ?",13,10
    db "    tbButton TBBUTTON <>",13,10
    db "  NMTBRESTORE ENDS",13,10
    db 13,10
    db "  NMTBSAVE STRUCT QWORD",13,10
    db "    nmhdr NMHDR <>",13,10
    db "    pData dd ?",13,10
    db "    pCurrent dd ?",13,10
    db "    cbData dd ?",13,10
    db "    iItem dd ?",13,10
    db "    cButtons dd ?",13,10
    db "    tbButton TBBUTTON <>",13,10
    db "  NMTBSAVE ENDS",13,10
    db 13,10
    db "  TBADDBITMAP STRUCT QWORD",13,10
    db "    hInst dq ?",13,10
    db "    nID dd ?",13,10
    db "  TBADDBITMAP ENDS",13,10
    db 13,10
    db "  TBBUTTONINFO STRUCT QWORD",13,10
    db "    cbSize dd ?",13,10
    db "    dwMask dd ?",13,10
    db "    idCommand dd ?",13,10
    db "    iImage dd ?",13,10
    db "    fsState db ?",13,10
    db "    fsStyle db ?",13,10
    db "    _cx dw ?",13,10
    db "    lParam dd ?",13,10
    db "    pszText dq ?",13,10
    db "    cchText dd ?",13,10
    db "  TBBUTTONINFO ENDS",13,10
    db 13,10
    db "  TBINSERTMARK STRUCT QWORD",13,10
    db "    iButton dd ?",13,10
    db "    dwFlags dd ?",13,10
    db "  TBINSERTMARK ENDS",13,10
    db 13,10
    db "  NMTOOLBAR STRUCT QWORD",13,10
    db "    hdr NMHDR <>",13,10
    db "    iItem dd ?",13,10
    db "    tbButton TBBUTTON <>",13,10
    db "    cchText dd ?",13,10
    db "    pszText dq ?",13,10
    db "    rcButton RECT <>",13,10
    db "  NMTOOLBAR ENDS",13,10
    db 13,10
    db "  TBREPLACEBITMAP STRUCT QWORD",13,10
    db "    hInstOld dq ?",13,10
    db "    nIDOld dd ?",13,10
    db "    hInstNew dq ?",13,10
    db "    nIDNew dd ?",13,10
    db "    nButtons dd ?",13,10
    db "  TBREPLACEBITMAP ENDS",13,10
    db 13,10
    db "  TBSAVEPARAMS STRUCT QWORD",13,10
    db "    hkr dq ?",13,10
    db "    pszSubKey dq ?",13,10
    db "    pszValueName dq ?",13,10
    db "  TBSAVEPARAMS ENDS",13,10
    db 13,10
    db "; -------------------",13,10
    db "; status bar messages",13,10
    db "; -------------------",13,10
    db "  SB_NONE equ 00000000h",13,10
    db "  SB_CONST_ALPHA equ 00000001h",13,10
    db "  SB_PIXEL_ALPHA equ 00000002h",13,10
    db "  SB_PREMULT_ALPHA equ 00000004h",13,10
    db "  SB_GRAD_RECT equ 00000010h",13,10
    db "  SB_GRAD_TRI equ 00000020h",13,10
    db "  SB_HORZ equ 0",13,10
    db "  SB_VERT equ 1",13,10
    db "  SB_CTL equ 2",13,10
    db "  SB_BOTH equ 3",13,10
    db "  SB_LINEUP equ 0",13,10
    db "  SB_LINELEFT equ 0",13,10
    db "  SB_LINEDOWN equ 1",13,10
    db "  SB_LINERIGHT equ 1",13,10
    db "  SB_PAGEUP equ 2",13,10
    db "  SB_PAGELEFT equ 2",13,10
    db "  SB_PAGEDOWN equ 3",13,10
    db "  SB_PAGERIGHT equ 3",13,10
    db "  SB_THUMBPOSITION equ 4",13,10
    db "  SB_THUMBTRACK equ 5",13,10
    db "  SB_TOP equ 6",13,10
    db "  SB_LEFT equ 6",13,10
    db "  SB_BOTTOM equ 7",13,10
    db "  SB_RIGHT equ 7",13,10
    db "  SB_ENDSCROLL equ 8",13,10
    db "  SB_SETTEXT equ WM_USER+1",13,10
    db "  SB_SETTEXTW equ WM_USER+11",13,10
    db "  SB_GETTEXT equ WM_USER+2",13,10
    db "  SB_GETTEXTW equ WM_USER+13",13,10
    db "  SB_GETTEXTLENGTHA equ WM_USER+3",13,10
    db "  SB_GETTEXTLENGTHW equ WM_USER+12",13,10
    db "  SB_SETPARTS equ WM_USER+4",13,10
    db "  SB_GETPARTS equ WM_USER+6",13,10
    db "  SB_GETBORDERS equ WM_USER+7",13,10
    db "  SB_SETMINHEIGHT equ WM_USER+8",13,10
    db "  SB_SIMPLE equ WM_USER+9",13,10
    db "  SB_GETRECT equ WM_USER+10",13,10
    db "  SB_ISSIMPLE equ WM_USER+14",13,10
    db "  SB_SETICON equ WM_USER+15",13,10
    db "  SB_SETTIPTEXT equ WM_USER+16",13,10
    db "  SB_SETTIPTEXTW equ WM_USER+17",13,10
    db "  SB_GETTIPTEXT equ WM_USER+18",13,10
    db "  SB_GETTIPTEXTW equ WM_USER+19",13,10
    db "  SB_GETICON equ WM_USER+20",13,10
    db "  SB_SETUNICODEFORMAT equ CCM_SETUNICODEFORMAT",13,10
    db "  SB_GETUNICODEFORMAT equ CCM_GETUNICODEFORMAT",13,10
    db "  SB_SETBKCOLOR equ CCM_SETBKCOLOR",13,10
    db "  SB_SIMPLEID equ 00FFh",13,10
    db 13,10
    db "; --------------------",13,10
    db "; tab control messages",13,10
    db "; --------------------",13,10
    db "TCM_FIRST equ 1300h",13,10
    db "TCM_GETIMAGELIST equ TCM_FIRST+2",13,10
    db "TCM_SETIMAGELIST equ TCM_FIRST+3",13,10
    db "TCM_GETITEMCOUNT equ TCM_FIRST+4",13,10
    db "TCM_GETITEM equ TCM_FIRST+5",13,10
    db "TCM_GETITEMW equ TCM_FIRST+60",13,10
    db "TCM_SETITEM equ TCM_FIRST+6",13,10
    db "TCM_SETITEMW equ TCM_FIRST+61",13,10
    db "TCM_INSERTITEM equ TCM_FIRST+7",13,10
    db "TCM_INSERTITEMW equ TCM_FIRST+62",13,10
    db "TCM_DELETEITEM equ TCM_FIRST+8",13,10
    db "TCM_DELETEALLITEMS equ TCM_FIRST+9",13,10
    db "TCM_GETITEMRECT equ TCM_FIRST+10",13,10
    db "TCM_GETCURSEL equ TCM_FIRST+11",13,10
    db "TCM_SETCURSEL equ TCM_FIRST+12",13,10
    db "TCM_HITTEST equ TCM_FIRST+13",13,10
    db "TCM_SETITEMEXTRA equ TCM_FIRST+14",13,10
    db "TCM_ADJUSTRECT equ TCM_FIRST+40",13,10
    db "TCM_SETITEMSIZE equ TCM_FIRST+41",13,10
    db "TCM_REMOVEIMAGE equ TCM_FIRST+42",13,10
    db "TCM_SETPADDING equ TCM_FIRST+43",13,10
    db "TCM_GETROWCOUNT equ TCM_FIRST+44",13,10
    db "TCM_GETTOOLTIPS equ TCM_FIRST+45",13,10
    db "TCM_SETTOOLTIPS equ TCM_FIRST+46",13,10
    db "TCM_GETCURFOCUS equ TCM_FIRST+47",13,10
    db "TCM_SETCURFOCUS equ TCM_FIRST+48",13,10
    db "TCM_SETMINTABWIDTH equ TCM_FIRST+49",13,10
    db "TCM_DESELECTALL equ TCM_FIRST+50",13,10
    db "TCM_HIGHLIGHTITEM equ TCM_FIRST+51",13,10
    db "TCM_SETEXTENDEDSTYLE equ TCM_FIRST+52",13,10
    db "TCM_GETEXTENDEDSTYLE equ TCM_FIRST+53",13,10
    db "TCM_SETUNICODEFORMAT equ CCM_SETUNICODEFORMAT",13,10
    db "TCM_GETUNICODEFORMAT equ CCM_GETUNICODEFORMAT",13,10
    db 13,10
    db "TCN_FIRST equ 0-550",13,10
    db "TCN_LAST equ 0-580",13,10
    db "TCN_KEYDOWN equ TCN_FIRST - 0",13,10
    db "TCN_SELCHANGE equ TCN_FIRST - 1",13,10
    db "TCN_SELCHANGING equ TCN_FIRST - 2",13,10
    db "TCN_GETOBJECT equ TCN_FIRST - 3",13,10
    db "TCN_FOCUSCHANGE equ TCN_FIRST - 4",13,10
    db 13,10
    db "; ----------------------",13,10
    db "; tab control structures",13,10
    db "; ----------------------",13,10
    db "  NMTCKEYDOWN STRUCT QWORD",13,10
    db "    hdr NMHDR <>",13,10
    db "    wVKey dw ?",13,10
    db "    flags dd ?",13,10
    db "  NMTCKEYDOWN ENDS",13,10
    db 13,10
    db "  TCHITTESTINFO STRUCT QWORD",13,10
    db "    pt POINT <>",13,10
    db "    flags dd ?",13,10
    db "  TCHITTESTINFO ENDS",13,10
    db 13,10
    db "  TCITEM STRUCT QWORD",13,10
    db "    _mask dd ?",13,10
    db "    dwState dd ?",13,10
    db "    dwStateMask dd ?",13,10
    db "    pszText dq ?",13,10
    db "    cchTextMax dd ?",13,10
    db "    iImage dd ?",13,10
    db "    lParam dq ?",13,10
    db "  TCITEM ENDS",13,10
    db 13,10
    db "  TCITEMHEADER STRUCT QWORD",13,10
    db "    _mask dd ?",13,10
    db "    lpReserved1 dd ?",13,10
    db "    lpReserved2 dd ?",13,10
    db "    pszText dq ?",13,10
    db "    cchTextMax dd ?",13,10
    db "    iImage dd ?",13,10
    db "  TCITEMHEADER ENDS",13,10
    db 13,10
    db "; ------------------",13,10
    db "; track bar messages",13,10
    db "; ------------------",13,10
    db "TBM_GETPOS equ WM_USER",13,10
    db "TBM_GETRANGEMIN equ WM_USER+1",13,10
    db "TBM_GETRANGEMAX equ WM_USER+2",13,10
    db "TBM_GETTIC equ WM_USER+3",13,10
    db "TBM_SETTIC equ WM_USER+4",13,10
    db "TBM_SETPOS equ WM_USER+5",13,10
    db "TBM_SETRANGE equ WM_USER+6",13,10
    db "TBM_SETRANGEMIN equ WM_USER+7",13,10
    db "TBM_SETRANGEMAX equ WM_USER+8",13,10
    db "TBM_CLEARTICS equ WM_USER+9",13,10
    db "TBM_SETSEL equ WM_USER+10",13,10
    db "TBM_SETSELSTART equ WM_USER+11",13,10
    db "TBM_SETSELEND equ WM_USER+12",13,10
    db "TBM_GETPTICS equ WM_USER+14",13,10
    db "TBM_GETTICPOS equ WM_USER+15",13,10
    db "TBM_GETNUMTICS equ WM_USER+16",13,10
    db "TBM_GETSELSTART equ WM_USER+17",13,10
    db "TBM_GETSELEND equ WM_USER+18",13,10
    db "TBM_CLEARSEL equ WM_USER+19",13,10
    db "TBM_SETTICFREQ equ WM_USER+20",13,10
    db "TBM_SETPAGESIZE equ WM_USER+21",13,10
    db "TBM_GETPAGESIZE equ WM_USER+22",13,10
    db "TBM_SETLINESIZE equ WM_USER+23",13,10
    db "TBM_GETLINESIZE equ WM_USER+24",13,10
    db "TBM_GETTHUMBRECT equ WM_USER+25",13,10
    db "TBM_GETCHANNELRECT equ WM_USER+26",13,10
    db "TBM_SETTHUMBLENGTH equ WM_USER+27",13,10
    db "TBM_GETTHUMBLENGTH equ WM_USER+28",13,10
    db "TBM_SETTOOLTIPS equ WM_USER+29",13,10
    db "TBM_GETTOOLTIPS equ WM_USER+30",13,10
    db "TBM_SETTIPSIDE equ WM_USER+31",13,10
    db "TBM_SETBUDDY equ WM_USER+32",13,10
    db "TBM_GETBUDDY equ WM_USER+33",13,10
    db "TBM_SETPOSNOTIFY equ WM_USER+34",13,10
    db "TBM_SETUNICODEFORMAT equ CCM_SETUNICODEFORMAT",13,10
    db "TBM_GETUNICODEFORMAT equ CCM_GETUNICODEFORMAT",13,10
    db 13,10
    db "; ------------------",13,10
    db "; tree view messages",13,10
    db "; ------------------",13,10
    db "TVM_INSERTITEM equ TV_FIRST+0",13,10
    db "TVM_INSERTITEMW equ TV_FIRST+50",13,10
    db "TVM_DELETEITEM equ TV_FIRST+1",13,10
    db "TVM_EXPAND equ TV_FIRST+2",13,10
    db "TVM_GETITEMRECT equ TV_FIRST+4",13,10
    db "TVM_GETCOUNT equ TV_FIRST+5",13,10
    db "TVM_GETINDENT equ TV_FIRST+6",13,10
    db "TVM_SETINDENT equ TV_FIRST+7",13,10
    db "TVM_GETIMAGELIST equ TV_FIRST+8",13,10
    db "TVM_SETIMAGELIST equ TV_FIRST+9",13,10
    db "TVM_GETNEXTITEM equ TV_FIRST+10",13,10
    db "TVM_SELECTITEM equ TV_FIRST+11",13,10
    db "TVM_GETITEM equ TV_FIRST+12",13,10
    db "TVM_GETITEMW equ TV_FIRST+62",13,10
    db "TVM_SETITEM equ TV_FIRST+13",13,10
    db "TVM_SETITEMW equ TV_FIRST+63",13,10
    db "TVM_EDITLABEL equ TV_FIRST+14",13,10
    db "TVM_EDITLABELW equ TV_FIRST+65",13,10
    db "TVM_GETEDITCONTROL equ TV_FIRST+15",13,10
    db "TVM_GETVISIBLECOUNT equ TV_FIRST+16",13,10
    db "TVM_HITTEST equ TV_FIRST+17",13,10
    db "TVM_CREATEDRAGIMAGE equ TV_FIRST+18",13,10
    db "TVM_SORTCHILDREN equ TV_FIRST+19",13,10
    db "TVM_ENSUREVISIBLE equ TV_FIRST+20",13,10
    db "TVM_SORTCHILDRENCB equ TV_FIRST+21",13,10
    db "TVM_ENDEDITLABELNOW equ TV_FIRST+22",13,10
    db "TVM_GETISEARCHSTRING equ TV_FIRST+23",13,10
    db "TVM_GETISEARCHSTRINGW equ TV_FIRST+64",13,10
    db "TVM_SETTOOLTIPS equ TV_FIRST+24",13,10
    db "TVM_GETTOOLTIPS equ TV_FIRST+25",13,10
    db "TVM_SETINSERTMARK equ TV_FIRST+26",13,10
    db "TVM_SETUNICODEFORMAT equ CCM_SETUNICODEFORMAT",13,10
    db "TVM_GETUNICODEFORMAT equ CCM_GETUNICODEFORMAT",13,10
    db "TVM_SETITEMHEIGHT equ TV_FIRST+27",13,10
    db "TVM_GETITEMHEIGHT equ TV_FIRST+28",13,10
    db "TVM_SETBKCOLOR equ TV_FIRST+29",13,10
    db "TVM_SETTEXTCOLOR equ TV_FIRST+30",13,10
    db "TVM_GETBKCOLOR equ TV_FIRST+31",13,10
    db "TVM_GETTEXTCOLOR equ TV_FIRST+32",13,10
    db "TVM_SETSCROLLTIME equ TV_FIRST+33",13,10
    db "TVM_GETSCROLLTIME equ TV_FIRST+34",13,10
    db "TVM_SETINSERTMARKCOLOR equ TV_FIRST+37",13,10
    db "TVM_GETINSERTMARKCOLOR equ TV_FIRST+38",13,10
    db "TVM_GETITEMSTATE equ TV_FIRST+39",13,10
    db "TVM_SETLINECOLOR equ TV_FIRST+40",13,10
    db "TVM_GETLINECOLOR equ TV_FIRST+41",13,10
    db "TVM_MAPACCIDTOHTREEITEM equ TV_FIRST+42",13,10
    db "TVM_MAPHTREEITEMTOACCID equ TV_FIRST+43",13,10
    db "TVM_SETEXTENDEDSTYLE equ TV_FIRST+44",13,10
    db "TVM_GETEXTENDEDSTYLE equ TV_FIRST+45",13,10
    db "TVM_SETAUTOSCROLLINFO equ TV_FIRST+59",13,10
    db "TVM_GETSELECTEDCOUNT equ TV_FIRST+70",13,10
    db "TVM_SHOWINFOTIP equ TV_FIRST+71",13,10
    db "TVM_GETITEMPARTRECT equ TV_FIRST+72",13,10
    db 13,10
    db "TVN_FIRST equ 0-400",13,10
    db "TVN_LAST equ 0-499",13,10
    db "TVN_SELCHANGING equ TVN_FIRST-1",13,10
    db "TVN_SELCHANGINGW equ TVN_FIRST-50",13,10
    db "TVN_SELCHANGED equ TVN_FIRST-2",13,10
    db "TVN_SELCHANGEDW equ TVN_FIRST-51",13,10
    db "TVN_GETDISPINFO equ TVN_FIRST-3",13,10
    db "TVN_GETDISPINFOW equ TVN_FIRST-52",13,10
    db "TVN_SETDISPINFO equ TVN_FIRST-4",13,10
    db "TVN_SETDISPINFOW equ TVN_FIRST-53",13,10
    db "TVN_ITEMEXPANDING equ TVN_FIRST-5",13,10
    db "TVN_ITEMEXPANDINGW equ TVN_FIRST-54",13,10
    db "TVN_ITEMEXPANDED equ TVN_FIRST-6",13,10
    db "TVN_ITEMEXPANDEDW equ TVN_FIRST-55",13,10
    db "TVN_BEGINDRAG equ TVN_FIRST-7",13,10
    db "TVN_BEGINDRAGW equ TVN_FIRST-56",13,10
    db "TVN_BEGINRDRAG equ TVN_FIRST-8",13,10
    db "TVN_BEGINRDRAGW equ TVN_FIRST-57",13,10
    db "TVN_DELETEITEM equ TVN_FIRST-9",13,10
    db "TVN_DELETEITEMW equ TVN_FIRST-58",13,10
    db "TVN_BEGINLABELEDIT equ TVN_FIRST-10",13,10
    db "TVN_BEGINLABELEDITW equ TVN_FIRST-59",13,10
    db "TVN_ENDLABELEDIT equ TVN_FIRST-11",13,10
    db "TVN_ENDLABELEDITW equ TVN_FIRST-60",13,10
    db "TVN_KEYDOWN equ TVN_FIRST-12",13,10
    db "TVN_GETINFOTIP equ TVN_FIRST-13",13,10
    db "TVN_GETINFOTIPW equ TVN_FIRST-14",13,10
    db "TVN_SINGLEEXPAND equ TVN_FIRST-15",13,10
    db "TVN_ITEMCHANGING equ TVN_FIRST-16",13,10
    db "TVN_ITEMCHANGINGW equ TVN_FIRST-17",13,10
    db "TVN_ITEMCHANGED equ TVN_FIRST-18",13,10
    db "TVN_ITEMCHANGEDW equ TVN_FIRST-19",13,10
    db "TVN_ASYNCDRAW equ TVN_FIRST-20",13,10
    db 13,10
    db "; --------------------",13,10
    db "; tree view structures",13,10
    db "; --------------------",13,10
    db "  TVITEM STRUCT QWORD",13,10
    db "    _mask dd ?",13,10
    db "    hItem dq ?",13,10
    db "    state dd ?",13,10
    db "    stateMask dd ?",13,10
    db "    pszText dq ?",13,10
    db "    cchTextMax dd ?",13,10
    db "    iImage dd ?",13,10
    db "    iSelectedImage dd ?",13,10
    db "    cChildren dd ?",13,10
    db "    lParam dq ?",13,10
    db "  TVITEM ENDS",13,10
    db 13,10
    db "  TVITEMEX STRUCT QWORD",13,10
    db "    _mask dd ?",13,10
    db "    hItem dq ?",13,10
    db "    state dd ?",13,10
    db "    stateMask dd ?",13,10
    db "    pszText dq ?",13,10
    db "    cchTextMax dd ?",13,10
    db "    iImage dd ?",13,10
    db "    iSelectedImage dd ?",13,10
    db "    cChildren dd ?",13,10
    db "    lParam dq ?",13,10
    db "    iIntegral dd ?",13,10
    db "  TVITEMEX ENDS",13,10
    db 13,10
    db "  NMTREEVIEW STRUCT QWORD",13,10
    db "    hdr NMHDR <>",13,10
    db "    action dd ?",13,10
    db "    itemOld TVITEM <>",13,10
    db "    itemNew TVITEM <>",13,10
    db "    ptDrag POINT <>",13,10
    db "  NMTREEVIEW ENDS",13,10
    db 13,10
    db "  NMTVCUSTOMDRAW STRUCT QWORD",13,10
    db "    nmcd NMCUSTOMDRAW <>",13,10
    db "    clrText dd ?",13,10
    db "    clrTextBk dd ?",13,10
    db "    iLevel dd ?",13,10
    db "  NMTVCUSTOMDRAW ENDS",13,10
    db 13,10
    db "  NMTVDISPINFO STRUCT QWORD",13,10
    db "    hdr NMHDR <>",13,10
    db "    item TVITEM <>",13,10
    db "  NMTVDISPINFO ENDS",13,10
    db 13,10
    db "  NMTVGETINFOTIP STRUCT QWORD",13,10
    db "    hdr NMHDR <>",13,10
    db "    pszText dq ?",13,10
    db "    cchTextMax dd ?",13,10
    db "    hItem dq ?",13,10
    db "    lParam dq ?",13,10
    db "  NMTVGETINFOTIP ENDS",13,10
    db 13,10
    db "  NMTVKEYDOWN STRUCT QWORD",13,10
    db "    hdr NMHDR <>",13,10
    db "    wVKey dw ?",13,10
    db "    flags dd ?",13,10
    db "  NMTVKEYDOWN ENDS",13,10
    db 13,10
    db "  TVHITTESTINFO STRUCT QWORD",13,10
    db "    pt POINT <>",13,10
    db "    flags dd ?",13,10
    db "    hItem dq ?",13,10
    db "  TVHITTESTINFO ENDS",13,10
    db 13,10
    db "  TVINSERTSTRUCT STRUCT QWORD",13,10
    db "    hParent dq ?",13,10
    db "    hInsertAfter dq ?",13,10
    db "      UNION DUMMYUNIONNAME",13,10
    db "      itemex TVITEMEX <>",13,10
    db "      item TVITEM <>",13,10
    db "      ENDS",13,10
    db "  TVINSERTSTRUCT ENDS",13,10
    db 13,10
    db "  TVSORTCB STRUCT QWORD",13,10
    db "    hParent dq ?",13,10
    db "    lpfnCompare dq ?",13,10
    db "    lParam dq ?",13,10
    db "  TVSORTCB ENDS",13,10
    db 13,10
    db "; -------------------",13,10
    db "; comboboxex messages",13,10
    db "; -------------------",13,10
    db "CBEM_INSERTITEMA equ WM_USER+1",13,10
    db "CBEM_SETIMAGELIST equ WM_USER+2",13,10
    db "CBEM_GETIMAGELIST equ WM_USER+3",13,10
    db "CBEM_GETITEMA equ WM_USER+4",13,10
    db "CBEM_SETITEMA equ WM_USER+5",13,10
    db "CBEM_DELETEITEM equ CB_DELETESTRING",13,10
    db "CBEM_GETCOMBOCONTROL equ WM_USER+6",13,10
    db "CBEM_GETEDITCONTROL equ WM_USER+7",13,10
    db "CBEM_SETEXSTYLE equ WM_USER+8",13,10
    db "CBEM_SETEXTENDEDSTYLE equ WM_USER+14",13,10
    db "CBEM_GETEXSTYLE equ WM_USER+9",13,10
    db "CBEM_GETEXTENDEDSTYLE equ WM_USER+9",13,10
    db "CBEM_SETUNICODEFORMAT equ CCM_SETUNICODEFORMAT",13,10
    db "CBEM_GETUNICODEFORMAT equ CCM_GETUNICODEFORMAT",13,10
    db "CBEM_SETEXSTYLE equ WM_USER+8",13,10
    db "CBEM_GETEXSTYLE equ WM_USER+9",13,10
    db "CBEM_HASEDITCHANGED equ WM_USER+10",13,10
    db "CBEM_INSERTITEMW equ WM_USER+11",13,10
    db "CBEM_SETITEMW equ WM_USER+12",13,10
    db "CBEM_GETITEMW equ WM_USER+13",13,10
    db "CBEM_SETWINDOWTHEME equ CCM_SETWINDOWTHEME",13,10
    db 13,10
    db "CBEN_FIRST equ 0-800",13,10
    db "CBEN_LAST equ 0-830",13,10
    db "CBEN_GETDISPINFO equ CBEN_FIRST - 0",13,10
    db "CBEN_GETDISPINFO equ CBEN_FIRST - 0",13,10
    db "CBEN_INSERTITEM equ CBEN_FIRST - 1",13,10
    db "CBEN_DELETEITEM equ CBEN_FIRST - 2",13,10
    db "CBEN_BEGINEDIT equ CBEN_FIRST - 4",13,10
    db "CBEN_ENDEDIT equ CBEN_FIRST - 5",13,10
    db "CBEN_ENDEDITW equ CBEN_FIRST - 6",13,10
    db "CBEN_GETDISPINFOW equ CBEN_FIRST - 7",13,10
    db "CBEN_DRAGBEGIN equ CBEN_FIRST - 8",13,10
    db "CBEN_DRAGBEGINW equ CBEN_FIRST - 9",13,10
    db 13,10
    db "; ---------------------",13,10
    db "; comboboxex structures",13,10
    db "; ---------------------",13,10
    db "  COMBOBOXEXITEM STRUCT QWORD",13,10
    db "    _mask dd ?",13,10
    db "    iItem dd ?",13,10
    db "    pszText dq ?",13,10
    db "    cchTextMax dd ?",13,10
    db "    iImage dd ?",13,10
    db "    iSelectedImage dd ?",13,10
    db "    iOverlay dd ?",13,10
    db "    iIndent dd ?",13,10
    db "    lParam dq ?",13,10
    db "  COMBOBOXEXITEM ENDS",13,10
    db 13,10
    db "  NMCBEDRAGBEGIN STRUCT QWORD",13,10
    db "    hdr NMHDR <>",13,10
    db "    iItemid dd ?",13,10
    db "    szText db CBEMAXSTRLEN dup (?)",13,10
    db "  NMCBEDRAGBEGIN ENDS",13,10
    db 13,10
    db "  NMCBEENDEDIT STRUCT QWORD",13,10
    db "    hdr NMHDR <>",13,10
    db "    fChanged dd ?",13,10
    db "    iNewSelection dd ?",13,10
    db "    szText db CBEMAXSTRLEN dup (?)",13,10
    db "    iWhy dd ?",13,10
    db "  NMCBEENDEDIT ENDS",13,10
    db 13,10
    db "  NMCOMBOBOXEX STRUCT QWORD",13,10
    db "    hdr NMHDR <>",13,10
    db "    ceItem COMBOBOXEXITEM <>",13,10
    db "  NMCOMBOBOXEX ENDS",13,10
    db 13,10
    db "; ----------------",13,10
    db "; tooltip messages",13,10
    db "; ----------------",13,10
    db "TTM_ACTIVATE equ WM_USER+1",13,10
    db "TTM_SETDELAYTIME equ WM_USER+3",13,10
    db "TTM_ADDTOOL equ WM_USER+4",13,10
    db "TTM_ADDTOOLW equ WM_USER+50",13,10
    db "TTM_DELTOOL equ WM_USER+5",13,10
    db "TTM_DELTOOLW equ WM_USER+51",13,10
    db "TTM_NEWTOOLRECT equ WM_USER+6",13,10
    db "TTM_NEWTOOLRECTW equ WM_USER+52",13,10
    db "TTM_RELAYEVENT equ WM_USER+7",13,10
    db "TTM_GETTOOLINFO equ WM_USER+8",13,10
    db "TTM_GETTOOLINFOW equ WM_USER+53",13,10
    db "TTM_SETTOOLINFO equ WM_USER+9",13,10
    db "TTM_SETTOOLINFOW equ WM_USER+54",13,10
    db "TTM_HITTEST equ WM_USER +10",13,10
    db "TTM_HITTESTW equ WM_USER +55",13,10
    db "TTM_GETTEXT equ WM_USER +11",13,10
    db "TTM_GETTEXTW equ WM_USER +56",13,10
    db "TTM_UPDATETIPTEXT equ WM_USER +12",13,10
    db "TTM_UPDATETIPTEXTW equ WM_USER +57",13,10
    db "TTM_GETTOOLCOUNT equ WM_USER +13",13,10
    db "TTM_ENUMTOOLS equ WM_USER +14",13,10
    db "TTM_ENUMTOOLSW equ WM_USER +58",13,10
    db "TTM_GETCURRENTTOOL equ WM_USER+15",13,10
    db "TTM_GETCURRENTTOOLW equ WM_USER+59",13,10
    db "TTM_WINDOWFROMPOINT equ WM_USER+16",13,10
    db "TTM_TRACKACTIVATE equ WM_USER+17",13,10
    db "TTM_TRACKPOSITION equ WM_USER+18",13,10
    db "TTM_SETTIPBKCOLOR equ WM_USER+19",13,10
    db "TTM_SETTIPTEXTCOLOR equ WM_USER+20",13,10
    db "TTM_GETDELAYTIME equ WM_USER+21",13,10
    db "TTM_GETTIPBKCOLOR equ WM_USER+22",13,10
    db "TTM_GETTIPTEXTCOLOR equ WM_USER+23",13,10
    db "TTM_SETMAXTIPWIDTH equ WM_USER+24",13,10
    db "TTM_GETMAXTIPWIDTH equ WM_USER+25",13,10
    db "TTM_SETMARGIN equ WM_USER+26",13,10
    db "TTM_GETMARGIN equ WM_USER+27",13,10
    db "TTM_POP equ WM_USER+28",13,10
    db "TTM_UPDATE equ WM_USER+29",13,10
    db "TTM_GETBUBBLESIZE equ WM_USER+30",13,10
    db "TTM_ADJUSTRECT equ WM_USER+31",13,10
    db "TTM_SETTITLE equ WM_USER+32",13,10
    db "TTM_SETTITLEW equ WM_USER+33",13,10
    db "TTM_POPUP equ WM_USER+34",13,10
    db "TTM_GETTITLE equ WM_USER+35",13,10
    db "TTM_SETWINDOWTHEME equ CCM_SETWINDOWTHEME",13,10
    db 13,10
    db "TTN_FIRST equ 0-520",13,10
    db "TTN_LAST equ 0-549",13,10
    db "TTN_GETDISPINFO equ TTN_FIRST - 0",13,10
    db "TTN_GETDISPINFOW equ TTN_FIRST - 10",13,10
    db "TTN_SHOW equ TTN_FIRST - 1",13,10
    db "TTN_POP equ TTN_FIRST - 2",13,10
    db "TTN_LINKCLICK equ TTN_FIRST - 3",13,10
    db "TTN_NEEDTEXT equ TTN_GETDISPINFO",13,10
    db "TTN_NEEDTEXTA equ TTN_GETDISPINFO",13,10
    db "TTN_NEEDTEXTW equ TTN_GETDISPINFOW",13,10
    db 13,10
    db "; ------------------",13,10
    db "; tooltip structures",13,10
    db "; ------------------",13,10
    db "  NMTTCUSTOMDRAW STRUCT QWORD",13,10
    db "    nmcd NMCUSTOMDRAW <>",13,10
    db "    uDrawFlags dd ?",13,10
    db "  NMTTCUSTOMDRAW ENDS",13,10
    db 13,10
    db "  NMTTDISPINFO STRUCT QWORD",13,10
    db "    hdr NMHDR <>",13,10
    db "    lpszText dq ?",13,10
    db "    szText db 80 dup (?)",13,10
    db "    hinst dq ?",13,10
    db "    uFlags dd ?",13,10
    db "    lParam dq ?",13,10
    db "  NMTTDISPINFO ENDS",13,10
    db 13,10
    db "  TOOLINFO STRUCT QWORD",13,10
    db "    cbSize dd ?",13,10
    db "    uFlags dd ?",13,10
    db "    hwnd dq ?",13,10
    db "    uId dq ?",13,10
    db "    rect RECT <>",13,10
    db "    hinst dq ?",13,10
    db "    lpszText dq ?",13,10
    db "    lParam dq ?",13,10
    db "  TOOLINFO ENDS",13,10
    db 13,10
    db "  TTHITTESTINFO STRUCT QWORD",13,10
    db "    hwnd dq ?",13,10
    db "    pt POINT <>",13,10
    db "    ti TOOLINFO <>",13,10
    db "  TTHITTESTINFO ENDS",13,10
    db 13,10,0

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    end
