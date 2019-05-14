99 rem crea e disegna snake
100 l=9:dim x(l):dim y(l)
110 for i=0 to l
120 x(i)=i+1:y(i)=i+1
130 k=102:gosub 1000 
140 next

149 rem posizione di partenza
150 t=l:px=x(t):py=y(t)

200 c=t+1:if c>l then c=c-l-1
210 k=32:i=c:gosub 1000
220 t=t+1:if t>l then t=0
230 px=px+1
240 x(t)=px:y(t)=py
250 k=102:i=t:gosub 1000
260 goto 200

1000 a=x(i)+y(i)*25+1024:poke a,k:return

