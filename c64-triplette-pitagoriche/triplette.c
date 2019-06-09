#include <stdio.h>
#include <stdlib.h>
#include <time.h>

unsigned int n = 1;  // numero di triplette generate

unsigned int *buf_read;    // buffer con le triplette da esaminare
unsigned int *buf_write;   // buffer dove scrivere le triplette generate

unsigned int buf_read_length;   // dimensione del buffer di lettura
unsigned int buf_write_length;  // dimensione del buffer di scrittura

unsigned int i;      // variabile per ciclare sopre le triplette
unsigned int *tp;    // tripletta corrente
unsigned int *tmp;   // variabile temporanea usata per swappare i buffer
unsigned int *wptr;  // variabile temporanea usata per swappare i buffer

clock_t start;
clock_t elapsed;

// variabili per velocizzare il calcolo matriciale
unsigned int a,b,c;
unsigned int a2,b2,c2,c3;

// genera la tripletta tp * M1 e la accoda in buf_write
void mmul1() {    
   buf_write[buf_write_length] = a  + -b2 + c2;   ++buf_write_length;
   buf_write[buf_write_length] = a2 + -b  + c2;   ++buf_write_length;
   buf_write[buf_write_length] = a2 + -b2 + c3;   ++buf_write_length;
}

// genera la tripletta tp * M2 e la accoda in buf_write
void mmul2() {   
   buf_write[buf_write_length] = a  + b2 + c2;    ++buf_write_length;
   buf_write[buf_write_length] = a2 + b  + c2;    ++buf_write_length;
   buf_write[buf_write_length] = a2 + b2 + c3;    ++buf_write_length;
}

// genera la tripletta tp * M3 e la accoda in buf_write
void mmul3() {   
   buf_write[buf_write_length] = -a  + b2 + c2;   ++buf_write_length;
   buf_write[buf_write_length] = -a2 + b  + c2;   ++buf_write_length;
   buf_write[buf_write_length] = -a2 + b2 + c3;   ++buf_write_length;
}

// funzione di stampa della tripletta appena generata nel buffer buf_write
void stampa() {
   tmp = &buf_write[buf_write_length-3];
   printf("%4u:%5u,%5u,%5u \n", n, tmp[0], tmp[1], tmp[2]);
}

void main() {   
   // imposta colore bianco (POKE 646,1)
   *((unsigned char *)646) = 1;

   printf("\n*** TRIPLETTE PITAGORICHE ***\nby Antonino Porcino\n\n");
   
   // tiene traccia del tempo di inizio per misurare quanto impiega
   start = clock();

   buf_read  = malloc(2000 * 3 * 2);  // crea buffer di lettura per almeno 2000 triplette
   buf_write = malloc(2000 * 3 * 2);  // crea buffer di scrittura per almeno 2000 triplette
   
   // scrive tripletta iniziale 3,4,5
   buf_read[0] = 3;
   buf_read[1] = 4;
   buf_read[2] = 5;
   buf_read_length = 3;

   while(n<=1000)
   {
      buf_write_length = 0;   // resetta il buffer di scrittura

      for(i=0; i<buf_read_length; i=i+3) {

         tp = &buf_read[i];  // legge tripletta

         a = tp[0]; // legge i numeri dalla tripletta per velocizzare il calcolo
         b = tp[1]; // legge i numeri dalla tripletta per velocizzare il calcolo
         c = tp[2]; // legge i numeri dalla tripletta per velocizzare il calcolo
         
         a2 = a*2; // precalcola elementi per velocizzare
         b2 = b*2; // precalcola elementi per velocizzare
         c2 = c*2; // precalcola elementi per velocizzare
         c3 = c*3; // precalcola elementi per velocizzare

         mmul1(); ++n; if(n>=981 && n<=1000) stampa();
         mmul2(); ++n; if(n>=981 && n<=1000) stampa();
         mmul3(); ++n; if(n>=981 && n<=1000) stampa();
         if(n>=1000) break;      
      }   

      // scambia i buffer di scrittura e lettura
      tmp = buf_read;
      buf_read = buf_write;
      buf_write = tmp;      
      buf_read_length = buf_write_length;      
   }

   elapsed = (clock()-start);
   printf("\nelapsed: %lu ticks (%lu secs)", elapsed, elapsed / CLOCKS_PER_SEC);
   getchar();
}

