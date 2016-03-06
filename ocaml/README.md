# OCaml Passphrase Generator

```
$ opam install core nocrypto
$ corebuild -pkg nocrypto.unix ocamlphrase.native
$ ./ocamlphrase.native -help
Generate strong passphrases

  ocamlphrase.native [PHRASE LENGTH]

=== flags ===

  [-d]           Use dash separation
  [-f filename]  Specify wordlist file
  [-build-info]  print info about this build and exit
  [-version]     print the version of this build and exit
  [-help]        print this help text and exit
                 (alias: -?)
```

## Language Notes
OCaml is delightfully concise. In this example, much of the conciseness is a
result of using ```Jane Street Core``` over the standard library.
Unfortunately, this makes the resulting binary absolutely massive.

