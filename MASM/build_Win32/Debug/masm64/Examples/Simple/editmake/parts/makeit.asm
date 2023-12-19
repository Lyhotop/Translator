; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    public makeit_bat

    .data

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

  makeit_bat \
    db "@echo off",13,10
    db 13,10
    db "set appname=xxxxxxxxxxxxxxxxxxxxxxxx",13,10
    db 13,10
    db "if exist %1.obj del %appname%.obj",13,10
    db "if exist %1.exe del %appname%.exe",13,10
    db 13,10
    db "\masm32\bin64\rc.exe rsrc.rc",13,10
    db 13,10
    db "\masm32\bin64\ml64.exe /c /nologo %appname%.asm",13,10
    db 13,10
    db "\masm32\bin64\polink.exe /SUBSYSTEM:WINDOWS /ENTRY:entry_point /LARGEADDRESSAWARE %appname%.obj rsrc.res",13,10
    db 13,10
    db "dir %appname%.*",13,10
    db 13,10
    db "pause",13,10,0

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    end