
*&---------------------------------------------------------------------*

*& Report ZEDR03_002_DATA_OBJECT_OTHERS

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_002_DATA_OBJECT_OTHERS.



"DATA : GV_DATA1(8) VALUE 'ABCDEFGH',

"       GV_DATA2(8) VALUE 'IJKLMNOP'.

"DATA : GV_START TYPE I VALUE 2,

"       GV_LENGTH TYPE I VALUE 4.

"

"MOVE GV_DATA1+GV_START(GV_LENGTH) TO GV_DATA2+GV_START(GV_LENGTH).

"WRITE / GV_DATA2.






*--------------------------------------------------------------------*






"CONSTANTS : BEGIN OF C_STUDENT,

"  ZCODE(10) VALUE 'SSU-03',

"  ZKNAME(10) VALUE '##',

"  ZENAME(10) VALUE'JW',

"  END OF C_STUDENT.



"  "C_STUDENT-ZNUM = C_STUDENT-ZNUM + 1. " ### # ## ###! ## #



"  WRITE / C_STUDENT-ZCODE.

"  WRITE / C_STUDENT-ZKNAME.

"  WRITE / C_STUDENT-ZENAME.





TABLES : ZEDT03_001.



SELECT SINGLE * FROM ZEDT03_001.



WRITE / ZEDT03_001-ZCODE.

WRITE / ZEDT03_001-ZKNAME.

WRITE / ZEDT03_001-ZENAME.

WRITE / ZEDT03_001-ZGENDER.

WRITE / ZEDT03_001-ZTEL.



WRITE /.



TABLES : SCARR.



SELECT * FROM SCARR.

  WRITE : / SCARR-CARRID, SCARR-CARRNAME.

ENDSELECT.