#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <getopt.h>

#include "rand_uint32.h"
#define MAX_LINES 250000   // cover size of 'web2' dict
#define MIN_CHAR 3
#define MAX_CHAR 8   // TODO: make these options


void
print_passphrase(char *file, int phraselen, int separator, int count)
{
    int wordfile = open(file, O_RDONLY);
    struct stat wordfile_stats;

    fstat(wordfile, &wordfile_stats);
    char *filechars = malloc(wordfile_stats.st_size);

    if(read(wordfile, filechars, wordfile_stats.st_size)
       != wordfile_stats.st_size) {
        printf("Error reading: '%s'\n", file);
        exit(EXIT_FAILURE);
    }
    close(wordfile);
   
 
    char* p;
    int endline = 0;
    int newlines = MAX_LINES;
    char **wordlist = malloc(sizeof(char*) * newlines);
 
    p = strtok(filechars, "\n");
    while (p != NULL) {
        if (MIN_CHAR <= strlen(p) && strlen(p) <= MAX_CHAR) {
            wordlist[endline] = malloc(strlen(p) + sizeof(char));
            if (wordlist[endline])
                strncpy(wordlist[endline], p, strlen(p) + sizeof(char));
            endline++;
        }
        if (endline >= newlines - 1) {   // prevent overflow
            newlines *= 2;
            wordlist = realloc(wordlist, sizeof(char*) * newlines);
        }
        p = strtok(NULL, "\n");
    }
    free(filechars);


    uint32_t rand_ele;

    for (int i = 0; i < count; i++) {
        for (int j = 0; j < phraselen; j++) {
            rand_ele = rand_uint32_uniform(endline + 1);
            if (j == phraselen - 1)
                printf("%s%c", wordlist[rand_ele], '\n');
            else
                printf("%s%c", wordlist[rand_ele], separator);
        }
    }

    for (int i = 0; i < endline; i++)
        free(wordlist[i]);
    free(wordlist);
}

void
print_help(char* s)
{
    printf("%s - Generate a strong passphrase\n\n", s);
    printf("%s\t[length]\tSpecify length of phrase\n", s);
    printf("%s\t-w [wordfile]\tSpecify a word file\n", s);
    printf("%s\t-c [count]\tGenerate multiple phrases\n", s);
    printf("%s\t-d\t\tSeparate words with dashes\n", s);
    printf("%s\t-h\t\tPrint this help\n", s);
}
    
int
main(int argc, char *argv[])
{
    int phraselen = 5;
    char* wordfile = "/usr/share/dict/words";
    int separator = ' ';
    int count = 1;

    int c;
    while ((c = getopt(argc, argv, "hdw:c:")) != -1)
    {
        switch(c)
        {
            case 'h':
                print_help(argv[0]); exit(EXIT_SUCCESS);
            case 'd':
                separator = '-'; break;
            case 'w':
                wordfile = optarg; break;
            case 'c':
                count = strtol(optarg, NULL, 10);
        }
    }

    if (optind != argc) {
        phraselen = strtol(argv[optind], NULL, 10);
        if (phraselen < 2) {
            printf("Invalid length\n\n");
            print_help(argv[0]);
            exit(EXIT_FAILURE);
        }
    }

    if (count < 1) {
        printf("What are you even trying to do?\n");
        exit(EXIT_FAILURE);
    }

    print_passphrase(wordfile, phraselen, separator, count);

    return 0;
}
