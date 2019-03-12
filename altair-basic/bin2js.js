const fs = require("fs");
const commandLineArgs = require('command-line-args')

const options = parseOptions([
   { name: 'input',      alias: 'i', type: String, defaultOption: true },
   { name: 'output',     alias: 'o', type: String },
   { name: 'varname',    alias: 'n', type: String },
]);

if(options.input === undefined || options.output === undefined || options.varname === undefined) 
{
   console.log("usage: bin2js -i inputfile -o javascriptfile -n varname");   
   process.exit(-1);
}

const fileName = options.input;
const outName = options.output;
const varName = options.varname;

const bytes = fs.readFileSync(fileName);

const javascript = bitmap2javascript(bytes, varName, true);
fs.writeFileSync(outName, javascript);
console.log(`'${outName}' generated from '${fileName}'`);

function parseOptions(optionDefinitions) {
   try {       
      return commandLineArgs(optionDefinitions);
   } catch(ex) {
      console.log(ex.message);
      process.exit(-1);
   }
}

function bitmap2javascript(bytes, varname, exportVarname) 
{   
   let s = "// file generated automatically by 'bin2js'. Do not edit\r\n\r\n";

   s += `const ${varname} = new Uint8Array([\n   `;

   bytes.forEach((value, i)=> {   
      const comma = (i != bytes.length-1) ? ',':'';
      const cr = (i % 16 == 15) ? '\n   ' : '';
      s += `${hex(value)}${comma}${cr}`;   
   });

   s+="\r\n]);\r\n";

   if(exportVarname !== undefined) {
      s += `\r\nmodule.exports = ${varname};\r\n`;
   }

   return s;
}

function hex(value) {
   return "0x" + (value<=0xF ? "0":"") + value.toString(16);
}
