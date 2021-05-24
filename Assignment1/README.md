The code in assignment1.js is the javascript code for the solution of the first assignment of the project.

It takes a string input and then finds a number to be appended (dubbed nonce here) at the end of the string which makes the hash (through sha256 algorithm)
less than the target which is: 0x00000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF and also finds the time it takes the program to calculate this number.

Following is an example of the same:

![image](https://user-images.githubusercontent.com/56204252/119348513-984c2c80-bcba-11eb-8835-fd2b05a521f0.png)

Here we take "Hello" as the string input, the program runs and determines the value of nonce to be 1853988. 
Hence the data hashed here is the string "Hello1853988". It's hash comes out to be:
  
                                      00000460F34348E24E0724834F9454D8290BDFDCB286A52D23BA9E37C90D3F78

which satisfies the given condition.
