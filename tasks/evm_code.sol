PUSH1 0x30 // [30]
PUSH1 0x60 // [60,40]
PUSH1 0x50 // [50,80,40]
DUP1       // [50,50,80,40]
DUP1       // [50,50,50,80,40]


PUSH1 0x30 // [30]
PUSH1 0x60 // [60,40]
ADD        // [90]
PUSH1 0x50 // [50,90]
LT         // [1]
DUP1       // [1,1]
POP        // [1]
PUSH2 0x33 // [33,1]
DUP2       // [1,33,1]


PUSH1 0x10 // [30]
PUSH1 0x5  // [5,10]
ADD        // [15]
DUP1       // [15,15]


PUSH1 0x30    // [30]
PUSH1 0x50   // [50,30]
PUSH2 0x30   // [30,50,30]
POP          //[50,30]
DUP1         // [50,50,30]


PUSH1 0x30  // [30]
PUSH1 0x50  // [50,30]
DUP1        //[50,50,30]
DUP2        //[50,50,50,30]
ADD         //[a0,50,30]