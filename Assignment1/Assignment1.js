const prompt = require('prompt-sync')();
const string = prompt('Enter string: ');
// The input is taken in the console itself.
let nonce = 0;
data = string + nonce;
const crypto = require('crypto');
let hash = crypto
    .createHash('sha256')
    .update(data)
    .digest('hex');
console.time('Execution Time');
while(hash >= '00000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'){
    nonce = nonce+1;
    data = string + nonce;
    hash = crypto
        .createHash('sha256')
        .update(data)
        .digest('hex');
}
//The while loop computes the value of the required appended number (dubbed here as nonce).
console.timeEnd('Execution Time');
console.log(nonce);
//Displaying the required outputs.
