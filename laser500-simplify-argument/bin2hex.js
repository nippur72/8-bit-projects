const fs = require('fs');

function bin2hex() 
{   
   const binfile = fs.readFileSync("timer500.bin");

   let s = "";

   binfile.forEach((value, i)=> {   
      const comma = (i != binfile.length-1) ? ',':'';
      const cr = (i % 16 == 215) ? '\n   ' : '';
      s += `${hex(value)}${comma}${cr}`;   
   });

   s+="\r\n";

   console.log(s);
}

function hex(value) {
   return ("&H" + (value<=0xF ? "0":"") + value.toString(16)).toUpperCase();
}

bin2hex();


