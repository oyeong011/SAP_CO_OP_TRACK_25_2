
*&---------------------------------------------------------------------*

*& Report ZEDR12_DBTDELETE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_DBTDELETE001.






* 1. Single line

*#######line###

*WA#####DELETE######

*WA##############

*DELETE <TABLE> FROM WA






DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT12_001
.

  DATA: END OF GS_STUDENT.

  DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



GS_STUDENT-ZCODE = 'SSU-14'.

GS_STUDENT-ZPERNR = '0000000014'.



DELETE ZEDT12_001 FROM GS_STUDENT.



  IF SY-SUBRC = 0.

    WRITE:/ '### ## ##'.

  ENDIF.