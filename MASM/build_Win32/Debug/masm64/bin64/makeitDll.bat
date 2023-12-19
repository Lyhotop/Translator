:: вывод выполн€ющихс€ строк на экран
@echo off
:: установка переменной
set appname=%1

\masm64\bin64\ml64.exe /nologo /Cp /c %appname%.asm
:: nologo - подавление авторских прав при запуске компил€тора и отображени€ сообщений при компил€ции
\masm64\bin64\link.exe  /SUBSYSTEM:WINDOWS /ENTRY:entry_point /DLL /DEF:Dll64-3-dll.def /NOENTRY  %appname%.obj
::NOENTRY требуетс€ дл€ создани€ ресурсной библиотеки DLL
:: вывод списка файлов 
dir %appname%.*

:: удаление файла *.obj
::del %appname%.obj
pause


