:: ����� ������������� ����� �� �����
@echo off
:: ��������� ����������
set appname=%1

\masm64\bin64\ml64.exe /c %appname%.asm

\masm64\bin64\link.exe /SUBSYSTEM:CONSOLE /ENTRY:entry_point /nologo /LARGEADDRESSAWARE %appname%.obj
:: nologo - ���������� ��������� ���� ��� ������� ����������� � ����������� ��������� ��� ����������

:: ����� ������ ������ 
dir %appname%.*

:: �������� ����� *.obj
del %appname%.obj
pause