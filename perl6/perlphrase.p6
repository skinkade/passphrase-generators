use v6;
use strict;
use experimental :pack;



sub getentropy (Int $entlen) {
    my $fh = open("/dev/urandom", :bin);
    my $bytes = $fh.read($entlen);
    $fh.close;
    return $bytes;
}

sub rand_uint32 {
    return getentropy(4).unpack("L");
}

sub rand_uniform (Int $upper_bound) {
    my ($r, $min);
    
    if ($upper_bound < 2) {
        return 0;
    }

    $min = -$upper_bound % $upper_bound;

    loop (;;) {
        $r = rand_uint32();
        if ($r >= $min) {
                last;
        }
    }

    return $r % $upper_bound;
}

sub printphrase (Str $wordfile, Int $phraselen, Int $phrasecount, Str $separator) {
    my $wordlist = open($wordfile, :r);
    my @words = lines $wordlist;
    $wordlist.close;

    my $listlen = @words.elems;

    for (1..$phrasecount) {
        my @passphrase;
        for (1..$phraselen) {
            my $rand_ele = rand_uniform($listlen);
            @passphrase.push(@words[$rand_ele]);
        }
        say @passphrase.join($separator);
    }
}

sub MAIN ( :file($file) = '/usr/share/dict/words', Int :$length = 5,
           Int :$count = 1, Bool :$dashes = False ) {

            my $separator;
            if ($dashes) {
                $separator = "-";
            } else {
                $separator = " ";
            }

            printphrase($file, $length, $count, $separator);
}
