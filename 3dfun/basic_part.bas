100 poke 53272,peek(53272) or 8
105 poke 53265,peek(53265) or 32
106 sys 6660
110 dim m(192)
120 fort=0to192:m(t)=184:next
130 fory=35to-35step-1
140 foro=0to191
150 x=(o+y*4-96)/7
160 h=sqr(x*x+y*y)
170 ifh<>0thenz=-sin(h)/h
180 v=84+y*2+z*70
190 ifv>m(o)thenv=m(o):goto 200
191 m(o)=v
200 poke 6656,o and 255:poke 6656+1,int(o/256)
210 poke 6658,v
220 sys 6723
230 next
240 next
250 goto 250
