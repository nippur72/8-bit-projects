0 poke648,30:poke36869,240:poke36866,150
1 v=36874:fori=.to5:readx:pokev+i,x:next:l=1.1:d=3:k=0:dimp(5):qr=peek(v-9)
2 pokev-5,240:print"{clr}{down}"spc(6)"{rvon}{yel}          {red}{cm-asterisk}{rvof}"
3 printspc(6)"{rvon}{yel} kweepout {red} {rvof}":printspc(6)"{rvon}{yel}          {red} {rvof}"
4 printspc(6)"{red}{cm-asterisk}{rvon}          {rvof}":print"{down}{down}{cyn}6502ad: evil kweepoids{down}block the space lanes."
5 print"{down}a bat is bred with one{down}purpose - destruction!{down}{grn}"
6 print"   by: steve mccrea     (c)2012 kweepa.com":gosub79:print"{down}{down}{red}  press fire to play"
7 j=37145:pokej+9,127:if(peek(j-8)and32)>.then7
8 dims(5):b=8142:c=30720:pokev-9,200:pokev-5,255:s=7680
9 fori=.to505:pokes+i,160:pokes+c+i,1:next:fori=1tod:poke8163+i,59:poke8163+c+i,3:next
10 print"{home}":fori=.to20:print"{down}";:next:print"{rght}{rght}{rght}{rght}{rght}{rght}{rvon}{red}";
11 u=0:fori=1to44:pokev+2,128+2*i:x=2+2*int(5*rnd(1))
12 y=s+44+22*int(12*rnd(1)):f=48-4*int(l*rnd(1)):g=5:iff=44theng=7
13 z=y+x:ifpeek(z)=160thenpokez,f:pokez+1,f+1:pokez+c,g:pokez+c+1,g:u=u+1
14 z=y+20-x:ifpeek(z)=160thenpokez,f:pokez+1,f+1:pokez+c,g:pokez+c+1,g:u=u+1
15 next
16 y=200:e=.:z=.5
17 e=e-.5:y=y+e:ify<.theny=.:e=-.4*e:z=4*z:pokev+3,140:ife<.5then19
18 pokev-9,qr+y:pokev+2,128+z*y:pokev+3,.:goto17
19 pokev+2,.:pokev+3,.:e=10:r=.
20 x=e+1:y=440:gosub67:sb=.
21 pokej+9,127:jl=.:ife>0and(peek(j-8)and16)=.thenjl=1:ll=ll+1:lr=.
22 jr=.:ife<19and(peek(j+7)and128)=.thenjr=1:lr=lr+1:ll=.
23 ifjl+jr=.thenll=.:lr=ll
24 ifn=1and(peek(j-8)and32)=.thenn=.:f=1:g=-22
25 pokej+9,255:ifjl<>.thenpokeb+e+2,160:e=e-1:ife>0andll>5thenpokeb+e+2,160:e=e-1
27 ifjr<>.thenpokeb+e,160:e=e+1:ife<19andlr>5thenpokeb+e,160:e=e+1
28 pokeb+e,56:pokeb+e+1,57:pokeb+e+2,58:o=q:ifn=1thenx=e+1:goto36
29 h=.:ifpeek(q+f)<60thenz=f:gosub50:f=-f:h=1
30 ifpeek(q+g)<60thenz=g:gosub50:g=-g:h=1:ify=440andsb>.thensb=sb-1:gosub67:goto37
31 ifh=.andpeek(q+g+f)<60thenz=g+f:gosub50:f=-f:g=-g:h=1
32 ifh=1then29
33 x=x+f:ifx=.thenf=1
34 ifx=21thenf=-1
35 y=y+g:ify=.theng=-g
36 q=s+y+x:pokeq,59:pokeq+c,3:ifo<>qthenpokeo,160
37 o=q:fori=.to4:ifs(i)<>0thengosub58
38 next:ify>440then44
40 ifcd>.thencd=cd-1:ifcd=.then47
41 ifmc>.thenmc=mc-1:ifmc=.thengosub64
42 ifr>.thengosub68
43 goto21
44 print"lost  ball";:gosub66:mc=5:pokeq,160:pokeq+c,1:poke8163+d,160:d=d-1:ifd>.then20
46 print"game  over";:gosub66:run
47 k=k+1000+100*d:gosub78:y=.:e=y:l=l+.1:ifl>2thenl=2
48 e=e+.5:y=y+e:pokev-9,qr+y:a=128+.5*y:pokev+2,a:ify<200then48
49 pokev+2,.:goto9
50 pokev+2,140:z=(q+z)and8190:w=peek(z):ifw=44thenpokez,48:pokez+1,49:pokez+c,5:pokez+c+1,5:goto57
52 ifw<>48then57
53 k=k+10:gosub78:pokev+3,140:u=u-1:ifu=.thencd=10
54 pokez,46:pokez+1,47:pokez+c,1:pokez+c+1,1:ifr=.andrnd(1)<.1thenr=z+int(rnd(2))
55 fori=.to4:ifs(i)=.thens(i)=6:p(i)=z:i=5
56 next
57 pokev+2,0:pokev+3,0:return
58 s(i)=s(i)-1:a=s(i):z=p(i):ifa=3thenpokez,50:pokez+1,51:pokez+c,2:pokez+c+1,2
60 ifa=2thenpokez,52:pokez+1,53
61 ifa=1thenpokez,54:pokez+1,55
62 ifa=0thenpokez,160:pokez+1,160
63 return
64 print"          ";
65 print"{left}{left}{left}{left}{left}{left}{left}{left}{left}{left}";:return
66 fori=.to999:next:goto65
67 print"press fire";:mc=20:n=1:g=.:goto65
68 ifr>8119thenpoker+c,1
69 ifpeek(r)=60thenpoker,160
70 r=r+22:z=r-(s+440):ifz>=eandz<e+3then75
71 ifz>21thenz=z-22:ifz>=eandz<e+3then75
72 ifz>21thenr=.:return
73 ifpeek(r)=160thenpoker,60:poker+c,4
74 return
75 r=.:mc=10:w=rnd(1):ifw<.3thenprint"sticky bat";:sb=3:goto65
76 ifw<.7andd<6thenprint"extra ball";:d=d+1:poke8163+d,59:poke8163+c+d,3:goto65
77 print"500 points";:gosub65:k=k+500
78 w=fre(w):a$=str$(k):w=len(a$):fori=1tow:poke8185+i-w,128+asc(mid$(a$,i,1)):next:return
79 q=7520:forx=.to11:reada$:fori=1tolen(a$)step4:forj=.to3:p(j)=asc(mid$(a$,i+j,1))-32:ifp(j)=18thenp(j)=2
80 next:pokeq,4*p(0)+p(1)/16:pokeq+1,16*(p(1)and15)+p(2)/4:pokeq+2,64*(p(2)and3)+p(3):q=q+3:next:next:return
81 data0,0,0,0,15,14,"?{left arrow}^[q{left arrow}{left arrow}\^w{left arrow}^{left arrow}]wc","{left arrow}s{left arrow}?{left arrow}g{left arrow}?[8/of/a{left arrow}","{left arrow}onwp?<y/{left arrow}y{left arrow}vxv3"
82 data"q^?\?{left arrow}[;l<gcys{left arrow}^","?]spo.^\\'p..{left arrow}\u","#sw{left arrow}/gspp/#\\,!p"
83 data" @\{left arrow}#p,//pypp # ","\,  0  ##p,  p\2","'w/ex?/{left arrow}{left arrow}w{left arrow}{left arrow}{left arrow}{left arrow}{left arrow}{left arrow}"
84 data"@8'#{left arrow}{left arrow}c.ex?/{left arrow}{left arrow}{left arrow}^"," !@t/#p8   $*!!n",";@!n;@  "
