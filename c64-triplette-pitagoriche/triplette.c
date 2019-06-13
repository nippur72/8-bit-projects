#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef unsigned int ttrip;

unsigned int n = 1;  // numero di triplette generate

ttrip buf1[1700 * 3];   // buffer1
ttrip buf2[1700 * 3];   // buffer2
ttrip buf_calc[50 * 3]; // buffer dove scrivere le triplette calcolate nel range 981-1000

ttrip *buf_read;    // puntatore al buffer con le triplette da esaminare
ttrip *buf_write;   // puntatore al buffer dove scrivere le triplette generate

unsigned int buf_read_length;   // dimensione del buffer di lettura
unsigned int buf_write_length;  // dimensione del buffer di scrittura
unsigned int buf_calc_length;   // dimensione del buffer di calcolo

unsigned int i;   // variabile per ciclare sopre le triplette

ttrip *tp;        // tripletta corrente
ttrip *tmp,*tmp1; // variabile temporanea usata per swappare i buffer
ttrip *wptr;      // variabile temporanea usata per swappare i buffer

clock_t start;
clock_t elapsed;

// variabili per velocizzare il calcolo matriciale
ttrip a,b,c;
ttrip a2,b2,c2,c3;
ttrip k;

// genera la tripletta tp * M1 e la accoda in buf_write
void mmul1() { 
   k = a  -b2 + c2; wptr[0] = k; 
   k = a2 -b  + c2; wptr[1] = k; 
   k = a2 -b2 + c3; wptr[2] = k; wptr += 3;   

   /*       
   k = a  -b2 + c2; *wptr = k; ++wptr;
   k = a2 -b  + c2; *wptr = k; ++wptr;
   k = a2 -b2 + c3; *wptr = k; ++wptr;   
   */

   /*
   *wptr = a  -b2 + c2;   ++wptr;
   *wptr = a2 -b  + c2;   ++wptr;
   *wptr = a2 -b2 + c3;   ++wptr;
   buf_write_length += 3;
   */

   /*
   buf_write[buf_write_length] = a  -b2 + c2;   ++buf_write_length;
   buf_write[buf_write_length] = a2 -b  + c2;   ++buf_write_length;
   buf_write[buf_write_length] = a2 -b2 + c3;   ++buf_write_length;
   */
}

// genera la tripletta tp * M2 e la accoda in buf_write
void mmul2() {   
   k = a  + b2 + c2; wptr[0] = k;  
   k = a2 + b  + c2; wptr[1] = k;  
   k = a2 + b2 + c3; wptr[2] = k;  wptr+=3;  

   /*
   k = a  + b2 + c2; *wptr = k;  ++wptr;
   k = a2 + b  + c2; *wptr = k;  ++wptr;
   k = a2 + b2 + c3; *wptr = k;  ++wptr;  
   */

   /*
   *wptr = a  + b2 + c2;    ++wptr;
   *wptr = a2 + b  + c2;    ++wptr;
   *wptr = a2 + b2 + c3;    ++wptr;
   buf_write_length += 3;
   */

   /*
   buf_write[buf_write_length] = a  + b2 + c2;    ++buf_write_length;
   buf_write[buf_write_length] = a2 + b  + c2;    ++buf_write_length;
   buf_write[buf_write_length] = a2 + b2 + c3;    ++buf_write_length;
   */
}

// genera la tripletta tp * M3 e la accoda in buf_write
void mmul3() {   
   k = b2 -a  + c2; wptr[0] = k;  
   k = b  -a2 + c2; wptr[1] = k;  
   k = b2 -a2 + c3; wptr[2] = k;  wptr += 3;

   /*
   k = b2 -a  + c2; *wptr = k;  ++wptr;
   k = b  -a2 + c2; *wptr = k;  ++wptr;
   k = b2 -a2 + c3; *wptr = k;  ++wptr;
   */

   /*
   *wptr = b2 -a  + c2;   ++wptr;
   *wptr = b  -a2 + c2;   ++wptr;
   *wptr = b2 -a2 + c3;   ++wptr;
   buf_write_length += 3;
   */

   /*
   buf_write[buf_write_length] = b2 -a  + c2;   ++buf_write_length;
   buf_write[buf_write_length] = b  -a2 + c2;   ++buf_write_length;
   buf_write[buf_write_length] = b2 -a2 + c3;   ++buf_write_length;
   */
}

// salva la tripletta appena generata nel buffer buf_calc
void salva() {   
   tmp  = wptr - 3;
   tmp1 = &buf_calc[buf_calc_length];

   tmp1[0] = tmp[0];
   tmp1[1] = tmp[1];
   tmp1[2] = tmp[2];

   buf_calc_length += 3;   
}

// funzione di stampa della tripletta appena generata nel buffer buf_write
void stampa() {
   for(i=0;i<buf_calc_length;i+=3)
   {   
      tmp = &buf_calc[i];   
      /*
      if(sizeof(ttrip)==4) printf("%4u:%5lu,%5lu,%5lu \n", n, tmp[0], tmp[1], tmp[2]);
      else                 printf("%4u:%5u,%5u,%5u \n"   , n, tmp[0], tmp[1], tmp[2]);
      */
      if(sizeof(ttrip)==4) printf("%4u:%5lu,%5lu,%5lu \n", i, tmp[0], tmp[1], tmp[2]);
      else                 printf("%4u:%5u,%5u,%5u \n", 981+i, tmp[0], tmp[1], tmp[2]);
   }      
}

void main() {   
   // imposta colore bianco (POKE 646,1)
   *((unsigned char *)646) = 1;

   printf("\n*** TRIPLETTE PITAGORICHE ***\nby Antonino Porcino\n\n");
   
   // tiene traccia del tempo di inizio per misurare quanto impiega
   start = clock();

   buf_read  = buf1;  // inizializza buffer di lettura
   buf_write = buf2;  // inizializza buffer di scrittura
   
   // scrive tripletta iniziale 3,4,5
   buf_read[0] = 3;
   buf_read[1] = 4;
   buf_read[2] = 5;

   buf_read_length = 3;
   buf_calc_length = 0;

   while(n<=1000)
   {
      buf_write_length = 0;   // resetta il buffer di scrittura
      wptr = buf_write;       // wptr punta al buffer di scrittura
      tp = buf_read;

      for(i=0; i<buf_read_length; i+=3) {
         
         //tp = &buf_read[i];  // legge tripletta
         a = tp[0]; // legge i numeri dalla tripletta per velocizzare il calcolo
         b = tp[1]; // legge i numeri dalla tripletta per velocizzare il calcolo
         c = tp[2]; // legge i numeri dalla tripletta per velocizzare il calcolo         
         tp += 3;

         a2 = a*2; // precalcola elementi per velocizzare
         b2 = b*2; // precalcola elementi per velocizzare
         c2 = c*2; // precalcola elementi per velocizzare
         c3 = c*3; // precalcola elementi per velocizzare

         mmul1(); ++n; if(n>=981 && n<=1000) salva();
         mmul2(); ++n; if(n>=981 && n<=1000) salva();
         mmul3(); ++n; if(n>=981 && n<=1000) salva();
         if(n>=1000) break;           
      }   

      // scambia i buffer di scrittura e lettura
      buf_read_length = wptr - buf_write /*buf_write_length*/;      

      tmp = buf_read;
      buf_read = buf_write;
      buf_write = tmp;      
   }

   elapsed = (clock()-start);

   stampa();

   printf("\nelapsed: %lu ticks (%lu msecs)", elapsed, (elapsed * 1000) / CLOCKS_PER_SEC);
   getchar();
}

