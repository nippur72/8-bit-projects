
  
                                    
                                    
                       
                                                     
       
                                                                   
                
          
  



GETIN   = $FFE4     
CLRSCN  = $E544     
PRNSTR  = $AB1E     
GOHOME  = $E566     
PRNINT  = $BDCD     



CURSOR_PTR  = 209
JIFFY_CLOCK = 162
CRSRCOL     = 646
MEMORY_CONFIG = 1



COLOR_BLACK   = 0
COLOR_WHITE   = 1
COLOR_RED     = 2
COLOR_CYAN    = 3
COLOR_MAGENTA = 4
COLOR_GREEN   = 5
COLOR_BLUE    = 6
COLOR_YELLOW  = 7




SCREEN_COLS = 40
SCREEN_ROWS = 25
VIDEO_RAM = 1024
COLOR_RAM =  55296
COLOR_PAGE_OFFSET =  ((COLOR_RAM - VIDEO_RAM) / 256)
BASIC_RAM = 2049
RASTER =  $D012
ROMCHAR =  $D000
BORDER =  53280
BACKGROUND =  53281


    



    












       






















































































































































































































































































    
































































    





































































































        








            
















        























   PROCESSOR 6502
   ORG BASIC_RAM


BASIC_ROW_0: BYTE [BASIC_ROW_1%256],[BASIC_ROW_1/256],[2020%256],[2020/256],158,32,[[[MAIN%10000]-[MAIN%1000]]/1000+$30],[[[MAIN%1000]-[MAIN%100]]/100+$30],[[[MAIN%100]-[MAIN%10]]/10+$30],[[[MAIN%10]-[MAIN%1]]/1+$30],0
BASIC_ROW_1 BYTE 0,0


PTR =  250


CC =  252
RR =  248

MAIN:   
   LDY #0

   
   LDA #((1024) % 256)
   STA PTR
 IF ((1024) % 256) != ((1024)/256)
      LDA #((1024)/256)
 ENDIF
   STA PTR+1   

   
DO_591_START:
      LDA #81
      STA (PTR),Y
   INC PTR
IF_595_START:
	BNE IF_595_ELSE
 INC PTR+1 
IF_595_ELSE:
IF_595_END:
 

   LDA PTR+1
   CMP #((2023)/256)
IF_602_START:
	BNE IF_602_ELSE
      LDA PTR
      CMP #((2023) % 256)
IF_602_ELSE:
IF_602_END:

	BNE DO_591_START
DO_591_END:


   
    LDA #0
    STA CC

    LDA #0
    STA RR


   LDA #((55296) % 256)
   STA PTR
 IF ((55296) % 256) != ((55296)/256)
      LDA #((55296)/256)
 ENDIF
   STA PTR+1   

DO_621_START:
      LDA RR         
   CLC
   ADC CC

      AND #15        
      STA (PTR),Y    

      INC CC
IF_635_START:
	LDA CC

 IF [40]!=0
	CMP #40
 ENDIF

	BNE IF_635_ELSE
         LDA #0
         STA CC
         INC RR
IF_635_ELSE:
IF_635_END:

   INC PTR
IF_642_START:
	BNE IF_642_ELSE
 INC PTR+1 
IF_642_ELSE:
IF_642_END:
 

   LDA PTR+1
   CMP #((56295)/256)
IF_649_START:
	BNE IF_649_ELSE
      LDA PTR
      CMP #((56295) % 256)
IF_649_ELSE:
IF_649_END:

	BNE DO_621_START
DO_621_END:


   

DO_650_START:
   LDA #((55296) % 256)
   STA PTR
 IF ((55296) % 256) != ((55296)/256)
      LDA #((55296)/256)
 ENDIF
   STA PTR+1   

DO_658_START:
         LDA (PTR),Y    

         CLC            
         ADC #1         
         AND #15        

         STA (PTR),Y    

   INC PTR
IF_678_START:
	BNE IF_678_ELSE
 INC PTR+1 
IF_678_ELSE:
IF_678_END:
 

   LDA PTR+1
   CMP #((56295)/256)
IF_685_START:
	BNE IF_685_ELSE
      LDA PTR
      CMP #((56295) % 256)
IF_685_ELSE:
IF_685_END:

	BNE DO_658_START
DO_658_END:

	BEQ DO_650_START
DO_650_END:


   RTS

