//
// This is the original Altair Basic 3.2 (4K) (4kbas32.bin)
// it was copied from https://github.com/jeelabs/embello/blob/master/projects/ask/emu8080/rom.h
//
const basic = require("./4kbas32");

// taken from https://github.com/maly/8080js
const cpu = require("./8080");

// console key press
const { getkey, kbhit, putchar } = require("./console");

const mem = new Uint8Array(65535).fill(0);

function mem_read(address) 
{ 
   return mem[address];    
};

function mem_write(address, value) 
{ 
   if(address < 8192) mem[address] = value; 
}

function io_read(address) {    
   let port = address & 0xFF;
   
   if(port === 0) {
      // port 0: 0=key ready
      const value = kbhit() ? 0 : 1;
      return value;
   }
   else if(port === 1) {      
      // port 1: key pressed
      const value = getkey();          
      return value; 
   }
   if(port === 255) {
      // Altair sense switches
      const value = 0x00;      
      return value;
   }   
};

/*
Data Bit	Logic Low Level	Logic High Level
7	Output device ready	 
6	Unused	Unused
5	 	Data available (a word of data is in the buffer on the I/O board)
4	 	Data overflow (a new word of data was received before the previous word was input to the accumulator)
3	 	Framing error (data word has no valid stop bit)
2	 	Parity error (received parity does not agree with selected parity)
1	 	X-mitter buffer empty (the previous data word has been X-mitted and a new data word may be outputted)
0	 Input device ready	 
*/

function io_write(address, value) {    
   const port = address & 0xFF;   
   if(port === 1) {      
      putchar(value);      
      return;
   }      
}

function loop() 
{   
   cpu.steps(100000);                 
   setTimeout(loop, 20);
}

cpu.init(mem_write, mem_read, undefined, io_write, io_read);

console.log("loading Altair Basic 3.2...");
for(let t=0;t<basic.length;t++) mem_write(t, basic[t]);

console.log("Altair 8800 started");
loop();
