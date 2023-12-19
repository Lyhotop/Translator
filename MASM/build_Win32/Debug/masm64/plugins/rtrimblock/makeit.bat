@echo off

set appname=trimr

if exist %1.obj del %appname%.obj
if exist %1.exe del %appname%.dll
\masm32\bin64\ml64 /c %appname%.asm
\masm32\bin64\link /SUBSYSTEM:WINDOWS /entry:LibMain /DLL /DEF:%appname%.def %appname%.obj 
del %appname%.obj
del %appname%.exp
dir %appname%.*
copy %appname%.dll ..
pause
