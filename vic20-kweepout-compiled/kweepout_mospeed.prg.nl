SGNFAC = $DC2B
MEMARG = $DA8C
ARGADD = $D86A
ARGAND = $CFE9
ARGDIV = $DB14
FACMUL = $DA30
FACADD = $D867
FACLOG = $D9EA
FACSQR = $DF71
FACEXP = $DFED
FACABS = $DC58
FACSIN = $E268
FACCOS = $E261
FACTAN = $E2B1
FACATN = $E30B
FACSGN = $DC39
FACNOT = $CED4
FACRND = $E094
FACWORD = $D7F7
FACDIV = $DB0F
BASINT = $DCCC
FACPOW = $DF7B
FACSUB = $D853
FACOR = $CFE6
FACMEM = $DBD7
ARGFAC = $DBFC
FACARG = $DC0C
FACSTR = $DDDF
FACINT = $D1AA
RNDFAC = $DC1B
REALFAC = $DBA2
INTFAC = $D391
WRITETIS = $C9E7
GETTI = $DE68
GETTIME = $CF7E
COPYTIME = $CF87
TI2FAC = $CF84
CHROUT = $FFD2
PRINTSTRS = $CB25
VALS = $D7B5
CMPFAC = $DC5B
BYTEFAC = $D3A2
CRSRPOS = $FFF0
CRSRRIGHT = $CB3B
GETIN = $FFE4
INPUT = $C560
OPENCH = $F40A
CLOSECH = $F34A
CHKIN = $FFC6
CHKOUT = $FFC9
CLRCH = $FFCC
LOADXX = $F54F
SAVEXX = $F685
TWAIT = $F770
TMP_ZP = 105
TMP2_ZP = 107
TMP3_ZP = 34
;make sure that JUMP_TARGET's low can't be $ff
JUMP_TARGET = 69
TMP_REG=71
*=8192
TSX
STX SP_SAVE
; *** CODE ***
PROGRAMSTART:
JSR START
;
LINE_0:
;
LDY #30
STY 648
; Optimizer rule: Simple POKE/2
LDY #240
STY 36869
; Optimizer rule: Simple POKE/2
LDY #150
STY 36866
; Optimizer rule: Simple POKE/2
;
LINE_1:
;
LDX #4
dcloop1:
LDA  CONST_3,X
STA  VAR_V,X
DEX
BPL dcloop1
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #$0
STA $61
; Optimizer rule: Direct loading of 0/2
LDY #>Y_REG
LDX #<Y_REG
JSR FACMEM
; Optimizer rule: FAC into REG?, REG? into FAC (2)/3
LDX #<VAR_I
LDY #>VAR_I
STX A_REG
STY A_REG+1
JSR FACMEM
; Optimizer rule: Simplified loading of A/5
LDA #<FORLOOP0
STA JUMP_TARGET
LDA #>FORLOOP0
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP0:
JSR READNUMBER
LDA #<Y_REG
LDY #>Y_REG
; Real in (A/Y) to FAC
JSR REALFAC
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<VAR_V
LDY #>VAR_V
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_X
LDY #>VAR_X
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF4+1
STA MOVBSELF4+2
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF4:
STY $FFFF
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_0
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_0:
LDX #4
dcloop2:
LDA  CONST_8,X
STA  VAR_L,X
DEX
BPL dcloop2
; Optimizer rule: Direct copy of floats into mem/6
LDX #4
dcloop3:
LDA  CONST_9R,X
STA  VAR_D,X
DEX
BPL dcloop3
; Optimizer rule: Direct copy of floats into mem/6
LDA #0
STA  VAR_K
STA  VAR_K+1
; Optimizer rule: Simplified setting to 0/3
LDA #<CONST_10R
LDY #>CONST_10R
JSR REALFAC
LDA #<VAR_V
LDY #>VAR_V
JSR MEMARG
JSR FACSUB
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF5+1
STA MOVBSELF5+2
MOVBSELF5:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_QR
LDY #>VAR_QR
; FAC to (X/Y)
JSR FACMEM
;
LINE_2:
;
LDY #240
STY 36869
; Optimizer rule: Simple POKE/2
LDA #<CONST_11
LDY #>CONST_11
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_12R
LDY #>CONST_12R
STY TMP3_ZP+1
LDX #<Y_REG
LDY #>Y_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_13
LDY #>CONST_13
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_3:
;
LDA #<CONST_12R
LDY #>CONST_12R
STY TMP3_ZP+1
LDX #<Y_REG
LDY #>Y_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_14
LDY #>CONST_14
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDA #<CONST_12R
LDY #>CONST_12R
STY TMP3_ZP+1
LDX #<Y_REG
LDY #>Y_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_15
LDY #>CONST_15
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_4:
;
LDA #<CONST_12R
LDY #>CONST_12R
STY TMP3_ZP+1
LDX #<Y_REG
LDY #>Y_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR SPC
LDA #<CONST_16
LDY #>CONST_16
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDA #<CONST_17
LDY #>CONST_17
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_5:
;
LDA #<CONST_18
LDY #>CONST_18
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_6:
;
LDA #<CONST_19
LDY #>CONST_19
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
JSR GOSUB
JSR LINE_79
LDA #<CONST_20
LDY #>CONST_20
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
;
LINE_7:
;
LDX #4
dcloop4:
LDA  CONST_21,X
STA  VAR_J,X
DEX
BPL dcloop4
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_10R
LDY #>CONST_10R
JSR REALFAC
LDA #<VAR_J
LDY #>VAR_J
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF7+1
STA MOVBSELF7+2
LDA #$7F
MOVBSELF7:
STA $FFFF
LDA #<CONST_23R
LDY #>CONST_23R
JSR REALFAC
LDA #<VAR_J
LDY #>VAR_J
JSR MEMARG
JSR FACSUB
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF8+1
STA MOVBSELF8+2
MOVBSELF8:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_24R
LDY #>CONST_24R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG & FAC
JSR FASTAND
; Optimizer rule: Faster logic AND/1
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #$0
STA $61
; Optimizer rule: Direct loading of 0/2
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
ROL
BCS GT_GT0
LDA #0
JMP GT_SKIP0
GT_GT0:
LDA #$1
GT_SKIP0:
COMP_SKP1:
BEQ LINE_SKIP53
; Simplified conditional branch
;
LINE_NSKIP53:
;
JMP LINE_7
;
LINE_SKIP53:
;
;
LINE_8:
;
LDX #4
dcloop5:
LDA  CONST_25,X
STA  VAR_B,X
DEX
BPL dcloop5
; Optimizer rule: Direct copy of floats into mem/6
LDX #4
dcloop6:
LDA  CONST_26,X
STA  VAR_C,X
DEX
BPL dcloop6
; Optimizer rule: Direct copy of floats into mem/6
LDY #200
STY 36865
; Optimizer rule: Simple POKE/2
LDY #255
STY 36869
; Optimizer rule: Simple POKE/2
LDX #4
dcloop7:
LDA  CONST_29,X
STA  VAR_S,X
DEX
BPL dcloop7
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_9:
;
LDA #<CONST_30
LDY #>CONST_30
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #0
STA  VAR_I
STA  VAR_I+1
; Optimizer rule: Simplified setting to 0/3
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP1
STA JUMP_TARGET
LDA #>FORLOOP1
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP1:
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<VAR_S
LDY #>VAR_S
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF11+1
STA MOVBSELF11+2
LDA #$A0
MOVBSELF11:
STA $FFFF
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_32
LDY #>CONST_32
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF12+1
STA MOVBSELF12+2
LDA #$1
MOVBSELF12:
STA $FFFF
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_1
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_1:
LDA #<VAR_D
LDY #>VAR_D
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_I
LDY #>VAR_I
STX A_REG
STY A_REG+1
JSR FACMEM
; Optimizer rule: Simplified loading of A/5
LDA #<FORLOOP2
STA JUMP_TARGET
LDA #>FORLOOP2
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP2:
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_33
LDY #>CONST_33
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF13+1
STA MOVBSELF13+2
LDA #$3B
MOVBSELF13:
STA $FFFF
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_35
LDY #>CONST_35
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF14+1
STA MOVBSELF14+2
LDA #$3
MOVBSELF14:
STA $FFFF
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_2
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_2:
;
LINE_10:
;
LDA #<CONST_36
LDY #>CONST_36
JSR STROUTBRKWL
; Optimizer rule: Memory saving STROUTBRK/1
; Optimizer rule: STROUT + LINEBRK/1
LDA #<CONST_37R
LDY #>CONST_37R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #0
STA  VAR_I
STA  VAR_I+1
; Optimizer rule: Simplified setting to 0/3
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP3
STA JUMP_TARGET
LDA #>FORLOOP3
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP3:
LDA #<CONST_38
LDY #>CONST_38
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_3
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_3:
LDA #<CONST_39
LDY #>CONST_39
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_11:
;
LDA #0
STA  VAR_U
STA  VAR_U+1
; Optimizer rule: Simplified setting to 0/3
LDA #<CONST_40R
LDY #>CONST_40R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_I
LDY #>VAR_I
STX A_REG
STY A_REG+1
JSR FACMEM
; Optimizer rule: Simplified loading of A/5
LDA #<FORLOOP4
STA JUMP_TARGET
LDA #>FORLOOP4
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP4:
LDY #1
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_I
LDY #>VAR_I
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
TXA
LDY #>X_REG
; Optimizer rule: Value already in X/5
; Real in (A/Y) to FAC
JSR REALFAC
; FAC = FAC<<A
JSR SHL
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_41R
LDY #>CONST_41R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 36876
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG * FAC
JSR FACMUL
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDY #1
LDA #0
STY A_REG
STA A_REG+1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC = FAC<<A
JSR SHL
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_42R
LDY #>CONST_42R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
;
LINE_12:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_43R
LDY #>CONST_43R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG * FAC
JSR FACMUL
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_44R
LDY #>CONST_44R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG * FAC
JSR FACMUL
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_45
LDY #>CONST_45
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Y
LDY #>VAR_Y
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_L
LDY #>VAR_L
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG * FAC
JSR FACMUL
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDY #2
LDA #0
STY A_REG
STA A_REG+1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC = FAC<<A
JSR SHL
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<Y_REG
LDY #>Y_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_46R
LDY #>CONST_46R
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<Y_REG
LDY #>Y_REG
; Real in (A/Y) to FAC
JSR REALFAC
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG - FAC
JSR FACSUB
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_F
LDY #>VAR_F
; FAC to (X/Y)
JSR FACMEM
LDX #4
dcloop8:
LDA  CONST_4R,X
STA  VAR_G,X
DEX
BPL dcloop8
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_40R
LDY #>CONST_40R
JSR REALFAC
LDA #<VAR_F
LDY #>VAR_F
JSR CMPFAC
EQ_EQ1:
EQ_SKIP1:
COMP_SKP5:
BNE LINE_SKIP54
LINE_NSKIP54:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop9:
LDA  CONST_47R,X
STA  VAR_G,X
DEX
BPL dcloop9
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP54:
;
;
LINE_13:
;
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Z
LDY #>VAR_Z
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_31R
LDY #>CONST_31R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF16+1
STA MOVBSELF16+2
MOVBSELF16:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<Y_REG
LDY #>Y_REG
JSR FACMEM
; Optimizer rule: POP, REG0, VAR0/4
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ2
LDA #0
JMP EQ_SKIP2
EQ_EQ2:
LDA #$1
EQ_SKIP2:
COMP_SKP6:
BNE LINE_NSKIP55
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP55
;
LINE_NSKIP55:
;
LDA #<VAR_Z
LDY #>VAR_Z
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_F
LDY #>VAR_F
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF17+1
STA MOVBSELF17+2
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF17:
STY $FFFF
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_F
LDY #>VAR_F
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF18+1
STA MOVBSELF18+2
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF18:
STY $FFFF
LDA #<VAR_C
LDY #>VAR_C
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_G
LDY #>VAR_G
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF19+1
STA MOVBSELF19+2
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF19:
STY $FFFF
LDA #<VAR_C
LDY #>VAR_C
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_G
LDY #>VAR_G
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF20+1
STA MOVBSELF20+2
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF20:
STY $FFFF
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_U
LDY #>VAR_U
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP55:
;
;
LINE_14:
;
LDA #<CONST_37R
LDY #>CONST_37R
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG - FAC
JSR FACSUB
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Z
LDY #>VAR_Z
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_31R
LDY #>CONST_31R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_Z
LDY #>VAR_Z
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF21+1
STA MOVBSELF21+2
MOVBSELF21:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<Y_REG
LDY #>Y_REG
JSR FACMEM
; Optimizer rule: POP, REG0, VAR0/4
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ3
LDA #0
JMP EQ_SKIP3
EQ_EQ3:
LDA #$1
EQ_SKIP3:
COMP_SKP7:
BNE LINE_NSKIP56
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP56
;
LINE_NSKIP56:
;
LDA #<VAR_Z
LDY #>VAR_Z
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_F
LDY #>VAR_F
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF22+1
STA MOVBSELF22+2
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF22:
STY $FFFF
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_F
LDY #>VAR_F
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF23+1
STA MOVBSELF23+2
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF23:
STY $FFFF
LDA #<VAR_C
LDY #>VAR_C
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_G
LDY #>VAR_G
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF24+1
STA MOVBSELF24+2
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF24:
STY $FFFF
LDA #<VAR_C
LDY #>VAR_C
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_G
LDY #>VAR_G
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF25+1
STA MOVBSELF25+2
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF25:
STY $FFFF
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_U
LDY #>VAR_U
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP56:
;
;
LINE_15:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_4
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_4:
;
LINE_16:
;
LDX #4
dcloop10:
LDA  CONST_27R,X
STA  VAR_Y,X
DEX
BPL dcloop10
; Optimizer rule: Direct copy of floats into mem/6
LDA #0
STA  VAR_E
STA  VAR_E+1
; Optimizer rule: Simplified setting to 0/3
LDX #4
dcloop11:
LDA  CONST_48,X
STA  VAR_Z,X
DEX
BPL dcloop11
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_17:
;
LDA #<CONST_48
LDY #>CONST_48
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR MEMARG
JSR FACSUB
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_E
LDY #>VAR_E
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_E
LDY #>VAR_E
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Y
LDY #>VAR_Y
; FAC to (X/Y)
JSR FACMEM
LDA #$0
STA $61
; Optimizer rule: Direct loading of 0/2
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ4
ROL
BCC LT_LT4
LT_LT_EQ4:
LDA #0
JMP LT_SKIP4
LT_LT4:
LDA #$1
LT_SKIP4:
COMP_SKP9:
BNE LINE_NSKIP57
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP57
;
LINE_NSKIP57:
;
LDA #0
STA  VAR_Y
STA  VAR_Y+1
; Optimizer rule: Simplified setting to 0/3
LDA #<VAR_E
LDY #>VAR_E
JSR REALFAC
LDA #<CONST_49
LDY #>CONST_49
JSR MEMARG
JSR FACMUL
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_E
LDY #>VAR_E
; FAC to (X/Y)
JSR FACMEM
LDY #2
LDA #0
STY A_REG
STA A_REG+1
LDA #<VAR_Z
LDY #>VAR_Z
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
TXA
LDY #>X_REG
; Optimizer rule: Value already in X/5
; Real in (A/Y) to FAC
JSR REALFAC
; FAC = FAC<<A
JSR SHL
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Z
LDY #>VAR_Z
; FAC to (X/Y)
JSR FACMEM
LDY #140
STY 36877
; Optimizer rule: Simple POKE/2
LDA #<CONST_48
LDY #>CONST_48
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ5
ROL
BCC LT_LT5
LT_LT_EQ5:
LDA #0
JMP LT_SKIP5
LT_LT5:
LDA #$1
LT_SKIP5:
COMP_SKP10:
BEQ LINE_SKIP58
; Simplified conditional branch
;
LINE_NSKIP58:
;
JMP LINE_19
;
LINE_SKIP58:
;
;
LINE_SKIP57:
;
;
LINE_18:
;
LDA #<VAR_Y
LDY #>VAR_Y
JSR REALFAC
LDA #<VAR_QR
LDY #>VAR_QR
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 36865
LDA #<VAR_Y
LDY #>VAR_Y
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR FACMUL
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_41R
LDY #>CONST_41R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 36876
LDA #$0
STA $61
; Optimizer rule: Direct loading of 0/2
; FAC to integer in Y/A
JSR FACWORD
STY 36877
JMP LINE_17
;
LINE_19:
;
LDA #$0
STA $61
; Optimizer rule: Direct loading of 0/2
; FAC to integer in Y/A
JSR FACWORD
STY 36876
LDA #$0
STA $61
; Optimizer rule: Direct loading of 0/2
; FAC to integer in Y/A
JSR FACWORD
STY 36877
LDX #4
dcloop12:
LDA  CONST_51R,X
STA  VAR_E,X
DEX
BPL dcloop12
; Optimizer rule: Direct copy of floats into mem/6
LDA #0
STA  VAR_R
STA  VAR_R+1
; Optimizer rule: Simplified setting to 0/3
;
LINE_20:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
LDX #4
dcloop13:
LDA  CONST_52,X
STA  VAR_Y,X
DEX
BPL dcloop13
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_67
LDA #0
STA  VAR_SB
STA  VAR_SB+1
; Optimizer rule: Simplified setting to 0/3
;
LINE_21:
;
LDA #<CONST_10R
LDY #>CONST_10R
JSR REALFAC
LDA #<VAR_J
LDY #>VAR_J
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF32+1
STA MOVBSELF32+2
LDA #$7F
MOVBSELF32:
STA $FFFF
LDA #0
STA  VAR_JL
STA  VAR_JL+1
; Optimizer rule: Simplified setting to 0/3
LDA #<CONST_23R
LDY #>CONST_23R
JSR REALFAC
LDA #<VAR_J
LDY #>VAR_J
JSR MEMARG
JSR FACSUB
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF33+1
STA MOVBSELF33+2
MOVBSELF33:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_53R
LDY #>CONST_53R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG & FAC
JSR FASTAND
; Optimizer rule: Faster logic AND/1
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #$0
STA $61
; Optimizer rule: Direct loading of 0/2
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ6
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP6
EQ_EQ6:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP6:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #$0
STA $61
; Optimizer rule: Direct loading of 0/2
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT7
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP7
GT_GT7:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP7:
; Real in (A/Y) to FAC
JSR REALFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA  X_REG
COMP_SKP11:
BNE LINE_NSKIP59
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP59
;
LINE_NSKIP59:
;
LDX #4
dcloop14:
LDA  CONST_5R,X
STA  VAR_JL,X
DEX
BPL dcloop14
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_LL
LDY #>VAR_LL
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_LL
LDY #>VAR_LL
; FAC to (X/Y)
JSR FACMEM
LDA #0
STA  VAR_LR
STA  VAR_LR+1
; Optimizer rule: Simplified setting to 0/3
;
LINE_SKIP59:
;
;
LINE_22:
;
LDA #0
STA  VAR_JR
STA  VAR_JR+1
; Optimizer rule: Simplified setting to 0/3
LDA #<CONST_47R
LDY #>CONST_47R
JSR REALFAC
LDA #<VAR_J
LDY #>VAR_J
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF34+1
STA MOVBSELF34+2
MOVBSELF34:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_41R
LDY #>CONST_41R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG & FAC
JSR FASTAND
; Optimizer rule: Faster logic AND/1
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #$0
STA $61
; Optimizer rule: Direct loading of 0/2
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ8
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP8
EQ_EQ8:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP8:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_54R
LDY #>CONST_54R
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ9
ROL
BCC LT_LT9
LT_LT_EQ9:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP9
LT_LT9:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP9:
; Real in (A/Y) to FAC
JSR REALFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA  X_REG
COMP_SKP12:
BNE LINE_NSKIP60
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP60
;
LINE_NSKIP60:
;
LDX #4
dcloop15:
LDA  CONST_5R,X
STA  VAR_JR,X
DEX
BPL dcloop15
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_LR
LDY #>VAR_LR
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_LR
LDY #>VAR_LR
; FAC to (X/Y)
JSR FACMEM
LDA #0
STA  VAR_LL
STA  VAR_LL+1
; Optimizer rule: Simplified setting to 0/3
;
LINE_SKIP60:
;
;
LINE_23:
;
LDA #<VAR_JR
LDY #>VAR_JR
JSR REALFAC
LDA #<VAR_JL
LDY #>VAR_JL
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA  X_REG
BEQ EQ_EQ10
LDA #0
; Optimizer rule: CMP (REG) = 0/3
JMP EQ_SKIP10
EQ_EQ10:
LDA #$1
EQ_SKIP10:
COMP_SKP13:
BEQ LINE_SKIP61
; Simplified conditional branch
;
LINE_NSKIP61:
;
LDA #0
STA  VAR_LL
STA  VAR_LL+1
; Optimizer rule: Simplified setting to 0/3
LDX #4
dcloop16:
LDA  VAR_LL,X
STA  VAR_LR,X
DEX
BPL dcloop16
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP61:
;
;
LINE_24:
;
LDA #<CONST_23R
LDY #>CONST_23R
JSR REALFAC
LDA #<VAR_J
LDY #>VAR_J
JSR MEMARG
JSR FACSUB
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF35+1
STA MOVBSELF35+2
MOVBSELF35:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_24R
LDY #>CONST_24R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG & FAC
JSR FASTAND
; Optimizer rule: Faster logic AND/1
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #$0
STA $61
; Optimizer rule: Direct loading of 0/2
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ11
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP11
EQ_EQ11:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP11:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_N
LDY #>VAR_N
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ12
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP12
EQ_EQ12:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP12:
; Real in (A/Y) to FAC
JSR REALFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA  X_REG
COMP_SKP14:
BEQ LINE_SKIP62
; Simplified conditional branch
;
LINE_NSKIP62:
;
LDA #0
STA  VAR_N
STA  VAR_N+1
; Optimizer rule: Simplified setting to 0/3
LDX #4
dcloop17:
LDA  CONST_5R,X
STA  VAR_F,X
DEX
BPL dcloop17
; Optimizer rule: Direct copy of floats into mem/6
LDX #4
dcloop18:
LDA  CONST_55,X
STA  VAR_G,X
DEX
BPL dcloop18
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP62:
;
;
LINE_25:
;
LDA #<CONST_10R
LDY #>CONST_10R
JSR REALFAC
LDA #<VAR_J
LDY #>VAR_J
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF36+1
STA MOVBSELF36+2
LDA #$FF
MOVBSELF36:
STA $FFFF
LDA  VAR_JL
BNE NEQ_NEQ13
LDA #0
; Optimizer rule: CMP (MEM) != 0/3
JMP NEQ_SKIP13
NEQ_NEQ13:
LDA #$1
NEQ_SKIP13:
COMP_SKP15:
BNE LINE_NSKIP63
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP63
;
LINE_NSKIP63:
;
LDA #<VAR_E
LDY #>VAR_E
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_42R
LDY #>CONST_42R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF37+1
STA MOVBSELF37+2
LDA #$A0
MOVBSELF37:
STA $FFFF
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR MEMARG
JSR FACSUB
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_E
LDY #>VAR_E
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFAC
LDA #<VAR_LL
LDY #>VAR_LL
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT14
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP14
GT_GT14:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP14:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #$0
STA $61
; Optimizer rule: Direct loading of 0/2
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT15
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP15
GT_GT15:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP15:
; Real in (A/Y) to FAC
JSR REALFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA  X_REG
COMP_SKP16:
BNE LINE_NSKIP64
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP64
;
LINE_NSKIP64:
;
LDA #<VAR_E
LDY #>VAR_E
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_42R
LDY #>CONST_42R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF38+1
STA MOVBSELF38+2
LDA #$A0
MOVBSELF38:
STA $FFFF
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR MEMARG
JSR FACSUB
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_E
LDY #>VAR_E
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP64:
;
;
LINE_SKIP63:
;
;
LINE_27:
;
LDA  VAR_JR
BNE NEQ_NEQ16
LDA #0
; Optimizer rule: CMP (MEM) != 0/3
JMP NEQ_SKIP16
NEQ_NEQ16:
LDA #$1
NEQ_SKIP16:
COMP_SKP17:
BNE LINE_NSKIP65
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP65
;
LINE_NSKIP65:
;
LDA #<VAR_E
LDY #>VAR_E
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF39+1
STA MOVBSELF39+2
LDA #$A0
MOVBSELF39:
STA $FFFF
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_E
LDY #>VAR_E
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_4R
LDY #>CONST_4R
JSR REALFAC
LDA #<VAR_LR
LDY #>VAR_LR
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT17
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP17
GT_GT17:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP17:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_54R
LDY #>CONST_54R
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ18
ROL
BCC LT_LT18
LT_LT_EQ18:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP18
LT_LT18:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP18:
; Real in (A/Y) to FAC
JSR REALFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA  X_REG
COMP_SKP18:
BNE LINE_NSKIP66
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP66
;
LINE_NSKIP66:
;
LDA #<VAR_E
LDY #>VAR_E
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF40+1
STA MOVBSELF40+2
LDA #$A0
MOVBSELF40:
STA $FFFF
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_E
LDY #>VAR_E
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP66:
;
;
LINE_SKIP65:
;
;
LINE_28:
;
LDA #<VAR_E
LDY #>VAR_E
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF41+1
STA MOVBSELF41+2
LDA #$38
MOVBSELF41:
STA $FFFF
LDA #<VAR_E
LDY #>VAR_E
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF42+1
STA MOVBSELF42+2
LDA #$39
MOVBSELF42:
STA $FFFF
LDA #<VAR_E
LDY #>VAR_E
JSR REALFAC
LDA #<VAR_B
LDY #>VAR_B
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_42R
LDY #>CONST_42R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF43+1
STA MOVBSELF43+2
LDA #$3A
MOVBSELF43:
STA $FFFF
LDX #4
dcloop19:
LDA  VAR_Q,X
STA  VAR_O,X
DEX
BPL dcloop19
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_N
LDY #>VAR_N
JSR CMPFAC
EQ_EQ19:
EQ_SKIP19:
COMP_SKP19:
BNE LINE_SKIP67
LINE_NSKIP67:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
JMP LINE_36
;
LINE_SKIP67:
;
;
LINE_29:
;
LDA #0
STA  VAR_H
STA  VAR_H+1
; Optimizer rule: Simplified setting to 0/3
LDA #<VAR_F
LDY #>VAR_F
JSR REALFAC
LDA #<VAR_Q
LDY #>VAR_Q
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF44+1
STA MOVBSELF44+2
MOVBSELF44:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_59R
LDY #>CONST_59R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ LT_LT_EQ20
ROL
BCC LT_LT20
LT_LT_EQ20:
LDA #0
JMP LT_SKIP20
LT_LT20:
LDA #$1
LT_SKIP20:
COMP_SKP20:
BNE LINE_NSKIP68
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP68
;
LINE_NSKIP68:
;
LDX #4
dcloop20:
LDA  VAR_F,X
STA  VAR_Z,X
DEX
BPL dcloop20
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_50
LDA #<VAR_F
LDY #>VAR_F
JSR REALFAC
LDA #<CONST_60
LDY #>CONST_60
JSR MEMARG
JSR FACMUL
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_F
LDY #>VAR_F
; FAC to (X/Y)
JSR FACMEM
LDX #4
dcloop21:
LDA  CONST_5R,X
STA  VAR_H,X
DEX
BPL dcloop21
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP68:
;
;
LINE_30:
;
LDA #<VAR_G
LDY #>VAR_G
JSR REALFAC
LDA #<VAR_Q
LDY #>VAR_Q
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF45+1
STA MOVBSELF45+2
MOVBSELF45:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_59R
LDY #>CONST_59R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ LT_LT_EQ21
ROL
BCC LT_LT21
LT_LT_EQ21:
LDA #0
JMP LT_SKIP21
LT_LT21:
LDA #$1
LT_SKIP21:
COMP_SKP21:
BNE LINE_NSKIP69
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP69
;
LINE_NSKIP69:
;
LDX #4
dcloop22:
LDA  VAR_G,X
STA  VAR_Z,X
DEX
BPL dcloop22
; Optimizer rule: Direct copy of floats into mem/6
JSR GOSUB
JSR LINE_50
LDA #<VAR_G
LDY #>VAR_G
JSR REALFAC
LDA #<CONST_60
LDY #>CONST_60
JSR MEMARG
JSR FACMUL
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_G
LDY #>VAR_G
; FAC to (X/Y)
JSR FACMEM
LDX #4
dcloop23:
LDA  CONST_5R,X
STA  VAR_H,X
DEX
BPL dcloop23
; Optimizer rule: Direct copy of floats into mem/6
LDA #$0
STA $61
; Optimizer rule: Direct loading of 0/2
LDA #<VAR_SB
LDY #>VAR_SB
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT22
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GT_SKIP22
GT_GT22:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GT_SKIP22:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_52
LDY #>CONST_52
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ23
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP23
EQ_EQ23:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP23:
; Real in (A/Y) to FAC
JSR REALFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA  X_REG
COMP_SKP22:
BEQ LINE_SKIP70
; Simplified conditional branch
;
LINE_NSKIP70:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_SB
LDY #>VAR_SB
JSR MEMARG
JSR FACSUB
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_SB
LDY #>VAR_SB
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_67
JMP LINE_37
;
LINE_SKIP70:
;
;
LINE_SKIP69:
;
;
LINE_31:
;
LDA #<VAR_G
LDY #>VAR_G
JSR REALFAC
LDA #<VAR_Q
LDY #>VAR_Q
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_F
LDY #>VAR_F
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF46+1
STA MOVBSELF46+2
MOVBSELF46:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_59R
LDY #>CONST_59R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ LT_LT_EQ24
ROL
BCC LT_LT24
LT_LT_EQ24:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP24
LT_LT24:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP24:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #$0
STA $61
; Optimizer rule: Direct loading of 0/2
LDA #<VAR_H
LDY #>VAR_H
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ25
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP25
EQ_EQ25:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP25:
; Real in (A/Y) to FAC
JSR REALFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA  X_REG
COMP_SKP23:
BNE LINE_NSKIP71
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP71
;
LINE_NSKIP71:
;
LDA #<VAR_F
LDY #>VAR_F
JSR REALFAC
LDA #<VAR_G
LDY #>VAR_G
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Z
LDY #>VAR_Z
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_50
LDA #<VAR_F
LDY #>VAR_F
JSR REALFAC
LDA #<CONST_60
LDY #>CONST_60
JSR MEMARG
JSR FACMUL
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_F
LDY #>VAR_F
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_G
LDY #>VAR_G
JSR REALFAC
LDA #<CONST_60
LDY #>CONST_60
JSR MEMARG
JSR FACMUL
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_G
LDY #>VAR_G
; FAC to (X/Y)
JSR FACMEM
LDX #4
dcloop24:
LDA  CONST_5R,X
STA  VAR_H,X
DEX
BPL dcloop24
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP71:
;
;
LINE_32:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_H
LDY #>VAR_H
JSR CMPFAC
EQ_EQ26:
EQ_SKIP26:
COMP_SKP24:
BNE LINE_SKIP72
LINE_NSKIP72:
; Optimizer rule: Simplified equal comparison/6
;
JMP LINE_29
;
LINE_SKIP72:
;
;
LINE_33:
;
LDA #<VAR_F
LDY #>VAR_F
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_X
LDY #>VAR_X
; FAC to (X/Y)
JSR FACMEM
LDA  VAR_X
BEQ EQ_EQ27
LDA #0
; Optimizer rule: CMP (MEM) = 0/3
JMP EQ_SKIP27
EQ_EQ27:
LDA #$1
EQ_SKIP27:
COMP_SKP25:
BEQ LINE_SKIP73
; Simplified conditional branch
;
LINE_NSKIP73:
;
LDX #4
dcloop25:
LDA  CONST_5R,X
STA  VAR_F,X
DEX
BPL dcloop25
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP73:
;
;
LINE_34:
;
LDA #<CONST_61R
LDY #>CONST_61R
JSR REALFAC
LDA #<VAR_X
LDY #>VAR_X
JSR CMPFAC
EQ_EQ28:
EQ_SKIP28:
COMP_SKP26:
BNE LINE_SKIP74
LINE_NSKIP74:
; Optimizer rule: Simplified equal comparison/6
;
LDX #4
dcloop26:
LDA  CONST_62,X
STA  VAR_F,X
DEX
BPL dcloop26
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP74:
;
;
LINE_35:
;
LDA #<VAR_G
LDY #>VAR_G
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Y
LDY #>VAR_Y
; FAC to (X/Y)
JSR FACMEM
LDA  VAR_Y
BEQ EQ_EQ29
LDA #0
; Optimizer rule: CMP (MEM) = 0/3
JMP EQ_SKIP29
EQ_EQ29:
LDA #$1
EQ_SKIP29:
COMP_SKP27:
BEQ LINE_SKIP75
; Simplified conditional branch
;
LINE_NSKIP75:
;
LDA #<VAR_G
LDY #>VAR_G
JSR REALFAC
LDA #<CONST_60
LDY #>CONST_60
JSR MEMARG
JSR FACMUL
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_G
LDY #>VAR_G
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP75:
;
;
LINE_36:
;
LDA #<VAR_Y
LDY #>VAR_Y
JSR REALFAC
LDA #<VAR_S
LDY #>VAR_S
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_X
LDY #>VAR_X
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
LDY #>X_REG
LDX #<X_REG
JSR FACMEM
; Optimizer rule: FAC into REG?, REG? into FAC (2)/3
LDX #<VAR_Q
LDY #>VAR_Q
; FAC to (X/Y)
JSR FACMEM
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF47+1
STA MOVBSELF47+2
LDA #$3B
MOVBSELF47:
STA $FFFF
LDA #<VAR_C
LDY #>VAR_C
JSR REALFAC
LDA #<VAR_Q
LDY #>VAR_Q
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF48+1
STA MOVBSELF48+2
LDA #$3
MOVBSELF48:
STA $FFFF
LDA #<VAR_Q
LDY #>VAR_Q
JSR REALFAC
LDA #<VAR_O
LDY #>VAR_O
JSR CMPFAC
NEQ_NEQ30:
NEQ_SKIP30:
COMP_SKP28:
BEQ LINE_SKIP76
LINE_NSKIP76:
; Optimizer rule: Simplified not equal comparison/6
;
LDA #<VAR_O
LDY #>VAR_O
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF49+1
STA MOVBSELF49+2
LDA #$A0
MOVBSELF49:
STA $FFFF
;
LINE_SKIP76:
;
;
LINE_37:
;
LDX #4
dcloop27:
LDA  VAR_Q,X
STA  VAR_O,X
DEX
BPL dcloop27
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_63R
LDY #>CONST_63R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #0
STA  VAR_I
STA  VAR_I+1
; Optimizer rule: Simplified setting to 0/3
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP5
STA JUMP_TARGET
LDA #>FORLOOP5
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP5:
LDA #<CONST_7R
LDY #>CONST_7R
STY TMP3_ZP+1
LDX #<Y_REG
LDY #>Y_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_I
LDY #>VAR_I
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<Y_REG
LDY #>Y_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_S[]
LDY #>VAR_S[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR POPREAL
LDX #<Y_REG
LDY #>Y_REG
JSR FACMEM
; Optimizer rule: POP, REG0, VAR0/4
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
NEQ_NEQ31:
NEQ_SKIP31:
COMP_SKP29:
BEQ LINE_SKIP77
LINE_NSKIP77:
; Optimizer rule: Simplified not equal comparison/6
;
JSR GOSUB
JSR LINE_58
;
LINE_SKIP77:
;
;
LINE_38:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_5
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_5:
LDA #<CONST_52
LDY #>CONST_52
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT32
LDA #0
JMP GT_SKIP32
GT_GT32:
LDA #$1
GT_SKIP32:
COMP_SKP31:
BEQ LINE_SKIP78
; Simplified conditional branch
;
LINE_NSKIP78:
;
JMP LINE_44
;
LINE_SKIP78:
;
;
LINE_40:
;
LDA #$0
STA $61
; Optimizer rule: Direct loading of 0/2
LDA #<VAR_CD
LDY #>VAR_CD
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT33
LDA #0
JMP GT_SKIP33
GT_GT33:
LDA #$1
GT_SKIP33:
COMP_SKP32:
BNE LINE_NSKIP79
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP79
;
LINE_NSKIP79:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_CD
LDY #>VAR_CD
JSR MEMARG
JSR FACSUB
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_CD
LDY #>VAR_CD
; FAC to (X/Y)
JSR FACMEM
LDA  VAR_CD
BEQ EQ_EQ34
LDA #0
; Optimizer rule: CMP (MEM) = 0/3
JMP EQ_SKIP34
EQ_EQ34:
LDA #$1
EQ_SKIP34:
COMP_SKP33:
BEQ LINE_SKIP80
; Simplified conditional branch
;
LINE_NSKIP80:
;
JMP LINE_47
;
LINE_SKIP80:
;
;
LINE_SKIP79:
;
;
LINE_41:
;
LDA #$0
STA $61
; Optimizer rule: Direct loading of 0/2
LDA #<VAR_MC
LDY #>VAR_MC
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT35
LDA #0
JMP GT_SKIP35
GT_GT35:
LDA #$1
GT_SKIP35:
COMP_SKP34:
BNE LINE_NSKIP81
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP81
;
LINE_NSKIP81:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_MC
LDY #>VAR_MC
JSR MEMARG
JSR FACSUB
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_MC
LDY #>VAR_MC
; FAC to (X/Y)
JSR FACMEM
LDA  VAR_MC
BEQ EQ_EQ36
LDA #0
; Optimizer rule: CMP (MEM) = 0/3
JMP EQ_SKIP36
EQ_EQ36:
LDA #$1
EQ_SKIP36:
COMP_SKP35:
BEQ LINE_SKIP82
; Simplified conditional branch
;
LINE_NSKIP82:
;
JSR GOSUB
JSR LINE_64
;
LINE_SKIP82:
;
;
LINE_SKIP81:
;
;
LINE_42:
;
LDA #$0
STA $61
; Optimizer rule: Direct loading of 0/2
LDA #<VAR_R
LDY #>VAR_R
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT37
LDA #0
JMP GT_SKIP37
GT_GT37:
LDA #$1
GT_SKIP37:
COMP_SKP36:
BEQ LINE_SKIP83
; Simplified conditional branch
;
LINE_NSKIP83:
;
JSR GOSUB
JSR LINE_68
;
LINE_SKIP83:
;
;
LINE_43:
;
JMP LINE_21
;
LINE_44:
;
LDA #<CONST_64
LDY #>CONST_64
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR GOSUB
JSR LINE_66
LDX #4
dcloop28:
LDA  CONST_4R,X
STA  VAR_MC,X
DEX
BPL dcloop28
; Optimizer rule: Direct copy of floats into mem/6
LDA #<VAR_Q
LDY #>VAR_Q
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF50+1
STA MOVBSELF50+2
LDA #$A0
MOVBSELF50:
STA $FFFF
LDA #<VAR_C
LDY #>VAR_C
JSR REALFAC
LDA #<VAR_Q
LDY #>VAR_Q
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF51+1
STA MOVBSELF51+2
LDA #$1
MOVBSELF51:
STA $FFFF
LDA #<VAR_D
LDY #>VAR_D
JSR REALFAC
LDA #<CONST_33
LDY #>CONST_33
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF52+1
STA MOVBSELF52+2
LDA #$A0
MOVBSELF52:
STA $FFFF
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_D
LDY #>VAR_D
JSR MEMARG
JSR FACSUB
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_D
LDY #>VAR_D
; FAC to (X/Y)
JSR FACMEM
LDA #$0
STA $61
; Optimizer rule: Direct loading of 0/2
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT38
LDA #0
JMP GT_SKIP38
GT_GT38:
LDA #$1
GT_SKIP38:
COMP_SKP37:
BEQ LINE_SKIP84
; Simplified conditional branch
;
LINE_NSKIP84:
;
JMP LINE_20
;
LINE_SKIP84:
;
;
LINE_46:
;
LDA #<CONST_65
LDY #>CONST_65
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR GOSUB
JSR LINE_66
JSR RUN
;
LINE_47:
;
LDA #<VAR_D
LDY #>VAR_D
JSR REALFAC
LDA #<CONST_66R
LDY #>CONST_66R
JSR MEMARG
JSR FACMUL
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_67
LDY #>CONST_67
JSR REALFAC
LDA #<VAR_K
LDY #>VAR_K
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR ARGADD
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_K
LDY #>VAR_K
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_78
LDA #0
STA  VAR_Y
STA  VAR_Y+1
; Optimizer rule: Simplified setting to 0/3
LDX #4
dcloop29:
LDA  VAR_Y,X
STA  VAR_E,X
DEX
BPL dcloop29
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_68
LDY #>CONST_68
JSR REALFAC
LDA #<VAR_L
LDY #>VAR_L
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_L
LDY #>VAR_L
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_42R
LDY #>CONST_42R
JSR REALFAC
LDA #<VAR_L
LDY #>VAR_L
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT39
LDA #0
JMP GT_SKIP39
GT_GT39:
LDA #$1
GT_SKIP39:
COMP_SKP38:
BEQ LINE_SKIP85
; Simplified conditional branch
;
LINE_NSKIP85:
;
LDX #4
dcloop30:
LDA  CONST_42R,X
STA  VAR_L,X
DEX
BPL dcloop30
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP85:
;
;
LINE_48:
;
LDA #<CONST_48
LDY #>CONST_48
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_E
LDY #>VAR_E
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_E
LDY #>VAR_E
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDY #>X_REG
LDX #<X_REG
JSR FACMEM
; Optimizer rule: FAC into REG?, REG? into FAC (2)/3
LDX #<VAR_Y
LDY #>VAR_Y
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_QR
LDY #>VAR_QR
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY 36865
LDA #<VAR_Y
LDY #>VAR_Y
JSR REALFAC
LDA #<CONST_48
LDY #>CONST_48
JSR MEMARG
JSR FACMUL
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_41R
LDY #>CONST_41R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
LDY #>X_REG
LDX #<X_REG
JSR FACMEM
; Optimizer rule: FAC into REG?, REG? into FAC (2)/3
LDX #<VAR_A
LDY #>VAR_A
; FAC to (X/Y)
JSR FACMEM
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC to integer in Y/A
JSR FACWORD
STY 36876
LDA #<CONST_27R
LDY #>CONST_27R
JSR REALFAC
LDA #<VAR_Y
LDY #>VAR_Y
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ40
ROL
BCC LT_LT40
LT_LT_EQ40:
LDA #0
JMP LT_SKIP40
LT_LT40:
LDA #$1
LT_SKIP40:
COMP_SKP39:
BEQ LINE_SKIP86
; Simplified conditional branch
;
LINE_NSKIP86:
;
JMP LINE_48
;
LINE_SKIP86:
;
;
LINE_49:
;
LDA #$0
STA $61
; Optimizer rule: Direct loading of 0/2
; FAC to integer in Y/A
JSR FACWORD
STY 36876
JMP LINE_9
;
LINE_50:
;
LDY #140
STY 36876
; Optimizer rule: Simple POKE/2
LDA #<VAR_Z
LDY #>VAR_Z
JSR REALFAC
LDA #<VAR_Q
LDY #>VAR_Q
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_69
LDY #>CONST_69
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG & FAC
JSR FASTAND
; Optimizer rule: Faster logic AND/1
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Z
LDY #>VAR_Z
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_Z
LDY #>VAR_Z
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF57+1
STA MOVBSELF57+2
MOVBSELF57:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_W
LDY #>VAR_W
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_40R
LDY #>CONST_40R
JSR REALFAC
LDA #<VAR_W
LDY #>VAR_W
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ41
LDA #0
JMP EQ_SKIP41
EQ_EQ41:
LDA #$1
EQ_SKIP41:
COMP_SKP40:
BNE LINE_NSKIP87
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP87
;
LINE_NSKIP87:
;
LDA #<VAR_Z
LDY #>VAR_Z
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF58+1
STA MOVBSELF58+2
LDA #$30
MOVBSELF58:
STA $FFFF
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF59+1
STA MOVBSELF59+2
LDA #$31
MOVBSELF59:
STA $FFFF
LDA #<VAR_C
LDY #>VAR_C
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF60+1
STA MOVBSELF60+2
LDA #$5
MOVBSELF60:
STA $FFFF
LDA #<VAR_C
LDY #>VAR_C
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF61+1
STA MOVBSELF61+2
LDA #$5
MOVBSELF61:
STA $FFFF
JMP LINE_57
;
LINE_SKIP87:
;
;
LINE_52:
;
LDA #<CONST_46R
LDY #>CONST_46R
JSR REALFAC
LDA #<VAR_W
LDY #>VAR_W
JSR CMPFAC
NEQ_NEQ42:
NEQ_SKIP42:
COMP_SKP41:
BEQ LINE_SKIP88
LINE_NSKIP88:
; Optimizer rule: Simplified not equal comparison/6
;
JMP LINE_57
;
LINE_SKIP88:
;
;
LINE_53:
;
LDA #<CONST_51R
LDY #>CONST_51R
JSR REALFAC
LDA #<VAR_K
LDY #>VAR_K
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_K
LDY #>VAR_K
; FAC to (X/Y)
JSR FACMEM
JSR GOSUB
JSR LINE_78
LDY #140
STY 36877
; Optimizer rule: Simple POKE/2
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_U
LDY #>VAR_U
JSR MEMARG
JSR FACSUB
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_U
LDY #>VAR_U
; FAC to (X/Y)
JSR FACMEM
LDA  VAR_U
BEQ EQ_EQ43
LDA #0
; Optimizer rule: CMP (MEM) = 0/3
JMP EQ_SKIP43
EQ_EQ43:
LDA #$1
EQ_SKIP43:
COMP_SKP42:
BEQ LINE_SKIP89
; Simplified conditional branch
;
LINE_NSKIP89:
;
LDX #4
dcloop31:
LDA  CONST_51R,X
STA  VAR_CD,X
DEX
BPL dcloop31
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP89:
;
;
LINE_54:
;
LDA #<VAR_Z
LDY #>VAR_Z
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF63+1
STA MOVBSELF63+2
LDA #$2E
MOVBSELF63:
STA $FFFF
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF64+1
STA MOVBSELF64+2
LDA #$2F
MOVBSELF64:
STA $FFFF
LDA #<VAR_C
LDY #>VAR_C
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF65+1
STA MOVBSELF65+2
LDA #$1
MOVBSELF65:
STA $FFFF
LDA #<VAR_C
LDY #>VAR_C
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF66+1
STA MOVBSELF66+2
LDA #$1
MOVBSELF66:
STA $FFFF
LDA #<CONST_68
LDY #>CONST_68
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<Y_REG
LDY #>Y_REG
JSR FACMEM
; Optimizer rule: POP, REG0, VAR0/4
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ LT_LT_EQ44
ROL
BCC LT_LT44
LT_LT_EQ44:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP44
LT_LT44:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP44:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #$0
STA $61
; Optimizer rule: Direct loading of 0/2
LDA #<VAR_R
LDY #>VAR_R
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ45
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP EQ_SKIP45
EQ_EQ45:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
EQ_SKIP45:
; Real in (A/Y) to FAC
JSR REALFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA  X_REG
COMP_SKP43:
BNE LINE_NSKIP90
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP90
;
LINE_NSKIP90:
;
LDA #<CONST_42R
LDY #>CONST_42R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = INT(FAC)
JSR BASINT
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_Z
LDY #>VAR_Z
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_R
LDY #>VAR_R
; FAC to (X/Y)
JSR FACMEM
;
LINE_SKIP90:
;
;
LINE_55:
;
LDA #<CONST_63R
LDY #>CONST_63R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #0
STA  VAR_I
STA  VAR_I+1
; Optimizer rule: Simplified setting to 0/3
LDA #<VAR_I
LDY #>VAR_I
STA A_REG
STY A_REG+1
LDA #<FORLOOP6
STA JUMP_TARGET
LDA #>FORLOOP6
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP6:
LDA #<CONST_6
LDY #>CONST_6
STY TMP3_ZP+1
LDX #<Y_REG
LDY #>Y_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_I
LDY #>VAR_I
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<Y_REG
LDY #>Y_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_S[]
LDY #>VAR_S[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR POPREAL
LDX #<Y_REG
LDY #>Y_REG
JSR FACMEM
; Optimizer rule: POP, REG0, VAR0/4
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ46
LDA #0
JMP EQ_SKIP46
EQ_EQ46:
LDA #$1
EQ_SKIP46:
COMP_SKP44:
BNE LINE_NSKIP91
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP91
;
LINE_NSKIP91:
;
LDA #<VAR_I
LDY #>VAR_I
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_12R
LDY #>CONST_12R
STY TMP3_ZP+1
LDX #<Y_REG
LDY #>Y_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_S[]
LDY #>VAR_S[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
LDA #<VAR_I
LDY #>VAR_I
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_Z
LDY #>VAR_Z
STY TMP3_ZP+1
LDX #<Y_REG
LDY #>Y_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_P[]
LDY #>VAR_P[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
LDX #4
dcloop32:
LDA  CONST_4R,X
STA  VAR_I,X
DEX
BPL dcloop32
; Optimizer rule: Direct copy of floats into mem/6
;
LINE_SKIP91:
;
;
LINE_56:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_6
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_6:
;
LINE_57:
;
LDY #0
STY 36876
; Optimizer rule: Simple POKE/2
LDY #0
STY 36877
; Optimizer rule: Simple POKE/2
JSR RETURN
RTS
;
LINE_58:
;
LDA #<VAR_I
LDY #>VAR_I
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
STY TMP3_ZP+1
LDX #<Y_REG
LDY #>Y_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_I
LDY #>VAR_I
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<Y_REG
LDY #>Y_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_S[]
LDY #>VAR_S[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FACSUB
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<Y_REG
LDY #>Y_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_S[]
LDY #>VAR_S[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
LDA #<VAR_I
LDY #>VAR_I
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_S[]
LDY #>VAR_S[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
LDX #<VAR_A
LDY #>VAR_A
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_I
LDY #>VAR_I
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_P[]
LDY #>VAR_P[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
LDX #<VAR_Z
LDY #>VAR_Z
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_9R
LDY #>CONST_9R
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ47
LDA #0
JMP EQ_SKIP47
EQ_EQ47:
LDA #$1
EQ_SKIP47:
COMP_SKP46:
BNE LINE_NSKIP92
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP92
;
LINE_NSKIP92:
;
LDA #<VAR_Z
LDY #>VAR_Z
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF69+1
STA MOVBSELF69+2
LDA #$32
MOVBSELF69:
STA $FFFF
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF70+1
STA MOVBSELF70+2
LDA #$33
MOVBSELF70:
STA $FFFF
LDA #<VAR_C
LDY #>VAR_C
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF71+1
STA MOVBSELF71+2
LDA #$2
MOVBSELF71:
STA $FFFF
LDA #<VAR_C
LDY #>VAR_C
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF72+1
STA MOVBSELF72+2
LDA #$2
MOVBSELF72:
STA $FFFF
;
LINE_SKIP92:
;
;
LINE_60:
;
LDA #<CONST_42R
LDY #>CONST_42R
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ48
LDA #0
JMP EQ_SKIP48
EQ_EQ48:
LDA #$1
EQ_SKIP48:
COMP_SKP47:
BNE LINE_NSKIP93
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP93
;
LINE_NSKIP93:
;
LDA #<VAR_Z
LDY #>VAR_Z
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF73+1
STA MOVBSELF73+2
LDA #$34
MOVBSELF73:
STA $FFFF
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF74+1
STA MOVBSELF74+2
LDA #$35
MOVBSELF74:
STA $FFFF
;
LINE_SKIP93:
;
;
LINE_61:
;
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_A
LDY #>VAR_A
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ EQ_EQ49
LDA #0
JMP EQ_SKIP49
EQ_EQ49:
LDA #$1
EQ_SKIP49:
COMP_SKP48:
BNE LINE_NSKIP94
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP94
;
LINE_NSKIP94:
;
LDA #<VAR_Z
LDY #>VAR_Z
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF75+1
STA MOVBSELF75+2
LDA #$36
MOVBSELF75:
STA $FFFF
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF76+1
STA MOVBSELF76+2
LDA #$37
MOVBSELF76:
STA $FFFF
;
LINE_SKIP94:
;
;
LINE_62:
;
LDA  VAR_A
BEQ EQ_EQ50
LDA #0
; Optimizer rule: CMP (MEM) = 0/3
JMP EQ_SKIP50
EQ_EQ50:
LDA #$1
EQ_SKIP50:
COMP_SKP49:
BNE LINE_NSKIP95
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP95
;
LINE_NSKIP95:
;
LDA #<VAR_Z
LDY #>VAR_Z
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF77+1
STA MOVBSELF77+2
LDA #$A0
MOVBSELF77:
STA $FFFF
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF78+1
STA MOVBSELF78+2
LDA #$A0
MOVBSELF78:
STA $FFFF
;
LINE_SKIP95:
;
;
LINE_63:
;
JSR RETURN
RTS
;
LINE_64:
;
LDA #<CONST_79
LDY #>CONST_79
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
;
LINE_65:
;
LDA #<CONST_80
LDY #>CONST_80
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR RETURN
RTS
;
LINE_66:
;
LDX #4
dcloop33:
LDA  CONST_81,X
STA  VAR_I,X
DEX
BPL dcloop33
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_65
;
LINE_67:
;
LDA #<CONST_82
LDY #>CONST_82
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDX #4
dcloop34:
LDA  CONST_37R,X
STA  VAR_MC,X
DEX
BPL dcloop34
; Optimizer rule: Direct copy of floats into mem/6
LDX #4
dcloop35:
LDA  CONST_5R,X
STA  VAR_N,X
DEX
BPL dcloop35
; Optimizer rule: Direct copy of floats into mem/6
LDA #0
STA  VAR_G
STA  VAR_G+1
; Optimizer rule: Simplified setting to 0/3
JMP LINE_65
;
LINE_68:
;
LDA #<CONST_83
LDY #>CONST_83
JSR REALFAC
LDA #<VAR_R
LDY #>VAR_R
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT51
LDA #0
JMP GT_SKIP51
GT_GT51:
LDA #$1
GT_SKIP51:
COMP_SKP50:
BEQ LINE_SKIP96
; Simplified conditional branch
;
LINE_NSKIP96:
;
LDA #<VAR_C
LDY #>VAR_C
JSR REALFAC
LDA #<VAR_R
LDY #>VAR_R
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF79+1
STA MOVBSELF79+2
LDA #$1
MOVBSELF79:
STA $FFFF
;
LINE_SKIP96:
;
;
LINE_69:
;
LDA #<CONST_59R
LDY #>CONST_59R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF80+1
STA MOVBSELF80+2
MOVBSELF80:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<Y_REG
LDY #>Y_REG
JSR FACMEM
; Optimizer rule: POP, REG0, VAR0/4
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ52:
EQ_SKIP52:
COMP_SKP51:
BNE LINE_SKIP97
LINE_NSKIP97:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF81+1
STA MOVBSELF81+2
LDA #$A0
MOVBSELF81:
STA $FFFF
;
LINE_SKIP97:
;
;
LINE_70:
;
LDA #<CONST_44R
LDY #>CONST_44R
JSR REALFAC
LDA #<VAR_R
LDY #>VAR_R
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_R
LDY #>VAR_R
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_84
LDY #>CONST_84
JSR REALFAC
LDA #<VAR_R
LDY #>VAR_R
JSR MEMARG
JSR FACSUB
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Z
LDY #>VAR_Z
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_9R
LDY #>CONST_9R
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<Y_REG
LDY #>Y_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_Z
LDY #>VAR_Z
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<Y_REG
LDY #>Y_REG
; Real in (A/Y) to FAC
JSR REALFAC
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ LT_LT_EQ53
ROL
BCC LT_LT53
LT_LT_EQ53:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP53
LT_LT53:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP53:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_E
LDY #>VAR_E
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ GTEQ_GTEQ54
BCS GTEQ_GTEQ54
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GTEQ_SKIP54
GTEQ_GTEQ54:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GTEQ_SKIP54:
; Real in (A/Y) to FAC
JSR REALFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA  X_REG
COMP_SKP52:
BEQ LINE_SKIP98
; Simplified conditional branch
;
LINE_NSKIP98:
;
JMP LINE_75
;
LINE_SKIP98:
;
;
LINE_71:
;
LDA #<CONST_61R
LDY #>CONST_61R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT55
LDA #0
JMP GT_SKIP55
GT_GT55:
LDA #$1
GT_SKIP55:
COMP_SKP53:
BNE LINE_NSKIP99
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP99
;
LINE_NSKIP99:
;
LDA #<CONST_44R
LDY #>CONST_44R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR MEMARG
JSR FACSUB
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Z
LDY #>VAR_Z
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_9R
LDY #>CONST_9R
JSR REALFAC
LDA #<VAR_E
LDY #>VAR_E
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<Y_REG
LDY #>Y_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_Z
LDY #>VAR_Z
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<Y_REG
LDY #>Y_REG
; Real in (A/Y) to FAC
JSR REALFAC
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ LT_LT_EQ56
ROL
BCC LT_LT56
LT_LT_EQ56:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP56
LT_LT56:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP56:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_E
LDY #>VAR_E
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ GTEQ_GTEQ57
BCS GTEQ_GTEQ57
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP GTEQ_SKIP57
GTEQ_GTEQ57:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
GTEQ_SKIP57:
; Real in (A/Y) to FAC
JSR REALFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA  X_REG
COMP_SKP54:
BEQ LINE_SKIP100
; Simplified conditional branch
;
LINE_NSKIP100:
;
JMP LINE_75
;
LINE_SKIP100:
;
;
LINE_SKIP99:
;
;
LINE_72:
;
LDA #<CONST_61R
LDY #>CONST_61R
JSR REALFAC
LDA #<VAR_Z
LDY #>VAR_Z
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
ROL
BCS GT_GT58
LDA #0
JMP GT_SKIP58
GT_GT58:
LDA #$1
GT_SKIP58:
COMP_SKP55:
BEQ LINE_SKIP101
; Simplified conditional branch
;
LINE_NSKIP101:
;
LDA #0
STA  VAR_R
STA  VAR_R+1
; Optimizer rule: Simplified setting to 0/3
JSR RETURN
RTS
;
LINE_SKIP101:
;
;
LINE_73:
;
LDA #<CONST_31R
LDY #>CONST_31R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF82+1
STA MOVBSELF82+2
MOVBSELF82:
LDY $FFFF
LDA #0
; integer in Y/A to FAC
JSR INTFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<Y_REG
LDY #>Y_REG
JSR FACMEM
; Optimizer rule: POP, REG0, VAR0/4
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
BEQ EQ_EQ59
LDA #0
JMP EQ_SKIP59
EQ_EQ59:
LDA #$1
EQ_SKIP59:
COMP_SKP56:
BNE LINE_NSKIP102
; Optimizer rule: Simplified CMP redux/7
JMP LINE_SKIP102
;
LINE_NSKIP102:
;
LDA #<VAR_R
LDY #>VAR_R
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF83+1
STA MOVBSELF83+2
LDA #$3C
MOVBSELF83:
STA $FFFF
LDA #<VAR_C
LDY #>VAR_C
JSR REALFAC
LDA #<VAR_R
LDY #>VAR_R
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF84+1
STA MOVBSELF84+2
LDA #$4
MOVBSELF84:
STA $FFFF
;
LINE_SKIP102:
;
;
LINE_74:
;
JSR RETURN
RTS
;
LINE_75:
;
LDA #0
STA  VAR_R
STA  VAR_R+1
; Optimizer rule: Simplified setting to 0/3
LDX #4
dcloop36:
LDA  CONST_51R,X
STA  VAR_MC,X
DEX
BPL dcloop36
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC = RND(FAC)
JSR FACRND
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_W
LDY #>VAR_W
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_85
LDY #>CONST_85
JSR REALFAC
LDA #<VAR_W
LDY #>VAR_W
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ60
ROL
BCC LT_LT60
LT_LT_EQ60:
LDA #0
JMP LT_SKIP60
LT_LT60:
LDA #$1
LT_SKIP60:
COMP_SKP57:
BEQ LINE_SKIP103
; Simplified conditional branch
;
LINE_NSKIP103:
;
LDA #<CONST_86
LDY #>CONST_86
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDX #4
dcloop37:
LDA  CONST_9R,X
STA  VAR_SB,X
DEX
BPL dcloop37
; Optimizer rule: Direct copy of floats into mem/6
JMP LINE_65
;
LINE_SKIP103:
;
;
LINE_76:
;
LDA #<CONST_12R
LDY #>CONST_12R
JSR REALFAC
LDA #<VAR_D
LDY #>VAR_D
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ61
ROL
BCC LT_LT61
LT_LT_EQ61:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP61
LT_LT61:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP61:
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_87
LDY #>CONST_87
JSR REALFAC
LDA #<VAR_W
LDY #>VAR_W
JSR CMPFAC
; Optimizer rule: Highly simplified loading for CMP/6
BEQ LT_LT_EQ62
ROL
BCC LT_LT62
LT_LT_EQ62:
LDA #<REAL_CONST_ZERO
LDY #>REAL_CONST_ZERO
JMP LT_SKIP62
LT_LT62:
LDA #<REAL_CONST_MINUS_ONE
LDY #>REAL_CONST_MINUS_ONE
LT_SKIP62:
; Real in (A/Y) to FAC
JSR REALFAC
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA  X_REG
COMP_SKP58:
BNE LINE_NSKIP104
; Optimizer rule: CMP (REG) != 0(2)/3
JMP LINE_SKIP104
;
LINE_NSKIP104:
;
LDA #<CONST_88
LDY #>CONST_88
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_D
LDY #>VAR_D
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDY #>X_REG
LDX #<X_REG
JSR FACMEM
; Optimizer rule: FAC into REG?, REG? into FAC (2)/3
LDX #<VAR_D
LDY #>VAR_D
; FAC to (X/Y)
JSR FACMEM
LDA #<CONST_33
LDY #>CONST_33
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF85+1
STA MOVBSELF85+2
LDA #$3B
MOVBSELF85:
STA $FFFF
LDA #<VAR_D
LDY #>VAR_D
JSR REALFAC
LDA #<CONST_35
LDY #>CONST_35
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
; Optimizer rule: FAC into REG?, REG? into FAC/0
; FAC to integer in Y/A
JSR FACWORD
STY MOVBSELF86+1
STA MOVBSELF86+2
LDA #$3
MOVBSELF86:
STA $FFFF
JMP LINE_65
;
LINE_SKIP104:
;
;
LINE_77:
;
LDA #<CONST_89
LDY #>CONST_89
JSR STROUTWL
; Optimizer rule: Memory saving STROUT/1
JSR GOSUB
JSR LINE_65
LDA #<CONST_90
LDY #>CONST_90
JSR REALFAC
LDA #<VAR_K
LDY #>VAR_K
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDY #>X_REG
LDX #<X_REG
JSR FACMEM
; Optimizer rule: FAC into REG?, REG? into FAC (2)/3
LDX #<VAR_K
LDY #>VAR_K
; FAC to (X/Y)
JSR FACMEM
;
LINE_78:
;
JSR FRE
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
LDX #<VAR_W
LDY #>VAR_W
; FAC to (X/Y)
JSR FACMEM
JSR COMPACT
LDA #<VAR_K
LDY #>VAR_K
STY TMP3_ZP+1
LDX #<Y_REG
LDY #>Y_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
JSR STR
;ignored: JSR COPYSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_A$
LDY #>VAR_A$
JSR COPYSTRING
LDA VAR_A$
LDY VAR_A$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR LEN
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
LDX #<VAR_W
LDY #>VAR_W
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_W
LDY #>VAR_W
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_I
LDY #>VAR_I
STX A_REG
STY A_REG+1
JSR FACMEM
; Optimizer rule: Simplified loading of A/5
LDA #<FORLOOP7
STA JUMP_TARGET
LDA #>FORLOOP7
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP7:
LDA #<VAR_I
LDY #>VAR_I
JSR REALFAC
LDA #<CONST_91
LDY #>CONST_91
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_W
LDY #>VAR_W
JSR REALFAC
; Optimizer rule: Direct loading of values into FAC/3
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG - FAC
JSR FACSUB
LDY #>X_REG
LDX #<X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACT
LDA #<VAR_I
LDY #>VAR_I
STY TMP3_ZP+1
LDX #<C_REG
LDY #>C_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_5R
LDY #>CONST_5R
STY TMP3_ZP+1
LDX #<D_REG
LDY #>D_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA VAR_A$
LDY VAR_A$+1
STA B_REG
STY B_REG+1
JSR MID
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR ASC
LDA #<CONST_41R
LDY #>CONST_41R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG + FAC
JSR ARGADD
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF87+1
STA MOVBSELF87+2
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF87:
STY $FFFF
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_7
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_7:
JSR RETURN
RTS
;
LINE_79:
;
LDX #4
dcloop38:
LDA  CONST_92,X
STA  VAR_Q,X
DEX
BPL dcloop38
; Optimizer rule: Direct copy of floats into mem/6
LDA #<CONST_93R
LDY #>CONST_93R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #0
STA  VAR_X
STA  VAR_X+1
; Optimizer rule: Simplified setting to 0/3
LDA #<VAR_X
LDY #>VAR_X
STA A_REG
STY A_REG+1
LDA #<FORLOOP8
STA JUMP_TARGET
LDA #>FORLOOP8
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP8:
JSR READSTR
LDA A_REG
LDY A_REG+1
STA TMP_ZP
STY TMP_ZP+1
LDA #<VAR_A$
LDY #>VAR_A$
JSR COPYSTRING
LDA VAR_A$
LDY VAR_A$+1
STA B_REG
STY B_REG+1
; ignored: CHGCTX #0
JSR LEN
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_63R
LDY #>CONST_63R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_I
LDY #>VAR_I
STX A_REG
STY A_REG+1
JSR FACMEM
; Optimizer rule: Simplified loading of A/5
LDA #<FORLOOP9
STA JUMP_TARGET
LDA #>FORLOOP9
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP9:
LDA #<CONST_9R
LDY #>CONST_9R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #0
STA  VAR_J
STA  VAR_J+1
; Optimizer rule: Simplified setting to 0/3
LDA #<VAR_J
LDY #>VAR_J
STA A_REG
STY A_REG+1
LDA #<FORLOOP10
STA JUMP_TARGET
LDA #>FORLOOP10
STA JUMP_TARGET+1
JSR INITFOR
FORLOOP10:
LDA #<VAR_J
LDY #>VAR_J
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
JSR COMPACT
LDA #<VAR_J
LDY #>VAR_J
JSR REALFAC
LDA #<VAR_I
LDY #>VAR_I
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
LDY #>X_REG
LDX #<X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<X_REG
LDY #>X_REG
STY TMP3_ZP+1
LDX #<C_REG
LDY #>C_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Improved copy from REG0 to REG1/7
LDA #<CONST_5R
LDY #>CONST_5R
STY TMP3_ZP+1
LDX #<D_REG
LDY #>D_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
; ignored: CHGCTX #1
LDA VAR_A$
LDY VAR_A$+1
STA B_REG
STY B_REG+1
JSR MID
LDY A_REG
LDA A_REG+1
STY B_REG
STA B_REG+1
; ignored: CHGCTX #0
JSR ASC
LDA #<CONST_24R
LDY #>CONST_24R
JSR REALFAC
; Optimizer rule: Avoid INTEGER->REAL conversion/3
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to ARG
JSR MEMARG
; FAC = ARG - FAC
JSR FACSUB
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<Y_REG
LDY #>Y_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDA #<VAR_P[]
LDY #>VAR_P[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
LDA #<CONST_94R
LDY #>CONST_94R
STY TMP3_ZP+1
LDX #<Y_REG
LDY #>Y_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_J
LDY #>VAR_J
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<Y_REG
LDY #>Y_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_P[]
LDY #>VAR_P[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR POPREAL
LDX #<Y_REG
LDY #>Y_REG
JSR FACMEM
; Optimizer rule: POP, REG0, VAR0/4
LDA #<X_REG
LDY #>X_REG
; CMPFAC with (A/Y)
JSR CMPFAC
EQ_EQ63:
EQ_SKIP63:
COMP_SKP60:
BNE LINE_SKIP105
LINE_NSKIP105:
; Optimizer rule: Simplified equal comparison/6
;
LDA #<VAR_J
LDY #>VAR_J
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_42R
LDY #>CONST_42R
STY TMP3_ZP+1
LDX #<Y_REG
LDY #>Y_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<VAR_P[]
LDY #>VAR_P[]
STA G_REG
STY G_REG+1
JSR ARRAYSTORE_REAL
;
LINE_SKIP105:
;
;
LINE_80:
;
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_8
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_8:
LDA #<VAR_Q
LDY #>VAR_Q
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_53R
LDY #>CONST_53R
STY TMP3_ZP+1
LDX #<Y_REG
LDY #>Y_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_5R
LDY #>CONST_5R
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<Y_REG
LDY #>Y_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_P[]
LDY #>VAR_P[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR ARGDIV
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_63R
LDY #>CONST_63R
STY TMP3_ZP+1
LDX #<Y_REG
LDY #>Y_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_7R
LDY #>CONST_7R
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<Y_REG
LDY #>Y_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_P[]
LDY #>VAR_P[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FACMUL
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR ARGADD
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF88+1
STA MOVBSELF88+2
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF88:
STY $FFFF
LDA #<CONST_5R
LDY #>CONST_5R
JSR REALFAC
LDA #<VAR_Q
LDY #>VAR_Q
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_63R
LDY #>CONST_63R
STY TMP3_ZP+1
LDX #<Y_REG
LDY #>Y_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_42R
LDY #>CONST_42R
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<Y_REG
LDY #>Y_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_P[]
LDY #>VAR_P[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR ARGDIV
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<CONST_95R
LDY #>CONST_95R
STY TMP3_ZP+1
LDX #<Y_REG
LDY #>Y_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_5R
LDY #>CONST_5R
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<Y_REG
LDY #>Y_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_P[]
LDY #>VAR_P[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDY #4
LDA #0
STY A_REG
STA A_REG+1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC = FAC<<A
JSR SHL
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR ARGADD
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF89+1
STA MOVBSELF89+2
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF89:
STY $FFFF
LDA #<CONST_42R
LDY #>CONST_42R
JSR REALFAC
LDA #<VAR_Q
LDY #>VAR_Q
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
JSR PUSHREAL
LDA #<VAR_P[]
LDY #>VAR_P[]
STA G_REG
STY G_REG+1
LDY #3
LDA #0
JSR ARRAYACCESS_REAL_INT
; Optimizer rule: Array index is integer (load)/7
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<CONST_9R
LDY #>CONST_9R
STY TMP3_ZP+1
LDX #<Y_REG
LDY #>Y_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<CONST_42R
LDY #>CONST_42R
STY TMP3_ZP+1
LDX #<X_REG
LDY #>X_REG
JSR COPY2_XYA
; Optimizer rule: Memory saving copy/4
; Optimizer rule: Quick copy into REG/7
LDA #<Y_REG
LDY #>Y_REG
; Real in (A/Y) to FAC
JSR REALFACPUSH
; Optimizer rule: Load and PUSH combined/1
LDA #<VAR_P[]
LDY #>VAR_P[]
JSR ARRAYACCESS_REAL_S
; Optimizer rule: Memory saving array access (real)/3
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR FASTAND
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
; Optimizer rule: Faster logic AND/1
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
LDY #6
LDA #0
STY A_REG
STA A_REG+1
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC = FAC<<A
JSR SHL
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL2X
; Optimizer rule: POPREAL and load X/1
JSR ARGADD
; Optimizer rule: POP, REG0, VAR0 -> direct calc/5
LDX #<X_REG
LDY #>X_REG
; FAC to (X/Y)
JSR FACMEM
JSR POPREAL
JSR FACWORD
; Optimizer rule: POP, REG0, VAR0 -> to WORD/2
STY MOVBSELF90+1
STA MOVBSELF90+2
LDA #<X_REG
LDY #>X_REG
; Real in (A/Y) to FAC
JSR REALFAC
; FAC to integer in Y/A
JSR FACWORD
MOVBSELF90:
STY $FFFF
LDA #<CONST_9R
LDY #>CONST_9R
JSR REALFAC
LDA #<VAR_Q
LDY #>VAR_Q
JSR MEMARG
JSR ARGADD
; Optimizer rule: Highly simplified loading for calculations/7
; Optimizer rule: FAC into REG?, REG? into FAC/0
LDX #<VAR_Q
LDY #>VAR_Q
; FAC to (X/Y)
JSR FACMEM
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_9
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_9:
LDA #0
STA A_REG
STA A_REG+1
JSR NEXT
; Optimizer rule: NEXT with no variable name simplified/4
LDA A_REG
BNE RBEQ_10
JMP (JUMP_TARGET)
; Optimizer rule: NEXT check simplified/4
RBEQ_10:
JSR RETURN
RTS
;
LINE_81:
;
;
LINE_82:
;
;
LINE_83:
;
;
LINE_84:
;
JSR END
RTS
; *** SUBROUTINES ***
;###################################
START		LDA ENDSTRBUF+1
BNE ENDGIVEN
LDA 55
STA ENDSTRBUF
LDA 56
STA ENDSTRBUF+1
ENDGIVEN	LDA #<FPSTACK
LDY #>FPSTACK
STA FPSTACKP
STY FPSTACKP+1
LDA #<FORSTACK
LDY #>FORSTACK
STA FORSTACKP
STY FORSTACKP+1
LDA #0
STA CONCATBUFP
LDA #<STRBUF
LDY #>STRBUF
STA STRBUFP
STY STRBUFP+1
STA HIGHP
STY HIGHP+1
LDA #0
STA LASTVAR
STA LASTVAR+1
JSR INITVARS
LDA #0
STA CMD_NUM
STA CHANNEL
TAY
TAX
STA $C6
JSR RESTORE
CLC
RTS
;###################################
;###################################
INITNARRAY
STA TMP_ZP
STY TMP_ZP+1
LDY #0
LDA #0
NINITLOOP	STA (TMP_ZP),Y
INC TMP_ZP
BNE NLOOPNOV
INC TMP_ZP+1
NLOOPNOV	LDX TMP2_ZP
BNE NLOOPNOV2
DEC TMP2_ZP+1
NLOOPNOV2	DEC TMP2_ZP
BNE NINITLOOP
LDX TMP2_ZP+1
BNE NINITLOOP
RTS
;###################################
;###################################
INITSTRARRAY
STA TMP_ZP
STY TMP_ZP+1
SINITLOOP	LDY #0
LDA #<EMPTYSTR
STA (TMP_ZP),Y
LDA #>EMPTYSTR
INY
STA (TMP_ZP),Y
CLC
LDA TMP_ZP
ADC #2
STA TMP_ZP
BCC SLOOPNOV1
INC TMP_ZP+1
SLOOPNOV1	SEC
LDA TMP2_ZP
SBC #2
STA TMP2_ZP
BCS SLOOPNOV2
DEC TMP2_ZP+1
SLOOPNOV2	LDA TMP2_ZP
BNE SINITLOOP
LDA TMP2_ZP+1
BNE SINITLOOP
RTS
;###################################
;###################################
INITSPARAMS	SEC
SBC #2
STA TMP_ZP
TYA
SBC #0
STA TMP_ZP+1
LDY #0
LDA (TMP_ZP),Y
STA TMP2_ZP
INY
LDA (TMP_ZP),Y
STA TMP2_ZP+1
RTS
;##################################
;##################################
INITSTRVARS	LDA #<STRINGVARS_START		; Reset all string variables...
LDY #>STRINGVARS_START
CMP #<STRINGVARS_END
BNE INITIT1
CPY #>STRINGVARS_END
BNE INITIT1
JMP INITSA2					; No string variables at all
INITIT1		STA TMP_ZP
STY TMP_ZP+1
LDY #0
INITSTRLOOP	LDA #<EMPTYSTR
STA (TMP_ZP),Y
INY
LDA #>EMPTYSTR
STA (TMP_ZP),Y
DEY
LDA TMP_ZP
CLC
ADC #2
STA TMP_ZP
LDA TMP_ZP+1
ADC #0
STA TMP_ZP+1
CMP #>STRINGVARS_END
BNE INITSTRLOOP
LDA TMP_ZP
CMP #<STRINGVARS_END
BNE INITSTRLOOP
INITSA2		LDA #<STRINGARRAYS_START	; ...and all string arrays
LDY #>STRINGARRAYS_START
CMP #<STRINGARRAYS_END
BNE ARRAYLOOP
CPY #>STRINGARRAYS_END
BNE ARRAYLOOP
RTS							;...no string array at all
ARRAYLOOP	CLC
ADC #3
BCC ARRAYSKIP1
INY
ARRAYSKIP1	CPY #>STRINGARRAYS_END
BEQ ARRAYSC
BCC ARRAYSKIP2
JMP ARRAYQUIT
ARRAYSC		CMP #<STRINGARRAYS_END
BCS ARRAYQUIT
ARRAYSKIP2	STA TMP_REG
STY TMP_REG+1
JSR INITSPARAMS
LDA TMP_REG
LDY TMP_REG+1
JSR INITSTRARRAY
LDA TMP_ZP
LDY TMP_ZP+1
JMP ARRAYLOOP
ARRAYQUIT	RTS
;###################################
;###################################
END			LDX SP_SAVE
TXS
RTS
;###################################
;###################################
RUN			LDX SP_SAVE
TXS
JMP PROGRAMSTART
;###################################
;###################################
RESTORE		LDA #<DATAS
LDY #>DATAS
STA DATASP
STY DATASP+1
RTS
;###################################
;###################################
MID			LDA #<D_REG
LDY #>D_REG
JSR REALFAC
JSR SGNFAC
ROL
BCC MIDLENGTH		; an actual length was given...
JSR STRFUNCINT		; ...no, it wasn't.
LDA TMP_REG			; copy start position from TMP_REG into TMP_REG+1
STA TMP_REG+1
BNE MIDOK2
JMP ILLEGALQUANTITY	; start has to be larger than 0
MIDOK2		DEC TMP_REG+1		; BASIC starts at 1, we start at 0
LDA (TMP_ZP),Y
SEC
SBC TMP_REG+1
STA TMP_REG			; store the calculated length
BCS	MIDNOV
STY TMP_REG			; Set length to 0, if start>string length
JMP MIDNOV
MIDLENGTH	JSR FACWORD
STY TMP2_REG		; save the length in TMP2_REG
JSR STRFUNCINT
LDA TMP_REG			; copy start position from TMP_REG into TMP_REG+1
BNE MIDOK
JMP ILLEGALQUANTITY	; start has to be larger than 0
MIDOK		LDX TMP2_REG
STX TMP_REG			; store the length saved above in TMP_REG
STA TMP_REG+1
DEC TMP_REG+1		; BASIC starts at 1, we start at 0
MIDNOV		LDA TMP_REG+1		; the starting position
CLC
ADC TMP_REG			; add the length
BCS MIDCLAMP
CMP (TMP_ZP),Y
BCS	MIDCLAMP
MIDCOPY		JMP STRFUNC
MIDCLAMP	LDA (TMP_ZP),Y		; Clamp to the string's length, if needed...
SEC
SBC TMP_REG+1
STA TMP_REG
BCS MIDCOPY
STY TMP_REG
JMP MIDCOPY
;###################################
;###################################
STRFUNCINT 	LDA B_REG			;the source string
STA TMP_ZP
LDA B_REG+1
STA TMP_ZP+1
LDA #<C_REG
LDY #>C_REG
JSR REALFAC
JSR FACWORD
STY TMP_REG			; store the parameter
LDY #0
RTS
;###################################
;###################################
; Generic function for string function like for left$, right$ and mid$. It reuses the actual code to
; copy strings for an assignment but it jumps into it at a "copy only" stage. However, it still assumes
; that the source pointer points towards the length of the source string and it resets the concat buffer pointer.
; These are both behaviours that we have to adapt to, so we are adjusting and/or saving/restoring some values here.
STRFUNC		LDA TMP_REG+1
BEQ STARTATZERO
LDA TMP_ZP
CLC
ADC TMP_REG+1
STA TMP_ZP
BCC STARTATZERO
INC TMP_ZP+1
STARTATZERO	LDY #0
LDA (TMP_ZP),Y
PHA					; save the first byte of the source string on the stack
LDA CONCATBUFP		; save the current concatbuffer position...
PHA
LDA TMP_REG
BNE STRFUNCNZ
LDA #<EMPTYSTR
STA A_REG
LDA #>EMPTYSTR
STA A_REG+1
JMP EXITSTRFUNC
STRFUNCNZ	STA (TMP_ZP),Y
LDA #<A_REG
LDY #>A_REG
STA TMP2_ZP
STY TMP2_ZP+1
JSR COPYONLY
EXITSTRFUNC	PLA
STA CONCATBUFP		; and restore it (because COPYONLY nulls it)
PLA
LDY #0
STA (TMP_ZP),Y		; restore the first byte of the source string on the stack
RTS
;###################################
;###################################
STR			LDA #<Y_REG
LDY #>Y_REG
JSR REALFAC
STRINT		LDY #0
JSR FACSTR
LDY #0
STY TMP_ZP+1
LDA #$FE
STA TMP_ZP
DEY
STRLOOP		INY
LDA $00FF,Y
BNE STRLOOP
INY
STY $FE
TYA
TAX			; Length in X
LDA #<A_REG
LDY #>A_REG
STA TMP2_ZP
STY TMP2_ZP+1
LDA CONCATBUFP	; save the current concatbuffer position...
PHA
JSR COPYONLY
PLA
STA CONCATBUFP	; and restore it (because COPYONLY nulls it)
RTS
;###################################
;###################################
TAB			JSR TABSPCINIT
JSR REROUTE
LDA CMD_NUM
BEQ NORMALTAB		; No reroute? Normal TAB
CMP #3
BEQ NORMALTAB2		; To screen? Normal TAB
JMP TABCHANNEL2
NORMALTAB2	JSR CLRCH
NORMALTAB	SEC
JMP TABSPC
;###################################
;###################################
SPC			JSR TABSPCINIT
JSR REROUTE
LDA CMD_NUM
BEQ NORMALSPC		; No reroute? Normal SPC
CMP #3
BEQ NORMALSPC2		; To screen? Normal SPC
JMP TABCHANNEL2
NORMALSPC2	JSR CLRCH
NORMALSPC	CLC
JMP TABSPC
;###################################
;###################################
TABSPCINIT	SEC
JSR CRSRPOS
STY $09
LDA #<Y_REG
LDY #>Y_REG
JSR REALFAC
JSR FACWORD
TYA
TAX
RTS
;###################################
;###################################
TABSPC	    BCC DOSPC
TXA
SBC $09
BCC TABSPCQUIT
TAX
DOSPC		INX
TABSPCLOOP  DEX
BNE TABSPCRIGHT
TABSPCQUIT	RTS
TABSPCRIGHT	JSR CRSRRIGHT
JMP TABSPCLOOP
;###################################
;###################################
LEN			LDA B_REG
STA TMP_ZP
LDA B_REG+1
STA TMP_ZP+1
LDY #0
LDA (TMP_ZP),Y
TAY
LDA #0
JSR INTFAC
LDX #<X_REG
LDY #>X_REG
JMP FACMEM	;RTS is implicit
;###################################
;###################################
ASC			LDA B_REG
STA TMP_ZP
LDA B_REG+1
STA TMP_ZP+1
LDY #0
LDA (TMP_ZP),Y
BNE DOASC
JMP ILLEGALQUANTITY
DOASC		INY
LDA (TMP_ZP),Y
TAY
LDA #0
JSR INTFAC
LDX #<X_REG
LDY #>X_REG
JMP FACMEM
;###################################
;###################################
SAVEPOINTERS
LDA TMP_ZP			; ...save the pointers
STA STORE1
LDA TMP_ZP+1
STA STORE1+1
LDA TMP2_ZP
STA STORE2
LDA TMP2_ZP+1
STA STORE2+1
LDA TMP3_ZP
STA STORE3
LDA TMP3_ZP+1
STA STORE3+1
RTS
;###################################
;###################################
RESTOREPOINTERS
LDA STORE3+1		; ...restore the pointers
STA TMP3_ZP+1
LDA STORE3
STA TMP3_ZP
LDA STORE2+1
STA TMP2_ZP+1
LDA STORE2
STA TMP2_ZP
LDA STORE1+1
STA TMP_ZP+1
LDA STORE1
STA TMP_ZP
RTS
;###################################
;###################################
COMPACT
LDY #0
GCBUFNE		LDA (TMP_ZP),Y		; Get the source's length
STA TMP4_REG		; ...and store it
LDA STRBUFP+1		; First, check if the new string would fit into memory...
STA TMP4_REG+1		; For that, we have to calculate the new strbufp after adding the string
LDA STRBUFP
CLC
ADC TMP4_REG
STA TMP4_REG
BCC	RGCNOOV1
INC TMP4_REG+1
RGCNOOV1	CLC
LDA TMP4_REG
ADC #3
STA TMP4_REG
BCC	RGCNOOV2
INC TMP4_REG+1
RGCNOOV2	LDA TMP4_REG+1		; Now do the actual check
CMP ENDSTRBUF+1
BEQ RGCLOW1
BCS GCEXE			; Doesn't fit, run GC!
JMP RGCEXIT
RGCLOW1		LDA TMP4_REG
CMP ENDSTRBUF
BCS	GCEXE			; This also triggers if it would fit exactly...but anyway...
RGCEXIT		RTS					; It fits? Then exit without GC
;###################################
;###################################
GCEXE		JSR SAVEPOINTERS
LDA #0
STA LASTVAR
STA LASTVAR+1		; reset the last variable pointer to 0
LDA #<STRBUF
STA TMP_ZP
STA GCSTART
LDA #>STRBUF
STA TMP_ZP+1		; Pointer into the string memory, initialized to point at the start...
STA GCSTART+1
GCLOOP		LDY #0
LDA TMP_ZP
STA GCWORK
LDA TMP_ZP+1
STA GCWORK+1		; store the pointer for later use...
LDA (TMP_ZP),Y
STA GCLEN			; store the length
INC TMP_ZP
BNE GCLOOPNOOV
INC TMP_ZP+1
GCLOOPNOOV	LDA TMP_ZP
CLC
ADC GCLEN
STA TMP_ZP
BCC GCLOOPNOOV2
INC TMP_ZP+1		; TMP_ZP now points to the reference to the string variable that used this chunk once
GCLOOPNOOV2 LDY #0
LDA (TMP_ZP),Y
STA TMP2_ZP
INY
LDA (TMP_ZP),Y
STA TMP2_ZP+1		; Store the variable reference in TMP2_ZP
LDA TMP_ZP
CLC
ADC #2
STA TMP_ZP
BCC GCLOOPNOOV3
INC TMP_ZP+1		; adjust the pointer to point to the next entry
GCLOOPNOOV3 LDY #0
LDA (TMP2_ZP),Y
CMP GCWORK
BNE GCKLOOP
INY
LDA (TMP2_ZP),Y
CMP GCWORK+1
BEQ MEMFREE
GCKLOOP		LDA TMP_ZP+1		; Check if we have processed all of the string memory...
CMP HIGHP+1
BEQ GCHECKLOW
BCC GCLOOP
JMP GCDONE
GCHECKLOW	LDA TMP_ZP
CMP HIGHP
BCS GCDONE
JMP GCLOOP
MEMFREE		LDA GCSTART			; found a variable that points to this chunk...
CMP GCWORK			; ...then check if the can be copied down. This is the case if GCSTART!=GCWORK
BNE COPYDOWN
LDA GCSTART+1
CMP GCWORK+1
BNE COPYDOWN
LDA TMP_ZP			; GCSTART==GCWORK...adjust GCSTART and continue
STA GCSTART
LDA TMP_ZP+1
STA GCSTART+1
JMP	GCKLOOP			; continue if needed...
COPYDOWN	LDA GCSTART			; There's a gap in memory, so copy the found variable down to GCSTART and adjust GCSTART accordingly
STA TMP_REG
LDA GCSTART+1
STA TMP_REG+1		; set the target location...
LDA GCWORK
STA TMP2_REG
LDA GCWORK+1
STA TMP2_REG+1		; set the source location...
LDA TMP_ZP
SEC
SBC GCWORK
STA TMP3_REG
LDA TMP_ZP+1
SBC GCWORK+1
STA TMP3_REG+1		; set the length
LDA GCSTART
CLC
ADC TMP3_REG
STA GCSTART
LDA GCSTART+1
ADC TMP3_REG+1
STA GCSTART+1		; update GCSTART to point to the next free chunk
JSR QUICKCOPY		; copy the chunk down to (former, now stored in TMP_REG) GCSTART
LDY #0
LDA TMP_REG
STA (TMP2_ZP),Y
INY
LDA TMP_REG+1
STA (TMP2_ZP),Y		; ...and adjust the pointer to the memory in the variable to that new location
JMP GCKLOOP
GCDONE		LDA GCSTART
STA HIGHP
STA STRBUFP
LDA GCSTART+1
STA HIGHP+1
STA STRBUFP+1		; Update the string pointers to the new, hopefully lower position
GCSKIP		JSR RESTOREPOINTERS
RTS					; Remember: GC has to adjust highp as well!
;###################################
;###################################
QUICKCOPY	LDA TMP_REG		; a self modifying copy routine
STA TMEM+1
LDA TMP_REG+1
STA TMEM+2
LDA TMP2_REG
STA SMEM+1
LDA TMP2_REG+1
STA SMEM+2
LDY #$0
LDX TMP3_REG
BNE QCLOOP
LDA TMP3_REG+1
BEQ QCEXIT		; length is null, nothing to copy
QCLOOP
SMEM		LDA $0000,Y
TMEM		STA $0000,Y
INY
BNE YNOOV
INC TMEM+2
INC SMEM+2
YNOOV		DEX
BNE QCLOOP
LDA TMP3_REG+1
BEQ QCEXIT
DEC TMP3_REG+1
JMP QCLOOP
QCEXIT		RTS
;###################################
;###################################
COPYSTRING	STA TMP2_ZP
STY TMP2_ZP+1
CPY TMP_ZP+1
BNE CONTCOPY
LDA TMP2_ZP
CMP TMP_ZP
BNE CONTCOPY
RTS					; A copy from a variable into the same instance is pointless an will be ignored.
CONTCOPY	JSR COMPACT			; Do a GC if needed
LDY #0
STY TMP_FLAG
LDA (TMP_ZP),Y
BNE NOTEMPTYSTR
LDA #<EMPTYSTR		; The source is empty? Then assign the empty string constant instead
STA TMP_ZP
LDA #>EMPTYSTR
STA TMP_ZP+1
JMP ISCONST
NOTEMPTYSTR	TAX					; Store the length of the source in X...this is valid until right to the end, where it's not longer used anyway
LDA (TMP2_ZP),Y
STA TMP3_ZP
INY
LDA (TMP2_ZP),Y
STA TMP3_ZP+1
DEY
LDA TMP_ZP+1		; Check if the source is a constant (upper bound). If so, don't copy it but just point to it
CMP #>CONSTANTS_END
BEQ CHECKLOW1
BCS INVAR
JMP CHECKNEXT
CHECKLOW1	LDA TMP_ZP
CMP #<CONSTANTS_END
BCS INVAR
CHECKNEXT	LDA TMP_ZP+1		; Check if the source is a constant (lower bound). If so, don't copy it but just point to it
CMP #>CONSTANTS
BEQ CHECKLOW3
BCC INVAR
JMP ISCONST
CHECKLOW3	LDA TMP_ZP
CMP #<CONSTANTS
BCC INVAR			; No, it's not a constant. It's something from lower memory...
ISCONST		JSR CHECKLASTVAR	; Reclaim formerly used memory if possible
LDA TMP_ZP
STA (TMP2_ZP),Y		; Yes, it's a constant...
INY
LDA TMP_ZP+1
STA (TMP2_ZP),Y
LDA HIGHP			; Reset the memory pointer to the last assigned one. Everything that came later has to be temp. data
STA STRBUFP
LDA HIGHP+1
STA STRBUFP+1
RTS
INVAR		INY
LDA (TMP2_ZP),Y		; Check if the target is currently pointing into the constant pool. If so, don't update that memory by accident
CMP #>CONSTANTS_END
BEQ CHECKLOW2
BCS INVAR2
JMP PUPDATEPTR
CHECKLOW2	DEY
LDA (TMP2_ZP),Y
CMP #<CONSTANTS_END
BCS INVAR2
JMP PUPDATEPTR
INVAR2		LDY #0			; The target is somewhere in var memory (i.e. not in constant memory)
LDA (TMP3_ZP),Y
STA TMP_REG
TXA
CMP TMP_REG		; Compare the string-to-copy's length (in A) with the variable's current one (in TMP_REG)
BEQ UPDATEHP2	; does the new string fit into the old memory location (i.e. is it the same length)?
; Shorter strings would fit as well, but aren't stored this way or otherwise, the result would
; be some stray memory chunk that none could identify properly when doing a GC
PUPDATEPTR	JSR CHECKLASTVAR
LDY #1			; No? Then new memory has to be used. Update the "highest memory position" in the process
STY TMP_FLAG	; to regain temp. memory used for non-assigned strings like for printing and such...
JMP UPDATEPTR	; ...we set a flag here to handle this case later
UPDATEHP2	LDA HIGHP		; Update the memory pointer to the last assigned position, reclaim some memory this way
STA STRBUFP
LDA HIGHP+1
STA STRBUFP+1
JMP STRFITS
COPYONLY	LDY #0
STY TMP_FLAG
JMP CHECKMEM
ALTCOPY		JMP COPYSTRING2
UPDATEPTR	LDA TMP_ZP+1	; Check if the new string comes after or equals highp, which indicates that it can be
CMP HIGHP+1		; "copied down". This is another routine, because of...reasons...
BEQ CHECKXT1
BCS ALTCOPY
JMP CHECKMEM
CHECKXT1	LDA TMP_ZP
CMP HIGHP
BCS ALTCOPY
CHECKMEM
MEMOK		LDY #0
LDA STRBUFP		; no, then copy it into string memory later...
STA (TMP2_ZP),Y	; ...but update the string memory pointer now
STA TMP3_ZP
LDA STRBUFP+1
INY
STA (TMP2_ZP),Y
STA TMP3_ZP+1
TXA
CLC
ADC STRBUFP
PHP
CLC
ADC #3
STA STRBUFP
BCC NOCS1
INC STRBUFP+1
NOCS1		PLP
BCC STRFITS
INC STRBUFP+1
STRFITS		LDY TMP_FLAG	; Check if the pointer to the highest mem addr used by an actual string
BEQ NOHPUPDATE	; has to be updated and do that...
LDA HIGHP+1
CMP STRBUFP+1
BCC UPDATEHIGHP
BEQ CHECKNEXTHP
JMP NOHPUPDATE
CHECKNEXTHP	LDA HIGHP
CMP	STRBUFP
BCC UPDATEHIGHP
JMP NOHPUPDATE
UPDATEHIGHP	LDA STRBUFP
STA HIGHP
LDA STRBUFP+1
STA HIGHP+1		; set new pointer
JSR REMEMBERLASTVAR
JSR STOREVARREF
NOHPUPDATE	LDY #0
LDA (TMP_ZP),Y	; Set the new length...
STA (TMP3_ZP),Y
TAY				; Copy length to Y
BEQ	EXITCOPY	; Length 0? nothing to copy then...
LOOP		LDA (TMP_ZP),Y	; Copy the actual string
STA (TMP3_ZP),Y
DEY
BNE LOOP
EXITCOPY	LDA #0
STA CONCATBUFP	; Reset the work buffer
RTS
;###################################
;###################################
; Special copy routine that handles the case that a string is >highp but might interleave with the temp data that has to be copied into it.
; Therefor, this routine copies from lower to higher addresses and not vice versa like the simpler one above.
COPYSTRING2	LDY #0
LDA (TMP_ZP),Y
STA TMP_REG
TAX
LDA HIGHP
STA TMP3_ZP
STA (TMP2_ZP),Y
LDA HIGHP+1
STA TMP3_ZP+1
INY
STA (TMP2_ZP),Y
JSR REMEMBERLASTVAR
; Do a quick test, if a real copy is needed or if the memory addrs are equal anyway?
; This introduces some overhead but according to my tests, its actually faster this way.
LDA TMP_ZP
CMP TMP3_ZP
BNE DOLOOP
LDA TMP_ZP+1
CMP TMP3_ZP+1
BEQ SKIPCP2
DOLOOP		DEY
TXA
STA (TMP3_ZP),Y
INY
ASLOOP		LDA (TMP_ZP),Y
STA (TMP3_ZP),Y
INY
DEX
BNE	ASLOOP
SKIPCP2		LDA HIGHP
CLC
ADC TMP_REG
PHP
CLC
ADC #3
STA HIGHP
STA STRBUFP
BCC SKIPLOWAS1
INC HIGHP+1
SKIPLOWAS1	PLP
BCC SKIPLOWAS2
INC HIGHP+1
SKIPLOWAS2	LDA HIGHP+1
STA STRBUFP+1
LDA #0
STA CONCATBUFP	; Reset the work buffer
JSR STOREVARREF
RTS
;###################################
;###################################
; Checks if this variable is the same one that has been stored last. If so, we can reclaim its memory first.
CHECKLASTVAR
LDA TMP2_ZP
CMP LASTVAR
BNE NOTSAMEVAR
LDA TMP2_ZP+1
CMP LASTVAR+1
BNE NOTSAMEVAR
LDA LASTVARP			; The target is the last string that has been added. We can free it's currently used memory then.
STA HIGHP
STA STRBUFP
LDA LASTVARP+1
STA HIGHP+1
STA STRBUFP+1
NOTSAMEVAR	RTS
;###################################
;###################################
; Stores the last variable reference that has been stored in string memory.
REMEMBERLASTVAR
LDA TMP2_ZP
STA LASTVAR
LDA TMP2_ZP+1
STA LASTVAR+1
LDA TMP3_ZP
STA LASTVARP
LDA TMP3_ZP+1
STA LASTVARP+1	; Remember this variable as the last written one
RTS
;###################################
;###################################
; Appends a reference to the variable at the end of the string in memory for
; easier GC later...
STOREVARREF
TYA
PHA				; Save Y reg
LDA TMP_ZP
PHA
LDA TMP_ZP+1
PHA
LDA HIGHP+1
STA TMP_ZP+1
LDA HIGHP
SEC
SBC #2
STA TMP_ZP
BCS RLVNOOV
DEC TMP_ZP+1
RLVNOOV		LDA TMP2_ZP
LDY #0
STA (TMP_ZP),Y
LDA TMP2_ZP+1
INY
STA (TMP_ZP),Y	; Store the reference to the variable that uses this chunk of memory at the end of the string
PLA
STA TMP_ZP+1
PLA
STA TMP_ZP		; ...restore TMP_ZP
PLA
TAY				; ...restore Y reg
RTS
;###################################
;###################################
REROUTE		LDA CMD_NUM		; if CMD mode, enable channel output
BEQ REROUTECMD
TAX
STA CHANNEL
JMP CHKOUT
REROUTECMD	RTS
;###################################
;###################################
RESETROUTE	LDA CMD_NUM		; if CMD mode, disable channel output
BEQ RESETROUTECMD
JMP CLRCH
RESETROUTECMD
RTS
;###################################
;###################################
STROUTWL	STA A_REG
STY A_REG+1
STROUT		JSR REROUTE
LDA A_REG
STA $22
LDA A_REG+1
STA $23
LDY #0
LDA ($22),Y
TAX
INC $22
BNE PRINTSTR
INC $23
PRINTSTR	JSR PRINTSTRS
LDA HIGHP			; Update the memory pointer to the last actually assigned one
STA STRBUFP
LDA HIGHP+1
STA STRBUFP+1
LDA #0
STA CONCATBUFP	; Reset the work buffer
JSR RESETROUTE
RTS
;###################################
;###################################
STROUTBRKWL	STA A_REG
STY A_REG+1
STROUTBRK	JSR REROUTE
LDA A_REG
STA $22
LDA A_REG+1
STA $23
LDY #0
LDA ($22),Y
TAX
INC $22
BNE PRINTSTR2
INC $23
PRINTSTR2	JSR PRINTSTRS
LDA HIGHP			; Update the memory pointer to the last actually assigned one
STA STRBUFP
LDA HIGHP+1
STA STRBUFP+1
LDA #0
STA CONCATBUFP	; Reset the work buffer
LDA #$0D
JSR CHROUT
JMP RESETROUTE 	;RTS is implicit
;###################################
;###################################
FRE
JSR GCEXE
LDA ENDSTRBUF
SEC
SBC STRBUFP
TAY
LDA ENDSTRBUF+1
SBC STRBUFP+1
JSR INTFAC
LDX #<X_REG
LDY #>X_REG
JMP FACMEM
;###################################
;###################################
ARRAYACCESS_REAL_S
STA G_REG
STY G_REG+1
ARRAYACCESS_REAL
LDA #<X_REG
LDY #>X_REG
JSR REALFAC
JSR FACINT
ARRAYACCESS_REAL_INT
LDX G_REG
STX TMP_ZP
LDX G_REG+1
STX TMP_ZP+1
STY TMP3_ZP
STA TMP3_ZP+1
TAX
TYA
ASL
TAY
TXA
ROL
TAX
TYA
ASL
STA TMP2_ZP
TXA
ROL
STA TMP2_ZP+1
LDA TMP_ZP
CLC
ADC TMP3_ZP
STA TMP_ZP
LDA TMP_ZP+1
ADC TMP3_ZP+1
STA TMP_ZP+1
LDA TMP_ZP
CLC
ADC TMP2_ZP
STA TMP3_ZP
LDA TMP_ZP+1
ADC TMP2_ZP+1
STA TMP3_ZP+1
LDX #<X_REG
STX TMP_ZP
LDY #>X_REG
STY TMP_ZP+1
JMP COPY3_XY	;RTS is implicit
;###################################
;###################################
ARRAYSTORE_REAL
LDA #<X_REG
LDY #>X_REG
JSR REALFAC
JSR FACINT
ARRAYSTORE_REAL_INT
LDX G_REG
STX TMP_ZP
LDX G_REG+1
STX TMP_ZP+1
STY TMP3_ZP
STA TMP3_ZP+1
TAX
TYA
ASL
TAY
TXA
ROL
TAX
TYA
ASL
STA TMP2_ZP
TXA
ROL
STA TMP2_ZP+1
LDA TMP_ZP
CLC
ADC TMP3_ZP
STA TMP_ZP
LDA TMP_ZP+1
ADC TMP3_ZP+1
STA TMP_ZP+1
LDA TMP_ZP
CLC
ADC TMP2_ZP
STA TMP_ZP
LDA TMP_ZP+1
ADC TMP2_ZP+1
STA TMP_ZP+1
LDA #<Y_REG
STA TMP3_ZP
LDY #>Y_REG
STY TMP3_ZP+1
JMP COPY3_XY	;RTS is implicit
;###################################
;###################################
INITFOR		LDA FORSTACKP
STA TMP_ZP
LDA FORSTACKP+1
STA TMP_ZP+1
LDY #0
LDA A_REG
STA (TMP_ZP),Y
INY
LDA A_REG+1
STA (TMP_ZP),Y
INY
LDA JUMP_TARGET
STA (TMP_ZP),Y
INY
LDA JUMP_TARGET+1
STA (TMP_ZP),Y
INY
STY TMP3_ZP
JSR INCTMPZP
JSR POPREAL
LDX TMP_ZP
LDY TMP_ZP+1
; FAC to (X/Y)
JSR FACMEM
JSR SGNFAC
STA TMP_FLAG
LDY #5
STY TMP3_ZP
JSR INCTMPZP
JSR POPREAL
LDX TMP_ZP
LDY TMP_ZP+1
; FAC to (X/Y)
JSR FACMEM
LDY #5
STY TMP3_ZP
JSR INCTMPZP
LDY #0
LDA TMP_FLAG
STA (TMP_ZP),Y
INY
LDA #1
STA (TMP_ZP),Y
INY
LDA #15
STA (TMP_ZP),Y
LDY #3
STY TMP3_ZP
JSR INCTMPZP
LDA TMP_ZP
STA FORSTACKP
LDA TMP_ZP+1
STA FORSTACKP+1
RTS
;###################################
;###################################
NEXT		LDA FORSTACKP
STA TMP_ZP
LDA FORSTACKP+1
STA TMP_ZP+1
SEARCHFOR	LDA TMP_ZP+1
STA TMP3_REG+1
LDA TMP_ZP
STA TMP3_REG
SEC
SBC #2
STA TMP_ZP
BCS NOPV1N1
DEC TMP_ZP+1
NOPV1N1		LDY #0
LDA (TMP_ZP),Y
BNE NOGOSUB
JMP NEXTWOFOR
NOGOSUB
INY
LDA TMP_ZP
SEC
SBC (TMP_ZP),Y
STA TMP_ZP
BCS NOPV1N2
DEC TMP_ZP+1
NOPV1N2		DEY
LDA A_REG
BEQ LOW0
CMPFOR		CMP (TMP_ZP),Y
BNE SEARCHFOR
LDA A_REG+1
INY
CMP (TMP_ZP),Y
BEQ FOUNDFOR
JMP SEARCHFOR
LOW0		LDX A_REG+1
BEQ FOUNDFOR
BNE CMPFOR
FOUNDFOR	LDA TMP_ZP
STA TMP2_REG
LDA TMP_ZP+1
STA TMP2_REG+1
VARREAL
LDY #0
STY A_REG+1 ; Has to be done anyway...so we can do it here as well
LDA (TMP_ZP),Y
TAX
INY
LDA (TMP_ZP),Y
TAY
TXA
JSR REALFAC
CALCNEXT	LDA TMP_ZP
CLC
ADC #4
STA TMP_ZP
BCC NOPV2IN
INC TMP_ZP+1
NOPV2IN		STA TMP_REG
LDY TMP_ZP+1
STY TMP_REG+1
JSR FACADD   ;M-ADD
LDA TMP2_REG
STA TMP_ZP
LDA TMP2_REG+1
STA TMP_ZP+1
STOREREAL
LDY #0
LDA (TMP_ZP),Y
TAX
INY
LDA (TMP_ZP),Y
TAY
JSR FACMEM	;FAC TO (X/Y)
CMPFOR		LDA #5
STA TMP3_ZP
LDA TMP_REG
CLC
ADC #5
STA TMP_REG
BCC NOPV3
INC TMP_REG+1
NOPV3		LDY TMP_REG+1
JSR CMPFAC 	;CMPFAC
BEQ LOOPING
PHA
LDY #14
LDA (TMP_ZP),Y
BEQ STEPZERO
ROL
BCC STEPPOS
STEPNEG		PLA
ROL
BCC LOOPING
BCS EXITLOOP
STEPPOS		PLA
ROL
BCC EXITLOOP
LOOPING		LDA TMP3_REG
STA FORSTACKP
LDA TMP3_REG+1
STA FORSTACKP+1
LDA TMP2_REG
CLC
ADC #2
STA TMP2_REG
BCC NOPV4IN
INC TMP2_REG+1
NOPV4IN		LDY #0
STY A_REG
STA TMP_ZP
LDA TMP2_REG+1
STA TMP_ZP+1
LDA (TMP_ZP),Y
STA JUMP_TARGET
INY
LDA (TMP_ZP),Y
STA JUMP_TARGET+1
RTS
STEPZERO	PLA
JMP LOOPING
EXITLOOP	LDA TMP2_REG
STA FORSTACKP
LDA TMP2_REG+1
STA FORSTACKP+1
LDA #1
STA A_REG
RTS
;###################################
;###################################
RETURN		LDA FORSTACKP
STA TMP_ZP
LDA FORSTACKP+1
STA TMP_ZP+1
SEARCHGOSUB	LDA TMP_ZP
SEC
SBC #2
STA TMP_ZP
BCS NOPV1SG
DEC TMP_ZP+1
NOPV1SG		LDY #0
LDA (TMP_ZP),Y
BEQ FOUNDGOSUB
INY
LDA (TMP_ZP),Y
STA TMP3_ZP
LDA TMP_ZP
SEC
SBC (TMP_ZP),Y
STA TMP_ZP
BCS NOPV1GS
DEC TMP_ZP+1
NOPV1GS		JMP SEARCHGOSUB
FOUNDGOSUB
LDA TMP_ZP
STA FORSTACKP
LDA TMP_ZP+1
STA FORSTACKP+1
RTS
;###################################
;###################################
GOSUB		LDA FORSTACKP
STA TMP_ZP
LDA FORSTACKP+1
STA TMP_ZP+1
LDY #0
TYA
STA (TMP_ZP),Y
INY
STA (TMP_ZP),Y
INY
TYA
CLC
ADC TMP_ZP
STA TMP_ZP
BCC GOSUBNOOV
INC TMP_ZP+1
GOSUBNOOV	LDA TMP_ZP
STA FORSTACKP
LDA TMP_ZP+1
STA FORSTACKP+1
RTS
;###################################
;###################################
READINIT	LDA DATASP
STA TMP3_ZP
LDA DATASP+1
STA TMP3_ZP+1
LDY #$0
LDA (TMP3_ZP),Y
INC TMP3_ZP
BNE READNOOV
INC TMP3_ZP+1
READNOOV	CMP #$FF
BNE MOREDATA
JMP OUTOFDATA
MOREDATA	RTS
;###################################
;###################################
READADDPTR	STX TMP_REG+1
LDA TMP3_ZP
CLC
ADC TMP_REG+1
STA TMP3_ZP
BCC READADDPTRX
INC TMP3_ZP+1
READADDPTRX	RTS
;###################################
;###################################
READNUMBER	JSR READINIT
MORENUMDATA CMP #$2				; Strings are not allowed here
BNE NUMNUM
LDA (TMP3_ZP),Y		; ...unless they are empty, which makes them count as 0
BEQ RNESTR
JMP SYNTAXERROR
RNESTR		LDA #0
LDY #0
JSR INTFAC
LDX #1
JSR READADDPTR
JMP NUMREAD
NUMNUM		CMP #$1
BEQ NUMREADREAL
CMP #$0
BEQ NUMREADINT
LDA (TMP3_ZP),Y
TAY
JSR BYTEFAC
LDX #1
JSR READADDPTR
JMP NUMREAD			; It's a byte
NUMREADINT	LDA (TMP3_ZP),Y		; It's an integer
STA TMP_REG
INY
LDA (TMP3_ZP),Y
LDY TMP_REG
JSR INTFAC
LDX #2
JSR READADDPTR
JMP NUMREAD
NUMREADREAL	LDA TMP3_ZP
LDY TMP3_ZP+1
JSR REALFAC
LDX #5
JSR READADDPTR
NUMREAD		JSR NEXTDATA
LDX #<Y_REG
LDY #>Y_REG
JMP FACMEM		; ...and return
;###################################
;###################################
READSTR		JSR READINIT
CMP #$2
BNE DATA2STR		; It's a number and has to be converted
LDA TMP3_ZP
STA A_REG
LDA TMP3_ZP+1
STA A_REG+1
LDA (TMP3_ZP),Y
CLC
ADC TMP3_ZP
STA TMP3_ZP
BCC READNOOV2
INC TMP3_ZP+1
READNOOV2	JSR NEXTDATA
INC DATASP
BNE READNOOV3
INC DATASP+1
READNOOV3	RTS
;###################################
;###################################
NEXTDATA	LDA TMP3_ZP			; Adjust pointer to the next element
STA DATASP
LDA TMP3_ZP+1
STA DATASP+1
RTS
;###################################
;###################################
DATA2STR	CMP #$1
BEQ DREAL2STR		; It's a floating point number...
CMP #$0
BEQ DATA2STRINT
LDA (TMP3_ZP),Y		; It's a byte
TAY
JSR BYTEFAC
LDX #1
JSR READADDPTR
JMP DFAC2STR
DATA2STRINT	LDA (TMP3_ZP),Y		; It's an integer
STA TMP_REG
INY
LDA (TMP3_ZP),Y
LDY TMP_REG
JSR INTFAC
LDX #2
JSR READADDPTR
JMP DFAC2STR
DREAL2STR	LDA TMP3_ZP
LDY TMP3_ZP+1
JSR REALFAC
LDX #5
JSR READADDPTR
DFAC2STR	JSR NEXTDATA
JSR STRINT
RTS
;###################################
;##################################
REALFACPUSH	STA TMP_ZP
STY	TMP_ZP+1
LDX FPSTACKP
LDY FPSTACKP+1
STX TMP2_ZP
STY TMP2_ZP+1
LDY #0
LDA (TMP_ZP),Y
STA (TMP2_ZP),Y
BEQ PUSHED0
INY
LDA (TMP_ZP),Y
STA (TMP2_ZP),Y
INY
LDA (TMP_ZP),Y
STA (TMP2_ZP),Y
INY
LDA (TMP_ZP),Y
STA (TMP2_ZP),Y
INY
LDA (TMP_ZP),Y
STA (TMP2_ZP),Y
PUSHED0		LDA FPSTACKP
CLC
ADC #5
STA FPSTACKP
BCC NOPVRFPXX
INC FPSTACKP+1
NOPVRFPXX	RTS
;###################################
;###################################
PUSHREAL	LDX FPSTACKP
LDY FPSTACKP+1
JSR FACMEM
LDA FPSTACKP
CLC
ADC #5
STA FPSTACKP
BCC NOPVPUR
INC FPSTACKP+1
NOPVPUR		RTS
;###################################
;###################################
POPREAL2X	LDA FPSTACKP
SEC
SBC #5
STA FPSTACKP
BCS NOPVPR2X
DEC FPSTACKP+1
NOPVPR2X	LDA FPSTACKP
LDY FPSTACKP+1
JSR REALFAC
LDA #<X_REG
LDY #>X_REG
JSR MEMARG
RTS
;###################################
;###################################
POPREAL		LDA FPSTACKP
SEC
SBC #5
STA FPSTACKP
BCS NOPVPR
DEC FPSTACKP+1
NOPVPR		LDA FPSTACKP
LDY FPSTACKP+1
JMP REALFAC
;###################################
;###################################
SHL			LDA $61
BEQ SHLOK
CLC
ADC A_REG
BCC SHLOK
LDA #0
STA $66
LDA #$FF
SHLOK		STA $61
RTS
;### HELPER ########################
;###################################
INCTMPZP	LDA TMP_ZP
CLC
ADC TMP3_ZP
STA TMP_ZP
BCC NOPV2
INC TMP_ZP+1
NOPV2		RTS
;###################################
;###################################
COPY2_XYA	STA TMP3_ZP
COPY2_XY	STX TMP_ZP
STY TMP_ZP+1
COPY3_XY	LDY #0
LDA (TMP3_ZP),Y
STA (TMP_ZP),Y
BEQ COPIED0			; Shortcut for 0 values...
INY
LDA (TMP3_ZP),Y
STA (TMP_ZP),Y
INY
LDA (TMP3_ZP),Y
STA (TMP_ZP),Y
INY
LDA (TMP3_ZP),Y
STA (TMP_ZP),Y
INY
LDA (TMP3_ZP),Y
STA (TMP_ZP),Y
RTS
COPIED0		INY
STA (TMP_ZP),Y
RTS
;###################################
;###################################
FASTAND		LDA $69			; Check ARG for 0
BNE CHECKFAC
STA $61
STA $66			; if so, set FAC to 0 and exit
RTS
CHECKFAC	LDA $61			; Check if there's a -1 in FAC1
BNE FACNOTNULL
STA $66			; make sure that it's not -0
RTS				; FAC is 0, then exit
FACNOTNULL	CMP #$81
BNE NORMALAND
LDA $62
CMP #$80
BNE NORMALAND
LDA $63
BNE NORMALAND
LDA $64
BNE NORMALAND
LDA $65
BNE NORMALAND
LDA $66
ROL
BCC NORMALAND
LDA $69			; Check if there's a -1 in ARG
CMP #$81
BNE NORMALAND
LDA $6A
CMP #$80
BNE NORMALAND
LDA $6B
BNE NORMALAND
LDA $6C
BNE NORMALAND
LDA $6D
BNE NORMALAND
LDA $6E
ROL
BCC NORMALAND
RTS				; both, FAC1 and ARG contain -1...then we leave FAC1 untouched and return
NORMALAND	JMP ARGAND
;###################################
;###################################
INITOUTCHANNEL
LDA #<C_REG
LDY #>C_REG
JSR REALFAC
JSR FACWORD
TYA
TAX
CPX CMD_NUM
BNE CMDNEQUAL
LDY #0
STY CMD_NUM			; Reset CMD channel
CMDNEQUAL	STA CHANNEL
JMP CHKOUT
;###################################
;###################################
TABCHANNEL
JSR INITOUTCHANNEL
TABCHANNELINT
LDA CHANNEL
CMP #3		; To the screen?
BEQ TABSCREEN
TABCHANNEL2	LDA $13
STA STORE1
LDA #1
STA $13		; Something that's not the screen...that's enough for the check the CRSRRIGHT does...
LDA #<Y_REG
LDY #>Y_REG
JSR REALFAC
JSR FACWORD
TYA
TAX
JMP EXITCHANNEL
TABSCREEN
JSR CLRCH
JMP TAB
;###################################
;###################################
EXITCHANNEL	CLC
JSR TABSPC
JSR CLRCH
LDA STORE1
STA $13
RTS
;###################################
;###################################
NEXTWOFOR	LDX #$0A
JMP $A437
;###################################
;###################################
OUTOFDATA	LDX #$0D
JMP $A437
;###################################
;###################################
ILLEGALQUANTITY
JMP $B248
;###################################
;###################################
SYNTAXERROR
JMP $AF08
;###################################
;###############################
INITVARS
JSR INITSTRVARS
LDA #0
STA VAR_V
STA VAR_V+1
STA VAR_I
STA VAR_I+1
STA VAR_X
STA VAR_X+1
STA VAR_L
STA VAR_L+1
STA VAR_D
STA VAR_D+1
STA VAR_K
STA VAR_K+1
STA VAR_QR
STA VAR_QR+1
STA VAR_J
STA VAR_J+1
STA VAR_B
STA VAR_B+1
STA VAR_C
STA VAR_C+1
STA VAR_S
STA VAR_S+1
STA VAR_U
STA VAR_U+1
STA VAR_Y
STA VAR_Y+1
STA VAR_F
STA VAR_F+1
STA VAR_G
STA VAR_G+1
STA VAR_Z
STA VAR_Z+1
STA VAR_E
STA VAR_E+1
STA VAR_R
STA VAR_R+1
STA VAR_SB
STA VAR_SB+1
STA VAR_JL
STA VAR_JL+1
STA VAR_LL
STA VAR_LL+1
STA VAR_LR
STA VAR_LR+1
STA VAR_JR
STA VAR_JR+1
STA VAR_N
STA VAR_N+1
STA VAR_Q
STA VAR_Q+1
STA VAR_O
STA VAR_O+1
STA VAR_H
STA VAR_H+1
LDA #<VAR_S[]
LDY #>VAR_S[]
JSR INITSPARAMS
LDA #<VAR_S[]
LDY #>VAR_S[]
JSR INITNARRAY
LDA #0
STA VAR_CD
STA VAR_CD+1
STA VAR_MC
STA VAR_MC+1
STA VAR_A
STA VAR_A+1
STA VAR_W
STA VAR_W+1
LDA #<VAR_P[]
LDY #>VAR_P[]
JSR INITSPARAMS
LDA #<VAR_P[]
LDY #>VAR_P[]
JSR INITNARRAY
LDA #0
RTS
;###############################
; *** SUBROUTINES END ***
SQRTTABLE
.BYTE 03 11 18 25 32 38 44 50
.BYTE 58 69 79 89 98 107 115 123
; *** CONSTANTS ***
CONSTANTS
; CONST: #30


