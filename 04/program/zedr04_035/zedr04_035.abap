
*&---------------------------------------------------------------------*

*& Report ZEDR04_035

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_035.



" ###(## ##) ##

DATA : BEGIN OF GS_STUDENT,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 10,

  ZENAME TYPE C LENGTH 10,

  END OF GS_STUDENT.



" ###### ##

DATA GT_STUDENT LIKE TABLE OF GS_STUDENT.



" ### ### ##

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'DONG'.



" ####### ### ##

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR GT_STUDENT. " #### ## ### ### CLEAR



BREAK-POINT.