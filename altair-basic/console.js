const readline = require('readline');
readline.emitKeypressEvents(process.stdin);
process.stdin.setRawMode(true);

let last_key_pressed = 0;

function getkey() 
{
   const key = last_key_pressed;
   last_key_pressed = 0;
   return key;
}

function kbhit()
{
   return last_key_pressed != 0;
}

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

function putchar(value)
{
   const char = String.fromCharCode(value & 127);
   process.stdout.write(char);
}

module.exports = { getkey, kbhit, putchar};