; CONST: #240


; CONST: #150


; CONST: #36874

CONST_3	.REAL 36874
; CONST: #5

CONST_4R	.REAL 5.0
; CONST: #1

CONST_5R	.REAL 1.0
; CONST: #0.0

CONST_6	.REAL 0.0
; CONST: #0

CONST_7R	.REAL 0.0
; CONST: #1.1

CONST_8	.REAL 1.1
; CONST: #3

CONST_9R	.REAL 3.0
; CONST: #9

CONST_10R	.REAL 9.0
; CONST: ${clr}{down}
CONST_11	.BYTE 11
	.STRG "{clr}{down}"
; CONST: #6

CONST_12R	.REAL 6.0
; CONST: ${rvon}{yel}          {red}{cm-asterisk}{rvof}
CONST_13	.BYTE 45
	.STRG "{rvon}{yel}          {red}{cm-asterisk}{rvof}"
; CONST: ${rvon}{yel} kweepout {red} {rvof}
CONST_14	.BYTE 33
	.STRG "{rvon}{yel} kweepout {red} {rvof}"
; CONST: ${rvon}{yel}          {red} {rvof}
CONST_15	.BYTE 33
	.STRG "{rvon}{yel}          {red} {rvof}"
; CONST: ${red}{cm-asterisk}{rvon}          {rvof}
CONST_16	.BYTE 40
	.STRG "{red}{cm-asterisk}{rvon}          {rvof}"
