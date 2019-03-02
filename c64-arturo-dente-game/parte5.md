# CONVERSIONE ASSEMBLY DI "F64" 

- Link alla [Parte 1](parte1.md)
- Link alla [Parte 2](parte2.md)
- Link alla [Parte 3](parte3.md)
- Link alla [Parte 4](parte4.md)

## PARTE 5

In questa parte ci occupiamo di eliminare le istruzioni `READ`, `DATA` e`RESTORE` 
dal listato BASIC.

Tali istruzioni vengono usate nel programma per leggere i dati della
grafica dello sprite e memorizzarli nella zona della RAM a 832, nell'area
del buffer del registratore a cassetta (Linea 140, e 590-610).

Per primo convertiamo i `DATA`, in maniera quasi immediata, basta 
sostituire `DATA` con `byte`:

```
sprite_data:
   byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
   byte 0,0,0,255,255,255,73,0,146,38,0,100,16,0,8,8,24,16
   byte 4,36,32,2,36,64,1,36,128,0,153,0,0,66,0,0,36,0,0,24,0
```
Possiamo però fare di meglio. La sintassi di Asmproc ci mette a disposizione
il comando `sprite` specifico per gli sprite del C64. Con esso possiamo
includere la grafica dello sprite direttamente nel file di testo
usando i simboli `.` e `X`:

```
sprite_data:
   ;      012345670123456701234567
   sprite ........................
   sprite ........................
   sprite ........................          
   sprite ........................
   sprite ........................
   sprite ........................
   sprite ........................
   sprite ........................
   sprite XXXXXXXXXXXXXXXXXXXXXXXX
   sprite .X..X...X......X...X..X.
   sprite ..X..XXX........XXX..X..
   sprite ...X................X...
   sprite ....X......XX......X....
   sprite .....X....X..X....X.....
   sprite ......X...X..X...X......
   sprite .......X..X..X..X.......
   sprite ........X..XX..X........
   sprite .........X....X.........
   sprite ..........X..X..........
   sprite ...........XX...........
   sprite ........................
```

Passiamo adesso al ciclo di lettura dei dati e di inizializzazione 
dello sprite:

```
; =====================================================================
; Name: prepara_sprite
; Purpose: attiva lo sprite 2 e ne carica la grafica
; =====================================================================

sub prepara_sprite()
   ld v+21, #4        ; enable sprite 2
   ld 53289, #4
   ld 2042, #13       ; sprite 2 data from block 13

   for x=#0 to #62
      lda sprite_data,x
      sta 832,x
   next
end sub  
```

Eliminiamo 590-610; sostituiamo 120-140 con:

```
120 sys {prepara_sprite}
```

Il file completo di questa quinta parte si trova qui: [parte5.lm](parte5.lm).

Potete compilarlo ed eseguirlo sull'emulatore VICE:

```
> t parte4 & x64 parte4.prg
```

Non abbiamo ottenuto in incremento di velocità, ma solo un risparmio di bytes (circa 125)
poichè l'istruzione `DATA` del Basic memorizza i numeri sotto forma di ASCII, mentre in
assembly li memorizziamo direttamente in bytes, con notevole risparmio di spazio.




