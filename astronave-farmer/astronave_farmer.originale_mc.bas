0 REM ASTRONAVE FARMER (c) 1983 Mario Pettenghi & MComputer
1 DEFINT A-Z:CO=8:VE=11:SOG=20:OGG=10
2 DIM CO$(8),VE$(11),SOG$(20),OGG(10),OGG$(10),FL(9)
3 CL$=CHR$(26):HO$=CHR$(21):UP$=CHR$(11):DO$=CHR$(10):RI$=CHR$(12):BE$=CHR$(7):WIDTH 78
10 GOTO 500
20 LINE INPUT "COSA DEVO FARE? ";FR$:PRINT:X=0:Y=0
30 FOR J=1 TO CO:IF INSTR(1,FR$,CO$(J))<>0 THEN X=J
40 NEXT:ON X GOSUB 100,100,100,100,8000,9000,9500,9700:IF X THEN RETURN
50 FOR J=1 TO VE:IF INSTR(1,FR$,VE$(J))<>0 THEN X=J
60 NEXT:FOR J=1 TO SOG:IF INSTR(1,FR$,SOG$(J))<>0 THEN Y=J
70 NEXT:ON X GOSUB 1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,1920:IF X THEN RETURN
80 PRINT DO$;BE$;"..SARO` STUPIDO MA NON TI CAPISCO!";DO$:GOTO 20
90 N=0:E=0:S=0:O=0:PRINT BE$;
91 IF LO>20 THEN ON LO-20 GOSUB 2210,2220,2230,2240,2250,2260:GOTO 94
92 ON LO GOSUB 2000,2010,2020,2030,2040,2050,2060,2070,2080,2090,2100,2110,2120,2130,2140,2150,2160,2170,2180,2190,2200
94 PRINT:PRINT"DIREZIONI POSSIBILI: ";:IF N THEN PRINT"nord ";
96 IF E THEN PRINT "est ";
97 IF S THEN PRINT "sud ";
98 IF O THEN PRINT "ovest ";
99 RETURN
100 IF LO=2 AND X=3 AND FL(1)=0  THEN PRINT "LA PORTA DI SICUREZZA E' BLOCCATA!":RETURN
101 IF LO=10 AND X=2 AND OGG(3) THEN PRINT"SOLO GLI UFFICIALI POSSONO ENTRARE!":RETURN
102 IF LO=17 AND FL(6)=0 AND X=4 THEN PRINT "IL PORTELLONE NON SI APRE!!!":RETURN
103 IF LO=17 AND X=4 AND FL(4)=0 THEN PRINT"VUOI USCIRE DALLA NAVE MENTRE E' IN VOLO? IDIOTA.":RETURN
108 ON X GOTO 110,120,130,140
110 IF N=0 THEN 150 ELSE LO=N:RETURN
120 IF E=0 THEN 150 ELSE LO=E:RETURN
130 IF S=0 THEN 150 ELSE LO=S:RETURN
140 IF O=0 THEN 150 ELSE LO=O:RETURN
150 PRINT "Non posso andare in quella direzione...":PRINT:RETURN
200 PRINT "OGGETTI VISIBILI:";
210 FL=0:FOR J=1 TO OGG:IF OGG(J)=LO THEN PRINT TAB(19);OGG$(J):FL=1
220 NEXT:IF FL=0 THEN PRINT TAB(19);"nessuno"
230 IF LO=8 AND FL(2)=0 THEN GOTO 9100
300 PRINT STRING$(78,"-"):RETURN
500 FOR J=1 TO CO:READ CO$(J):NEXT
540 FOR J=1 TO VE:READ VE$(J):NEXT
550 FOR J=1 TO SOG:READ SOG$(J):NEXT
560 FOR J=1 TO OGG:READ OGG(J),OGG$(J):NEXT
590 LO=1:PRINT CL$
600 PRINT STRING$(78,"-"):GOSUB 90
610 PRINT:GOSUB 200
620 PRINT:GOSUB 20
630 GOTO 600
1000 IF Y=0 THEN PRINT "Non ci trovo nulla di interessante!":RETURN
1010 IF LO=2 AND Y=10 THEN PRINT "E` una porta di sicurezza. Puoi aprirla con la sua scheda di riconoscimento.":RETURN
1020 IF LO=4 AND Y=11 THEN PRINT "E` di metallo, ma lo sportello non ha serrature.":RETURN
1030 IF LO=6 AND Y=13 AND OGG(3)=69 THEN PRINT"Era il comandante C.P.Ustinov. Grand'uomo. Non ha soldi in tasca, ma ha una":PRINT"tessera con foto sul petto e una brutta cera.":OGG(3)=6:RETURN
1040 IF LO=18 AND Y=16 AND FL(3)=0 THEN PRINT"C'e` scritto qualcosa in un vecchio linguaggio.  Un appassionato di computer saprebbe certo decifrarlo...":RETURN
1050 IF LO=18 AND Y=16 AND FL(3) THEN PRINT"Le tue conoscenze di computer  ti consentono di leggere il codice di uscita":FL(6)=1 :RETURN
1060 IF LO=21 AND Y=18 AND OGG(8)<>0 THEN PRINT"E` DI OTTONE. C'E` UNA TORCIA SU DI ESSO!":OGG(8)=21:RETURN
1090 PRINT "Mi bruciano gli occhi dallo sforzo.":RETURN
1100 FL=0:IF Y=0 THEN  1115
1102 IF LO=6 AND Y=13 THEN PRINT"No, amico, chiedilo a Frankenstein!":RETURN
1103 IF LO=4 AND Y=2 THEN PRINT"No, non vale la pena non e` nemmeno digitale.":RETURN
1104 IF LO=5 AND Y=3 THEN PRINT "E'bloccato con una catenella!":RETURN
1109 FOR J=1 TO OGG:IF INSTR(1,OGG$(J),SOG$(Y))<>0 THEN FL=J
1110 NEXT
1115 IF FL=0 OR LO<>OGG(FL) THEN PRINT "Andiamo, cerca di essere serio!!":RETURN
1120 OGG(FL)=0:PRINT "Ok, eseguito.":RETURN
1200 FOR J=1 TO OGG:IF SOG$(Y)=OGG$(J) THEN FL=J
1210 NEXT
1220 IF FL=0 OR OGG(FL)<>0 THEN PRINT"COME POSSO LASCIARE QUELLO CHE NON HO, TOTANO!":RETURN
1230 OGG(FL)=LO:PRINT"Ok... come vuoi tu!":RETURN
1300 IF Y=0 THEN 1390
1310 IF LO=4 AND Y=2 THEN PRINT"E' spento...":RETURN
1320 IF LO=11 AND Y=7 AND FL(5) AND OGG(7)=0 THEN LO=14:PRINT"OK, FUNZIONA, MA NON C'E` PIU` ENERGIA PER UN SECONDO UTILIZZO":RETURN
1330 IF LO=11 AND Y=7 AND FL(5)=0 THEN PRINT "Per farlo devi attivare prima il motore.":RETURN
1340 IF LO=11 AND Y=7 AND OGG(7) THEN PRINT "E` necessaria la chiave del quadro comandi!":RETURN
1390 PRINT "PROVA A USARE IL CERVELLO, SE NON E` UN OPTIONAL!":RETURN
1400 IF Y=17 AND OGG(8)=0 THEN OGG(8)=-1:PRINT"OK....":RETURN
1408 IF Y<>2 THEN PRINT "ACCENDITI LA BARBA, IPPOGRIFO!":RETURN
1410 IF LO=4 AND OGG(6) THEN PRINT"Dovrei avere anche una cassetta per farlo!":RETURN
1420 IF LO<>4 THEN PRINT "Dove lo trovo? Su Audio Review?":RETURN
1440 PRINT"OK.. C'e` un messaggio:";DO$:PRINT"SEI STATO RISVEGLIATO DALL'IBERNAZIONE PER UNA MISSIONE DI EMERGENZA!"
1450 PRINT"L'ASTRONAVE FARMER HA AVUTO UN'AVARIA. DEVI RIPROGRAMMARE IL COMPUTER":PRINT"DI BORDO PER UN ATTERRAGGIO DI FORTUNA."
1460 PRINT"PER FARLO TI SERVE UN FLOPPY DISC CHE CONTIENE I DATI NECESSARI. TROVALO":PRINT"E INSERISCILO NEL LETTORE DEL COMPUTER DI BORDO."
1470 PRINT"E` IN GIOCO ANCHE LA TUA VITA. AUGURI.":RETURN
1500 IF LO=13 AND Y=15 THEN PRINT "Le luci vacillano per un istante. Tutto ok.":FL(5)=1:RETURN
1590 PRINT "Forse una petunia ha un Q.I. superiore al tuo...":RETURN
1600 IF Y=0 THEN PRINT "Ora ti apriro` il cranio se continui a dire scemate!":RETURN
1610 IF LO=2 AND OGG(1)=0 AND Y=10 THEN PRINT"La porta si apre lentamente...":FL(1)=1:RETURN
1620 IF LO=4 AND Y=11 THEN PRINT"C'E` UNA CASSETTA QUI DENTRO!":OGG(6)=4:RETURN
1690 PRINT "NON CI RIESCO!!!":RETURN
1700 IF LO=5 AND Y=3 THEN FL(3)=1: PRINT"Ora sai tutto di computer!":RETURN
1710 PRINT "E` meglio un buon libro di fantascienza":RETURN
1800 IF Y<>6 THEN 1830
1810 IF OGG(5)<>0 THEN PRINT "Non mi sembra di averne una...":RETURN
1820 FL(2)=1:PRINT "Non e` proprio la mia taglia, ma puo` andare!":RETURN
1830 PRINT"L'unica cosa che potrei mettere e` la tua testa in un tritatutto!":RETURN
1900 PRINT CL$;:PRINT:RETURN
1920 IF LO<>16 OR Y<>5 THEN 1970
1930 IF OGG(4)<>0 THEN PRINT "Buona idea! Peccato che non ne ho uno...":RETURN
1940 PRINT "COMPLIMENTI! Il calcolatore e` riprogrammato. Stiamo atterrando!":PRINT "Ora devi uscire dall'astronave e lanciare l'SOS alla terra! FAI PRESTO!":FL(4)=1:RETURN
1970 PRINT"Potrei dire una volgarita`... ":RETURN
2000 PRINT"Ora sono nella mia cabina. La mia capsula criogenica e` spenta.":PRINT"L'arredamento e` ridotto all'essenziale. Posso uscire solo dalla porta sud."
2005 S=2:RETURN
2010 PRINT"Sono in una stanza dalle pareti di metallo. Ci sono uscite in ogni direzione":PRINT"La porta a sud ha una serratura magnetica e sembra molto robusta."
2015 N=1:E=3:S=6:O=4:RETURN
2020 PRINT"Sono in un corridoio del settore ricreativo. L'illuminazione e` scarsa, ma":PRINT"riesco a orientarmi. Nessun segno di vita, mi sento in pericolo."
2025 N=5:E=24:O=2:RETURN
2030 PRINT"Questa e` la sala riunioni. C'e` un grande tavolo con molte sedie, un armadio.":PRINT"Sul tavolo vedo un registratore a cassette, sembra possa funzionare ancora."
2035 E=2:RETURN
2040 PRINT"Sono nella sala di lettura. Ci sono numerosi volumi e in bella vista c'e` una":PRINT"copia recente di MComputer. Non c'e` anima viva..."
2045 S=3:RETURN
2050 PRINT"Mi trovo in un lungo corridoio. Per terra di fronte a me c'e` un cadavere.":PRINT"Riesco a sentire il ronzio dei motori dell'astronave."
2055 N=2:S=7:RETURN
2060 PRINT"Eccomi in una grande stanza. Ci sono porte dappertutto. Sono vicino al cuore":PRINT"della nave. La moquette non e` di mio gusto ma sopporto stoicamente il fatto."
2065 N=6:E=9:S=10:O=8:RETURN
2070 PRINT"Sono nella cabina del comandante. L'oblo` di fronte a me e` incrinato. La temperatura e` di settanta gradi, le radiazioni sono mortali."
2075 O=7:RETURN
2080 PRINT"Questa e` l'armeria. Gli scaffali sono vuoti, siamo in missione pacifica.":PRINT"La porta a est e` chiusa e non vedo come aprirla..."
2085 O=7:RETURN
2090 PRINT"A ovest c'e` un corridoio bloccato da un robot in avaria. A sud vedo lo":PRINT"splendore della galassia da un oblo` trinitron!"
2095 E=11:N=7 :RETURN
2100 PRINT"Ecco la sala ufficiali. C'e` un ascensore con le porte spalancate. Un tavolo":PRINT"pieno di bicchieri (vuoti). Vedo a est una sala con pannelli di controllo."
2105 E=13:O=10:RETURN
2110 RETURN: REM pardon!
2120 PRINT"E' la sala controllo traffico. Di fronte a me c'e` un pulsante con la scritta":PRINT"'Interruttore ascensore', mi sembra troppo bello..."
2125 O=11:RETURN
2130 PRINT "Vedo l'ascensore, ora inutilizzabile. Sono in un  lungo corridoio.":PRINT"A ovest c'e` la sala di sbarco, a est la sala del computer."
2135 E=15:O=17:RETURN
2140 PRINT"Sono nella sala del computer. Vedo i giganteschi banchi di memoria della":PRINT"Sinclair, e le tastiere a sfioramento. Sono vicino alla sala controlli."
2145 N=18:E=16:O=14:RETURN
2150 PRINT "La sala controllo. Di fronte a me c'e` il drive per floppy disc, ma c'e`":PRINT"anche una telecamera dall'aspetto sinistro..."
2155 O=15: IF OGG(3)=0 THEN 9110
2156 RETURN
2160 PRINT"Ecco la sala per lo sbarco. A ovest c'e` il portellone elettronico, a est un":PRINT"lungo corridoio ben illuminato."
2165 O=19:E=14:RETURN
2170 PRINT"Questa e` la sala controllo sbarco, C'e` un terminale acceso, un vecchio":PRINT"Quantum Beef, con un monitor HP a cristalli tossicodipendenti!"
2175 S=15:RETURN
2180 PRINT "Sono sbarcato. Il cielo e` verde chiaro. Spira un dolce vento. A ovest vedo":PRINT"una costruzione. A nord una caverna. Un sentiero porta a sud."
2185 N=20:S=22:E=17:RETURN:'o=21
2190 IF OGG(8)=-1 THEN 9200
2192 PRINT"L'interno della caverna e` piu` buio che in un adventure... I rumori sono":PRINT"altrettanto ripugnanti. Anima di Scott Adams, aiutami tu!"
2195 S=19:RETURN
2200 REM
2210 PRINT"Sono all'interno di un tempio alieno. C'e` un grande altare con una statua":PRINT"di uno scarafaggio a trenta braccia, c'e` odore di insetticida!"
2215 E=19:S=23:RETURN
2220 PRINT"Sono su una collina. Il panorama sotto di me` e` entusiasmante. Vedo villaggi ":PRINT"alieni, carri trainati da strani animali e la reclame della coca-cola."
2225 N=19:RETURN
2230 PRINT "Sono in unga grande sala con dipinti alle pareti, gioielli e armi. Dalla porta":PRINT"a est scorgo il resto del villaggio, ma una forza misteriosa non mi permette di proseguire."
2235 N=21:RETURN
2240 PRINT"Questa e` la sala addestramento colonizzatori. Non riesco a orientarmi.":PRINT"Ci sono strane attrezzature in ogni punto." 
2245 E=25:S=24:N=25:O=24:RETURN
2250 PRINT "Sono sempre nei locali di addestramento. Non conosco quest'area della nave!"
2255 S=26:N=24:E=24:O=25:RETURN
2260 PRINT "Questa e` la sala addestramento colonizzatori. Non riesco a orientarmi.":PRINT"Ci sono strane attrezzature in ogni punto..."
2265 N=3:S=24:O=25:E=25:RETURN
8000 PRINT:IF LO=1 THEN PRINT"SEI SOLO ALL'INIZIO.":RETURN
8010 IF LO=2 THEN PRINT"STAI IN GUARDIA E CERCA CON PAZIENZA.":RETURN
8020 IF LO<27 AND LO>23 THEN PRINT"STUDIA I PUNTI....":RETURN
8030 IF LO=17 THEN PRINT"CI VORREBBE IL CODICE COMPUTERIZZATO...":RETURN
8040 IF LO=18 AND FL(3)=0 THEN PRINT"SE TI FOSSI PREPARATO PRIMA, MAGARI LEGGENDO QUALCOSA DI UTILE...":RETURN
8050 IF LO=18 THEN PRINT PRINT"EPPURE QUALCOSA CI DEVE ESSERE...":RETURN
8060 IF LO=21 THEN PRINT"INSISTI, VEDO QUALCOSA...":RETURN
8070 IF LO=20 THEN PRINT"SE CI FOSSE MENO BUIO...":RETURN
8900 IF RND(1)>.5 THEN PRINT"SONO NEI GUAI COME TE." ELSE PRINT"MI HAI SCAMBIATO PER L'HOBBIT?"
8910 PRINT:RETURN
9000 PRINT CL$;"Inventario:":PRINT"In questo momento ho con me:";DO$:FL=0
9010 FOR J=1 TO OGG:IF OGG(J)=0 THEN PRINT OGG$(J):FL=1
9020 NEXT:IF FL=0 THEN PRINT "un bel niente..."
9030 RETURN
9100 PRINT:IF LO=8 THEN PRINT "LA MIA PELLE STA PRENDENDO FUOCO. HO POCHI SECONDI DI VITA E NON MI STO":PRINT"DIVERTENTO PER NIENTE. AAAARGH!":GOTO 9150
9110 PRINT DO$;DO$;"*** ATTENZIONE **** IDENTIFICAZIONE NEGATIVA. IL TUO TRACCIATO METABOLICO":PRINT"NON CORRISPONDE AL CAMPIONE. NON SEI IL COMANDANTE USTINOV!"
9112 PRINT DO$;"Un raggio laser mi trapassa da parte a parte, con poca discrezione. Muoio!":GOTO 9150
9150 PRINT DO$;"Hai fallito miseramente. Vuoi ritentare? (S/N)"
9160 A$=INKEY$:IF A$="" THEN 9160
9170 IF A$="s" OR A$="S" THEN RUN
9180 PRINT CL$;"ADDIO...":CLEAR:END
9200 PRINT DO$;BE$;DO$:PRINT"HAI TERMINATO QUESTA AVVENTURA...";DO$
9205 PRINT "Di fronte a me c'e` una lastra di pietra alta venti metri: reca una scritta:";DO$
9210 READ X:IF X=255 THEN 9230
9220 PRINT CHR$(X-OGG(8)-LO);:GOTO 9210
9230 PRINT: PRINT DO$;"***COMPLIMENTI***";DO$:END
9500 PRINT CL$;BE$;"ASTRONAVE FARMER (Avventura 1)********************************"
9510 PRINT DO$;"(C) 1984 Mario Pettenghi";DO$
9520 PRINT "COMANDI RICONOSCIUTI:";DO$
9530 FOR J=1 TO VE:PRINT VE$(J),:NEXT:FOR J=1 TO CO:PRINT CO(J),:NEXT
9540 PRINT DO$;">PREMI UN TASTO PER RIPRENDERE IL GIOCO":A$=INKEY$
9550 A$=INKEY$:IF A$="" THEN 9550
9560 PRINT CL$:RETURN
9700 PRINT DO$;"*** SEI SICURO DI VOLER TERMINARE? ***"
9710 A$=INKEY$:IF A$="" THEN 9710
9720 IF A$="n" OR A$="N" THEN PRINT DO$;"Hai bisogno di una LUNGA vacanza...":RETURN
9730 IF A$="s" OR A$="S" THEN PRINT CL$:END
9740 GOTO 9710
10000 DATA nord ,est,sud,ovest,aiuto,inventario,vocabolario,fine:'   VERBI
10010 DATA esamina,prendi,lascia,usa,accendi,premi,apri,leggi,metti,guarda,inserisci:'VERBI
10020 DATA scheda,registratore,MC,tessera,floppy disc,tuta,ascensore,codice,portello
10021 DATA porta,armadio,cassetta,cadavere,chiave,pulsante,monitor,torcia,altare,laser,portachiavi
10030 DATA 4,scheda,5,MC,69,tessera,8,floppy disc,9,tuta,32,cassetta,25,chiave,29,torcia,4,laser,7,portachiavi
10040 DATA 89,92,97,88,51,87,88,95,95,84,51,99,101,92,96,84,51,99,84,101,103,88,65,51,97,98,97,51,99,88,101,87,88,101,88,51,58,92,95,51,103,88,96,99,92,98,51,84,95,92,88,97,98,58,52,65,65,65,255

REM le seguenti linee risolvono due BUG sulla mappa (Antonino Porcino 2019)

2075 E=7:RETURN
2185 N=20:S=22:E=17:o=21:RETURN