; CONST: ${down}{down}{cyn}6502ad: evil kweepoids{down}block the space lanes.
CONST_17	.BYTE 67
	.STRG "{down}{down}{cyn}6502ad: evil kweepoids{down}block the space lanes."
; CONST: ${down}a bat is bred with one{down}purpose - destruction!{down}{grn}
CONST_18	.BYTE 67
	.STRG "{down}a bat is bred with one{down}purpose - destruction!{down}{grn}"
; CONST: $   by: steve mccrea     (c)2012 kweepa.com
CONST_19	.BYTE 42
	.STRG "   by: steve mccrea     (c)2012 kweepa.com"
; CONST: ${down}{down}{red}  press fire to play
CONST_20	.BYTE 37
	.STRG "{down}{down}{red}  press fire to play"
; CONST: #37145

CONST_21	.REAL 37145
; CONST: #127


; CONST: #8

CONST_23R	.REAL 8.0
; CONST: #32

CONST_24R	.REAL 32.0
; CONST: #8142

CONST_25	.REAL 8142
; CONST: #30720

CONST_26	.REAL 30720
; CONST: #200

CONST_27R	.REAL 200.0
; CONST: #255


; CONST: #7680

CONST_29	.REAL 7680
; CONST: #505

CONST_30	.REAL 505
; CONST: #160

