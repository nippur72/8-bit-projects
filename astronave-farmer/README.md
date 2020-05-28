# ASTRONAVE FARMER (risveglio in astronave)

Astronave Farmer è un adventure testuale scritto in BASIC da Mario Pettenghi
e pubblicato come listato type-in sulla rivista MC MicroComputer [n. 40 - Aprile 1985](http://www.digitanto.it/mc-online/PDF/Articoli/040_160_163_0.pdf).

Conobbi questo gioco nel lontano 1986 grazie a due miei amici che lo digitarono sul 
Laser 500 e successivamente mi ci fecero giocare, evitando che la visione del listato 
mi spoilerasse la soluzione. 

Rimanemmo molto colpiti da questo semplice quanto affascinante adventure, tanto da 
spingerci alla lettura del noto libro "Scrivere un gioco di avventura" di Enrico 
Colombini. Tentammo anche di creare un adventure tutto nostro, senza però mai 
portarlo a compimento.

Di Astronave Farmer, oltre all'avventura in sé, mi affascinava il fatto che il computer
potesse comprendere le frasi digitate in lingua italiana, reagendo con un comportamento 
intelligente. C'era un alone di mistero intorno al cosiddetto "parser", l'algoritmo
che analizzava il testo inserito comprendendone il significato; non avevo la 
più pallida idea di come potesse funzionare... per me era quasi magico!

Per molti anni ho cercato invano di ritrovare il listato di questo gioco, speravo che 
prima o poi saltasse fuori da qualche parte. Non ero neanche sicuro del suo nome, poichè 
i miei amici lo avevano cambiato in "Astronave FARMET" (con la T finale); a detta 
loro "suonava meglio". 

Poi finalmente il link giusto, ed ecco il numero di MC MicroComputer con il listato 
bello e pronto in formato PDF!

Non potevo far altro che digitarlo e assaporare il piacere di giocarci nuovamente 
dopo quasi trentacinque anni, peraltro sullo stesso computer di allora: il Laser 500. Che emozione
rivedere quella scritta insistere sullo schermo ... "COSA DEVO FARE?"

Il sorgente originale è scritto in MBASIC per lo Sharp MZ80B, ma risulta compatibile
con la maggior parte dei BASIC degli home computer dell'epoca poichè non utilizza 
nessuna istruzione specifica dello Sharp; i codici per pilotare lo schermo (`CLS` e 
`NEWLINE`) sono parametrizzati in delle variabili stringa, per cui è molto facile 
adattarlo a qualsiasi macchina.

Una curiosità: il finale del gioco è criptato tramite delle istruzioni `DATA`, l'autore
ha voluto così evitare che venisse rivelato durante la digitazione del listato:
```
9210 READ X:IF X=255 THEN 9230
9220 PRINT CHR$(X-OGG(8)-LO);:GOTO 9210
10040 DATA 89, ... ,255
```

Stranamente, il sorgente contiene due bug, uno dei quali impedisce il completamento
dell'avventura. Alla linea `2185` manca l'istruzione `O=21` che collega l'uscita
OVEST alla stanza n.21 sulla mappa, bloccando quindi il giocatore. 

Il gioco è previsto per schermi a 80 colonne, ma ne ho fatto un adattamento anche
per 40 colonne considerato che molti home computer non avevano modalità testo 
che arrivassero a 80 caratteri per linea. 

Sul repo di GitHub, oltre al sorgente originale ridigitato in formato testo, 
trovate alcuni adattamenti già pronti per essere giocati. Se fate il port su altri 
computer, mi piacerebbe averne notizia in modo da aggiungere il programma alla lista.

Adattamenti:

- [Laser 500](astronave_farmer.laser500.bin): questa è la versione più fedele all'originale per `MBasic` 
di Mario Pettenghi, poichè il BASIC del Laser 500 è perfettamente compatibile.
Potete giocarci direttamente sul mio [emulatore on-line](https://nippur72.github.io/laser500emu/?load=astronave_farmer.bin).

- [Commodore 64](astronave_farmer.c64.mospeed.prg): adattato per girare a 40 colonne.
In questa versione ho dovuto simulare la funzione `INSTR()` che manca nel
CBM BASIC V2.0; ho anche dovuto riscrivere alcuni `IF THEN ELSE` a causa della mancanza
dell'istruzione `ELSE`. Per velocizzare il gioco, ho compilato il listato BASIC
con [Mospeed](https://github.com/EgonOlsen71/basicv2) (ma è anche possibile giocare
con [la versione non compilata](astronave_farmer.c64.prg)).

- [Commodore 128](astronave_farmer.c128.prg): in modalità 80 colonne. L'unica differenza col sorgente 
originale è che l'istruzione `ELSE` nel BASIC del 128 deve essere preceduta dal 
carattere `:` quando è sulla stessa riga dell'`IF`.

- [Commodore 16/Plus 4](astronave_farmer.c16.prg): simile alla versione 40 colonne per C64.

- [Amstrad CPC](astronave_farmer.amstrad.dsk): conversione effettuata da Francesco Fiorentini.

- [TI-99/4A](astronave_farmer.ti994a.dsk): conversione effettuata da Francesco Fiorentini.


