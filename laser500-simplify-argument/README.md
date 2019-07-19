# GIOCANDO COL BASIC DEL LASER 500

Il Laser 500 dispone di un ottimo interprete BASIC; è siglato
"Video Technology BASIC 1.0" ma in realtà non è altro che 
un BASIC MicroSOFT di ultima generazione, adattato per la macchina e
concesso in licenza alla Video Technology. Addirittura
in fondo al manuale si trova un form di "non-disclosure agreement"
con cui l'utente si impegna a custodire e non fare utilizzare 
il Microsoft BASIC da persone non autorizzate, e a comunicare
alla Video Technology l'esatta ubicazione dove si trovano
le copie dello stesso (!).

Di recente si è reso possibile approfondire i dettagli di questa
specifica implementazione dell'interprete BASIC, grazie al 
manuale della macchina di cui ne esistono solo poche rare copie, 
ma che è stato gentilmente scannerizzato e condiviso dal retroamatore
Carletto, a cui va la nostra eterna gratitudine. 

Sfogliando il manuale, a pagina 160 si trovano alcuni consigli 
su come rendere più efficienti i programmi BASIC.

Fra questi ve n'è uno che mi ha insospettito:

[](manual_page_160_snip.png)

Secondo quanto consigliato, rendere l'argomento di una funzione 
più semplice ne aumenterebbe la velocità di esecuzione. Ossia
```
A=3^2+17-22/3:A=INT(A)
```
sarebbe più veloce di
```
A=INT(3^2+17-22/3)
```

Ciò mi è sembrato piuttosto controintuitivo, così ho voluto 
mettere alla prova quanto affermato scrivendo un piccolo programma 
di test in BASIC.

Dopotutto basta mettere le istruzioni incrimante a confronto
dentro un ciclo `FOR`, allo scopo di redere apprezzabile 
la differenza di tempo:

```
119 REM versione suggerita
120 FOR I=1 TO 100
130 A=3^2+17-22/3:A=INT(A)
140 NEXT

189 REM versione sconsigliata
190 FOR I=1 TO 100
200 A=INT(3^2+17-22/3)
210 NEXT
```

Adesso basterebbe contare il tempo impiegato nei due `FOR`; vi
è però un problema: il BASIC del Laser 500 non dispone di un meccanismo
per misurare il trascorrere del tempo (per intederci, l'equivalente 
di `TI` o `TI$`), possiamo però ricorrere ad uno stratagemma.

Nel Laser 500 il segnale `VSYNC` del chip video è collegato direttamente
al pin `/INT` (interrupt) della CPU Z80. Questo fa si che ad ogni inizio 
della pagina video, cioè esattamente ogni 20 millisecondi, venga generato 
un interrupt sulla CPU; questo interrupt è utilizzato dal kernal del Laser 
per eseguire alcune funzioni di base, come ad esempio la scansione della 
tastiera, il lampeggiamento del cursore ecc... 

Finita la routine di interrupt, il kernel da la possibilità all'utente di eseguire 
eventualmente una propria routine assembly. A tale scopo, terminata la
propria routine, il kernel fa un jump alla locazione `$8012` nella quale normalemente 
vi è contenuta una istruzione `RET`. Modificando questa in `JP` (jump)
è possibile eseguire del proprio nostro codice. 

L'idea è quella di scrivere una piccola routine di interrupt che incrementi 
un contatore in memoria, il quale diverrà un sostituto della variabile `TI` non
presente nel BASIC.

In assembly Z80 la routine sarà:

```
counter EQU $8650

timer:
   ld hl, (counter)
   inc hl
   ld (counter), hl
   ret
```

dove `$8650` è una word a 16 bit nella memoria bassa del Laser 500 normalmente non utilizzata. 
Il nostro contatore è dunque a 16 bit, questo ci consente di contare fino a circa 21 minuti prima
che questo raggiunga il massimo e riparta da zero (ossia 65536 * 20ms).

Da BASIC potremo poi accedere al contatore semplicemente leggendolo con `PEEK`, ad esempio:
```
T=PEEK(&H8650)+PEEK(&H8651)*256
```

Oltre alla routine di interrupt vera e propria, ci serve anche la routine che installa
la stessa modificando il vettore del kernel a `$8012` appena descritto.

Posiziamo tutta la routine all'indirizzo `$D000`, che è in una zona abbastanza alta nella 
RAM BASIC libera. 

```
org $d000

install:
   ld hl, 0            ; azzera il contatore
   ld (counter), hl    ;

   ld hl, timer        ; carica in HL l'indirizzo della routine "timer"

   di                  ; disabilita gli interrupt momentaneamente
   ld (0x8013), hl     ; scrive l'indirizzo della routine
   ld a, $c3           ; C3 è l'opcode per "JP"
   ld (0x8012), a      ; scrive "JP"
   ei                  ; riabilita gli interrupt
   ret

counter EQU $8650

timer:
   ld hl, (counter)
   inc hl
   ld (counter), hl
   ret   
```

Dopo averla caricato la routine in RAM, possiamo eseguire la stessa
in vari modi, ad esempio dal `MON`itor con il comando:
```
D000G
```

Possiamo adesso estendere il programma BASIC leggendo 
nelle locazioni del contatore che sfruttiamo a 'mo
di cronometro:

```
100 PRINT "SIMPLE ARGUMENT:";
110 T=PEEK(&H8650)+PEEK(&H8651)*256
120 FOR Z=1 TO 100
130 A=3^2+17-22/3:A=INT(A)
140 NEXT
150 PRINT PEEK(&H8650)+PEEK(&H8651)*256-T

170 PRINT "COMPOSITE ARGUMENT:";
180 T=PEEK(&H8650)+PEEK(&H8651)*256
190 FOR Z=1 TO 100
200 A=INT(3^2+17-22/3)
210 NEXT
220 PRINT PEEK(&H8650)+PEEK(&H8651)*256-T
```

Eseguendo il programma troviamo conferma ai
nostri sospetti, infatti la versione "consigliata"
è più lenta (236 ticks contro 223).

[](screenshot.png)

Vatti a fidare dei manuali!