CONST_31R	.REAL 160.0
; CONST: #38400.0

CONST_32	.REAL 38400.0
; CONST: #8163

CONST_33	.REAL 8163
; CONST: #59


; CONST: #38883.0

CONST_35	.REAL 38883.0
; CONST: ${home}
CONST_36	.BYTE 6
	.STRG "{home}"
; CONST: #20

CONST_37R	.REAL 20.0
; CONST: ${down}
CONST_38	.BYTE 6
	.STRG "{down}"
; CONST: ${rght}{rght}{rght}{rght}{rght}{rght}{rvon}{red}
CONST_39	.BYTE 47
	.STRG "{rght}{rght}{rght}{rght}{rght}{rght}{rvon}{red}"
; CONST: #44

CONST_40R	.REAL 44.0
; CONST: #128

CONST_41R	.REAL 128.0
; CONST: #2

CONST_42R	.REAL 2.0
; CONST: #12

CONST_43R	.REAL 12.0
; CONST: #22

CONST_44R	.REAL 22.0
; CONST: #7724.0

CONST_45	.REAL 7724.0
; CONST: #48

CONST_46R	.REAL 48.0
; CONST: #7

CONST_47R	.REAL 7.0
; CONST: #0.5

CONST_48	.REAL 0.5
; CONST: #-0.4

