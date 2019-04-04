@echo off

set SOURCE=test
set ASMPROC=call asmproc
rem set ASMPROC=node ..\asmproc\asmproc

%ASMPROC% -i %SOURCE%.lm -o %SOURCE%.asm -t dasm -d VIC20
if %errorlevel% == -1 goto fine

dasm %SOURCE%.asm -f1 -l%SOURCE%.lst -o%SOURCE%.prg
if %errorlevel% == -1 goto fine

echo "ALL OK!"

:fine

