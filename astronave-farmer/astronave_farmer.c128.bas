0 rem "ASTRONAVE FARMER (c) 1983 Mario Pettenghi & MComputer"
1 rem "Digitato e adattato al C128 da Antonino Porcino, Luglio 2019"
2 co=8:ve=11:sog=20:ogg=10
3 dim co$(8),ve$(11),sog$(20),ogg(10),ogg$(10),fl(9)
4 cl$=chr$(147):ho$=chr$(19):up$=chr$(145):dx$=chr$(13):ri$=chr$(29):be$=chr$(7)
5 print cl$:graphic 5:rem go 80 columns
6 print chr$(14):rem go lowercase
10 goto 500
20 input "COSA DEVO FARE";fr$:print :x=0:y=0
30 for j=1 to co:if instr(fr$,co$(j))<>0 then x=j
40 next:on x gosub 100,100,100,100,8000,9000,9500,9700:if x then return
50 for j=1 to ve:if instr(fr$,ve$(j))<>0 then x=j
60 next:for j=1 to sog:if instr(fr$,sog$(j))<>0 then y=j
70 next:on x gosub 1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,1920:if x then return
80 print dx$;be$;"..SARO' STUPIDO MA NON TI CAPISCO!";dx$:goto 20
90 n=0:e=0:s=0:o=0:print be$;
91 if lo>20 then on lo-20 gosub 2210,2220,2230,2240,2250,2260:goto 94
92 on lo gosub 2000,2010,2020,2030,2040,2050,2060,2070,2080,2090,2100,2110,2120,2130,2140,2150,2160,2170,2180,2190,2200
94 print :print "DIREZIONI POSSIBILI: ";:if n then print "nord ";
96 if e then print "est ";
97 if s then print "sud ";
98 if o then print "ovest ";
99 return
100 if lo=2 and x=3 and fl(1)=0  then print "LA PORTA DI SICUREZZA E' BLOCCATA!":return
101 if lo=10 and x=2 and ogg(3) then print "SOLO GLI UFFICIALI POSSONO ENTRARE!":return
102 if lo=17 and fl(6)=0 and x=4 then print "IL PORTELLONE NON SI APRE!!!":return
103 if lo=17 and x=4 and fl(4)=0 then print "VUOI USCIRE DALLA NAVE MENTRE E' IN VOLO? IDIOTA.":return                                             
108 on x goto 110,120,130,140
110 if n=0 then 150:else lo=n:return
120 if e=0 then 150:else lo=e:return
130 if s=0 then 150:else lo=s:return
140 if o=0 then 150:else lo=o:return
150 print "Non posso andare in quella direzione...":print :return
200 print "OGGETTI VISIBILI:";
210 fl=0:for j=1 to ogg:if ogg(j)=lo then print tab(19);ogg$(j):fl=1
220 next:if fl=0 then print tab(19);"nessuno"
230 if lo=8 and fl(2)=0 then goto 9100
300 print "-----------------------------------------------------------------------------":return
500 for j=1 to co:read co$(j):next
540 for j=1 to ve:read ve$(j):next
550 for j=1 to sog:read sog$(j):next
560 for j=1 to ogg:read ogg(j),ogg$(j):next
590 lo=1:print cl$
600 print "-----------------------------------------------------------------------------":gosub 90
610 print :gosub 200
620 print :gosub 20
630 goto 600
1000 if y=0 then print "Non ci trovo nulla di interessante!":return
1010 if lo=2 and y=10 then print "E' una porta di sicurezza. Puoi aprirla con la sua scheda di riconoscimento.":return
1020 if lo=4 and y=11 then print "E' di metallo, ma lo sportello non ha serrature.":return
1030 if lo=6 and y=13 and ogg(3)=69 then print "Era il comandante C.P.Ustinov. Grand'uomo. Non ha soldi in tasca, ma ha una"
1031 if lo=6 and y=13 and ogg(3)=69 then print "tessera con foto sul petto e una brutta cera.":ogg(3)=6:return
1040 if lo=18 and y=16 and fl(3)=0 then print "C'e' scritto qualcosa in un vecchio linguaggio.  Un appassionato di computer saprebbe certo decifrarlo...":return
1050 if lo=18 and y=16 and fl(3) then print "Le tue conoscenze di computer  ti consentono di leggere il codice di uscita":fl(6)=1 :return
1060 if lo=21 and y=18 and ogg(8)<>0 then print "E' DI OTTONE. C'E' UNA TORCIA SU DI ESSO!":ogg(8)=21:return
1090 print "Mi bruciano gli occhi dallo sforzo.":return
1100 fl=0:if y=0 then  1115
1102 if lo=6 and y=13 then print "No, amico, chiedilo a Frankenstein!":return
1103 if lo=4 and y=2 then print "No, non vale la pena non e' nemmeno digitale.":return
1104 if lo=5 and y=3 then print "E'bloccato con una catenella!":return
1109 for j=1 to ogg:if instr(ogg$(j),sog$(y))<>0 then fl=j
1110 next
1115 if fl=0 or lo<>ogg(fl) then print "Andiamo, cerca di essere serio!!":return
1120 ogg(fl)=0:print "Ok, eseguito.":return
1200 for j=1 to ogg:if sog$(y)=ogg$(j) then fl=j
1210 next
1220 if fl=0 or ogg(fl)<>0 then print "COME POSSO LASCIARE QUELLO CHE NON HO, TOTANO!":return
1230 ogg(fl)=lo:print "Ok... come vuoi tu!":return
1300 if y=0 then 1390
1310 if lo=4 and y=2 then print "E' spento...":return
1320 if lo=11 and y=7 and fl(5) and ogg(7)=0 then lo=14:print "OK, FUNZIONA, MA NON C'E' PIU' ENERGIA PER UN SECONDO UTILIZZO":return
1330 if lo=11 and y=7 and fl(5)=0 then print "Per farlo devi attivare prima il motore.":return
1340 if lo=11 and y=7 and ogg(7) then print "E' necessaria la chiave del quadro comandi!":return
1390 print "PROVA A USARE IL CERVELLO, SE NON E' UN OPTIONAL!":return
1400 if y=17 and ogg(8)=0 then ogg(8)=-1:print "OK....":return
1408 if y<>2 then print "ACCENDITI LA BARBA, IPPOGRIFO!":return
1410 if lo=4 and ogg(6) then print "Dovrei avere anche una cassetta per farlo!":return
1420 if lo<>4 then print "Dove lo trovo? Su Audio Review?":return
1440 print "OK.. C'e' un messaggio:";dx$:print "SEI STATO RISVEGLIATO DALL'IBERNAZIONE PER UNA MISSIONE DI EMERGENZA!"
1450 print "L'ASTRONAVE FARMER HA AVUTO UN'AVARIA. DEVI RIPROGRAMMARE IL COMPUTER":print "DI BORDO PER UN ATTERRAGGIO DI FORTUNA."
1460 print "PER FARLO TI SERVE UN FLOPPY DISC CHE CONTIENE I DATI NECESSARI. TROVALO":print "E INSERISCILO NEL LETTORE DEL COMPUTER DI BORDO."
1470 print "E' IN GIOCO ANCHE LA TUA VITA. AUGURI.":return
1500 if lo=13 and y=15 then print "Le luci vacillano per un istante. Tutto ok.":fl(5)=1:return
1590 print "Forse una petunia ha un Q.I. superiore al tuo...":return
1600 if y=0 then print "Ora ti apriro' il cranio se continui a dire scemate!":return
1610 if lo=2 and ogg(1)=0 and y=10 then print "La porta si apre lentamente...":fl(1)=1:return
1620 if lo=4 and y=11 then print "C'E' UNA CASSETTA QUI DENTRO!":ogg(6)=4:return
1690 print "NON CI RIESCO!!!":return
1700 if lo=5 and y=3 then fl(3)=1: print "Ora sai tutto di computer!":return
1710 print "E' meglio un buon libro di fantascienza":return
1800 if y<>6 then 1830
1810 if ogg(5)<>0 then print "Non mi sembra di averne una...":return
1820 fl(2)=1:print "Non e' proprio la mia taglia, ma puo' andare!":return
1830 print "L'unica cosa che potrei mettere e' la tua testa in un tritatutto!":return
1900 print cl$;:print :return
1920 if lo<>16 or y<>5 then 1970
1930 if ogg(4)<>0 then print "Buona idea! Peccato che non ne ho uno...":return
1940 print "COMPLIMENTI! Il calcolatore e' riprogrammato. Stiamo atterrando!"
1941 print "Ora devi uscire dall'astronave e lanciare l'SOS alla terra! FAI PRESTO!":fl(4)=1:return
1970 print "Potrei dire una volgarita'... ":return
2000 print "Ora sono nella mia cabina. La mia capsula criogenica e' spenta."
2001 print "L'arredamento e' ridotto all'essenziale. Posso uscire solo dalla porta sud."
2005 s=2:return
2010 print "Sono in una stanza dalle pareti di metallo. Ci sono uscite in ogni direzione"
2011 print "La porta a sud ha una serratura magnetica e sembra molto robusta."
2015 n=1:e=3:s=6:o=4:return
2020 print "Sono in un corridoio del settore ricreativo. L'illuminazione e' scarsa, ma"
2021 print "riesco a orientarmi. Nessun segno di vita, mi sento in pericolo."
2025 n=5:e=24:o=2:return
2030 print "Questa e' la sala riunioni. C'e' un grande tavolo con molte sedie, un armadio."
2031 print "Sul tavolo vedo un registratore a cassette, sembra possa funzionare ancora."
2035 e=2:return
2040 print "Sono nella sala di lettura. Ci sono numerosi volumi e in bella vista c'e' una"
2041 print "copia recente di MComputer. Non c'e' anima viva..."
2045 s=3:return
2050 print "Mi trovo in un lungo corridoio. Per terra di fronte a me c'e' un cadavere."
2051 print "Riesco a sentire il ronzio dei motori dell'astronave."
2055 n=2:s=7:return
2060 print "Eccomi in una grande stanza. Ci sono porte dappertutto. Sono vicino al cuore"
2061 print "della nave. La moquette non e' di mio gusto ma sopporto stoicamente il fatto."
2065 n=6:e=9:s=10:o=8:return
2070 print "Sono nella cabina del comandante. L'oblo' di fronte a me e' incrinato. "
2071 print "La temperatura e' di settanta gradi, le radiazioni sono mortali."
2075 e=7:return
2080 print "Questa e' l'armeria. Gli scaffali sono vuoti, siamo in missione pacifica."
2081 print "La porta a est e' chiusa e non vedo come aprirla..."
2085 o=7:return
2090 print "A ovest c'e' un corridoio bloccato da un robot in avaria. A sud vedo lo"
2091 print "splendore della galassia da un oblo' trinitron!"
2095 e=11:n=7 :return
2100 print "Ecco la sala ufficiali. C'e' un ascensore con le porte spalancate. Un tavolo"
2101 print "pieno di bicchieri (vuoti). Vedo a est una sala con pannelli di controllo."
2105 e=13:o=10:return
2110 return: rem pardon!
2120 print "E' la sala controllo traffico. Di fronte a me c'e' un pulsante con la scritta"
2121 print "'Interruttore ascensore', mi sembra troppo bello..."
2125 o=11:return
2130 print "Vedo l'ascensore, ora inutilizzabile. Sono in un  lungo corridoio."
2131 print "A ovest c'e' la sala di sbarco, a est la sala del computer."
2135 e=15:o=17:return
2140 print "Sono nella sala del computer. Vedo i giganteschi banchi di memoria della"
2141 print "Sinclair, e le tastiere a sfioramento. Sono vicino alla sala controlli."
2145 n=18:e=16:o=14:return
2150 print "La sala controllo. Di fronte a me c'e' il drive per floppy disc, ma c'e'"
2151 print "anche una telecamera dall'aspetto sinistro..."
2155 o=15:if ogg(3)=0 then 9110
2156 return
2160 print "Ecco la sala per lo sbarco. A ovest c'e' il portellone elettronico, a est un"
2161 print "lungo corridoio ben illuminato."
2165 o=19:e=14:return
2170 print "Questa e' la sala controllo sbarco, C'e' un terminale acceso, un vecchio"
2171 print "Quantum Beef, con un monitor HP a cristalli tossicodipendenti!"
2175 s=15:return
2180 print "Sono sbarcato. Il cielo e' verde chiaro. Spira un dolce vento. A ovest vedo"
2181 print "una costruzione. A nord una caverna. Un sentiero porta a sud."
2185 n=20:s=22:e=17:o=21:return
2190 if ogg(8)=-1 then 9200
2191 print "L'interno della caverna e' piu' buio che in un adventure... I rumori sono"
2192 print "altrettanto ripugnanti. Anima di Scott Adams, aiutami tu!"
2195 s=19:return
2200 rem
2210 print "Sono all'interno di un tempio alieno. C'e' un grande altare con una statua"
2211 print "di uno scarafaggio a trenta braccia, c'e' odore di insetticida!"
2215 e=19:s=23:return
2220 print "Sono su una collina. Il panorama sotto di me' e' entusiasmante. Vedo villaggi "
2221 print "alieni, carri trainati da strani animali e la reclame della coca-cola."
2225 n=19:return
2230 print "Sono in unga grande sala con dipinti alle pareti, gioielli e armi. Dalla porta"
2231 print "a est scorgo il resto del villaggio, ma una forza misteriosa non mi permette di proseguire."
2235 n=21:return
2240 print "Questa e' la sala addestramento colonizzatori. Non riesco a orientarmi."
2241 print "Ci sono strane attrezzature in ogni punto." 
2245 e=25:s=24:n=25:o=24:return
2250 print "Sono sempre nei locali di addestramento. Non conosco quest'area della nave!"
2255 s=26:n=24:e=24:o=25:return
2260 print "Questa e' la sala addestramento colonizzatori. Non riesco a orientarmi."
2261 print "Ci sono strane attrezzature in ogni punto..."
2265 n=3:s=24:o=25:e=25:return
8000 print :if lo=1 then print "SEI SOLO ALL'INIZIO.":return
8010 if lo=2 then print "STAI IN GUARDIA E CERCA CON PAZIENZA.":return
8020 if lo<27 and lo>23 then print "STUDIA I PUNTI....":return
8030 if lo=17 then print "CI VORREBBE IL CODICE COMPUTERIZZATO...":return
8040 if lo=18 and fl(3)=0 then print "SE TI FOSSI PREPARATO PRIMA, MAGARI LEGGENDO QUALCOSA DI UTILE...":return
8050 if lo=18 then print print "EPPURE QUALCOSA CI DEVE ESSERE...":return
8060 if lo=21 then print "INSISTI, VEDO QUALCOSA...":return
8070 if lo=20 then print "SE CI FOSSE MENO BUIO...":return
8900 if rnd(0)>.5 then print "SONO NEI GUAI COME TE.":else print "MI HAI SCAMBIATO PER L'HOBBIT?"
8910 print :return
9000 print cl$;"Inventario:":print "In questo momento ho con me:";dx$:fl=0
9010 for j=1 to ogg:if ogg(j)=0 then print ogg$(j):fl=1
9020 next:if fl=0 then print "un bel niente..."
9030 return
9100 print :if lo=8 then print "LA MIA PELLE STA PRENDENDO FUOCO. HO POCHI SECONDI DI VITA E NON MI STO"
9101 print "DIVERTENTO PER NIENTE. AAAARGH!":goto 9150
9110 print dx$;dx$;"*** ATTENZIONE **** IDENTIFICAZIONE NEGATIVA. IL TUO TRACCIATO METABOLICO"
9111 print "NON CORRISPONDE AL CAMPIONE. NON SEI IL COMANDANTE USTINOV!"
9112 print dx$;"Un raggio laser mi trapassa da parte a parte, con poca discrezione. Muoio!":goto 9150
9150 print dx$;"Hai fallito miseramente. Vuoi ritentare? (S/N)"
9160 get a$:if a$="" then 9160
9170 if a$="s" or a$="S" then run
9171 if a$="n" or a$="N" then print cl$;"ADDIO...":clr:end
9180 goto 9160
9200 print dx$;be$;dx$:print "HAI TERMINATO QUESTA AVVENTURA...";dx$
9205 print "Di fronte a me c'e' una lastra di pietra alta venti metri: reca una scritta:";dx$
9210 read x:if x=255 then 9230
9220 print chr$(x-ogg(8)-lo);:goto 9210
9230 print : print dx$;"***COMPLIMENTI***";dx$:end
9500 print cl$;be$;"ASTRONAVE FARMER (Avventura 1)********************************"
9510 print dx$;"(C) 1984 Mario Pettenghi"
9511 print dx$;"Digitato e adattato al C128 da Antonino Porcino, Luglio 2019";dx$
9520 print "COMANDI RICONOSCIUTI:";dx$
9530 for j=1 to ve:print ve$(j),:next:for j=1 to co:print co$(j),:next
9540 print dx$;dx$;">PREMI UN TASTO PER RIPRENDERE IL GIOCO":get a$
9550 get a$:if a$="" then 9550
9560 print cl$:return
9700 print dx$;"*** SEI SICURO DI VOLER TERMINARE? ***"
9710 get a$:if a$="" then 9710
9720 if a$="n" or a$="N" then print dx$;"Hai bisogno di una LUNGA vacanza...":return
9730 if a$="s" or a$="S" then print cl$:end
9740 goto 9710
10000 data nord,est,sud,ovest,aiuto,inventario,vocabolario,fine
10010 data esamina,prendi,lascia,usa,accendi,premi,apri,leggi,metti,guarda,inserisci
10020 data scheda,registratore,MC,tessera,floppy disc,tuta,ascensore,codice,portello
10021 data porta,armadio,cassetta,cadavere,chiave,pulsante,monitor,torcia,altare,laser,portachiavi
10030 data 4,scheda,5,MC,69,tessera,8,floppy disc,9,tuta,32,cassetta,25,chiave,29,torcia,4,laser,7,portachiavi
10040 data 89,92,97,88,51,87,88,95,95,84,51,99,101,92,96,84,51,99,84,101,103,88,65,51,97
10041 data 98,97,51,99,88,101,87,88,101,88,51,58,92,95,51,103,88,96,99,92,98,51,84,95,92
10043 data 88,97,98,58,52,65,65,65,255

