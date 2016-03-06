# C Passphrase Generator

```
$ gcc -std=c99 passphrase.c rand_uint32.c -o passphrase
$ ./passphrase -h
./passphrase - Generate a strong passphrase

./passphrase    [length]    Specify length of phrase
./passphrase    -w [wordfile]   Specify a word file
./passphrase    -c [count]  Generate multiple phrases
./passphrase    -d      Separate words with dashes
./passphrase    -h      Print this help
```

## Language Notes
This is the implementation in which I am least confident, due to lack of safety
as in the other implementations so far. I compiled with ```-Wall -Wextra``` and
used ```Valgrind``` to sort out memory issues.

On Linux, it tries to call ```getrandom()```, reading from ```/dev/urandom```
as a fallback. On OS X / *BSD, it should use ```arc4random()```.
