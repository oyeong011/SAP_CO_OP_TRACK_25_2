
*&---------------------------------------------------------------------*

*& Report ZEDR04_036

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_036.



" #### ## ### ### ##

DATA : BEGIN OF GT_STUDENT OCCURS 0,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 10,

  ZENAME TYPE C LENGTH 10,

  END OF GT_STUDENT.



" ### ### ##

GT_STUDENT-ZCODE = 'SSU-01'.

GT_STUDENT-ZKNAME = '###'.

GT_STUDENT-ZENAME = 'DONG'.



" ####### ### ##

APPEND GT_STUDENT.



"CLEAR GT_STUDENT. " ### CLEAR

CLEAR GT_STUDENT[]. " BODY# CLEAR



BREAK-POINT.