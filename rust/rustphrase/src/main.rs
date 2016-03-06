extern crate rand;
extern crate getopts;

use std::io::BufReader;
use std::io::BufRead;
use std::fs::File;
use rand::Rng;
use rand::os::OsRng;
use getopts::Options;
use std::env;
use std::str::FromStr;

fn genlist(wordfile: &str) -> Vec<String> {
    let f = match File::open(wordfile) {
        Ok(file) => file,
        Err(e) => panic!("{}: \"{}\"", e, wordfile),
    };

    // size covers 'web2' dict
    let mut wordlist: Vec<String> = Vec::with_capacity(250000);
    let file = BufReader::new(f);

    for line in file.lines() {
        let word = String::from(line.unwrap());
        wordlist.push(word);
    }

    return wordlist
}
    
fn print_phrases(wordfile: &str, phraselen: u32, phrasecount: u32, separator: &str) {
    let wordlist = genlist(wordfile);

    let mut csprng = match OsRng::new() {
        Ok(g) => g,
        Err(e) => panic!("{}", e),
    };

    for _ in 0 .. phrasecount {
        for i in 1 .. phraselen + 1 {
            let randword = csprng.gen_range(0, wordlist.len());
            if i == phraselen {
                println!("{}", wordlist[randword]);
            } else {
                print!("{}{}", wordlist[randword], separator);
            }
        }
    }
}

fn print_usage(program: &str, opts: Options) {
    let brief = format!("Usage: {} [options]", program);
    print!("{}", opts.usage(&brief));
}

fn main() {
    let mut phraselen = 5;
    let mut phrasecount = 1;
    let mut separator = " ";
    let mut wordfile = String::from("/usr/share/dict/words");

    let args: Vec<String> = env::args().collect();
    let program = args[0].clone();

    let mut opts = Options::new();
    opts.optopt("l", "length", "Length of phrase(s) [default: 5]", "");
    opts.optopt("c", "count", "Number of phrase(s) [default: 1]", "");
    opts.optopt("f", "file", "Wordlist file [default: /usr/share/dict/words]", "");
    opts.optflag("d", "dashes", "Separate words with dashes [default: spaces]"); 
    opts.optflag("h", "help", "Print this dialog");
    let matches = match opts.parse(&args[1..]) {
        Ok(o) => o,
        Err(e) => panic!("{}", e),
    };
    if matches.opt_present("h") {
        print_usage(&program, opts);
        return;
    }
    if matches.opt_present("c") {
        phrasecount = FromStr::from_str(&matches.opt_str("c").unwrap()).unwrap();
    }
    if matches.opt_present("l") {
        phraselen = FromStr::from_str(&matches.opt_str("l").unwrap()).unwrap();
    }
    if matches.opt_present("f") {
        wordfile = matches.opt_str("f").unwrap();
    }
    if matches.opt_present("d") {
        separator = "-";
    }

    print_phrases(&wordfile, phraselen, phrasecount, separator);
}
