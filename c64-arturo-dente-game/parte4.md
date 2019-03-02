# CONVERSIONE ASSEMBLY DI "F64" 

- Link alla [Parte 1](parte1.md)
- Link alla [Parte 2](parte2.md)
- Link alla [Parte 3](parte3.md)

## PARTE 4

Iniziamo adesso la conversione in Assembly vera e propria.

Abbiamo già visto come la sintassi di Asmproc `BASIC START` e `BASIC END` consenta 
di inserire un normale sorgente basic V2 all'interno del codice assembly. 
Vi è inoltre la possibilità di far riferimento ai simboli definiti nell'assembly
direttamente dal BASIC e questo consente di richiamare facilmente le
parti in assembly con il comando `SYS`. 

Vediamo un esempio:

```
basic start
   10 sys {prova}
basic end

prova:
   nop
   rts
```

Alla linea 10 `{prova}` verrà sostituito con l'indirizzo effettivo della routine `prova:` 
definita dopo il blocco BASIC. `SYS` chiamerà quindi tale routine e ritornerà 
poi nuovamente all'interprete BASIC. Per inciso, la routine`prova:` non fa assolutamente nulla, 
è solo un esempio.

### Movimento dell'astronave

Il primo pezzo che è facile convertire in assembly è il movimento dell'astronave
(linee 160-260 e 620-700). In particolare aiuta il fatto che le variabili `a`, `x`, `y` e `de`
non vengano usate da nessun altra parte al di fuori della routine; esse sono quindi
isolate e le possiamo convertire in blocco.

Rinominiamo `a` in `joy` e `x`, `y` in `posx` e `posy`, poichè i loro nomi vanno
in conflitto con i nomi dei registri del processore 6502. Contestualmente creiamo
le "variabili" con l'istruzione `byte` che indica che tali variabli avranno appunto
la dimensione di un byte:
```
joy   byte 0
posx  byte 0
posy  byte 0
delta byte 0
```

Creiamo inoltre i riferimenti ai registri dello sprite (linea 110 e 260)
```
const v = 53248
const spritex = v+4
const spritey = v+5
```

La parola chiave `const` serve a creare delle costanti numeriche. In genere è sempre meglio usare
delle costanti al posto dei valori numerici, poichè il nome stesso aiuta nella lettura del codice.

Creiamo adesso una subroutine in assembly:

```
sub muove_astronave()
end sub
```

E dentro scriviamo la conversione delle linee da 160 a 260:

```
   ld joy, 56320    ; legge joystick in porta 2

   ; accelerazione   
   if a<>#127 then
      inc delta 
      if delta > #10 then ld delta, #10      ; non esageriamo      
   else
      dec delta
      if delta <  #3 then ld delta, #3       ; non esageriamo      
   end if   

   ; rem movimenti navicella
   if joy = #126 then sub posy, delta
   if joy = #125 then add posy, delta
   if joy = #123 then sub posx, delta
   if joy = #119 then add posx, delta

   if joy = #122 then 
      sub posy, delta
      sub posx, delta
   end if
   if joy = #118 then 
      sub posy, delta
      add posx, delta
   end if
   if joy = #121 then 
      add posy, delta
      sub posx, delta
   end if
   if joy = #117 then 
      add posy, delta
      add posx, delta
   end if
   
   if posx < #20  then ld posx, #20   ; bordi
   if posx > #255 then ld posx, #255  ; bordi
   if posy < #50  then ld posy, #50   ; bordi
   if posy > #237 then ld posy, #237  ; bordi

   ; aggiorna lo sprite
   ld spritex, posx      ; coordinata x
   ld spritey, posy      ; coordinata y
```

Note:

1) abbiamo usato la macro `ld dest, source` per scrivere in maniera compatta `LDA source`/`STA dest`.
2) in maniera simile, `add` e `sub` sono macro per sommare e sottrarre in maniera compatta.
3) abbiamo sviluppato gli `IF` usando anche `ELSE` (non presente nel Basic V2) eliminando 
del tutto l'uso delle subroutines. Il codice adesso è molto più leggibile!
4) La subroutine non è ottimizzata al massimo, ho preferito mantenerne la leggibilità piuttosto
che avere una routine leggermente più veloce ma illegibile (almeno in questa fase).
5) L'assembly del 6502 vuole che le costanti numeriche siano indicate con `#`, mentre un numero
che non inizia per `#` è interpretato come una cella di memoria. E' piuttosto contro-intuitivo 
all'inizio, ma dopo un po' ci si abitua.

Ad esempio:

```
   lda 53280     ; carica in A in valore della cella di memoria 53280
   lda #3        ; carica in A il valore 3  
```

### Posizione iniziale dell'astronave

Alla linee 130 e 150 vengono inizializzate le variabili dell'astronave,
convertiamo anche queste linee:

```
; =====================================================================
; Name: posizione_iniziale
; Purpose: imposta la posizione iniziale della navicella in posx, posy
; =====================================================================

sub posizione_iniziale()
   ld posx, #165
   ld posy, #50
   ld delta, #3    ; delta pixel di movimento sprite
end sub 
```

Eliminiamo adesso le linee BASIC 130, da 160 a 260, e da 620-700, sostituendo con:
```
   150 sys {posizione_iniziale}
   160 sys {muove_astronave}
```

Il file completo di questa terza parte si trova qui: [parte4.lm](parte4.lm).

Potete compilarlo ed eseguirlo sull'emulatore VICE:

```
> t parte4 & x64 parte4.prg
```

Si inizia già a vedere un incremento di velocità, e siamo appena all'inizio!


