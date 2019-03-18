5 ti$="000000"
10 dim m(160)
20 fort=0to160:m(t)=184:next
30 @on:@clr
60 fory=35to-25step-1
70 foro=0to159
71 x=(o+y*4-80)/7
80 h=sqr(x*x+y*y)
90 ifh<>.thenz=sin(h)/h
110 v=84+y*2-z*70
120 ifv>m(o)thenv=m(o):goto130
121 m(o)=v
130 @1,o,v
140 next:next
150 @return
151 print ti$