CONST_49	.REAL -0.4
; CONST: #140


; CONST: #10

CONST_51R	.REAL 10.0
; CONST: #440

CONST_52	.REAL 440
; CONST: #16

CONST_53R	.REAL 16.0
; CONST: #19

CONST_54R	.REAL 19.0
; CONST: #-22.0

CONST_55	.REAL -22.0
; CONST: #56


; CONST: #57


; CONST: #58


; CONST: #60

CONST_59R	.REAL 60.0
; CONST: #-1

CONST_60	.REAL -1
; CONST: #21

CONST_61R	.REAL 21.0
; CONST: #-1.0

CONST_62	.REAL -1.0
; CONST: #4

CONST_63R	.REAL 4.0
; CONST: $lost  ball
CONST_64	.BYTE 10
	.STRG "lost  ball"
; CONST: $game  over
CONST_65	.BYTE 10
	.STRG "game  over"
; CONST: #100

CONST_66R	.REAL 100.0
; CONST: #1000

CONST_67	.REAL 1000
; CONST: #0.1

CONST_68	.REAL 0.1
; CONST: #8190

CONST_69	.REAL 8190
; CONST: #49


; CONST: #46


; CONST: #47


; CONST: #50


; CONST: #51


; CONST: #52


; CONST: #53


; CONST: #54


