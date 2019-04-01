@echo off

set SOURCE=tapemon
rem set ASMPROC=call asmproc
set ASMPROC=node ..\..\asmproc\asmproc

REM VIC 20

%ASMPROC% -i %SOURCE%_vic20.lm -o %SOURCE%_vic20.asm -t dasm -d VIC20
if %errorlevel% == -1 goto fine

dasm %SOURCE%_vic20.asm -f1 -l%SOURCE%_vic20.lst -o%SOURCE%_vic20.prg
if %errorlevel% == -1 goto fine

REM C64

%ASMPROC% -i %SOURCE%_c64.lm -o %SOURCE%_c64.asm -t dasm -d C64
if %errorlevel% == -1 goto fine

dasm %SOURCE%_c64.asm -f1 -l%SOURCE%_c64.lst -o%SOURCE%_c64.prg
if %errorlevel% == -1 goto fine

echo "ALL OK!"

:fine



