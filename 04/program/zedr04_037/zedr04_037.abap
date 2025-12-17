
*&---------------------------------------------------------------------*

*& Report ZEDR04_037

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_037.



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



BREAK-POINT.



REFRESH GT_STUDENT. " ### ###, ### ###



BREAK-POINT.



FREE GT_STUDENT.  " ### ##



BREAK-POINT.