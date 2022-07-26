100 REM **************************************************
110 REM *                                                *
120 REM * John Conway's Life Game for the Compukit UK101 *
130 REM * Requires CEGMON and 2K VDU RAM (64x32 display) *
140 REM *                                                *
150 REM *       Tim Holyoake, 13th August 2022.          *
160 REM *                                                *
170 REM **************************************************
180 REM
190 REM *** Constants
200 REM Top of visible screen, border char, cell char
210 TA=53248:B=187:L=42
220 REM Maximum VDU width, empty cell char
230 SW=64:SP=32
240 REM Game area - columns, rows
250 W=62:D=24
260 REM *** Variables
270 REM Generation number, living cells, randomizer, repeats
280 Z=0:E=0:EL=0:R=12:RP=1
290 REM New generation array
300 DIM G(W,D)
310 REM *** Clear screen and set up scroll area
320 PRINT CHR$(26)
330 GOSUB 5000
500 REM *** Start a new game
510 GOSUB 1000
520 GOSUB 2000
530 GOSUB 3000
540 GOSUB 4000
550 IF E<> 0 AND RP<12 THEN GOTO 530
560 END
997 REM
998 REM *** SUBROUTINES ***
999 REM
1000 REM *** DRAW BORDER
1010 FOR I=0 TO W+1:POKE TA+I,B:NEXT I
1020 FOR I=1 TO D+1:POKE TA+W+1+I*SW,B:NEXT I
1030 FOR I=W TO 0 STEP -1:POKE TA+(D+1)*SW+I,B:NEXT I
1040 FOR I=D+1 TO 1 STEP -1:POKE TA+I*SW,B:NEXT I
1050 GOSUB 6000
1060 RETURN
2000 REM *** INITIALISE LIFE CELLS
2010 FOR I=1 TO W
2020 FOR J=1 TO D
2030 G(I,J)=SP:IF INT(RND(1)*R)=7 THEN G(I,J)=L:E=E+1
2040 NEXT J
2050 NEXT I
2060 RETURN
3000 REM *** PRINT CURRENT GENERATION TO SCREEN
3010 Z=Z+1
3020 FOR I=1 TO W
3030 FOR J=1 TO D
3040 POKE TA+J*SW+I,G(I,J)
3050 NEXT J
3060 NEXT I
3070 GOSUB 6000
3080 RETURN
4000 REM *** EVALUATE NEXT GENERATION
4010 EL=E:E=0
4020 FOR I=1 TO W
4030 FOR J=1 TO D
4040 TC=0:NC=0
4050 FOR K=-1 TO 1
4060 FOR M=-1 TO 1
4070 IF PEEK(TA+(J+M)*SW+I+K)=L THEN NC=NC+1
4080 NEXT M
4090 NEXT K
4100 IF PEEK(TA+J*SW+I)=L THEN NC=NC-1:TC=1
4110 G(I,J)=SP:IF((NC=3)OR(NC=2 AND TC=1))THEN G(I,J)=L:E=E+1
4120 NEXT J
4130 NEXT I
4140 IF E=EL THEN RP=RP+1:RETURN
4150 RP=1
4160 RETURN
5000 REM *** SET UP SCROLLING PRINT WINDOW
5010 DIM WI(1,5)
5020 DATA 63,128,214,192,215
5030 FOR X=0 TO 4:READ WI(0,X):NEXT X
5040 FOR X=0 TO 4
5050 POKE 546+X,WI(0,X)
5060 NEXT X
5070 PRINT CHR$(12)
5080 RETURN
6000 REM *** STATUS UPDATE
6010 PRINT CHR$(30):PRINT "Generation";Z;
6020 PRINT "has";E;"living cells"
6030 IF RP<2 THEN RETURN
6040 PRINT "Stable/repeating pattern? ";
6050 PRINT RP;"generations with same cell count"
6060 RETURN
