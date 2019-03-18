4 color 4,1,0
5 color 0,1,0
6 color 1,6,5
10 dim m(192)
20 fort=0to192:m(t)=184:next
30 graphic1
40 scnclr
50 box 1,0,0,192,184
60 fory=35to-35step-1
70 foro=0to191
71 x=(o+y*4-96)/7
80 h=sqr(x*x+y*y)
90 ifh<>0thenz=-sin(h)/h
110 v=84+y*2+z*70
120 ifv>m(o)thenv=m(o):elsem(o)=v
130 draw 1,o,v
140 next
150 next




