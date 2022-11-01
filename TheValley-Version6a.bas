1 REM ** Pre-loader for The Valley in 8K on Compukit UK101
2 REM ** Tim Holyoake, October 2022, RetroChallenge 2022/10
3 REM ** Load The Valley game after running this file first
4 REM **
5 REM ** GET keyboard character routine
6 REM ** UK101, Original Monitor (MONUK02)
7 REM ** From Practical Electronics magazine, Sept. 1980
8 REM ** Must be loaded and run before the 8K Valley game
9 POKE527,1:REM ** Stop cursor flashing
10 FOR A=546 TO 597
20 READ B:POKE A,B:NEXT
30 DATA 169,2,32,190,252,32,198,252,208,7,10,208,245,169,32
40 DATA 208,28,74,32,200,253,152,133,252,10,10,10,56,229
50 DATA 252,133,252,138,74,32,200,253,24,152,101,252,168
60 DATA 185,207,253,160,0,41,127,145,105,96
65 REM ** Store some Valley constants in unused RAM outside
66 REM ** of normal BASIC space
70 DATA 9,7,19,10,23,18,26,50,35,0,50: REM Monster strength
80 DATA 0,3,0,12,0,14,20,0,25,30,50:   REM Monster psi
90 FORI=598TO619:READJ:POKEI,J:NEXT:   REM Store in 598 on
100 REM ** Test the input USR
110 PRINT "Press anykey to test, Press Q to quit" 
120 A$=" ":POKE 11,34:POKE 12,2:X=USR(X):IF ASC(A$)=32 THEN 120
130 PRINT A$;
140 IF A$<>"Q" THEN 120
150 REM ** Clear code from memory
160 NEW
170 END
