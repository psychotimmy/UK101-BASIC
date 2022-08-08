10 REM ********************
20 REM * 100 door problem *
30 REM *  Compukit UK101  *
40 REM *                  *
50 REM *   Tim Holyoake   *
60 REM * 8th August 2022  *
70 REM ********************
100 REM *** D = Display position of 1st door
110 REM *** Use four lines of doors one line apart
120 D=53523
130 FOR I=0 TO 3
140 FOR J=0 TO 24
150 POKE D+J+I*128,232
160 NEXT J
170 NEXT I
180 REM *** Invert status (open/closed) of 100 doors
190 REM *** 1st run check every door, 2nd every 2 etc.
200 FOR M=1 TO 100
210 FOR K=M TO 100 STEP M
220 R=INT((K-1)/25)
230 C=K-1-R*25
240 T=D+C+R*128
250 IF PEEK(T)=128 THEN POKE T,232:GOTO 270
260 POKE T,128
270 NEXT K
280 NEXT M
300 DIM A(100):Z=0
310 FOR I=0 TO 3
320 FOR J=0 TO 24
330 X=PEEK(D+J+I*128):IF X=128 THEN Z=Z+1:A(Z)=I*25+J+1
340 NEXT J
350 NEXT I
360 PRINT "Open doors are:"
370 FOR I=1TOZ:PRINT A(I);:NEXT I
