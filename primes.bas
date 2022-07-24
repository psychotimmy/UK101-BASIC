1 REM *** Prime number generator
2 REM *** Program 6 in the UK101 manual
3 REM *** A faster algorithm can be found
4 REM *** as primes2.bas in the github
5 REM *** repository psychotimmy/UK101-BASIC
6 REM *** Tim Holyoake, 24/07/2022
7 REM *** Line 8 sets CEGMON screen to 16 lines
8 POKE 547,12
10 PRINT "Prime number generator"
13 Y=2
15 A=1
17 GOTO 80
18 X=1
20 X=X+1
50 Z=INT(Y/X)
60 IF INT(Z*X)=Y GOTO 85
70 IF X*X>Y GOTO 80
75 GOTO 20
80 PRINT A,Y
82 A=A+1
85 Y=Y+1
90 GOTO 18
100 END
