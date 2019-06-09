
let tpi = [3,4,5];

function mmul(m, v) {
   return [
      m[0+0]*v[0] + m[1+0]*v[1] + m[2+0]*v[2],
      m[0+3]*v[0] + m[1+3]*v[1] + m[2+3]*v[2],
      m[0+6]*v[0] + m[1+6]*v[1] + m[2+6]*v[2],
   ];
}

let m1 = [
   1, -2, 2, 
   2, -1, 2,
   2, -2, 3
];

function mmul1(v) {
   return [
      1*v[0] + -2*v[1] + 2*v[2],
      2*v[0] + -1*v[1] + 2*v[2],
      2*v[0] + -2*v[1] + 3*v[2],
   ];
}

let m2 = [
   1, 2, 2, 
   2, 1, 2,
   2, 2, 3
];

function mmul2(v) {
   return [
      1*v[0] + 2*v[1] + 2*v[2],
      2*v[0] + 1*v[1] + 2*v[2],
      2*v[0] + 2*v[1] + 3*v[2],
   ];
}

let m3 = [
   -1, 2, 2, 
   -2, 1, 2,
   -2, 2, 3
];

function mmul3(v) {
   return [
      -1*v[0] + 2*v[1] + 2*v[2],
      -2*v[0] + 1*v[1] + 2*v[2],
      -2*v[0] + 2*v[1] + 3*v[2],
   ];
}

let n = 1;
let heap_old = [ tpi ];

while(n<1000)
{
   let heap_new = [];
   for(let i=0; i<heap_old.length; i++) {
      let tp = heap_old[i];
      let t1 = mmul1(tp); n++; if(n>=1 && n<=6) console.log(t1);
      let t2 = mmul2(tp); n++; if(n>=1 && n<=6) console.log(t2);
      let t3 = mmul3(tp); n++; if(n>=1 && n<=6) console.log(t3);
      heap_new.push(t1);
      heap_new.push(t2);
      heap_new.push(t3);      
      if(n>1000) break;      
   }   
   heap_old = heap_new;
   heap_new = [];
}

