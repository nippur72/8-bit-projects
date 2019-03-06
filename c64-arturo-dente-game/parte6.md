# CONVERSIONE ASSEMBLY DI "F64" 

- Link alla [Parte 1](parte1.md)
- Link alla [Parte 2](parte2.md)
- Link alla [Parte 3](parte3.md)
- Link alla [Parte 4](parte4.md)
- Link alla [Parte 5](parte5.md)

## PARTE 6

### Routine Random

In questa parte ci occupiamo di eliminare del tutto la funzione `RND` che abbiamo
"isolato" nella parte 3.

Ci sono vari algoritmi per generare un numero casuale in assembly, o in qualsiasi
altro linguaggio di programmazione. Si tratta di un classico problema 
dell'informatica e della matematica. 

Nel gergo si chiamano numero "pseudo" causali: non sono del tutto casuali perchè
sono generati matematicamente, ma poichè sono difficili da indovinare
è come se lo fossero.

Per il nostro esercizio didattico ho scelto di utilizzare una routine molto
semplice, forse la più semplice in assoluto, che ho preso da un thread
sul formum "Denial" (per VIC-20) e adattandola poi al C64.

Non è necessario capirne il funzionamento, la possiamo utilizzare come
se fosse una black-box. Ci basti sapere che richiamandola ci restituisce
un numero causale nel registro `A` e nella locazione `RandomNumber`:

```
; =====================================================================
; Name: Random
; Purpose: genera un numero random tra 0-255
; Returns: A=numero random. Il numero si trova anche nella cella "RandomNumber"
; Nota: presa dal forum Denial e adattata per il C64:
;       http://sleepingelephant.com/ipw-web/bulletin/bb/viewtopic.php?f=2&t=7878
;       
;       La sequenza random viene resa ancora più casuale facendo uno XOR
;       con il Timer del C64 (locazione $dc04). Il seme di partenza deve
;       essere un numero diverso da zero (qui è #$01).
;
;       Fa uso di codice auto-modificante (sintassi **RandomNumber($01))
; =====================================================================

sub Random()
   lda #**RandomNumber($01)
   asl
   if not carry then eor #$4d
   sta RandomNumber
   eor $dc04
   if not zero then sta RandomNumber
end sub
```

Per provarne il funzionamento aggiungiamo temporaneamente
il seguente codice BASIC:
```
   1000 for t=1 to 10
   1010 sys {Random}
   1020 print peek({RandomNumber})
   1030 next
```
Ed eseguiamo con `RUN 1000`:
```
ready.
run 1000
 79
 211
 166
 76
 213
 170
 84
 229
 202
 148

ready.
```

### Integrazione con il sorgente Basic

Integriamo adesso la routine `Random` nel listato BASIC.

Poichè abbiamo isolato le chiamate a `RND` tutto diventa molto semplice:

```
   // calcola un numero casuale tra 1..3 (estremi compresi)
   900 sys {Random}:rn = (peek({RandomNumber}) and 3) + 1
   901 if rn=4 then 900                     
   910 return

   // calcola un numero casuale tra 1..18 (estremi compresi)
   920 sys {Random}:rn = (peek({RandomNumber}) and 31) + 1
   921 if rn>18 then 920                   // scarta i numeri maggiori di 18
   930 return   
```

Possiamo inoltre eliminare la gestione del seed random, poichè
la nostra routine non ne fa uso. Eliminiamo le linee 20, 940 e 950.

### Conversione del disegno della strada

Covertiamo le linee 431-434, ossia il disegno della strada a partire dalla colonna `sp`
e lo scroll del video.

Per un migliore effetto grafico, eseguiamo prima lo scroll del video e poi
il disegno della strada. In questo modo sull'ultima riga sarà sempre visibile
la strada.

```
_sp byte 0

sub disegna_strada()
   jsr scroll_video

   ; pulisce ultima riga
   lda #32
   ldx #SCREEN_COLS-1
   do 
      sta VIDEO_RAM + 24*SCREEN_COLS,x
      dex
   loop while not negative

   ; disegna nell'ultima riga
   ldx _sp       ;
   lda #102      ;
   sta 1984,x    ; equivale a poke 1984+sp,102
   sta 1984+19,x ; equivale a poke 1984+sp+19,102
end sub

sub scroll_video()
   ldx #255
   do
      lda VIDEO_RAM +0*256 + SCREEN_COLS,x : sta VIDEO_RAM +0*256,x
      lda VIDEO_RAM +1*256 + SCREEN_COLS,x : sta VIDEO_RAM +1*256,x
      lda VIDEO_RAM +2*256 + SCREEN_COLS,x : sta VIDEO_RAM +2*256,x
      lda VIDEO_RAM +3*256 + SCREEN_COLS,x : sta VIDEO_RAM +3*256,x
      dex
   loop while not zero
end sub
```















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

Il file completo di questa sesta parte si trova qui: [parte6.lm](parte6.lm).

Potete compilarlo ed eseguirlo sull'emulatore VICE:

```
> t parte6 & x64 parte6.prg
```

Non abbiamo ottenuto in incremento di velocità, ma solo un risparmio di bytes (circa 125)
poichè l'istruzione `DATA` del Basic memorizza i numeri sotto forma di ASCII, mentre in
assembly li memorizziamo direttamente in bytes, con notevole risparmio di spazio.




