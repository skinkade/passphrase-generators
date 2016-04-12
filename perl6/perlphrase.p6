use v6;
use strict;
use Crypt::Random;



subset PosInt of Int where * > 0;
sub MAIN ( Str :$wordfile = '/usr/share/dict/words', PosInt :$length = 5,
           PosInt :$count = 1, Bool :$dashes = False )
{
    my $separator;
    if ($dashes) {
        $separator = "-";
    } else {
        $separator = " ";
    }

    my @words = $wordfile.IO.words;
    my $listlen = @words.elems;

    for ^$count {
        my @passphrase;
        for ^$length {
            my $rand_ele = crypt_random_uniform($listlen);
            @passphrase.push(@words[$rand_ele]);
        }
        say @passphrase.join($separator);
    }
}
