# MAZE

Il classico random maze `10 PRINT CHR$(205.5+RND(1));:GOTO 10` scritto però in
linguaggio macchina.

## Breve spiegazione

Il programma si compone di un loop che cicla su tutta la memoria video del C64.

Ad ogni cella, viene generato un numero casuale tra 0 e 255.

Se il bit 0 di questo numero è zero viene scelto il carattere `/` altrimenti il `\`.

Il carattere viene poi scritto a video, la cella di scrittua avanza di una 
posizione e il ciclo si ripete fino ad arrivare all'ultima cella del video.

## Codice auto-modificante

Il programma fa uso di codice automodificante per velocizzare il ciclo di 
scrittura, evitando di far ricorso un puntatore in pagina zero.

La sintassi
```
sta **cella(VIDEO_RAM)             
```
indica una normale operazione `STA $0400` dove contestualmente viene creato 
il simbolo `cella` che punta all'argomento `$0400` di `STA`. Il simbolo
viene inoltre inizializzato al valore `VIDEO_RAM`. 

## Compilazione

Eseguire il file batch `t.bat`. Richiede `ASMPROC` e `DASM`.

