
*&---------------------------------------------------------------------*

*& Report ZEDR12_IT_8

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_IT_008.

DATA: BEGIN OF GS_STUDENT,

  ZCODE(10) TYPE C,

  ZKNAME(10) TYPE C,

  ZENAME(10) TYPE C,



  END OF GS_STUDENT.



   DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



  GS_STUDENT-ZCODE = 'SSU01'.

  GS_STUDENT-ZKNAME = '###'.

  GS_STUDENT-ZENAME = 'KANG'.



  APPEND GS_STUDENT TO GT_STUDENT. "###### ##



  BREAK-POINT.



  CLEAR : GT_STUDENT. "CLEAR # BODY ##



  BREAK-POINT.