; CONST: #55


; CONST: $          
CONST_79	.BYTE 10
	.STRG "          "
; CONST: ${left}{left}{left}{left}{left}{left}{left}{left}{left}{left}
CONST_80	.BYTE 60
	.STRG "{left}{left}{left}{left}{left}{left}{left}{left}{left}{left}"
; CONST: #999

CONST_81	.REAL 999
; CONST: $press fire
CONST_82	.BYTE 10
	.STRG "press fire"
; CONST: #8119

CONST_83	.REAL 8119
; CONST: #8120.0

CONST_84	.REAL 8120.0
; CONST: #0.3

CONST_85	.REAL 0.3
; CONST: $sticky bat
CONST_86	.BYTE 10
	.STRG "sticky bat"
; CONST: #0.7

CONST_87	.REAL 0.7
; CONST: $extra ball
CONST_88	.BYTE 10
	.STRG "extra ball"
; CONST: $500 points
CONST_89	.BYTE 10
	.STRG "500 points"
; CONST: #500

CONST_90	.REAL 500
; CONST: #8185

CONST_91	.REAL 8185
; CONST: #7520

CONST_92	.REAL 7520
; CONST: #11

CONST_93R	.REAL 11.0
; CONST: #18

CONST_94R	.REAL 18.0
; CONST: #15

