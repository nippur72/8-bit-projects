@echo off

set SOURCE=timer
set ASMPROC=call asmproc
rem set ASMPROC=node ..\asmproc\asmproc

%ASMPROC% -i %SOURCE%.lm -o %SOURCE%_pal.asm -t dasm -d VIC20,PAL
if %errorlevel% == -1 goto fine
%ASMPROC% -i %SOURCE%.lm -o %SOURCE%_ntsc.asm -t dasm -d VIC20,NTSC
if %errorlevel% == -1 goto fine

dasm %SOURCE%_pal.asm -f1 -l%SOURCE%_pal.lst -o%SOURCE%_pal.prg
if %errorlevel% == -1 goto fine
dasm %SOURCE%_ntsc.asm -f1 -l%SOURCE%_ntsc.lst -o%SOURCE%_ntsc.prg
if %errorlevel% == -1 goto fine

echo "ALL OK!"

:fine



