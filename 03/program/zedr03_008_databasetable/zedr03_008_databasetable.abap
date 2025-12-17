
*&---------------------------------------------------------------------*

*& Report ZEDR03_008_DATABASETABLE

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_008_DATABASETABLE.



DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT03_001
.

  DATA END OF GS_STUDENT.



DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



CLEAR : GS_STUDENT, GT_STUDENT.







GS_STUDENT-ZCODE = 'SSU-06'.

GS_STUDENT-ZPERNR = '0000000006'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'TEST'.

GS_STUDENT-ZTEL = '01000000006'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.



GS_STUDENT-ZCODE = 'SSU-33'.

GS_STUDENT-ZPERNR = '0000000003'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'FIGHTING'.

GS_STUDENT-ZTEL = '01000000006'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.



MODIFY ZEDT03_001 FROM TABLE GT_STUDENT.



IF SY-SUBRC = 0.

  WRITE :/ '##'.

ELSE.

  WRITE :/ '##'.

ENDIF.