CONST_95R	.REAL 15.0
; ******** DATA ********
DATAS
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 0
.BYTE 3
.BYTE 15
.BYTE 3
.BYTE 14
.BYTE 2
.BYTE 71
.STRG "?{left arrow}^[q{left arrow}{left arrow}\^w{left arrow}^{left arrow}]wc"
.BYTE 2
.BYTE 71
.STRG "{left arrow}s{left arrow}?{left arrow}g{left arrow}?[8/of/a{left arrow}"
.BYTE 2
.BYTE 49
.STRG "{left arrow}onwp?<y/{left arrow}y{left arrow}vxv3"
.BYTE 2
.BYTE 38
.STRG "q^?\?{left arrow}[;l<gcys{left arrow}^"
.BYTE 2
.BYTE 27
.STRG "?]spo.^\\'p..{left arrow}\u"
.BYTE 2
.BYTE 27
.STRG "#sw{left arrow}/gspp/#\\,!p"
.BYTE 2
.BYTE 27
.STRG " @\{left arrow}#p,//pypp # "
.BYTE 2
.BYTE 16
.STRG "\,  0  ##p,  p\2"
.BYTE 2
.BYTE 104
.STRG "'w/ex?/{left arrow}{left arrow}w{left arrow}{left arrow}{left arrow}{left arrow}{left arrow}{left arrow}"
.BYTE 2
.BYTE 71
.STRG "@8'#{left arrow}{left arrow}c.ex?/{left arrow}{left arrow}{left arrow}^"
.BYTE 2
.BYTE 16
.STRG " !@t/#p8   $*!!n"
.BYTE 2
.BYTE 8
.STRG ";@!n;@  "
.BYTE $FF
; ******** DATA END ********
CONSTANTS_END
; *** VARIABLES ***
VARIABLES
; VAR: V
VAR_V	.REAL 0.0
; VAR: I
VAR_I	.REAL 0.0
; VAR: X
VAR_X	.REAL 0.0
; VAR: L
VAR_L	.REAL 0.0
; VAR: D
VAR_D	.REAL 0.0
; VAR: K
VAR_K	.REAL 0.0
; VAR: QR
VAR_QR	.REAL 0.0
; VAR: J
VAR_J	.REAL 0.0
; VAR: B
VAR_B	.REAL 0.0
; VAR: C
VAR_C	.REAL 0.0
; VAR: S
VAR_S	.REAL 0.0
; VAR: U
VAR_U	.REAL 0.0
; VAR: Y
VAR_Y	.REAL 0.0
; VAR: F
VAR_F	.REAL 0.0
; VAR: G
VAR_G	.REAL 0.0
; VAR: Z
VAR_Z	.REAL 0.0
; VAR: E
VAR_E	.REAL 0.0
; VAR: R
VAR_R	.REAL 0.0
; VAR: SB
VAR_SB	.REAL 0.0
; VAR: JL
VAR_JL	.REAL 0.0
; VAR: LL
VAR_LL	.REAL 0.0
; VAR: LR
VAR_LR	.REAL 0.0
; VAR: JR
VAR_JR	.REAL 0.0
; VAR: N
VAR_N	.REAL 0.0
; VAR: Q
VAR_Q	.REAL 0.0
; VAR: O
VAR_O	.REAL 0.0
; VAR: H
VAR_H	.REAL 0.0
; VAR: S[]
	.BYTE 1
	.WORD 30
