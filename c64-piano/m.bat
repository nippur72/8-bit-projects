@echo off
set name=piano
call asmproc -i %name%.lm -o %name%.asm
dasm %name%.asm -o%name%.prg -l%name%.lst


