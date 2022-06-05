70 REM Screen test, save, load by Hey Birt! 2022
80 REM Screen load/save from LCD Tips, by Mike Safonov 
90 S$ = "1":REM Last fill type
100 CLEAR 256,MAXRAM-1921:CLS
110 PRINT "[T]oggle screen"
120 PRINT "[S]ave screen"
130 PRINT "[L]oad screen
140 PRINT "[Q]uit"
150 K$=INKEY$:IF K$ = "" GOTO 150
160 IF K$ = "T" THEN GOTO 200
170 IF K$ = "S" THEN GOTO 300
180 IF K$ = "Q" THEN GOTO 500
190 GOTO 150
199 REM Toggle screen fill
200 IF S$ = "0" THEN GOTO 230 
210 CLS:S$ = "0"
220 GOTO 150
230 CLS:POKE 63038,1:S$ = "1":REM Turn off scroll
240 FOR I=1 TO 320:PRINT CHR$(239);:NEXT I
250 GOTO 150
299 REM Load or Save screen
300 POKE 63038,0:POKE HIMEM,201:REM POKE "return" at beginning of file
310 HL=HIMEM+1
320 if K$="S" THEN MZ%(0)=22 ELSE LOADM"IMAGE":MZ%(0)=278
330 MZ%(1)=13005
340 MZ%(2)=-13964
350 FOR RZ%=0 TO 6
360     FOR CZ%=0 TO 39
370         CALL 30300
380         POKE-12,RZ%
390         POKE-11,CZ%
400         CALL VARPTR(MZ%(0)),0,HL
410         HL=HL+6
420     NEXT
430 NEXT
440 N$ = "IMAGE" + S$
450 IF K$="S" THEN SAVEM N$,HIMEM,HIMEM+1921
460 END: REM Program automatically ends after SAVEM done
499 REM Enable scroll and exit
500 POKE 63038,0:END
 