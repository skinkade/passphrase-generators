use v6;
use strict;
use Crypt::Random;



sub printphrase (Str $wordfile, Int $phraselen, Int $phrasecount, Str $separator) {
    my @words = $wordfile.IO.words;
    my $listlen = @words.elems;

    for (1..$phrasecount) {
        my @passphrase;
        for (1..$phraselen) {
            my $rand_ele = crypt_random_uniform($listlen);
            @passphrase.push(@words[$rand_ele]);
        }
        say @passphrase.join($separator);
    }
}

subset PosInt of Int where * > 0;
sub MAIN ( Str :$wordfile = '/usr/share/dict/words', PosInt :$length = 5,
           PosInt :$count = 1, Bool :$dashes = False ) {

            my $separator;
            if ($dashes) {
                $separator = "-";
            } else {
                $separator = " ";
            }

            printphrase($wordfile, $length, $count, $separator);
}
