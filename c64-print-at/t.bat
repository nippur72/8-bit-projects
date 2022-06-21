@echo off

set SOURCE=printat
set ASMPROC=call asmproc
rem set ASMPROC=node ..\asmproc\asmproc

%ASMPROC% -i %SOURCE%.lm -o %SOURCE%.asm -t dasm 
if %errorlevel% == -1 goto fine

dasm %SOURCE%.asm -f1 -l%SOURCE%.lst -o%SOURCE%.prg
if %errorlevel% == -1 goto fine

echo "ALL OK!"

:fine



