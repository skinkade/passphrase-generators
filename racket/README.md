# Racket Scheme Passphrase Generator
```
$ racket racketphrase.rkt --help
Racket passphrase generator [ <option> ... ]
 where <option> is one of
  -d, --dashes : Use dashes as separator
  -f <f>, --file <f> : Line-separated wordlist file
  -l <l>, --length <l> : Length of passphrase
  --help, -h : Show this help
  -- : Do not treat any remaining argument as a switch (at this level)
 Multiple single-letter switches can be combined after one `-'; for
  example: `-h-' is the same as `-h --'
```

## Language Notes
`crypto-random-bytes` was added in Racket 6.3.

Despite the line noise and having to define `crypto-random-uniform`, etc,
it's quite concise, as can be expected of a Lisp. Much of it would seem alien
to someone unacquainted with functional languages, however.
