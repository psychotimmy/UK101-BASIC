79 REM ** UK101 specific code
80 TL=53248 :REM Top left corner screen memory location
81 GOSUB 56000: REM Non-halting get initialisation
99 REM ** Define major variables
100 DIM D(3),G(73),P(8),N(8),A(4),T(2)
110 DIM M$(18),MS(18),N1(18)
120 VG$="":GC$="":F$="":DL$=""
130 TS=0:TN=0:TM=4:CF=0: REM ** TM affects delay in 36000
140 D$=CHR$(12):FOR I=1TO21:D$=D$+CHR$(10):NEXT I
150 D1$=LEFT$(D$,17)
155 D6$=LEFT$(D$,16):D0$=LEFT$(D$,20)
160 SP$="                                       "
170 R$="":FOR I=1TO30:R$=R$+CHR$(11):NEXT I
180 R1$=LEFT$(R$,21)
190 R8$="":FORI=1TO8:R8$=R8$+CHR$(11):NEXT I
299 REM ** Skip scene data
300 FOR I=1 TO 32
310 READ C$
320 NEXT I
329 REM ** Load monster data
330 FOR I=0 TO 18
340 READ M$(I),MS(I),N1(I)
350 NEXT I
999 REM ** Character choice and load
1000 PRINTCHR$(26);CHR$(10);"Load a character from tape (Y/N) ?"
1010 VG$="YN":GOSUB 1500:VG$="0123456789E":REM ** Uniget
1015 IF GC$="Y" THEN 1060:REM ** Don't allow name change!
1020 PRINT CHR$(10);:INPUT "Character's name   ";J$
1030 IF J$="" THEN 1020
1040 IF LEN(J$)>15 THEN PRINT CHR$(10);"Too long":GOTO 1020
1050 IF GC$="N" THEN 1240
1060 PRINT CHR$(26);"Place data tape in deck"
1070 PRINT CHR$(10);"Is it rewound?":PRINT
1080 GOSUB 1600: REM ** Anykey
1090 POKE11,0:POKE12,253:X=USR(X):LOAD:REM ** Set ACIA for input
1095 INPUT J$
1100 INPUT P$
1110 INPUT TS
1120 INPUT EX
1130 INPUT TN
1140 INPUT CS
1150 INPUT PS
1160 INPUT T(0)
1170 INPUT T(1)
1180 INPUT T(2)
1190 INPUT C1
1200 INPUT P1
1210 POKE 515,0:REM ** Close ACIA for input
1215 DF=150:DL$="D":GOSUB 36000:REM ** Delay
1220 C=150
1225 GOSUB 56000: REM Non-halting get re-initialisation
1230 GOTO 1400
1240 PRINTCHR$(26);CHR$(10);"Character types ... choose carefully"
1250 PRINT
1260 PRINT "Wizard     (1)"
1270 PRINT "Thinker    (2)"
1280 PRINT "Barbarian  (3)","Key 1-5"
1290 PRINT "Warrior    (4)"
1300 PRINT "Cleric     (5)"
1310 GOSUB 1500: REM ** Uniget
1320 A=VAL(GC$)
1330 IFA=1 THEN P$="Wizard":P1=2:C1=0.5:CS=22:PS=28
1340 IFA=2 THEN P$="Thinker":P1=1.5:C1=0.75:CS=24:PS=26
1350 IFA=3 THEN P$="Barbarian":P1=0.5:C1=2:CS=28:PS=22
1360 IFA=4 THEN P$="Warrior":P1=1:C1=1.25:CS=26:PS=24
1370 IFA=5 THEN P$="Cleric":P1=1.25:C1=1:CS=25:PS=25
1380 IFA<1 OR A>5 THEN P$="Dolt":P1=1:C1=1:CS=20:PS=20
1390 EX=5:C=150
1400 PRINT CHR$(10);CHR$(10);"Good luck"
1410 PRINT CHR$(10);J$;" the ";P$
1420 DF=150:DL$="D":GOSUB 36000:REM ** Delay
1430 GOSUB 10000:REM ** Valley draw
1440 DF=5:GOSUB 36000:REM ** Delay and update
1450 GOTO 2000:REM ** Movement
1499 REM ** Uniget routine
1500 GC=USR(X):IF GC THEN GC$=CHR$(GC):GOTO 1510
1501 GOTO 1500
1510 FOR I=1 TO LEN(VG$)
1520 IF MID$(VG$,I,1)=GC$ THEN RETURN
1530 NEXT I
1540 GOTO 1500
1599 REM ** Anykey routine
1600 PRINT "** Press any key to continue **"
1610 GC=USR(X):IF GC THEN GC$=CHR$(GC):RETURN
1615 GOTO 1610
1699 REM ** Combat get routine
1700 FORI=1TO10:GC=USR(X):GC$=CHR$(GC):NEXTI:REM ** Empties buffer
1710 TV=0
1720 FOR I=1 TO 200 :REM ** Original had 60, but this USR(x) is fast!
1730 GC=USR(X):IF GC THEN GC$=CHR$(GC):GOTO 1770
1750 NEXT I
1760 TV=1:REM ** No key pressed
1770 PRINT D$;SP$:REM ** Wipe away message
1780 RETURN
1999 REM ** Movement routine
2000 M=W:PK=PEEK(W):POKEM,236
2010 C=C+10
2020 IF PK=189 OR PK=190 THEN 2040
2030 PRINT D$;"Your move...which direction ?":GOTO 2050
2040 PRINT D$;"Safe on the path...which way?"
2050 FOR I = 1 TO 10:GC=USR(X):NEXT I:REM ** Clear kbd buffer
2060 GOSUB 1500:IF GC$="E" THEN 45000:REM ** Ego
2069 REM ** Special routine for numeric keypads
2070 A=VAL(GC$):IF A=0 THEN 2060
2080 IF A>3 THEN A=A-3:GOTO 2080
2090 W=M+A-2-64*(INT((VAL(GC$)-1)/3)-1)
2100 TN=TN+1:PRINT D$;SP$
2109 REM ** Am I stepping on something ?
2110 Q=236:Q1=PEEK(W):IF Q1=32 OR Q1=191 THEN 2190
2120 IF Q1=226 THEN 48000:REM ** Quit
2130 IFQ1=161ORQ1=219ORQ1=240THENTN=TN-1:GOTO2030:REM ** Wall/tree
2140 IFQ1=230ORQ1=231ORQ1=193ORQ1=187THEN9000:REM ** Scene entry
2150 IF Q1=184 OR Q1=188 THEN 9090:REM Scene exit
2160 IF Q1=178 THEN 15000:REM ** Stairs
2170 IFQ1=214OR(GC$="5"ANDPK=214)THEN Q=236:C=C-20:IFC<=0THEN55000
2180 IF Q1=42 THEN 2800:REM ** Special find
2190 POKE M,PK:PK=PEEK(W):M=W:POKE M,Q:REM ** Update character pos
2200 IF PK=189 OR PK=190 THEN DF=5:GOTO 2250
2209 REM ** Nothing, monster or find?
2210 RF=RND(1)
2220 IF RF<0.33 THEN 3000: REM ** Monster selection
2230 IF RF>0.75 THEN 2300: REM ** A find!
2240 PRINTD$;"Nothing of value...search on":DF=80
2250 GOSUB 36000:REM ** Delay and update
2260 GOTO 2010
2299 REM ** Finds subroutine
2300 RF=INT(RND(1)*6+1)
2310 ON RF GOSUB 2340,2380,2380,2410,2410,2440
2320 DF=80:GOSUB 36000:REM ** Delay and update
2330 GOTO 2010
2340 PRINT D$;"A circle of evil...depart in haste !"
2350 CS=CS+INT((FL+1)/2):PS=PS-INT((FL+1)/2):C=C-20
2360 IF C<=0 THEN 55000: REM ** Death
2370 RETURN
2380 PRINT D$;"A hoard of gold"
2390 TS=TS+INT(FL*RND(1)*100+100)
2400 RETURN
2410 PRINT D$;"You feel the aura of the deep magic..."
2420 PRINT "        ...all around you..."
2430 GOTO 2450
2440 PRINT D$;"...A place of ancient power..."
2450 PS=PS+2+INT(FL*P1):CS=CS+1+INT(FL*C1):C=C+25
2460 RETURN
2799 REM ** Special finds subroutine
2800 POKE M,32:M=W:PK=32:POKE M,236
2810 RN=RND(1):PRINT D$;SP$
2820 IFS=6ANDRN>0.95ANDT(1)=6ANDT(2)=0ANDRT>25THENT(2)=1:GOTO2870
2830 IF S=5 AND RN>0.85 AND T(0)=0 THEN T(0)=1:GOTO 2880
2840 IFS=4 AND RN>0.7AND T(0)=1AND T(1)<6AND FL>T(1) THEN 2890
2850 IF RN>0.43 THEN PRINT D$;"A worthless bauble":GOTO 2940
2860 PRINT D$;"A precious stone !":GOTO 2930
2870 PRINT D$;"You find the Helm of Evanna !":GOTO 2930
2880 PRINT D$;"The amulet of Alarian...empty...":GOTO 2930
2890 PRINT D$;"An amulet stone...":PRINT
2900 DF=60:DL$="D":GOSUB 36000:REM ** Delay
2910 IF RN>0.85 THEN PRINT"...but the wrong one !":GOTO 2940
2920 PRINT"...the stone fits !":T(1)=T(1)+1
2930 TS=TS+100*(T(0)+T(1)+T(2)+FL)
2940 DF=80:GOSUB 36000:REM ** Delay and update
2950 GOTO 2010
2999 REM ** Monster selection subroutine
3000 PRINT D$;"** Beware...thou hast encountered **"
3010 MS=0:N=0:CF=1
3020 RF=INT(RND(1)*17):IF RF>9 AND RND(1)>0.85 THEN 3020
3030 IF Q1=214 OR PK=214 THEN RF=INT(RND(1)*2)+17
3040 IF RF=16 AND RND(1)<0.7 THEN 3020
3050 IF FL<5 AND RF=15 THEN 3020
3060 X$=LEFT$(M$(RF),1)
3070 FOR I=1 TO LEN(F$)
3080 IF MID$(F$,I,1)=X$ THEN 3110
3090 NEXT I
3100 GOTO 3020
3110 M$=RIGHT$(M$(RF),LEN(M$(RF))-1)
3120 IF MS(RF)=0 THEN 3150
3130 MS=INT((CS*0.3)+MS(RF)+FL^0.2/(RND(1)+1))
3140 IF N1(RF)=0 THEN 3160
3150 N=INT(N1(RF)*FL^0.2/(RND(1)+1))
3160 U=INT((RF+1)*(FL^1.5))
3170 IF RF>23 THEN U=INT((RF-22)*FL^1.5)
3180 PRINTLEFT$(R$,12-(LEN(M$))/2);"An evil ";M$
3190 DF=40:GOSUB 36000:REM **Delay and update
3499 REM ** Character's combat subroutine
3500 IF RND(1)<0.6 THEN 4000:REM ** Monster's combat
3510 PRINT D$;"You have surprise...Attack or Retreat"
3520 GOSUB 1700:REM ** Combat get
3530 IF GC$="R" THEN 3900
3540 IF TV=1 THEN 3600
3550 IF GC$<>"A" THEN 4000
3560 DF=30:DL$="D":GOSUB 36000:REM ** Delay
3570 PRINT D$;"*** Strike quickly ***"
3580 GOSUB 1700:REM ** Combat get
3590 IF TV=0 THEN 3620
3600 PRINT D$;"* Too slow...Too slow *"
3610 HF=0:GOTO 3830
3620 E=39*LOG(EX)/3.14
3630 IF GC$="S" THEN 4500:REM ** Spell control
3640 IFMS=0THENPRINTD$;"Your sword avails you nought here":GOTO3830
3650 C=C-1
3660 IFC<=0THENPRINTD$;"You fatally exhaust yourself":GOTO55000
3670 RF=RND(1)*10
3680 IF GC$="H" AND (RF<5 OR CS>MS*4) THEN Z=2:GOTO 3730
3690 IF GC$="B" AND (RF<7 OR CS>MS*4) THEN Z=1:GOTO 3730
3700 IF GC$="L" AND (RF<9 OR CS>MS*4) THEN Z=0.3:GOTO 3730
3710 PRINT D$;"You missed it !"
3720 HF=0:GOTO 3830
3730 IF HF=1 THEN D=MS+INT(RND(1)*9):HF=0:GOTO 3760
3740 D=INT((((CS*50*RND(1))-(10*MS)+E)/100)*Z):IF D<0 THEN D=0
3750 IF CS>(MS-D)*4 THEN HF=1
3760 MS=MS-D
3770 PRINT D$;"A hit..."
3780 DF=60:DL$="D":GOSUB 36000:REM ** Delay
3790 IF D=0 THEN PRINTD$;R8$"but...no damage":HF=0:GOTO 3830
3800 PRINT D$;R8$;D;" damage":IF MS<=0 THEN 3860:REM ** Dead monster
3810 IF HF=1 THEN DF=30:DL$="D":GOSUB 36000
3820 IF HF=1 THEN PRINT "The ";M$;" staggers defeated"
3830 DF=110:GOSUB 36000
3840 IF HF=1 THEN 3570
3850 GOTO 4000:REM ** Monster's combat
3860 PRINT D$;CHR$(10);CHR$(10)"...killing the monster..."
3870 EX=EX+U:HF=0:CF=0
3880 DF=80:GOSUB 36000
3890 GOTO 2010:REM ** Movement
3900 PRINT D$;"Knavish coward !":CF=0
3910 GOTO 3880
3999 REM ** Monster's combat subroutine
4000 PRINT D$;"The creature attacks..."
4010 DF=50:DL$="W":GOSUB 36000:REM ** Delay and wipe
4020 IF MS=0 THEN 4300:REM ** Psionic attack
4030 IF MS<N AND N>6 AND RND(1)<0.5 THEN 4300
4040 MS=MS-1:IF MS<=0 THEN 4240
4050 RF=INT(RND(1)*10+1)
4060 ON RF GOTO 4070,4080,4090,4100,4110,4110,4120,4120,4130,4140
4070 PRINT D$;"It swings at you...and misses":GOTO 4280
4080 PRINT D$;"Your blade deflects the blow":GOTO 4280
4090 PRINT D$;"...but hesitates, unsure...":GOTO 4280
4100 Z=3:PRINT D$;"It strikes your head !":GOTO 4150
4110 Z=1.5:PRINT D$;"Your chest is struck !":GOTO 4150
4120 Z=1:PRINT D$;"A strike to your swordarm !":GOTO 4150
4130 Z=1.3:PRINT D$;"A blow to your body !":GOTO 4150
4140 Z=0.5:PRINT D$;"It catches your legs !"
4150 DF=60:DL$="D":GOSUB 36000
4160 G=INT((((MS*75*RND(1))-(10*CS)-E)/100)*Z)
4170 IF G<0 THEN G=0:PRINT D$;"...saved by your armour !  ":GOTO 4280
4180 C=C-G
4190 IF G>9 THEN CS=INT(CS-G/6)
4200 IF G=0 THEN PRINT D$;"Shaken......but no damage done":GOTO 4280
4210 PRINT D$;"You take...           ";G;" damage...      "
4220 IF CS<=0 OR C<=0 THEN 55000:REM ** Death
4230 GOTO 4280
4240 PRINT D$;"...using its last energy in the attempt"
4250 EX=INT(EX+U/2):CF=0
4260 DF=100:GOSUB 36000
4270 GOTO 2010:REM ** Movement
4280 DF=100:GOSUB 36000
4290 GOTO 3570:REM ** Character's combat
4299 REM ** Monster's psionic attack
4300 PRINT D$;"...hurling a lightning bolt at you !"
4310 G=INT(((180*N*RND(1))-(PS+E))/100):N=N-5:IF G>9 THEN N=N-INT(G/5)
4320 DF=80:DL$="W":GOSUB 36000
4330 IF N<=0 THEN N=0:GOTO 4240
4340 IF RND(1)<0.25 THEN 4410
4350 IF G<=0 THEN G=0:GOTO 4400
4360 PRINT D$;"It strikes home !"
4370 DF=110:GOSUB 36000
4380 C=C-G:IF G>9 THEN PS=INT(PS-G/4)
4390 GOTO 4210
4400 PRINT D$;"Your psi shield protects you":GOTO 4280
4410 PRINT D$;"...missed you !":GOTO 4280
4499 REM ** Spell control subroutine
4500 PRINT D$;"Which spell seek ye ? ":GOSUB 1700:REM ** Combat get
4510 IF TV=1 THEN 3600:REM ** Too slow
4520 IF VAL(GC$)>0 AND VAL(GC$)<4 THEN 4540
4530 PRINT D$;"No such spell...     ":GOTO 4640
4540 IF 4*PS*RND(1)<=N THEN 4590
4550 ON VAL(GC$) GOSUB 5000,5200,5400
4559 REM ** SC contains outcome flag
4560 ON SC GOTO 4620,4640,4660,4570,4600,4580,4590
4570 PRINT D$;"It is beyond you     ":GOTO 4640
4580 PRINT "But the spell fails... !":GOTO 4640
4590 PRINT D$;"No use, the beast's psi shields it":GOTO 4640
4600 PRINT D$;"The spell saps all your strength"
4610 GOTO 55000:REM ** Death
4620 DF=100:GOSUB 36000
4630 GOTO 2010:REM ** Movement
4640 DF=60:GOSUB 36000
4650 GOTO 4000:REM ** Monster's combat
4660 DF=60:GOSUB 36000
4670 GOTO 3570:REM ** Character's combat
4999 REM ** Spell 1 - Sleepit
5000 C=C-5:IF C<=0 THEN SC=5:RETURN
5010 PRINT D$;"Sleep you foul fiend that I may escape"
5020 PRINT "and preserve my miserable skin"
5030 DF=180:GOSUB 36000
5040 PRINTD$;"The creature staggers..."
5050 DF=40:DL$="D":GOSUB 36000
5060 IF RND(1)<0.5 THEN 5090
5070 PRINT "and collapses...stunned"
5080 EX=INT(EX+U/2):CF=0:SC=1:RETURN
5090 PRINT "but recovers with a snarl !"
5100 SC=2:RETURN
5199 REM ** Spell 2 - Psi lance
5200 IF MS>C OR PS<49 OR EX<1000 THEN SC=4:RETURN
5210 C=C-10:IF C<=0 THEN SC=5:RETURN
5220 IFN=0THENPRINTD$;"This beast has no psi to attack":SC=2:RETURN
5230 PRINTD$;"With my mind I battle thee for my life"
5240 DF=120:GOSUB 36000
5250 RF=RND(1):IF RF<0.4 AND N>10 THEN SC=6:RETURN
5260 D=INT((((CS*50*RF)-5*(MS+N)+E)/50)/4)
5270 IF D<=0 THEN D=0:SC=7:RETURN
5280 PRINTD$;"The psi lance causes ";D*2;" damage"
5290 N=N-3*D:IF N<=0 THEN N=0
5300 MS=MS-D:IF MS<=0 THEN MS=0
5310 IF (MS+N)>0 THEN SC=2:RETURN
5320 PRINTCHR$(10);"...killing the creature"
5330 EX=EX+U:CF=0:SC=1:RETURN
5399 REM ** Spell 3 - Crispit
5400 IF PS<77 OR EX<5000 THEN SC=4:RETURN
5410 C=C-20:IF C<=0 THEN SC=5:RETURN
5420 PRINTD$;"With the might of my sword I smite thee"
5430 PRINT"With the power of my spell I curse thee"
5440 PRINT"Burn ye spawn of hell and suffer..."
5450 DF=240:GOSUB 36000
5460 PRINTD$;"A bolt of energy lashes at the beast..."
5470 DF=80:DL$="W":GOSUB 36000
5480 IF RND(1)>(PS/780)*(5*P1)THEN PRINT D$;"Missed it !":SC=2:RETURN
5490 D=INT((CS+PS*RND(1))-(10*N*RND(1)))
5500 IF D<=0 THEN D=0:SC=7:RETURN
5510 IF MS=0 THEN N=N-D:GOTO 5530
5520 MS=MS-D:IF D>10 THEN N=INT(N-(D/3))
5530 PRINTD$;"It strikes home causing ";D;" damage  !"
5540 IF (MS+N)<0 THEN 5570
5550 DF=80:DL$="D":GOSUB 36000
5560 SC=2:RETURN
5570 PRINT:PRINT"The beast dies screaming !"
5580 EX=EX+U:CF=0:SC=1:RETURN
8999 REM ** Scenario control subroutine
9000 IFQ1=187ANDPK=214THENPRINTD$;"You cannot enter this way.":GOTO 9110
9010 FOR I=2 TO 7
9020 P(I)=0
9030 N(I)=INT(RND(1)*5+4)
9040 IF N(I)=5 THEN 9030
9050 NEXT I
9060 IF S=1 THEN MP=M
9070 P(2)=INT(RND(1)*30+1)
9080 TF=TN:GOTO 9130
9089 REM ** Exit from scenario
9090 IF TN>TF+INT(RND(1)*6+1) THEN 9130
9100 PRINT D$;"The way is barred"
9110 TN=TN-1:C=C-10:DF=100:DL$="W":GOSUB 36000
9120 GOTO 2010
9130 C=C-10:POKE M,32:POKE W,Q
9140 IF Q1=188 THEN S=1:FL=1
9150 IF Q1=184 AND S=4 THEN S=1:FL=1
9160 IF Q1=184 AND S=5 OR S=6 THEN S=S-3:FL=FL-4:M=MW
9170 IF Q1=193 THEN S=2:FL=2
9180 IF Q1=230 THEN S=3:FL=3
9189 I = INT(RND(1)*7)+1
9190 IF Q1=230 OR Q1=193 THEN D2$=LEFT$(D$,I):R2$=LEFT$(R$,P(2))
9200 IF Q1=231 THEN S=4:FL=2
9210 IF Q1=187 THEN S=S+3:FL=FL+4:MW=M
9220 ON S GOSUB 10000,12000,12010,14000,14010,14010
9230 DF=5:GOSUB 36000
9240 GOTO 2000:REM ** Movement
9999 REM ** Scenario 1 - The Valley
10000 PRINT CHR$(26):PRINT D$:F$="VAEGH":FL=1:S=1
10009 REM ** Draw the valley frame
10010 FOR I=0 TO 38:POKE TL+I,161:NEXT I
10020 FOR I=1 TO 12:POKE TL+(I*64),161:POKE TL+(I*64)+38,161:NEXT I
10050 FOR I=0 TO 38:POKE TL+(13*64)+I,161:NEXT I
10059 REM ** If path already drawn skip
10060 IF G(0)<>0 THEN 10190
10069 REM ** Compute the path
10070 M=TL+INT(RND(1)*11+1)*64+1
10080 L=M:MP=M:W=M:G(0)=M:G(1)=226
10090 FOR I=2 TO 72 STEP 2
10100 IF RND(1)>0.5 THEN 10120
10110 PC=190:L1=L+65:GOTO 10130
10120 PC=189:L1=L-63
10130 IF L1>=TL+831 OR L1<=TL+66 THEN 10100
10140 G(I+1)=PC
10150 IF I>2 AND G(I+1)<>G(I-1)THEN L1=L+1
10160 G(I)=L1:L=L1:POKE G(I),G(I+1)
10170 NEXT I
10180 G(73)=226
10189 REM ** Plot in path
10190 FOR I=0 TO 72 STEP 2
10200 POKE G(I),G(I+1)
10210 NEXT I
10220 IF S(O)<>0 THEN 10280
10229 REM ** Compute scenario positions
10230 FOR I=0 TO 4
10240 N1=INT(RND(1)*11)+1:N2=INT(RND(1)*34)+1
10250 S(I)=TL+(64*N1)+N2
10260 IF PEEK(S(I))<>32 OR PEEK(S(I)+1)<>32 THEN 10240
10270 NEXT I
10279 REM ** Plot in scenarios
10280 POKE S(0),230:POKE S(0)+1,230:POKE S(1),230:POKE S(1)+1,230
10290 POKE S(2),193:POKE S(2)+1,193:POKE S(3),193:POKE S(3)+1,193
10300 POKE S(4),231
10310 M=MP:W=M
10320 RETURN
11999 REM ** Scenario 2 - Woods and Swamps
12000 F$="AFL":PC=191:GOTO 12020
12010 F$="FAEHL":PC=240
12020 PK=32
12030 PRINT CHR$(26)
12039 REM ** Draw random woods or swamps
12050 FOR I=1 TO 200
12060 UY=INT(RND(1)*12)+1:UX=INT(RND(1)*38)+1:POKE(TL+(UY*64)+UX),PC
12070 NEXT I
12079 REM ** Print in lake
12080 PRINTCHR$(12);D2$;R2$;CHR$(11);CHR$(11);CHR$(214);CHR$(214)
12090 PRINTR2$;CHR$(11);
12091 FORI=1TO4:PRINTCHR$(214);:NEXTI:PRINTCHR$(214)
12100 PRINTR2$;CHR$(214);CHR$(214);"  ";CHR$(214);CHR$(214)
12110 PRINTR2$;CHR$(214);CHR$(214);CHR$(187);" ";
12111 PRINTCHR$(214);CHR$(214);CHR$(214)
12120 PRINTR2$;CHR$(11);
12121 FORI=1TO4:PRINTCHR$(214);:NEXTI
12122 PRINTCHR$(11);CHR$(214);CHR$(214)
12130 PRINTR2$;CHR$(11);CHR$(11);CHR$(11);CHR$(214);CHR$(214)
12140 PRINTR2$;CHR$(11);CHR$(11);CHR$(11);CHR$(11);CHR$(214)
12141 PRINTD$ : REM ** Position cursor out of frame
12149 REM ** Draw in the frame
12150 FOR I=0TO38:POKE TL+I,188:NEXT I
12160 FOR I=1TO12:POKE TL+(I*64),188:POKE TL+(I*64)+38,188:NEXTI
12190 FOR I=0TO38:POKE TL+(13*64)+I,188:NEXT I
12200 W=TL+(12*64)+37:POKE W,32
12210 IF Q1=184 THEN M=MW:W=M
12220 RETURN
13999 REM ** Scenario 3 - Castles
14000 F$="CAGE":P=0:H=N(FL):PK=32:GOTO 14020
14010 F$="CBE":P=0:H=N(FL):PK=32:P(FL)=P(2)
14019 REM ** Draw frame
14020 PRINT CHR$(26);CHR$(11);CHR$(11);
14021 FOR I=1TO20:PRINTCHR$(219);:NEXTI:PRINT CHR$(219)
14030 FOR I=1TO12
14040 PRINT CHR$(11);CHR$(11);CHR$(219);
14041 PRINT "                   ";CHR$(219)
14050 NEXT I
14060 PRINTCHR$(11);CHR$(11);
14061 FOR I=1TO20:PRINTCHR$(219);:NEXTI:PRINT CHR$(219)
14069 REM ** Draw vertical walls
14070 RESTORE:FOR I=1 TO P(FL)
14080 READ V:IF V=100 THEN RESTORE
14090 NEXT I
14100 L1=TL+2
14110 FOR J=1 TO 3
14120 READ D(J):P=P+1
14130 IF D(J)=100 THEN RESTORE:D(J)=3:P=P+1
14140 NEXT J
14150 FOR I=0 TO H:PC=219
14160 L=L1+(64*I):IF L>TL+768 THEN 14260
14170 IF I=1 THEN PC=32
14180 IF D(1)=0 THEN PC=219:GOTO 14200
14190 POKE L+D(1),PC:PC=219
14200 IF I=3 THEN PC=32
14210 POKE L+D(1)+D(2),PC:PC=219
14220 IF I=4 THEN PC=32
14230 POKE L+D(1)+D(2)+D(3),PC:PC=219
14240 NEXT I
14250 L1=L1+(64*H)+64:GOTO 14110
14259 REM ** Draw horizontal walls
14260 L1=TL+2
14270 FOR J=1 TO 4
14280 L=L1+(64*J*(H+1))
14290 FOR K=1 TO 19
14300 IF L>TL+704 THEN 14350
14310 POKE L+K,PC
14320 IFK=2ORK=3*HORK=17THENPOKEL+K,32:POKEL+K-64,32:POKEL+K+64,32
14330 NEXT K
14340 NEXT J
14349 REM ** Draw in the stairs
14350 IF S=5 OR S=6 THEN 14380
14360 IF FL/2=INT(FL/2) THEN POKE TL+64+21,178:GOTO 14380
14370 POKE TL+771,178
14379 REM ** Doorway needed ?
14380 IF FL=2 OR S=5 OR S=6 THEN POKE TL+838,184:POKE TL+774,32
14390 IF P(3)=0 THEN W=TL+774
14399 REM ** Write appropriate castle name
14400 IF S=5 THEN 14470
14410 IF S=6 THEN 14450
14420 PRINTCHR$(12);R1$;CHR$(10);CHR$(10);CHR$(10);CHR$(10);
14421 PRINTCHR$(11);CHR$(11);CHR$(11);"The Black Tower"
14430 PRINTR1$;CHR$(11);CHR$(11);CHR$(11);"   of Zaexon"
14440 PRINTR1$;CHR$(10);CHR$(10);CHR$(10);
14441 PRINTCHR$(11);CHR$(11);CHR$(11);"   Floor ";FL-1:GOTO 14490
14450 PRINTCHR$(12);R1$;CHR$(10);CHR$(10);CHR$(11);CHR$(11);
14451 PRINTCHR$(11);CHR$(11);CHR$(11);CHR$(219);"Vounim's";CHR$(219)
14460 PRINTR1$;CHR$(11);CHR$(11);CHR$(11);CHR$(11);CHR$(11);
14461 PRINTCHR$(219);CHR$(219);CHR$(219);"Lair";
14462 PRINTCHR$(219);CHR$(219);CHR$(219):GOTO 14500
14470 PRINTCHR$(12);R1$;CHR$(10);CHR$(10);
14471 PRINTCHR$(11);CHR$(11);CHR$(11);CHR$(11);"The Temple Of"
14480 PRINTR1$;CHR$(11);CHR$(11);CHR$(11);CHR$(11);
14481 PRINTCHR$(219);CHR$(219);"Y'Nagioth";CHR$(219);CHR$(219)
14490 P(FL+1)=P(FL)+P
14499 REM ** Scatter special finds
14500 IF FL<4 OR RND(1)<0.3 THEN RETURN
14510 FOR I=1 TO INT(RND(1)*5)+2
14520 N1=INT(RND(1)*19)
14530 N2=INT(RND(1)*12)
14540 IF PEEK(TL+3+64*N2+N1)<>32 THEN 14520
14550 POKE TL+3+64*N2+N1,42
14560 NEXT I
14570 RETURN
14999 REM ** Stairs subroutine
15000 POKE W,236:POKE M,32
15010 PRINTD$;"A stairway...up or down?":TV=FL
15020 VG$="UD":GOSUB 1500:VG$="0123456789E"
15030 IF GC$="U" THEN FL=FL+1:GOTO 15050
15040 FL=FL-1
15050 IF FL>7 OR FL<2 THEN 15080
15060 DF=110:DL$="D":GOSUB 36000
15070 GOTO 9220
15080 PRINTD$;"These stairs are blocked "
15090 DF=60:DL$="D":GOSUB 36000
15100 FL=TV:GOTO 15010
35999 REM ** Delay, wipe and update subroutine
36000 FOR DL=1 TO DF*TM
36010 NEXT DL
36020 IF DL$="D" THEN DL$="":RETURN
36030 PRINT D$;SP$
36040 PRINT SP$
36050 PRINT SP$
36060 IF DL$="W" THEN DL$="":RETURN
36070 IF CS>77-INT(2*P1^2.5) THEN CS=77-INT(2*P1^2.5)
36080 IF PS<7 THEN PS=7
36085 PT=INT(42*(P1+1)^LOG(P1^3.7))+75
36090 IF PS>PT THEN PS=PT
36100 IFC>125-(INT(P1)*12.5)THENC=125-INT(INT(P1)*12.5)
36110 PRINT D6$;J$;" the ";P$
36120 PRINT "Treasure   =";TS
36130 PRINT "Experience =";EX
36140 PRINT "Turns      =";TN
36150 PRINT D1$;R1$;"  Combat str =";CS
36160 PRINT R1$;"  Psi power  =";PS
36170 PRINT R1$;"  Stamina    =";C
36179 REM ** If fighting update monster
36180 IF CF=1 THEN 36210
36190 PRINT SP$
36200 RETURN
36210 PRINT D0$;M$;
36220 PRINT D0$;R1$;"  M Str =";MS;N;" "
36230 RETURN
44999 REM ** Ratings subroutine
45000 DF=5:DL$="W":GOSUB 36000
45010 RT=INT(0.067*(EX+TS/3)^0.5+LOG(EX/((TN+1)^1.5)))
45011 IF RT>28 THEN RT=28
45020 IF RT<0 THEN RT=0
45030 PRINTD$;"Your rating now be";RT
45040 IF T(2)=1 THEN PRINT "You have the helm of Evanna"
45050 IF T(0)=1 THEN PRINT "Amulet stones... ";T(1)
45060 DF=250:DL$="W":GOSUB 36000
45070 IF GC$="E" THEN C=C-10:GC$="":GOTO 2010
45080 RETURN
47999 REM ** Quit valley subroutine
48000 PRINTD$;"Thou art safe in a castle":IFCS<20THENCS=20
48010 POKE M,PK:PK=PEEK(W):M=W:POKE M,Q
48020 PRINT "Wilt thou leave the valley (Y/N) ?"
48030 VG$="YN":GOSUB 1500
48040 DF=5:DL$="W":GOSUB 36000
48049 REM ** Generate rating in case of save
48050 GOSUB 45000:REM ** Rating
48060 DF=110:DL$="W":GOSUB 36000
48070 IF GC$="Y" THEN 50000: REM ** Save
48080 C=150:PRINTD$;"Thy wounds healed...thy sword sharp"
48090 PRINT "Go as the Gods demand...trust no other"
48100 DF=120:GOSUB 36000
48110 VG$="0123456789E":GOTO 2010:REM ** Movement
49999 REM ** Save character routine - UK101 CEGMON
50000 PRINT CHR$(26);"Do you wish to save ";J$;" ?"
50010 PRINT:PRINT"Please key Y or N"
50020 VG$="YN":GOSUB1500:REM ** Uniget
50030 IF GC$="N" THEN 50210
50040 PRINT CHR$(26);"Place your cassette in the tape deck"
50050 PRINT "Is it rewound ?":PRINT
50060 GOSUB 1600: REM ** Anykey
50069 REM ** For UK101 only - enable output to ACIA
50070 POKE11,0:POKE12,253:X=USR(X):SAVE
50075 PRINT J$
50080 PRINT P$
50090 PRINT TS
50100 PRINT EX
50110 PRINT TN
50120 PRINT CS
50130 PRINT PS
50140 PRINT T(0)
50150 PRINT T(1)
50160 PRINT T(2)
50170 PRINT C1
50180 PRINT P1
50190 POKE 517,0:REM ** Disable output to ACIA
50200 PRINT CHR$(26);CHR$(10);CHR$(10);CHR$(10);" *** Done ***"
50205 DF=150:DL$="D":GOSUB 36000:REM ** Delay
50210 PRINT D$;"      Type RUN to start again"
50220 CLEAR
50230 END: REM ** Program end
54999 REM ** Death subroutine
55000 C=0:CS=0:PS=0:CF=0
55010 DF=110:GOSUB 36000
55020 IF T(1)=6 THEN 55070
55030 PRINTD$;"Oh what a frail shell"
55040 PRINT "  is this that we call man"
55050 DF=300:DL$="W":GOSUB 36000
55060 PRINT CHR$(26):GOTO 50210
55070 T(0)=0:T(1)=0:TS=0:CS=30:C=150:PS=30
55080 PRINTD$;"Alarian's amulet protects thy soul"
55090 PRINTCHR$(10);CHR$(219);CHR$(219);"Live again";
55091 PRINTCHR$(219);CHR$(219)
55100 DF=150:GOSUB 36000
55110 L=G(0):MP=L:M=W:S=1:GOTO 9220
55999 REM ** UK101 CEGMON non-halting get
56000 FORI=1TO80:M=PEEK(64767+I):POKE(575+I),M:NEXTI
56010 POKE634,76:POKE635,208:POKE636,253
56030 POKE656,141:POKE657,19:POKE658,2
56050 POKE659,76:POKE660,110:POKE661,253
56060 POKE662,32:POKE663,64:POKE664,2
56070 POKE665,168:POKE666,169:POKE667,0
56080 POKE668,76:POKE669,193:POKE670,175
56090 POKE 11,150:POKE 12,2
56100 RETURN
59999 REM ** Data for castle type scenarios
60000 DATA 4,7,3,6,4,4,6,5,3,6,0,3,8,4,3,5,5,3
60001 DATA 8,3,4,5,0,6,3,6,4,6,4,7,4,100
60009 REM ** Data for monsters
60010 DATA AWolfen,9,0,AHob-Goblin,9,0,AOrc,9,0
60011 DATA EFire-Imp,7,3,GRock-Troll,19,0
60020 DATA EHarpy,10,12,AOgre,23,0,BBarrow-Wight,0,25
60021 DATA HCentaur,18,14
60030 DATA EFire-Giant,26,20,VThunder-Lizard,50,0
60031 DATA CMinotaur,35,25,CWraith,0,30
60040 DATA FWyvern,36,12,BDragon,50,20
60041 DATA CRing-Wraith,0,45,ABalrog,50,50
60049 REM ** Special water monsters
60050 DATA LWater-Imp,15,15,LKraken,50,0
