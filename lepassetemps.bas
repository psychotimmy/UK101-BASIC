1 REM  LE PASSE-TEMPS  A.Knight  December,79
10 POKE15,72:DIMS(44),T(11)
20 AA=531:REM AA=533 FOR CEGMON
30 O=54220:O=O-(PEEK(O)=32):GOTO1100
40 L=O-882:Q=57088:Q1=57100:MM=0
50 E=0:F=0:G=0:FORA=1TO42:S(A)=0:NEXT
60 PRINTTAB(16)"LE PASSE-TEMPS"TAB(64):PRINT
70 PRINT:PRINT:PRINTTAB(7)"SCORES":PRINT:PRINT
80 PRINT"YOU"TAB(9)S1:PRINT:PRINT"ME"TAB(9)S2
90 PRINT:PRINT"DRAWN"TAB(9)S3:PRINT:PRINT:PRINT
100 RESTORE:DATA136,143,209,208
110 FORT=1TO13:IFT/2=INT(T/2)THENRESTORE
120 READA,B:FORC=1TO28STEP4:IFT=1THEN150
130 POKEL,143:POKEL+29,136
140 POKEL+C,A:POKEL+C+3,B
150 NEXTC:L=L+64:NEXTT
160 N=36:FORC=1TO7:N(C)=N:N=N+1:NEXT
170 R=O-884:C=4
180 S=S1+S2+S3:IFS/2><INT(S/2)THEN495
200 M$="MY MOVE":GOSUB950
205 V=0:X=0:Y=0:Z=0
210 FORJ=1TO7:C=C+1:IFC>7THENC=1
220 P=R+C*4:IFN(C)>0THENGOSUB700
230 IFFTHEN450
240 NEXT:H=0
250 IFXTHENC=X:GOTO450
260 IFYTHENC=Y:GOTO330
270 IFZTHENC=Z:GOTO330
300 C=INT(RND(1)*7+1):IFN(C)<1THEN300
310 IFC><4THENH=H+1:IFH<5THEN300
320 IFC<3ORC>5THENH=H+1:IFH<10THEN300
330 V=V+1:IFN(C)<8THENF=0:GOTO450
340 IFV<13THEN400
350 IFV/3><INT(V/3)THEN360
355 M$="NOW WHAT DO I DO?":GOSUB950
356 FORI=0TO1200:NEXT:GOSUB950
360 IFV<21THEN400
370 FORA=1TO500
380 POKEO-64-INT(RND(1)*940),INT(RND(1)*256)
390 NEXT:E=1:GOTO640
400 N(C)=N(C)-7:Z=0:GOSUB700:N(C)=N(C)+7
410 IFFTHENF=0:IFV<11THEN300
420 IFXTHENX=0:GOTO300
450 X=R+63+C*4+128*(N(C)-C)/7
470 FORB=1TO2:POKEX+B,154:POKEX+B+64,155:NEXT
480 IFFTHENM$="I WIN!":S2=S2+1:GOTO1210
490 S(N(C))=5:GOSUB960:IFMM=42THEN1210
495 M$="YOUR MOVE":GOSUB950
500 P=R+C*4:POKEP,31:POKEP+1,31
510 C1=(PEEK(Q1)=250)-(PEEK(Q1)=252)
520 IFC1THENC=C+C1:C=C+(C>7)-(C<1):GOTO550
530 POKE530,128:POKEQ,253:IFPEEK(Q)=239THEN600
540 POKE530,0:GOTO510
550 POKEP,32:POKEP+1,32:FORA=0TO100:NEXT:GOTO500
600 L=(N(C)-C)/7:IFL<0THEN500
610 X=P+63+L*128
620 FORA=1TO2:POKEX+A,193:POKEX+A+64,191:NEXTA
630 S(N(C))=1:E=0:GOSUB700
640 IFETHENM$="YOU WIN!":S1=S1+1:GOTO1210
650 GOSUB960:IFMM=42THEN1210
660 GOTO200
700 P=R+C*4:POKEP,31:POKEP+1,31
705 FORA=0TO11:T(A)=0:NEXTA
710 I=0:M=N(C)
720 FORU=MTOM+21STEP7:IFU>42THEN740
730 T(I)=T(I)+S(U)
740 NEXTU:I=I+1
750 FORA=C-3TOC+3:IFA<1THENA=1
760 IFA>4ORA>CTHEN800
770 FORB=ATOA+3:T(I)=T(I)+S(M-C+B):NEXTB:I=I+1
780 N=M-(C-A)*8:IFN<1ORN>18THEN800
790 FORD=0TO3:T(I)=T(I)+S(N):N=N+8:NEXTD:I=I+1
800 IFA>7THEN840
810 IFA<4ORA<CTHEN840
820 N=M+(C-A)*6:IFN<4ORN>21THEN840
830 FORD=0TO3:T(I)=T(I)+S(N):N=N+6:NEXTD:I=I+1
840 NEXTA
850 FORH=0TOI:D=T(H):IFD=4THENE=1
860 IFD=15THENF=C
870 IFD=10THENZ=C
880 IFD=3THENX=C
890 IFHANDD=2THENY=C
900 NEXTH:POKEP,32:POKEP+1,32:RETURN
950 PRINTTAB(23-LEN(M$)/2)M$TAB(45)CHR$(13);:POKEO,32:M$="":RETURN
960 N(C)=N(C)-7:MM=MM+1:S3=S3-(MM=42)
970 M$="IT'S A DRAW.":RETURN
1100 PRINT:PRINT:PRINT:PRINT:PRINTTAB(15)"LE PASSE-TEMPS":PRINT:PRINT
1110 PRINT"1) The object of this game is to get FOUR
1120 PRINT"   IN A LINE.
1130 PRINT"2) The board is a 6 by 7 matrix and a line
1140 PRINT"   may be horizontal, vertical or diagonal.
1150 PRINT"3) Columns are filled from the base up.
1160 PRINT"4) In play, only three keys are used:":PRINT
1170 PRINT"   a) Shift left moves the pointer left.
1180 PRINT"   b) Shift right..........
1190 PRINT"   c) The space-bar drops your man to the
1200 PRINTTAB(6)"foot of the selected column.":PRINT
1210 M$=M$+" HIT 'C' TO CONTINUE.":GOSUB950
1230 POKE15,72:POKE11,0:POKE12,253:Q=USR(Q)
1240 IFPEEK(AA)=67THEN40
1250 END
