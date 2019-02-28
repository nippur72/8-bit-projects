# CONVERSIONE ASSEMBLY DI "F64" 

## PARTE 1 

A scopo didattico vi propongo la conversione in assembly di un breve programma BASIC per Commodore 64.

Si tratta di un micro-game pubblicato da Arturo Dente sul gruppo Facebook 
"8bit Retroprogramming Italia" nei post:

https://www.facebook.com/groups/programming.c64/permalink/292525798094349/
https://www.facebook.com/groups/programming.c64/permalink/291740931506169/

Inizialmente il gioco era troppo lento, poi con varie ottimizzazioni mirate 
è stato reso "giocabile" (cosa per niente facile in Basic V2).

Per esercizio vediamo come sia possibile convertirlo in assembly aumentando
sensibilmente la velocità di esecuzione al punto che sia necessario rallentarlo.

La conversione in assembly verrà fatta passo per passo, 
partendo dal sorgente BASIC e convertendo di volta in volta 
piccole porzioni di codice.

Il risultato sarà un programma misto, un po' BASIC e un po' assembly.

In questa prima parte ci limiteremo alla fase preparatoria, la conversione vera 
e propria la affronteremo nelle parti successive.

### Fase preparatoria

Prepariamo gli strumenti e l'area di lavoro (questa è la parte più noiosa).

1) Creiamo la directory `c64-arturo-dente-game` che ospiterà tutti i files. 

2) Scarichiamo l'assemblatore [DASM](https://sourceforge.net/projects/dasm-dillon/) e scompattiamo l'eseguibile `DASM.exe` nella cartella in modo tale che sia richiamabile dalla linea di comando. Alternativamente lo possiamo scompattare in una cartella separata e aggiungerlo nel `PATH`.

3) Installiamo [asmproc](https://github.com/nippur72/asmproc), uno strumento che estende 
la sintassi dell'assembly con la programmazione strutturata, rendendo molto
più semplice programmare in linguaggio macchina. Per installarlo, dal prompt dei comandi:

`npm i -g asmproc`

`AMSPROC` richiede come requisito che sia presente [Node.Js](https://nodejs.org/it/) (ossia
il linguaggio JavaScript). Se non l'avete già fatto, scaricatelo ed installatelo da [questo link](https://nodejs.org/it/).

4) Scarichiamo i files di inclusione `c64.lm`, `macros.lm` e `macro_16.lm` da [qui](https://github.com/nippur72/8-bit-projects/tree/master/c64-arturo-dente-game). Il primo di essi definisce alcune costanti specifiche del Commodore 64 (schermo, memoria ecc...), mentre gli altri sono delle macro che semplificano alcune operazioni ripetitive, consentento di rendere il codice molto meno verboso.

5) Scarichiamo il file batch di compilazione [`t.bat`]([qui](https://github.com/nippur72/8-bit-projects/tree/master/c64-arturo-dente-game/t.bat)). Questo file consente di richiamare in sequenza `asmproc` e `dasm`, ad esempio:

`t parte1`

### Importazione del sorgente BASIC

Prepariamo adesso il file BASIC da dove iniziare la conversione in assembly.

Il nostro punto di partenza è [il sorgente](https://github.com/ArturoDente/F64) di Arturo Dente cha rilasciato su GitHub (versione "ottimizzata").

Nella nostra directory creiamo un file di testo `parte1.lm` con il seguente preambolo:

```
include "macros_16.lm"
include "macros.lm"
include "c64.lm"

   processor 6502
   org BASIC_RAM

basic start
basic end
```

Adesso copiamo il sorgente BASIC dal link GitHub sopra riportato e lo inseriamo tra le linee `basic start` e `basic end`. Le istruzioni `basic start` e `basic end` sono un'estensione di `asmproc` e consentono di aggiungere del codice in BASIC al programma in assembly.

In questa prima parte non faremo alcuna modifica al programma BASIC, ci limitiamo soltanto ad inserire alcuni commenti (con `//`) per una maggiore comprensione.

Trovate il file completo di questa prima parte qui: [parte1.lm](parte1.lm).

Potete compilarlo ed eseguirlo sull'emulatore VICE:

```
> t parte1 & x64 parte1.prg
```

Nella prossima puntata, faremo qualche ottimizzazione al programma BASIC prima di iniziare a convertirlo in assembly.

Link alla [Parte 2](parte2.md)