TRIPLETTE PITAGORICHE
=====================

La mia entry per la sfida delle triplette pitagoriche proposta a Emanuele Bonin:  
   - https://sys64738.org/wp-content/uploads/2019/06/00_TriplettePitagoriche.pdf
   - https://www.facebook.com/groups/programming.c64/permalink/334295593917369/


NOTE SULL'IMPLEMENTAZIONE
=========================

Sono partito da un prototipo in JavaScript per prendere confidenza col problema ed
avere una versione funzionante con cui confrontarmi ([triplette.js](triplette.js)) e
da cui ricavare un sorgente in C.

In JavaScript non ho fatto nessuna ottimizzazione, ho solo evitato
di utilizzare la ricorsione anticipando che sarebbe stato un problema 
nell'ambiente a 8 bit.

Analizzando il problema ho notato che non è necessario memorizzare tutto 
l'albero delle soluzioni, ma solo due livelli: il livello "n" contenete
le triplette di partenza, e "n+1" le triplette generate.

La mia soluzione consiste quindi nell'utilizzo di due buffer/vettori: un
primo buffer di lettura contenente le triplette "origine" e un secondo
buffer di scrittura per memorizzare le triplette generate.

Ad ogni iterazione, il buffer di scrittura diventa il buffer di lettura
per la prossima iterazione, operazione molto veloce in C poichè basta 
scambiare i puntatori.

Ho utilizzato interi a 16 bit (`unsigned int` in C) poichè sono sufficienti
a memorizzare i numeri delle triplette almeno fino al punto richiesto dal 
problema.

In C ho fatto una serie di piccole ottimizzazioni che hanno via via
diminuito il tempo di esecuzione, rendendo però il codice sempre meno
leggibile.

Alcune tecniche utilizzate:
- variabili tutte globali
- niente passaggio di parametri alle funzioni
- la moltiplicazione delle matrici è stata velocizzata precalcolando gli elementi che sono comuni a `M1`, `M2` e `M3`
- ho scoperto che è più veloce scrivere:
```
buf[i] = valore; ++i;
```
al posto di
```
buf[i++] = valore;
```
probabilmente ciò è dovuto al fatto che il 6502 non ha abbastanza registri per memorizzare il valore temporaneo di `i` prima di incrementarlo, per cui non si ha nessun guadagno al contrario di quanto si potrebbe intuire.


