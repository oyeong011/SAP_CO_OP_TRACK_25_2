
*&---------------------------------------------------------------------*

*& Report ZEDR03_011_PERFORMPLUE

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_011_PERFORMPLUE.



DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT03_001
.

 DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : GV_PNAME(20) VALUE 'ZEDR03_011_PERFORM'.

DATA : GV_FORMNAME(20) VALUE 'GET_DATA'.



PERFORM ('GET_DATA') IN PROGRAM ('ZEDR03_011_PERFORM') IF FOUND CHANGING GT_STUDENT.



LOOP AT GT_STUDENT INTO GS_STUDENT.

  WRITE :/ GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

ENDLOOP.