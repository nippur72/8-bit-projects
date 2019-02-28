@echo off

set SOURCE=%1

call asmproc -i %SOURCE%.lm -o %SOURCE%.asm -t dasm 
rem node ..\..\asmproc\asmproc -i %SOURCE%.lm -o %SOURCE%.asm -t dasm 
if %errorlevel% == -1 goto fine
dasm %SOURCE%.asm -f1 -l%SOURCE%.lst -o%SOURCE%.prg
if %errorlevel% == -1 goto fine
dir %SOURCE%.prg 
:fine
