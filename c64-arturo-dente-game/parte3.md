# CONVERSIONE ASSEMBLY DI "F64" 

Link alla [Parte 1](parte1.md)
Link alla [Parte 2](parte2.md)

## PARTE 3

In questa parte ci occupiamo di eliminare dal listato l'uso dei numeri 
decimali (floating point) che sarebbero troppo lenti e complessi 
da gestire in assembly. 

Il processore 6502 preferisce infatti numeri interi, se possibile 
composti di un solo byte, al massimo due.

Per fortuna il nostro game in BASIC per la maggior parte fa sempre 
uso di numeri interi tranne che per:

1) l'accelerazione dell'astronave (delta=1.5 alla linea 180)
2) generazione di numeri random (linee 20, 270, 370 e 440)

Riguardo il primo punto, possiamo tranquillamente arrotondare `1.5` a `1`
senza avere un cambio significativo del comportamento del gioco (che
comunque andrà rivisto quando si avrà l'incremento di velocità dovuto
al passaggio all'assembly).

Procediamo quindi a sostituire:
```
   180 ifa=127thende=de-1.5

// sostituiamo con   

   180 ifa=127thende=de-1
```

Riguardo ai numeri random, in realtà nel gioco servono 
numeri casuali esclusivamente interi: 

- da 1 a 3 (estremi compresi) alle linee 270, 370
- da 1 a 18 (estremi compresi) alla linea 440

Per facilitare il passaggio in assembly isoliamo le chiamate alla funzione `RND()`
mettendole in delle subroutine separate, come segue:

- numero random da 1 a 3: subroutine alla linea 900
- numero random da 1 a 18: subroutine alla linea 920
- inizializzazione del seme random: subroutine alla linea 940

```
   20 zz=rnd(-ti)

// diventa

   20 gosub 940    

   940 zz=rnd(-ti)
   950 return
```

```
   270 c=int(rnd(1)*3)+1                              // 1:aumenta spazi, 2:diminuisce spazi,3:invariato
   370 ob=int(rnd(1)*3)+1

// diventa

   270 gosub 900:c=rn                                 // 1:aumenta spazi, 2:diminuisce spazi,3:invariato
   370 gosub 900:ob=rn

   900 rn = (int(rnd(1)*256) and 3)+1                 // 1,2,3,4
   901 if rn=4 then 900 
   910 return
```

```
   440 ob=int(rnd(1)*18)+1 

// diventa   

   440 gosub 920:ob=rn

   920 rn = (int(rnd(1)*256) and 31)+1               // 1..32
   921 if rn>18 then 900 
   930 return   
```

Nell'isolare le subroutine di generazione dei numeri random, abbiamo fatto un'altra cosa:
abbiamo generato il numero in maniera simile a come lo genereremo in assembly, questo
ci faciliterà la successiva conversione e ce ne fa capire il funzionamento.

I numeri random in assembly di sono generati come numeri interi da 1 a 2^n-1, utilizzando
svariati algoritmi matematici (di cui non ci occuperemo).

Dunque non è possibile generare direttamente un numero causale da 1..18, o da 1..3,
ma solo da 1..31 e da 1..4, salvo poi rettificare il risultato riportandolo nel range
desiderato. Questo lo si fa con la tecnica del "roll dice and discard", cioè estraiamo 
il numero casuale e ripetiamo l'estrazione se questo dovessere al di fuori del range
1..8 (o 1..3):

```
   920 rn = (int(rnd(1)*256) and 31)+1    // estrae numero da 1..32
   921 if rn>18 then 900                  // se l'estratto > 18 ripete l'estrazione
   930 return   
```

Con questa ultima modifica il programma BASIC è pronto per essere convertito in Assembly.
Termina quindi la fase "preparatoria", dalla prossima puntata inizieremo la conversione
in "linguaggio macchina" con la sintassi di ASMPROC.

Il file completo di questa terza parte si trova qui: [parte3.lm](parte3.lm).

Potete compilarlo ed eseguirlo sull'emulatore VICE:

```
> t parte3 & x64 parte3.prg
```

