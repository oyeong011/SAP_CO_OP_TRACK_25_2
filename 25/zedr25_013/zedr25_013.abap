
*&---------------------------------------------------------------------*

*& Report ZEDR25_013

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR25_013.



DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT25_001
.

  DATA : END OF GS_STUDENT.

DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : GV_ZCODE LIKE ZEDT25_001-ZCODE.

DATA : GV_ZKNAME LIKE ZEDT25_001-ZKNAME.



" ## ###### PERFROM# #### ### #### PERFORM### ##

PERFORM GET_DATA(ZEDR25_012) IF FOUND CHANGING GT_STUDENT.



LOOP AT GT_STUDENT INTO GS_STUDENT.

  WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

ENDLOOP.