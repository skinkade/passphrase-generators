#!/usr/bin/perl

use 5.010;
use strict;
use warnings;
use Getopt::Long;
use File::Basename;
use Bytes::Random::Secure;



# From OpenBSD's arc4random_uniform()
sub rand_uniform {
    my ($upper_bound, $csprng) = @_;
    my $r;
    my $min;
 
    if ($upper_bound < 2) {
        return 0;
    }

    $min = -$upper_bound % $upper_bound;

    for (;;) {
        $r = $csprng->irand;
        if ($r >= $min) {
                last;
        }
    }

    return $r % $upper_bound;
}

sub gen_passphrase {
    my ($words_file, $phraselen) = @_;
    my $random = Bytes::Random::Secure->new( NonBlocking => 1, Bits => 128 );

    open(WORDLIST, $words_file) or die("Could not open '$words_file'\n");
    chomp(my @words = <WORDLIST>);
    close(WORDLIST);

    my $listlen = @words;
    my @passphrase;

    for (1..$phraselen) {
        my $randele = rand_uniform($listlen, $random);
        push(@passphrase, $words[$randele]);
    }

    return join(" ", @passphrase);
}



my $help    = 0;
my $userlen = 5;;
my $userwords;

my $scriptdir = dirname(__FILE__);
if (-e "$scriptdir/wordlist") {
    $userwords = "$scriptdir/wordlist";
}
elsif (-e "/usr/share/dict/words") {
    $userwords = "/usr/share/dict/words";
}

GetOptions("h|help"     => \$help,
           "l|length=i" => \$userlen,
           "f|file=s"   => \$userwords)
or exit;

if ($help) {
    say "perlphrase: Generate a random passphrase.";
    say "\t-h\t--help\t\tPrint this dialog";
    say "\t-l\t--length\tSpecify length of passphrase";
    say "\t-f\t--file\t\tSpecify custom wordlist file";
    exit;
}

if (($userlen > 3) && ($userlen < 11)) {
    say gen_passphrase($userwords, $userlen);
}
else {
    say "Passphrase of unreasonable length requested.";
    exit;
}
