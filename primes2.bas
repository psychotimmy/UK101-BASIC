100 REM ************************************
110 REM *                                  *
120 REM * Find primes up to input limit    *
125 REM * 255 array size ok for 2.7m-ish   *
130 REM *                                  *
140 REM * Tim Holyoake, 10th February 2021 *
150 REM *                                  *
160 REM * After Trevor Lusty's column in   *
170 REM * Computing Today, March 1980.     *
180 REM *                                  *
190 REM ************************************
195 REM *** Set CEGMON to 16 lines
196 POKE 547,12
200 PRINT "Enter prime number limit (greater than 18) ";
210 INPUT L
220 IF L < 19 GOTO 500
239 REM Array for storing primes found that are >= 3
240 DIM P(255) : P(1) = 17
259 REM *** Easy primes - print these
260 PRINT ". 2 3 . 5 . 7 ... 11 . 13 ... 17";
319 REM N keeps track of how much space is used in array P
320 N = 1 : X = 19
327 REM *** First few primes are often divisors - sieve
328 REM *** then here - ugly code but faster than using
329 REM *** SQR function and FOR loop if not needed
330 IF X = 3*INT(X/3) THEN PRINT ".."; : GOTO 480
335 IF X = 5*INT(X/5) THEN PRINT ".."; : GOTO 480
340 IF X = 7*INT(X/7) THEN PRINT ".."; : GOTO 480
345 IF X = 11*INT(X/11) THEN PRINT ".."; : GOTO 480
350 IF X = 13*INT(X/13) THEN PRINT ".."; : GOTO 480
369 REM *** No divisor found in first few primes, so sieve
370 SR = SQR(X)
380 FOR J = 1 TO N
390 W = P(J)
399 REM *** No need to sieve past the square root of X
400 IF W > SR GOTO 430
409 REM *** Divisor found, so skip to next odd number
410 IF X = W*INT(X/W) THEN PRINT ".."; : GOTO 480
420 NEXT J
429 REM Found a new prime, add it to array P, increment count N
430 N = N+1
438 REM *** Can store 1st 255 primes found: good for X < 2.7million-ish
439 REM *** Only add a new prime to array if space for it
440 IF N > 255 GOTO 460
450 P(N) = X
459 REM *** Print the new prime found
460 PRINT ".";X;
479 REM *** Set X to test next odd number
480 X = X+2
489 REM *** Test all numbers up to and including limit
490 IF X <= L GOTO 330
500 END
