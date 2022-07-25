1 REM *** Acey-Ducey game
2 REM *** Program 7 from UK101 Manual
3 REM *** Recovered & enhanced by Tim Holyoake
4 REM *** 25th July 2022
5 REM
10 PRINT "Acey-Ducey"
12 PRINT "You will get 25 hands"
13 H=1:T=100
15 PRINT
17 REM *** Main game loop
19 PRINT "You have $";T
20 X=INT(7*RND(67)+6)
21 IF X>12 GOTO 20
30 Y=INT(X*RND(23)+1)
31 IF Y>=X GOTO 30
32 IF Y=1 THEN Y=2
40 A=X
50 GOSUB 500
60 A=Y
70 GOSUB 500
100 PRINT:PRINT"Your bet";:INPUT B
110 IF B=T GOTO 120
112 PRINT"You don't have that much"
