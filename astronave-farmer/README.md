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
intelligente. C'era un alone di mistero intorno al cosidetto "parser" - l'algoritmo
che analizzava il testo inserito comprendendone il significato; proprio non avevo idea
di come potesse funzionare!

Per molti anni ho cercato invano di ritrovare il listato di questo gioco, speravo che 
prima o poi saltasse fuori da qualche parte. Non ero neanche sicuro del suo nome, poichè 
i miei amici lo avevano cambiato in "Astronave FARMET" (con la T finale); a detta 
loro "suonava meglio". 

Poi finalmente il link giusto, ed ecco il numero di MC MicroComputer con il listato 
bello e pubblicato in formato PDF!

Non potevo far altro che digitarlo e assaporare il piacere di giocarci nuovamente 
dopo trent'anni, peraltro sullo stesso computer di allora, il Laser 500. Che emozione
rivedere quella scritta insistere sullo schermo ... "COSA DEVO FARE?"

Il sorgente originale è scritto in MBASIC per lo Sharp MZ80B, ma risulta compatibile
con la maggior parte dei BASIC degli home computer dell'epoca poichè non utilizza 
nessuna istruzione specifica dello Sharp; i codici per pilotare lo schermo (`CLS` e 
`NEWLINE`) sono parametrici per cui è molto facile adattarlo a qualsiasi macchina.

Curiosamente il listato contiene due bug, uno dei quali impedisce il completamento
dell'adventure. Alla linea `2185` manca l'istruzione `O=21` che collega l'uscita
OVEST alla stanza n.21 sulla mappa, bloccando quindi il giocatore. 

Il gioco è previsto per schermi a 80 colonne, ma ne ho fatto un adattamento anche
per 40 colonne considerato che la maggior parte degli home computer dell'epoca 
non poteva visualizzare le 80 colonne.

Sul repo di GitHub, oltre al sorgente originale ridigitato in formato testo, 
trovate alcuni adattamenti già pronti per essere giocati. Se fate il port su altri 
computer, mi piacerebbe averne notizia in modo da aggiungere il programma alla lista.

Adattamenti:

- [Laser 500](). Questa è la versione più fedele all'originale per `MBasic` 
di Mario Pettenghi, poichè il BASIC 1.0 del Laser 500 è perfettamente compatibile.
Potete giocarci direttamente sul mio [emulatore on-line]().

- [Commodore 64](). Adattato per girare a 40 colonne. In questa versione ho 
dovuto simulare la funzione `INSTR()` che manca nel CBM BASIC V2.0; ho anche dovuto 
riscrivere alcuni `IF THEN ELSE` a causa della mancaza dell'istruzione `ELSE`.

- [Commodore 128](astronave_farmer.c128.prg) in modalità 80 colonne. L'unica differenza col sorgente 
originale è che l'istruzione `ELSE` nel BASIC del 128 deve essere preceduta dal 
carattere `:` quando è sulla stessa riga dell'`IF`.

- [Commodore 16](). Simile alla versione per C64.

- [Commodore PET](). 

