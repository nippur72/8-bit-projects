//
// This is the original Altair Basic 3.2 (4K) (4kbas32.bin)
// it was copied from https://github.com/jeelabs/embello/blob/master/projects/ask/emu8080/rom.h
//

const basic = require("./4kbas32");

const readline = require('readline');
readline.emitKeypressEvents(process.stdin);
process.stdin.setRawMode(true);

let last_key_pressed = 0;

process.stdin.on('keypress', (str, key) => {
   if (key.ctrl && key.name === 'c') {
     process.exit();
   } 
   if (key.ctrl && key.name === 'p') {
      debug();
   } 
   else {
      /*
      sequence: 'k',
      name: 'k',
      ctrl: false,
      meta: false,
      shift: false }
      */
      last_key_pressed = key.sequence.charCodeAt(0);
            
      // echo
      // const char = String.fromCharCode(last_key_pressed);
      // process.stdout.write(char);      
   }
 });

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
      const value = last_key_pressed === 0 ? 1 : 0;
      //console.log(`io_read ${port} = ${value}`);
      return value;
   }
   else if(port === 1) {      
      const value = last_key_pressed;
      last_key_pressed = 0;
      //console.log(`io_read ${port} = ${value}`);
      return value; 
   }
   if(port === 255) {
      /* Altair sense switches */
      const value = 0x00;
      //console.log(`io_read ${port} = ${value}`);
      return value;
   }
   else {
      //console.log(`io_read from unknown port ${port & 0xFF}`);
      return 0; 
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
      const char = String.fromCharCode(value & 127);
      process.stdout.write(char);
      return;
   }   
   
   // console.log(`io_write to unknown port ${port} value ${value}`);
}

function loop() 
{
   for(let t=0; t<20000;)
   {
      t += cpu.run_instruction();        
   }      
   cpu.interrupt(false);
   setTimeout(loop, 200);
}

function debug() {
   console.log(cpu.getState());
}

const Z80 = require("./Z80");

let cpu = new Z80({mem_read, mem_write, io_read, io_write});

console.log("loading Altair Basic 3.2...");
for(let t=0;t<basic.length;t++) mem_write(t, basic[t]);

console.log("Altair 8800 started");
loop();

