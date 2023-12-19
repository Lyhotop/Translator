:: вывод выполн€ющихс€ строк на экран
@echo off
:: установка переменной
set appname=%1

\masm64\bin64\ml64.exe /c %appname%.asm

\masm64\bin64\link.exe /SUBSYSTEM:CONSOLE /ENTRY:entry_point /nologo /LARGEADDRESSAWARE %appname%.obj
:: nologo - подавление авторских прав при запуске компил€тора и отображени€ сообщений при компил€ции

:: вывод списка файлов 
dir %appname%.*

:: удаление файла *.obj
del %appname%.obj
pause