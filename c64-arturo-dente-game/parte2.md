# CONVERSIONE ASSEMBLY DI "F64" 

Link alla [Parte 1](parte1.md)

## PARTE 2 

Per facilitare la conversione, modifichiamo il
sorgente BASIC adattando le parti che mal si prestano 
ad essere convertite in assembly.

In particolare cerchiamo di evitare ove possibile:

- manipolazione di stringhe
- numeri decimali (cioè non interi)

Nel caso specifico, notiamo che nel nostro programma la "strada"
viene disegnata costruendo una stringa di spazi e poi stampata con `PRINT` 
(linea 50, 60 e 360). Quando poi vi è un'ostacolo (la "pallina" ottenuta
con `shift` + `Q`) la stessa stringa viene modificata per includere
lo stesso ostacolo. 

Lo stesso effetto di disegno della strada lo si può ottenere
stampando i caratteri della strada e dell'ostacolo direttamente
sullo schermo con `POKE`. 

Possiamo inoltre usare il trucco di scriverli sempre nell'ultima
riga dello schermo, la strada si formerà automaticamente 
grazie allo scroll dei caratteri.

- La strada è larga 19 spazi + 2 simboli `cbm`+`+`
- Il simbolo `cbm`+`+` equivale a 102 come SCREEN CODE
- `sp` contiene la colonna di inizio della strada
- La memoria schermo del C64 inizia da 1024
- Lo schermo è fatto da 40 colonne * 25 righe
- L'ultima riga si trova all'indirizzo: 1024+40*24 = 1984

Aggiungiamo le seguenti linee BASIC:

```
   // disegna strada sull'ultima riga e scrolla il video
   431 poke 1984+sp,102   
   432 poke 1984+sp+19,102
   433 print                      // scrolla il video
   434 return
```

e modifichiamo

```
380 ifob<3orsc<6then?pf$+ln$:goto400     // disegna strada senza ostacolo

// sostituiamo con

380 ifob<3orsc<6then gosub 431:goto400   // disegna strada senza ostacolo
```

C'è ora il disegno di strada + ostacolo:

```   
   440 ob=int(rnd(1)*(len(ln$)-1))+1
   450 l$=left$(ln$,ob):r$=right$(ln$,len(ln$)-ob-1)
   460 ?pf$+l$+"{shift q}"+r$
   470 return

// sostituiamo con

   440 ob=int(rnd(1)*18)+1 
   450 poke 1984+sp,102   
   455 poke 1984+sp+19,102
   460 poke 1984+sp+ob,81          // disegna ostacolo (pallina)
   465 print
   470 return
```

Adesso il programma non fa più uso di `pf$`, `ln$` e `empt$`, quindi possiamo rimuovere le seguenti linee:
```
   50 empt$="                   "
   60 ln$="{cbm +}"+empt$+"{cbm +}"
   90 dimpf$
   350 pf$=""
   360 fort=1tosp:pf$=pf$+" ":nextt

   50
   60
   90
   350
   360
```

Poichè abbiamo levato la linea 350, aggiustiamo il `goto` della 330:
```
   330 ifsp<rcthensp=rc:goto350

// sostituiamo con

   330 ifsp<rcthensp=rc:goto370
```

Il nostro programma adesso scrive sempre sull'ultima riga, bisogna quindi posizionare il cursore:
```
   100 print"{clear}"

// sostituiamo con

   100 print"{clear}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}"
```

Non è più necessario inoltre controllare che gli ostacoli non vengano generati prima della riga 6,
possiamo eliminare le condizioni `sc<6` e `sc>5`:
```
   380 if ob<3 or sc<6 thengosub 431:goto400   // disegna strada senza ostacolo
   390 if ob=3 then if sc>5 thengosub 440            // disegna strada + ostacolo

// sostituiamo con

   380 if ob<3 then gosub 431:goto 400   // disegna strada senza ostacolo
   390 if ob=3 then gosub 440           // disegna strada + ostacolo
```

Trovate il file completo di questa prima parte qui: [parte2.lm](parte2.lm).

Potete compilarlo ed eseguirlo sull'emulatore VICE:

```
> t parte1 & x64 parte1.prg
```

Con la modifiche che abbiamo apportato, il gioco è diventato visibilmente più veloce.

Nella prossima puntata, faremo qualche ottimizzazione al programma BASIC prima di iniziare a convertirlo in assembly.

