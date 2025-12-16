
*&---------------------------------------------------------------------*

*& Report ZEDR08_017

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR08_017.



DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT08_001
.

  DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : GV_ZCODE LIKE ZEDT08_001-ZCODE.

DATA : GV_ZKNAME LIKE ZEDT08_001-ZKNAME.



PERFORM GET_DATA(ZEDR08_015) IF FOUND CHANGING GT_STUDENT.



LOOP AT GT_STUDENT INTO GS_STUDENT.

  WRITE :/ GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

ENDLOOP.



"---------------------------------------------------------------------



DATA : GV_PNAME(20) VALUE 'ZEDR08_015'.

DATA : GV_FORMNAME(20) VALUE 'GET_DATA'.



TRANSLATE GV_PNAME TO UPPER CASE.

TRANSLATE GV_PNAME TO UPPER CASE.



PERFORM (GV_FORMNAME) IN PROGRAM (GV_PNAME) IF FOUND CHANGING GT_STUDENT.



LOOP AT GT_STUDENT INTO GS_STUDENT.

  WRITE :/ GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

ENDLOOP.



"---------------------------------------------------------------------



DO 2 TIMES.

  PERFORM SY-INDEX OF SUBR1 SUBR2.

ENDDO.

FORM SUBR1.

  WRITE :/ SY-INDEX, '## ####'.

ENDFORM.

FORM SUBR2.

  WRITE :/ SY-INDEX, '## ####'.

ENDFORM.