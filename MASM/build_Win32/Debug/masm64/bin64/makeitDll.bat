:: ����� ������������� ����� �� �����
@echo off
:: ��������� ����������
set appname=%1

\masm64\bin64\ml64.exe /nologo /Cp /c %appname%.asm
:: nologo - ���������� ��������� ���� ��� ������� ����������� � ����������� ��������� ��� ����������
\masm64\bin64\link.exe  /SUBSYSTEM:WINDOWS /ENTRY:entry_point /DLL /DEF:Dll64-3-dll.def /NOENTRY  %appname%.obj
::NOENTRY ��������� ��� �������� ��������� ���������� DLL
:: ����� ������ ������ 
dir %appname%.*

:: �������� ����� *.obj
::del %appname%.obj
pause


