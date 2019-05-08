#!/usr/bin/env node

const fs = require('fs');

// setup a virtual Z80 cpu
const Z80 = require("./Z80");
const memory = new Uint8Array(65536);
const mem_read = (address) => memory[address]; 
const mem_write = (address, value) => memory[address] = value; 

/*
let debugRead = false;
let mem_read = function(address) {   
   if(debugRead) 
   {
      if(address >= compressed.start && address <= compressed.end)
      {
         console.log(`R ${hex(address,4)}: ${hex(memory[address])}`);
      }
   }
   return memory[address];
}

let debugWrite = false;
let mem_write = function(address, value) {
   memory[address] = value;
   if(debugWrite) 
   {
      if(address >= original.start && address <= original.end)
      {
         console.log(`W ${hex(address,4)}: ${hex(value)}`);
      }
   }
}
*/

function io_read(port) {
   return 0;
};

function io_write(port, value) { 

};

const cpu = new Z80({ mem_read, mem_write, io_read, io_write });

// 93448.BIN is the charset ROM
load("D000.BIN", 0xD000);
load("D800.BIN", 0xD800);
load("E000.BIN", 0xE000);
load("E400.BIN", 0xE400);
load("E800.BIN", 0xE800);
load("EC00.BIN", 0xEC00);
load("F000_V1.BIN", 0xF000);
load("F800_V1.BIN", 0xF800);
load([ 0xC3, 0x00, 0xE0 ], 0x0000); // JP E000

console.log("ChildZ is ready");

let tstates = 0;
for(let t=0;;t++) {
   const pc = cpu.getState().pc;
   console.log(pc);
   tstates += cpu.run_instruction();
   if(t>50000000) {
      console.log("ending....");
      failed = true;
      break;
   }
}

// ********************** UTILITY FUNCTIONS **********************

function load(filename, start) {   
   const bytes = typeof filename == 'string' ? fs.readFileSync(filename) : filename;
   
   const end = start + bytes.length - 1;

   for(let i=0,t=start;t<=end;i++,t++) {
      mem_write(t, bytes[i]);
   }

   if(typeof filename == 'string') {
      console.log(`file "${filename}" (${bytes.length} bytes) loaded at ${hex(start,4)}-${hex(end,4)}`);
   }

   return bytes;
}

function lo(word) {
   return word & 0xff;   
}

function hi(word) {
   return (word >> 8) & 0xff;
}

function hex(value, size) {
   if(size === undefined) size = 2;
   let s = "0000" + value.toString(16);
   return s.substr(s.length - size);
}

function parseOptions() {
   try { 
      const options = commandLineArgs(optionDefinitions); 
      return { 
         ...options, 
         original: fileNameAndAddress(options.original),
         compressed: fileNameAndAddress(options.compressed)
      }      
   } catch(ex) {
      console.log(ex.message);
      process.exit(-1);
   }
}

function fileNameAndAddress(argv)
{   
   if(argv === undefined || argv.length != 2) return undefined;

   const [fileName, address] = argv;

   if(!fs.existsSync(fileName)) {
      console.log(`${fileName} not found`);
      process.exit(-1);
   }

   const decimalAddress = parseInt(address, 16);

   return { name: fileName, start: decimalAddress };
}
