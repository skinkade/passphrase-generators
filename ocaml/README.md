# OCaml Passphrase Generator

```
$ ocamlopt ocamlphrase.ml -o ocamlphrase
$ ./ocamlphrase -help
generate strong passphrases
  -file <file>     specify wordlist file
  -length <length> length of passphrase
  -dashes          separate words with dashes
  -help            Display this list of options
  --help           Display this list of options
```

(Not sure why that second help flag shows up.)

```
$ opam install core nocrypto
$ corebuild -pkg nocrypto.unix ocamlphrase_core.native
$ ./ocamlphrase_core.native -help
Generate strong passphrases

  ocamlphrase_core.native [PHRASE LENGTH]

=== flags ===

  [-d]           Use dash separation
  [-f filename]  Specify wordlist file
  [-build-info]  print info about this build and exit
  [-version]     print the version of this build and exit
  [-help]        print this help text and exit
                 (alias: -?)
```

## Language Notes
Originally I wrote this OCaml passphrase generator using Jane Street Core. This
gave some really nice features and made the code extra concise, but the
resulting executable, being statically linked, was huge.

Later, I re-wrote it using solely the standard library. It's a bit messier, but
has no extra dependencies, a much smaller executable, and isn't much longer.
