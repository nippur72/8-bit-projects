counter EQU $8650

org $d000

install:
   ld hl, 0            ; azzera il contatore
   ld (counter), hl    ;

   ld hl, timer        ; carica in HL l'indirizzo della routine

   di                  ; disabilita gli interrupt momentaneamente
   ld (0x8013), hl     ; scrive l'indirizzo della routine
   ld a, $c3           ; C3 è l'opcode per "JP"
   ld (0x8012), a      ; scrive "JP"
   ei                  ; riabilita gli interrupt
   ret

timer:
   ld hl, (counter)
   inc hl
   ld (counter), hl
   ret