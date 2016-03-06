# Python 3 Passphrase Generator

```
$ python3 pyphrase.py --help
usage: pyphrase.py [-h] [-l LENGTH] [-c COUNT] [-f FILE] [-d]

Generate strong passphrases

optional arguments:
  -h, --help            show this help message and exit
  -l LENGTH, --length LENGTH
  -c COUNT, --count COUNT
  -f FILE, --file FILE
  -d, --dashes
```

## Language Notes
Reading lines from a file handle was made trivial.

Also made trivial was the actual word selection. Python's ```random``` library
provides a number of statistics functions, including ```sample()```. It also
provides the ```SystemRandom()``` class as a drop-in, cryptographically secure
replacement which inherents these same functions.

The ```argparse``` module was very simple to use.
