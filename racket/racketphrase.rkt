#lang racket
(require racket/random)
(require racket/file)
(require racket/cmdline)



(define (crypto-random)
  (integer-bytes->integer (crypto-random-bytes 4) #f))

(define (crypto-random-uniform upper-bound)
  (define lower (modulo (- (expt 2 32) upper-bound) upper-bound))
  
  (define (loop lower)
    (define r (crypto-random))
    (if (>= r lower)
        (modulo r upper-bound)
        (loop lower)))
  
  (loop lower))

(define (printphrase dec)
  (printf (list-ref wordlist (crypto-random-uniform wordcount)))
  (if (> dec 1)
      (begin
        (printf separator)
        (printphrase (- dec 1)))
      (printf "\n")))

(define separator " ")
(define wordfile "/usr/share/dict/words")
(define phraselen 5)

(define file-to-compile
  (command-line
   #:program "Racket passphrase generator"
   #:once-each
   [("-d" "--dashes") "Use dashes as separator"
                      (set! separator "-")]
   [("-f" "--file") f "Line-separated wordlist file"
                    (set! wordfile f)]
   [("-l" "--length") l "Length of passphrase"
                      (set! phraselen (string->number l))]))

(define wordlist (file->lines wordfile))
(define wordcount (length wordlist))

(printphrase phraselen)