VAR_S[]	.ARRAY 30
; VAR: CD
VAR_CD	.REAL 0.0
; VAR: MC
VAR_MC	.REAL 0.0
; VAR: A
VAR_A	.REAL 0.0
; VAR: W
VAR_W	.REAL 0.0
; VAR: P[]
	.BYTE 1
	.WORD 30
VAR_P[]	.ARRAY 30
STRINGVARS_START
; VAR: A$
VAR_A$	.WORD EMPTYSTR
; VAR: TI$
VAR_TI$ .WORD EMPTYSTR
STRINGVARS_END
STRINGARRAYS_START
STRINGARRAYS_END
VARIABLES_END
; *** INTERNAL ***
X_REG	.REAL 0.0
Y_REG	.REAL 0.0
C_REG	.REAL 0.0
D_REG	.REAL 0.0
E_REG	.REAL 0.0
F_REG	.REAL 0.0
A_REG	.WORD 0
B_REG	.WORD 0
G_REG	.WORD 0
CMD_NUM	.BYTE 0
CHANNEL	.BYTE 0
SP_SAVE	.BYTE 0
TMP2_REG	.WORD 0
TMP3_REG	.WORD 0
TMP4_REG	.WORD 0
AS_TMP	.WORD 0
STORE1	.WORD 0
STORE2	.WORD 0
STORE3	.WORD 0
GCSTART	.WORD 0
GCLEN	.WORD 0
GCWORK	.WORD 0
TMP_FREG	.REAL 0
TMP2_FREG	.REAL 0
TMP_FLAG	.BYTE 0
REAL_CONST_ONE	.REAL 1.0
REAL_CONST_ZERO	.REAL 0.0
REAL_CONST_MINUS_ONE	.REAL -1.0
EMPTYSTR	.BYTE 0
FPSTACKP	.WORD FPSTACK
FORSTACKP	.WORD FORSTACK
DATASP	.WORD DATAS
LASTVAR	.WORD 0
LASTVARP	.WORD 0
HIGHP	.WORD STRBUF
STRBUFP	.WORD STRBUF
ENDSTRBUF	.WORD 0
INPUTQUEUEP	.BYTE 0
CONCATBUFP	.BYTE 0
PROGRAMEND
CONCATBUF	.ARRAY 256
INPUTQUEUE	.ARRAY $0F
FPSTACK .ARRAY 50
FORSTACK .ARRAY 170
STRBUF	.BYTE 0
