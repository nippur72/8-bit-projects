0 rem "ASTRONAVE FARMER (c) 1983 Mario Pettenghi & MComputer"
1 rem "Digitato e adattato al C64 da Antonino Porcino, Luglio 2019"
2 co=8:ve=11:sog=20:ogg=10
3 dim co$(8),ve$(11),sog$(20),ogg(10),ogg$(10),fl(9)
4 cl$=chr$(147):ho$=chr$(19):up$=chr$(145):dx$=chr$(13):ri$=chr$(29):be$=chr$(7)
5 print cl$:poke 53280,0:poke 53281,0:poke 646,5
6 print chr$(14):rem go lowercase
10 goto 500
20 input "COSA DEVO FARE";fr$:print :x=0:y=0
30 for j=1 to co:a$=fr$:b$=co$(j):gosub 11000:if i<>0 then x=j
40 next:on x gosub 100,100,100,100,8000,9000,9500,9700:if x then return
50 for j=1 to ve:a$=fr$:b$=ve$(j):gosub 11000:if i<>0 then x=j
60 next:for j=1 to sog:a$=fr$:b$=sog$(j):gosub 11000:if i<>0 then y=j
70 next:on x gosub 1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,1920:if x then return
80 print dx$;be$;"..SARO' STUPIDO MA NON TI CAPISCO!";dx$:goto 20
90 n=0:e=0:s=0:o=0:print be$;
91 if lo>20 then on lo-20 gosub 2210,2220,2230,2240,2250,2260:goto 94
92 on lo gosub 2000,2010,2020,2030,2040,2050,2060,2070,2080,2090,2100,2110,2120,2130,2140,2150,2160,2170,2180,2190,2200
94 print :print "DIREZIONI: ";:if n then print "nord ";
96 if e then print "est ";
97 if s then print "sud ";
98 if o then print "ovest ";
99 return                                             
100 if lo=2 and x=3 and fl(1)=0  then print "LA PORTA DI SICUREZZA E' BLOCCATA!":return
101 if lo=10 and x=2 and ogg(3) then print "SOLO GLI UFFICIALI POSSONO ENTRARE!":return
102 if lo=17 and fl(6)=0 and x=4 then print "IL PORTELLONE NON SI APRE!!!":return
103 if lo=17 and x=4 and fl(4)=0 then print "VUOI USCIRE DALLA NAVE MENTRE E' IN"+chr$(13)+"VOLO? IDIOTA.":return                                             
108 on x goto 110,120,130,140
110 if n=0 then 150
111 lo=n:return
120 if e=0 then 150
121 lo=e:return
130 if s=0 then 150
131 lo=s:return
140 if o=0 then 150
141 lo=o:return           
150 print "Non posso andare in quella direzione...":print :return
200 print "OGGETTI VISIBILI:";
210 fl=0:for j=1 to ogg:if ogg(j)=lo then print tab(19);ogg$(j):fl=1
220 next:if fl=0 then print tab(19);"nessuno"
230 if lo=8 and fl(2)=0 then goto 9100
300 print "--------------------------------------":return
500 for j=1 to co:read co$(j):next
540 for j=1 to ve:read ve$(j):next
550 for j=1 to sog:read sog$(j):next
560 for j=1 to ogg:read ogg(j),ogg$(j):next
590 lo=1:print cl$
600 print "--------------------------------------":gosub 90
610 print :gosub 200
620 print :gosub 20
630 goto 600
1000 if y=0 then print "Non ci trovo nulla di"+chr$(13)+"interessante!":return                                                                                     
1010 if lo=2 and y=10 then print "E' una porta di sicurezza. Puoi"+chr$(13)+"aprirla con la sua scheda di"+chr$(13)+"riconoscimento.":return
1020 if lo=4 and y=11 then print "E' di metallo, ma lo sportello non"+chr$(13)+"ha serrature.":return
1030 if lo=6 and y=13 and ogg(3)=69 then print "Era il comandante C.P.Ustinov."+chr$(13)+"Grand'uomo. Non ha soldi in tasca,"+chr$(13)+"ma ha una tessera con foto sul petto"+chr$(13)+"e una brutta cera.":ogg(3)=6:return
1040 if lo=18 and y=16 and fl(3)=0 then print "C'e' scritto qualcosa in un vecchio"+chr$(13)+"linguaggio. Un appassionato di"+chr$(13)+"computer saprebbe certo decifrarlo...":return
1050 if lo=18 and y=16 and fl(3) then print "Le tue conoscenze di computer ti"+chr$(13)+"consentono di leggere il codice di"+chr$(13)+"uscita":fl(6)=1 :return
1060 if lo=21 and y=18 and ogg(8)<>0 then print "E' DI OTTONE. C'E' UNA TORCIA SU DI"+chr$(13)+"ESSO!":ogg(8)=21:return
1090 print "Mi bruciano gli occhi dallo sforzo.":return
1100 fl=0:if y=0 then  1115
1102 if lo=6 and y=13 then print "No, amico, chiedilo a Frankenstein!":return
1103 if lo=4 and y=2 then print "No, non vale la pena non e' nemmeno"+chr$(13)+"digitale.":return
1104 if lo=5 and y=3 then print "E'bloccato con una catenella!":return
1109 for j=1 to ogg:a$=ogg$(j):b$=sog$(y):gosub 11000:if i<>0 then fl=j
1110 next
1115 if fl=0 or lo<>ogg(fl) then print "Andiamo, cerca di essere serio!!":return
1120 ogg(fl)=0:print "Ok, eseguito.":return
1200 for j=1 to ogg:if sog$(y)=ogg$(j) then fl=j
1210 next
1220 if fl=0 or ogg(fl)<>0 then print "COME POSSO LASCIARE QUELLO CHE NON"+chr$(13)+"HO, TOTANO!":return
1230 ogg(fl)=lo:print "Ok... come vuoi tu!":return
1300 if y=0 then 1390
1310 if lo=4 and y=2 then print "E' spento...":return
1320 if lo=11 and y=7 and fl(5) and ogg(7)=0 then lo=14:print "OK, FUNZIONA, MA NON C'E' PIU'"+chr$(13)+"ENERGIA PER UN SECONDO UTILIZZO":return
1330 if lo=11 and y=7 and fl(5)=0 then print "Per farlo devi attivare prima il"+chr$(13)+"motore.":return
1340 if lo=11 and y=7 and ogg(7) then print "E' necessaria la chiave del quadro"+chr$(13)+"comandi!":return
1390 print "PROVA A USARE IL CERVELLO, SE NON E'"+chr$(13)+"UN OPTIONAL!":return
1400 if y=17 and ogg(8)=0 then ogg(8)=-1:print "OK....":return
1408 if y<>2 then print "ACCENDITI LA BARBA, IPPOGRIFO!":return
1410 if lo=4 and ogg(6) then print "Dovrei avere anche una cassetta per"+chr$(13)+"farlo!":return
1420 if lo<>4 then print "Dove lo trovo? Su Audio Review?":return
1440 print "OK.. C'e' un messaggio:";dx$:print "SEI STATO RISVEGLIATO"+chr$(13)+"DALL'IBERNAZIONE PER UNA MISSIONE DI"+chr$(13)+"EMERGENZA!"
1450 print "L'ASTRONAVE FARMER HA AVUTO"+chr$(13)+"UN'AVARIA. DEVI RIPROGRAMMARE IL"+chr$(13)+"COMPUTER DI BORDO PER UN"+chr$(13)+"ATTERRAGGIO DI FORTUNA."
1460 print "PER FARLO TI SERVE UN FLOPPY DISC"+chr$(13)+"CHE CONTIENE I DATI NECESSARI."+chr$(13)+"TROVALO E INSERISCILO NEL LETTORE"+chr$(13)+"DEL COMPUTER DI BORDO."
1470 print "E' IN GIOCO ANCHE LA TUA VITA."+chr$(13)+"AUGURI.":return
1500 if lo=13 and y=15 then print "Le luci vacillano per un istante."+chr$(13)+"Tutto ok.":fl(5)=1:return
1590 print "Forse una petunia ha un Q.I."+chr$(13)+"superiore al tuo...":return
1600 if y=0 then print "Ora ti apriro' il cranio se continui"+chr$(13)+"a dire scemate!":return
1610 if lo=2 and ogg(1)=0 and y=10 then print "La porta si apre lentamente...":fl(1)=1:return
1620 if lo=4 and y=11 then print "C'E' UNA CASSETTA QUI DENTRO!":ogg(6)=4:return
1690 print "NON CI RIESCO!!!":return
1700 if lo=5 and y=3 then fl(3)=1: print "Ora sai tutto di computer!":return
1710 print "E' meglio un buon libro di"+chr$(13)+"fantascienza":return
1800 if y<>6 then 1830
1810 if ogg(5)<>0 then print "Non mi sembra di averne una...":return
1820 fl(2)=1:print "Non e' proprio la mia taglia, ma"+chr$(13)+"puo' andare!":return
1830 print "L'unica cosa che potrei mettere e'"+chr$(13)+"la tua testa in un tritatutto!":return
1900 print cl$;:print :return
1920 if lo<>16 or y<>5 then 1970
1930 if ogg(4)<>0 then print "Buona idea! Peccato che non ne ho"+chr$(13)+"uno...":return
1940 print "COMPLIMENTI! Il calcolatore e'"+chr$(13)+"riprogrammato. Stiamo atterrando!"
1941 print "Ora devi uscire dall'astronave e"+chr$(13)+"lanciare l'SOS alla terra! FAI"+chr$(13)+"PRESTO!":fl(4)=1:return
1970 print "Potrei dire una volgarita'... ":return
2000 print "Ora sono nella mia cabina. La mia"+chr$(13)+"capsula criogenica e' spenta."+chr$(13)+"L'arredamento e' ridotto"+chr$(13)+"all'essenziale. Posso uscire solo"+chr$(13)+"dalla porta sud."
2005 s=2:return
2010 print "Sono in una stanza dalle"+chr$(13)+"pareti di metallo. Ci sono"+chr$(13)+"uscite in ogni direzione. La"+chr$(13)+"porta a sud ha una serratura"+chr$(13)+"magnetica e sembra molto"+chr$(13)+"robusta."
2015 n=1:e=3:s=6:o=4:return
2020 print "Sono in un corridoio del"+chr$(13)+"settore ricreativo."+chr$(13)+"L'illuminazione e' scarsa, ma"+chr$(13)+"riesco a orientarmi. Nessun"+chr$(13)+"segno di vita, mi sento in"+chr$(13)+"pericolo."
2025 n=5:e=24:o=2:return
2030 print "Questa e' la sala riunioni."+chr$(13)+"C'e' un grande tavolo con"+chr$(13)+"molte sedie, un armadio. Sul"+chr$(13)+"tavolo vedo un registratore a"+chr$(13)+"cassette, sembra possa"+chr$(13)+"funzionare ancora."
2035 e=2:return
2040 print "Sono nella sala di lettura. Ci"+chr$(13)+"sono numerosi volumi e in"+chr$(13)+"bella vista c'e' una copia"+chr$(13)+"recente di MComputer. Non c'e'"+chr$(13)+"anima viva..."
2045 s=3:return
2050 print "Mi trovo in un lungo"+chr$(13)+"corridoio. Per terra di fronte"+chr$(13)+"a me c'e' un cadavere. Riesco"+chr$(13)+"a sentire il ronzio dei motori"+chr$(13)+"dell'astronave."
2055 n=2:s=7:return
2060 print "Eccomi in una grande stanza."+chr$(13)+"Ci sono porte dappertutto."+chr$(13)+"Sono vicino al cuore della"+chr$(13)+"nave. La moquette non e' di"+chr$(13)+"mio gusto ma sopporto"+chr$(13)+"stoicamente il fatto."
2065 n=6:e=9:s=10:o=8:return
2070 print "Sono nella cabina del"+chr$(13)+"comandante. L'oblo' di fronte"+chr$(13)+"a me e' incrinato. La"+chr$(13)+"temperatura e' di settanta"+chr$(13)+"gradi, le radiazioni sono"+chr$(13)+"mortali."
2075 e=7:return:rem "era o=7:return"
2080 print "Questa e' l'armeria. Gli"+chr$(13)+"scaffali sono vuoti, siamo in"+chr$(13)+"missione pacifica. La porta a"+chr$(13)+"est e' chiusa e non vedo come"+chr$(13)+"aprirla..."
2085 o=7:return
2090 print "A ovest c'e' un corridoio"+chr$(13)+"bloccato da un robot in"+chr$(13)+"avaria. A sud vedo lo"+chr$(13)+"splendore della galassia da"+chr$(13)+"un oblo' trinitron!"
2095 e=11:n=7 :return
2100 print "Ecco la sala ufficiali. C'e'"+chr$(13)+"un ascensore con le porte"+chr$(13)+"spalancate. Un tavolo pieno"+chr$(13)+"di bicchieri (vuoti). Vedo a"+chr$(13)+"est una sala con pannelli di"+chr$(13)+"controllo."
2105 e=13:o=10:return
2110 return: rem pardon!
2120 print "E' la sala controllo traffico."+chr$(13)+"Di fronte a me c'e' un"+chr$(13)+"pulsante con la scritta"+chr$(13)+"'Interruttore ascensore', mi"+chr$(13)+"sembra troppo bello..."
2125 o=11:return
2130 print "Vedo l'ascensore, ora"+chr$(13)+"inutilizzabile. Sono in un"+chr$(13)+"lungo corridoio. A ovest c'e'"+chr$(13)+"la sala di sbarco, a est la"+chr$(13)+"sala del computer."
2135 e=15:o=17:return
2140 print "Sono nella sala del computer."+chr$(13)+"Vedo i giganteschi banchi di"+chr$(13)+"memoria della Sinclair, e le"+chr$(13)+"tastiere a sfioramento. Sono"+chr$(13)+"vicino alla sala controlli."
2145 n=18:e=16:o=14:return
2150 print "La sala controllo. Di fronte a me c'e'"+chr$(13)+"il drive per floppy disc, ma c'e'"+chr$(13)+"anche una telecamera dall'aspetto"+chr$(13)+"sinistro..."
2155 o=15:if ogg(3)=0 then 9110
2156 return
2160 print "Ecco la sala per lo sbarco. A ovest"+chr$(13)+"c'e' il portellone elettronico, a est"+chr$(13)+"un lungo corridoio ben illuminato."
2165 o=19:e=14:return
2170 print "Questa e' la sala controllo sbarco,"+chr$(13)+"C'e' un terminale acceso, un vecchio"+chr$(13)+"Quantum Beef, con un monitor HP a"+chr$(13)+"cristalli tossicodipendenti!"
2175 s=15:return
2180 print "Sono sbarcato. Il cielo e' verde"+chr$(13)+"chiaro. Spira un dolce vento. A ovest"+chr$(13)+"vedo una costruzione. A nord una"+chr$(13)+"caverna. Un sentiero porta a sud."
2185 n=20:s=22:e=17:o=21:return:rem o=21 era commentato
2190 if ogg(8)=-1 then 9200
2191 print "L'interno della caverna e' piu' buio"+chr$(13)+"che in un adventure... I rumori sono"+chr$(13)+"altrettanto ripugnanti. Anima di Scott"+chr$(13)+"Adams, aiutami tu!"
2195 s=19:return
2200 rem
2210 print "Sono all'interno di un tempio alieno."+chr$(13)+"C'e' un grande altare con una statua"+chr$(13)+"di uno scarafaggio a trenta braccia,"+chr$(13)+"c'e' odore di insetticida!"
2215 e=19:s=23:return
2220 print "Sono su una collina. Il panorama sotto"+chr$(13)+"di me' e' entusiasmante. Vedo villaggi"+chr$(13)+"alieni, carri trainati da strani"+chr$(13)+"animali e la reclame della coca-cola."
2225 n=19:return
2230 print "Sono in unga grande sala con dipinti"+chr$(13)+"alle pareti, gioielli e armi. Dalla"+chr$(13)+"porta a est scorgo il resto del"+chr$(13)+"villaggio, ma una forza misteriosa"+chr$(13)+"non mi permette di proseguire."
2235 n=21:return
2240 print "Questa e' la sala addestramento"+chr$(13)+"colonizzatori. Non riesco a"+chr$(13)+"orientarmi. Ci sono strane attrezzature"+chr$(13)+"in ogni punto." 
2245 e=25:s=24:n=25:o=24:return
2250 print "Sono sempre nei locali di"+chr$(13)+"addestramento. Non conosco quest'area"+chr$(13)+"della nave!"
2255 s=26:n=24:e=24:o=25:return
2260 print "Questa e' la sala addestramento"+chr$(13)+"colonizzatori. Non riesco a orientarmi."+chr$(13)+"Ci sono strane attrezzature in ogni"+chr$(13)+"punto..."
2265 n=3:s=24:o=25:e=25:return
8000 print :if lo=1 then print "SEI SOLO ALL'INIZIO.":return
8010 if lo=2 then print "STAI IN GUARDIA E CERCA CON PAZIENZA.":return
8020 if lo<27 and lo>23 then print "STUDIA I PUNTI....":return
8030 if lo=17 then print "CI VORREBBE IL CODICE COMPUTERIZZATO...":return
8040 if lo=18 and fl(3)=0 then print "SE TI FOSSI PREPARATO PRIMA, MAGARI LEGGENDO QUALCOSA DI UTILE...":return
8050 if lo=18 then print "EPPURE QUALCOSA CI DEVE ESSERE...":return
8060 if lo=21 then print "INSISTI, VEDO QUALCOSA...":return
8070 if lo=20 then print "SE CI FOSSE MENO BUIO...":return
8900 if rnd(0)>.5 then print "SONO NEI GUAI COME TE.":print:return
8901 print "MI HAI SCAMBIATO PER L'HOBBIT?":print:return
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
9170 if a$="s" or a$="S" then RUN
9171 if a$="n" or a$="N" then print cl$;"ADDIO...":clr:end
9180 goto 9160
9200 print dx$;be$;dx$:print "HAI TERMINATO QUESTA AVVENTURA...";dx$
9205 print "Di fronte a me c'e' una lastra di pietra alta venti metri: reca una scritta:";dx$
9210 read x:if x=255 then 9230
9220 print chr$(x-ogg(8)-lo);:goto 9210
9230 print : print dx$;"***COMPLIMENTI***";dx$:end
9500 print cl$;be$;"ASTRONAVE FARMER (Avventura 1)********************************"
9510 print dx$;"(C) 1984 Mario Pettenghi"
9511 print dx$;"Digitato e adattato al C64 da Antonino Porcino, Luglio 2019";dx$
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
10010 data esamina,prendi,lascia,usa,accendi,premi
10011 data apri,leggi,metti,guarda,inserisci
10020 data scheda,registratore,MC,tessera,floppy disc,tuta
10021 data ascensore,codice,portello
10022 data porta,armadio,cassetta,cadavere,chiave,pulsante
10023 data monitor,torcia,altare,laser,portachiavi
10030 data 4,scheda,5,MC,69,tessera,8,floppy disc
10031 data 9,tuta,32,cassetta,25,chiave,29,torcia,4,laser,7,portachiavi
10040 data 89,92,97,88,51,87,88,95,95,84,51,99
10041 data 101,92,96,84,51,99,84,101,103,88,65,51,97
10042 data 98,97,51,99,88,101,87,88,101,88,51,58,92
10043 data 95,51,103,88,96,99,92,98,51,84,95,92
10044 data 88,97,98,58,52,65,65,65,255
11000 rem instr(A$,B$) returns I
11010 for i=1 to len(a$)-len(b$)+1
11030 if mid$(a$,i,len(b$))=b$ then return
11050 next i
11060 i=0:return

