#!/usr/bin/env python3

import getopt, sys
import argparse
from random import SystemRandom



def printphrase(wordfile, phraselen, phrasecount, separator):
    try:
        f = open(wordfile, 'r')
    except IOError as err:
        print(err)
        sys.exit(2)

    wordlist = f.read().splitlines()
    for i in range(0, phrasecount):
        print(separator.join(SystemRandom().sample(wordlist, phraselen)))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate strong passphrases')
    parser.add_argument('-l', '--length', type=int, default=5)
    parser.add_argument('-c', '--count', type=int, default=1)
    parser.add_argument('-f', '--file', type=str, default='/usr/share/dict/words')
    parser.add_argument('-d', '--dashes', action='store_true')
    
    args = parser.parse_args()

    if args.dashes:
        separator = '-'
    else:
        separator = ' '

    printphrase(args.file, args.length, args.count, separator)

