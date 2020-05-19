/*
2100 rem === calcola le frequenze della tastiera ===
2100 dim f(49)
2110 c=256^(3)/985248
2120 for i=0 to 48
2130 f(i)=(440*2^((i-24)/12))*c
2145 print f(i)
2140 next
2150 return
*/

function hi(x) {
    return (x>>8) & 0xFF;
}

function lo(x) {
   return x & 0xFF;
}

let f = [];
let f_sid = [];
for(let i=0; i<49; i++) {
    let c = Math.pow(256,3)/985248;
    let relative_tone = i-24;
    let freq = 440 * Math.pow(2, relative_tone/12);
    f.push(freq);
    f_sid.push(Math.round(freq * c));
}

console.log("FREQTABLE_LOW:");
for(let i=0; i<49; i++) {
    console.log(`   .byte ${lo(f_sid[i])}   ; f=${Math.round(f[i]*10)/10}`);
}

console.log("\nFREQTABLE_HI:");
for(let i=0; i<49; i++) {
    console.log(`   .byte ${hi(f_sid[i])}   ; f=${Math.round(f[i]*10)/10}`);
}
