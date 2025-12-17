
*&---------------------------------------------------------------------*

*& Report ZEDR04_022

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_022.



" 1. MOVE A TO B (3. WRITE A TO B)

DATA : BEGIN OF GS_NAME,

  NAME1 TYPE C LENGTH 10,

  NAME2 TYPE C LENGTH 10,

  END OF GS_NAME.



GS_NAME-NAME1 = '###'.

GS_NAME-NAME2 = '##'.



"GS_NAME-NAME1 = GS_NAME-NAME2.

MOVE GS_NAME-NAME2 TO GS_NAME-NAME1.




*WRITE GS_NAME-NAME2 TO GS_NAME-NAME1.  " ##?






WRITE / GS_NAME-NAME1.  "##

WRITE / GS_NAME-NAME2.  "##

WRITE / '--------------------------------------------'.



" 1-1) MOVE A TO B ### ### ##

DATA : BEGIN OF GS_NAME2,

  NAME1 TYPE C LENGTH 10,     " ##

  DEGREE1 TYPE P DECIMALS 2,  " ##

  END OF GS_NAME2.



GS_NAME2-NAME1 = '##'.

GS_NAME2-DEGREE1 = '35.12'.



MOVE GS_NAME2-DEGREE1 TO GS_NAME2-NAME1.  " ##->##

CONDENSE GS_NAME2-NAME1 NO-GAPS. " ## ##



WRITE / GS_NAME2-NAME1.     "35.12

WRITE / GS_NAME2-DEGREE1.   "           35.12

WRITE / '--------------------------------------------'.



" 2. MOVE A+P1(P2) TO B+P3(P4) : OFFSET(0-INDEXED)# ### # ##

DATA :  GV_DATA1(8) VALUE 'ABCDEFGH',

        GV_DATA2(8),

        GV_START TYPE I VALUE 2,

        GV_LENGTH TYPE I VALUE 4.



"MOVE GV_DATA1+2(4) TO GV_DATA2.

MOVE GV_DATA1+GV_START(GV_LENGTH) TO GV_DATA2.

WRITE / GV_DATA2.     "CDEF



" 2-1) ####

GV_DATA2 = 'IJKLMNOP'.



MOVE GV_DATA1+GV_START(GV_LENGTH) TO GV_DATA2+GV_START(GV_LENGTH).

WRITE / GV_DATA2.   "IJCDEFOP