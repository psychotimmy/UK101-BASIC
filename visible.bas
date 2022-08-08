1 REM *** Fill the visible screen with
2 REM *** characters A-P then wait forever
3 REM *** UK101 display RAM is 53248-54271
4 REM *** Visible display RAM on standard
5 REM *** screen (original monitor) is
6 REM *** 16 rows x 48 columns starting at
7 REM *** 53261 and ending at 54268.
8 REM *** Tim Holyoake, 08/08/2022.
9 REM ***
10 TL=53261:RW=16:CV=48
20 FOR I=0 TO RW-1
30 FOR J=0 TO CV-1
40 POKE TL+J+I*64,65+I
50 NEXT J
60 NEXT I
70 GOTO 70
