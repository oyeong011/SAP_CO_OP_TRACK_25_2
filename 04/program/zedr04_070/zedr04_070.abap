
*&---------------------------------------------------------------------*

*& Report ZEDR04_070

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_070.



DATA GS_STUDENT TYPE ZEDT04_001.

DATA GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA GV_PNAME(20) VALUE 'ZEDR04_069'.

DATA GV_FORMNAME(20) VALUE 'GET_DATA3'.



TRANSLATE GV_PNAME TO UPPER CASE.     " ## ## ## # #### ###

TRANSLATE GV_FORMNAME TO UPPER CASE.  " #### ## #### ## ##



"PERFORM GET_DATA3(ZEDR04_069) IF FOUND USING GT_STUDENT.  " ######(ZEDR04_069)# SUBROUTINE ##

PERFORM (GV_FORMNAME) IN PROGRAM (GV_PNAME) IF FOUND USING GT_STUDENT. " #### ### SUBROUTINE ### ### ### #### ##



LOOP AT GT_STUDENT INTO GS_STUDENT.

  WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

ENDLOOP.