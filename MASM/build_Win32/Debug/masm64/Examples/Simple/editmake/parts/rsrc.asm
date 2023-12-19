; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    public rsrc_rc

    .data

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

  rsrc_rc \
    db "// *************************************************************************************************",13,10
    db 13,10
    db "#include ",34,"\masm32\include64\resource.h",34,13,10
    db 13,10
    db "// *************************************************************************************************",13,10
    db 13,10
    db "1 24 ",34,"manifest.xml",34,"    // manifest file",13,10
    db 13,10
    db "10 ICON MOVEABLE PURE LOADONCALL DISCARDABLE ",34,"icon.ico",34,13,10
    db "20 BITMAP MOVEABLE PURE LOADONCALL DISCARDABLE ",34,"toolbar.bmp",34,13,10
    db "30 BITMAP MOVEABLE PURE LOADONCALL DISCARDABLE ",34,"gradient.bmp",34,13,10
    db 13,10
    db "100	MENUEX MOVEABLE IMPURE LOADONCALL DISCARDABLE",13,10
    db "BEGIN",13,10
    db "    POPUP ",34,"&File",34,", , , 0",13,10
    db "    BEGIN",13,10
    db "        MENUITEM ",34,"&New",34,",  101",13,10
    db "        MENUITEM ",34,34,", , 0x0800 /*MFT_SEPARATOR*/",13,10
    db "        MENUITEM ",34,"&Open",34,", 102",13,10
    db "        MENUITEM ",34,34,", , 0x0800 /*MFT_SEPARATOR*/",13,10
    db "        MENUITEM ",34,"&Save",34,", 103",13,10
    db "        MENUITEM ",34,34,", , 0x0800 /*MFT_SEPARATOR*/",13,10
    db "        MENUITEM ",34,"&Exit",34,", 125",13,10
    db "    END",13,10
    db 13,10
    db "    POPUP ",34,"&Edit",34,", , , 0",13,10
    db "    BEGIN",13,10
    db "        MENUITEM ",34,"&Undo\tCtrl+Z",34,", 200",13,10
    db "        MENUITEM ",34,"&Redo\tCtrl+Y",34,", 201",13,10
    db "        MENUITEM ",34,34,", , 0x0800 /*MFT_SEPARATOR*/",13,10
    db "        MENUITEM ",34,"&Cut\tCtrl+X",34,", 202",13,10
    db "        MENUITEM ",34,"Copy\tCtrl+C",34,", 203",13,10
    db "        MENUITEM ",34,"&Paste\tCtrl+V",34,", 204",13,10
    db "        MENUITEM ",34,34,", , 0x0800 /*MFT_SEPARATOR*/",13,10
    db "        MENUITEM ",34,"Clear\tDel",34,", 205",13,10
    db "    END",13,10
    db 13,10
    db "    POPUP ",34,"&Help",34,", , , 0",13,10
    db "    BEGIN",13,10
    db "        MENUITEM ",34,"&About",34,", 300",13,10
    db "    END",13,10
    db "END",13,10
    db 13,10
    db "#include ",34,"dlgs.rc",34,13,10
    db 13,10
    db "// *************************************************************************************************",13,10
    db 13,10
    db "VS_VERSION_INFO VERSIONINFO",13,10
    db "FILEVERSION 1, 0, 0, 0",13,10
    db "PRODUCTVERSION 1, 0, 0, 0",13,10
    db "FILEOS VOS__WINDOWS32",13,10
    db "FILETYPE VFT_APP",13,10
    db "BEGIN",13,10
    db "  BLOCK ",34,"StringFileInfo",34,13,10
    db "  BEGIN",13,10
    db "    BLOCK ",34,"040904B0",34,13,10
    db "    BEGIN",13,10
    db "      VALUE ",34,"CompanyName",34,",      ",34,"The MASM32 SDK\000",34,13,10
    db "      VALUE ",34,"FileDescription",34,",  ",34,"Default 64 Bit Template\000",34,13,10
    db "      VALUE ",34,"FileVersion",34,",      ",34,"1.0\000",34,13,10
    db "      VALUE ",34,"InternalName",34,",     ",34,"xxxxxxxxxxxxxxxxxxxxxxxx\000",34,13,10
    db "      VALUE ",34,"OriginalFilename",34,", ",34,"xxxxxxxxxxxxxxxxxxxxxxxx.exe\000",34,13,10
    db "      VALUE ",34,"LegalCopyright",34,",   ",34,"\251 2016 The MASM32 SDK\000",34,13,10
    db "      VALUE ",34,"ProductName",34,",      ",34,"xxxxxxxxxxxxxxxxxxxxxxxx\000",34,13,10
    db "      VALUE ",34,"ProductVersion",34,",   ",34,"1.0\000",34,13,10
    db "    END",13,10
    db "  END",13,10
    db "  BLOCK ",34,"VarFileInfo",34,13,10
    db "  BEGIN",13,10
    db "    VALUE ",34,"Translation",34,", 0x409, 0x4B0",13,10
    db "  END",13,10
    db "END",13,10
    db 13,10
    db "// *************************************************************************************************",13,10
    db 13,10,0

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    end