@echo off
rem === challenge 1 ===
rem call asmproc -i challenge1.lm -o challenge1.asm
rem dasm challenge1.asm -ochallenge1.prg -lchallenge1.lst

rem === challenge 1 ===
rem call asmproc -i challenge2-maze.lm -o challenge2-maze.asm
rem dasm challenge2-maze.asm -ochallenge2-maze.prg -lchallenge2-maze.lst

rem === challenge 2 ===
set name=challenge2-maze
call asmproc -i %name%.lm -o %name%.asm
dasm %name%.asm -o%name%.prg -l%name%.lst

set name=challenge2-mosquito
call asmproc -i %name%.lm -o %name%.asm
dasm %name%.asm -o%name%.prg -l%name%.lst

set name=challenge2-both
call asmproc -i %name%.lm -o %name%.asm
dasm %name%.asm -o%name%.prg -l%name%.lst
