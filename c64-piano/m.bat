@echo off
rem node freq.js > freq.lm
set name=piano
rem call asmproc -i %name%.lm -o %name%.asm -d KBD_SIEL
call asmproc -i %name%.lm -o %name%.asm
rem call asmproc -i %name%.lm -o %name%.asm -d DEBUG
dasm %name%.asm -o%name%.prg -l%name%.lst


