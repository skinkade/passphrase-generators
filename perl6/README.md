# Perl 6 Passphrase Generator

```
$ perl6 perlphrase.p6 --help
Usage:
  perlphrase.p6 [--wordfile=<Str>] [--length=<Int>] [--count=<Int>] [--dashes]
```

## Language Notes
Reading lines from a file handle into an array is made trivial.

Adding arguments to the ```MAIN``` subroutine allows for basic command-line
argument parsing without having to use ```getopts``` or similar.
