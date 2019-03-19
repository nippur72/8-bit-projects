@echo off

set SOURCE=3dfun_c64
set ASMPROC=call asmproc
rem set ASMPROC=node ..\..\asmproc\asmproc

rem normal basic V2

%ASMPROC% -i %SOURCE%.lm -o %SOURCE%.asm -t dasm 
if %errorlevel% == -1 goto fine

dasm %SOURCE%.asm -f1 -l%SOURCE%.lst -o%SOURCE%.prg
if %errorlevel% == -1 goto fine

rem basic V2 compiled with Mospeed

%ASMPROC% -i %SOURCE%.lm -o %SOURCE%_mospeed.asm -t dasm -d MOSPEED
if %errorlevel% == -1 goto fine

dasm %SOURCE%_mospeed.asm -f1 -l%SOURCE%_mospeed.lst -o%SOURCE%_mospeed.prg
if %errorlevel% == -1 goto fine

echo "ALL OK!"

:fine


