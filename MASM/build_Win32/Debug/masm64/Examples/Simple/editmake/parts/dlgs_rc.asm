; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    public dlgs_rc

    .data

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

  dlgs_rc \
    db "#define IDD_DLG1 100",13,10
    db "#define IDC_STC1 101",13,10
    db "#define IDC_BTN1 102",13,10
    db "#define IDC_STC2 103",13,10
    db 13,10
    db "IDD_DLG1 DIALOGEX 10,10,274,112",13,10
    db "CAPTION ",34," About Template Window",34,13,10
    db "FONT 8,",34,"MS Sans Serif",34,",0,0,0",13,10
    db "STYLE WS_POPUP|WS_VISIBLE|WS_CAPTION|WS_SYSMENU|DS_CENTER",13,10
    db "BEGIN",13,10
    db "  CONTROL ",34,"IDC_STC",34,",IDC_STC1,",34,"Static",34,",WS_CHILDWINDOW|WS_VISIBLE|SS_CENTERIMAGE|SS_ICON,6,6,56,46",13,10
    db "  CONTROL ",34,"OK",34,",IDC_BTN1,",34,"Button",34,",WS_CHILDWINDOW|WS_VISIBLE|WS_TABSTOP,108,86,56,14",13,10
    db "  CONTROL ",34,"Text",34,",IDC_STC2,",34,"Static",34,",WS_CHILDWINDOW|WS_VISIBLE,68,6,196,68",13,10
    db "END",13,10
    db 13,10
    db 13,10,0

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    end