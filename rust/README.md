# Rust Passphrase Generator

```
rustphrase $ cargo build --release
...
rustphrase $ ./target/release/rustphrase --help
Usage: ./target/release/rustphrase [options]

Options:
    -l, --length        Length of phrase(s) [default: 5]
    -c, --count         Number of phrase(s) [default: 1]
    -f, --file          Wordlist file [default: /usr/share/dict/words]
    -d, --dashes        Separate words with dashes [default: spaces]
    -h, --help          Print this dialog
```

## Language Notes
I fought with a lot of '[x] does not live long enough' and type errors.

Also, be prepared to ```unwrap()``` or ```match { ... }``` a ton of ```Result<T, E>```.
There's a lot of line noise to get what you want.
