
*&---------------------------------------------------------------------*

*& Report ZEDR12_DBTUPDATE002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_DBTUPDATE002.




* 2. Several lines

*######################

*UPDATE <TABLE> FROM TABLE ITAB








DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT12_001
.

  DATA: END OF GS_STUDENT.

DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



CLEAR: GS_STUDENT, GT_STUDENT.

GS_STUDENT-ZCODE = 'SSU-12'.

GS_STUDENT-ZPERNR = '0000000012'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'JAE'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01000002222'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR: GS_STUDENT.

GS_STUDENT-ZCODE = 'SSU-12'.

GS_STUDENT-ZPERNR = '0000000012'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'JAE'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01000002222'.

APPEND GS_STUDENT TO GT_STUDENT.



UPDATE ZEDT12_001 FROM TABLE GT_STUDENT.



IF SY-SUBRC = 0.

  WRITE:/ '### ## ##'.

ENDIF.