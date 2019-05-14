   PROCESSOR 6502








































































































































































































































    
































































    




































































































        








            
















        






















VIC20 = 1 



GETIN   = $FFE4     
CLRSCN  = $E55F     
PRNSTR  = $CB1E     
GOHOME  = $E581     
PRNINT  = $DDCD     
SCNKEY  = $FF9F     



CURSOR_PTR  = 209
JIFFY_CLOCK = 162
CRSRCOL     = 646



COLOR_BLACK   = 0
COLOR_WHITE   = 1
COLOR_RED     = 2
COLOR_CYAN    = 3
COLOR_MAGENTA = 4
COLOR_GREEN   = 5
COLOR_BLUE    = 6
COLOR_YELLOW  = 7



SCREEN_COLS = 22
SCREEN_ROWS = 23
VIDEO_RAM = 7680
COLOR_RAM =  38400
COLOR_PAGE_OFFSET =  ((COLOR_RAM - VIDEO_RAM) / 256)
BASIC_RAM = 4097
RASTER =  $9004
ROMCHAR =  32768


    



    












       

























   ORG BASIC_RAM


BASIC_ROW_0: BYTE [BASIC_ROW_1%256],[BASIC_ROW_1/256],[10%256],[10/256],151,32,51,54,56,55,56,44,49,53,0
BASIC_ROW_1: BYTE [BASIC_ROW_2%256],[BASIC_ROW_2/256],[20%256],[20/256],151,32,51,54,56,55,54,44,32,49,53,50,58,153,32,34,78,79,82,77,65,76,34,0
BASIC_ROW_2: BYTE [BASIC_ROW_3%256],[BASIC_ROW_3/256],[30%256],[30/256],161,32,65,36,58,139,32,65,36,179,177,34,32,34,32,167,32,51,48,0
BASIC_ROW_3: BYTE [BASIC_ROW_4%256],[BASIC_ROW_4/256],[40%256],[40/256],151,32,51,54,56,55,54,44,49,50,54,58,129,32,73,178,49,32,164,32,49,48,58,130,0
BASIC_ROW_4: BYTE [BASIC_ROW_5%256],[BASIC_ROW_5/256],[60%256],[60/256],158,32,[[[WAV%10000]-[WAV%1000]]/1000+$30],[[[WAV%1000]-[WAV%100]]/100+$30],[[[WAV%100]-[WAV%10]]/10+$30],[[[WAV%10]-[WAV%1]]/1+$30],58,153,32,34,69,78,72,65,78,67,69,68,34,0
BASIC_ROW_5: BYTE [BASIC_ROW_6%256],[BASIC_ROW_6/256],[70%256],[70/256],161,32,65,36,58,139,32,65,36,179,177,34,32,34,32,167,32,55,48,0
BASIC_ROW_6: BYTE [BASIC_ROW_7%256],[BASIC_ROW_7/256],[80%256],[80/256],151,32,51,54,56,55,54,44,32,49,50,54,58,129,32,73,178,49,32,164,32,49,48,58,130,0
BASIC_ROW_7: BYTE [BASIC_ROW_8%256],[BASIC_ROW_8/256],[90%256],[90/256],137,32,50,48,0
BASIC_ROW_8: BYTE [BASIC_ROW_9%256],[BASIC_ROW_9/256],[1000%256],[1000/256],158,32,[[[MAIN%10000]-[MAIN%1000]]/1000+$30],[[[MAIN%1000]-[MAIN%100]]/100+$30],[[[MAIN%100]-[MAIN%10]]/10+$30],[[[MAIN%10]-[MAIN%1]]/1+$30],0
BASIC_ROW_9 BYTE 0,0

WAV:
   LDX #$7E   
   LDY #$FE   
   LDA #152   

   
   SEI        
   STY $900C  
   STX $900C  
   STY $900C  
   STY $900C  
   STX $900C  
   STX $900C  
   STA $900C  
   CLI
   RTS

MAIN: 
   SEI   
   
   
   LDX #8
   LDY #27

LOOPA:     
   STX 36879
   NOP
   NOP
   NOP

   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   JMP LOOPB

LOOPB
   STY 36879
   NOP
   NOP
   NOP

   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   NOP
   JMP LOOPA


