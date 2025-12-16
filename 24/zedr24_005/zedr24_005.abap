
*&---------------------------------------------------------------------*

*& Report ZEDR24_005

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR24_005.



DATA : BEGIN OF GS_STUDENT,

  ZCODE TYPE ZEDT24_001-ZCODE,

  ZKNAME TYPE ZEDT24_001-ZKNAME,

  ZENAME TYPE ZEDT24_001-ZENAME,

  END OF GS_STUDENT.



GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'DONG'.



DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



BREAK-POINT.



APPEND GS_STUDENT TO GT_STUDENT.



BREAK-POINT.



CLEAR : GT_STUDENT.



BREAK-POINT.



 CLEAR : GS_STUDENT.



 BREAK-POINT.