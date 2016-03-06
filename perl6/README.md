# Perl 6 Passphrase Generator

```
$ perl6 perlphrase.p6 --help
Usage:
  perlphrase.p6 [--file=<Any>] [--length=<Int>] [--count=<Int>] [--dashes]
```

## Language Notes
Perl6 does not yet have a CSPRNG at the time of writing, ergo we grab 32bit
values from ```/dev/urandom```.

Reading lines from a file handle into an array is made trivial.

Adding arguments to the ```MAIN``` subroutine allows for basic command-line
argument parsing without having to use ```getopts``` or similar.
