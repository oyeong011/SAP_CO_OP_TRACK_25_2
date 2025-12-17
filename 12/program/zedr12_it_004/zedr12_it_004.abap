
*&---------------------------------------------------------------------*

*& Report ZEDR12_IT_4

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_IT_004.

DATA: BEGIN OF GS_STUDENT,

  ZCODE(10) TYPE C,

  ZKNAME(10) TYPE C,

  ZENAME(10) TYPE C,

  ZCLASS TYPE C,

  END OF GS_STUDENT.



  DATA: BEGIN OF GS_STUDENT2,

    ZCODE(10) TYPE C,

  ZKNAME(10) TYPE C,

  ZENAME(10) TYPE C,

  ZCLASS TYPE C,

  END OF GS_STUDENT2.



  DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.

  DATA: GT_STUDENT2 LIKE TABLE OF GS_STUDENT.



  GS_STUDENT-ZCODE = 'SSU01'.

  GS_STUDENT-ZKNAME = '###'.

  GS_STUDENT-ZENAME = 'KANG'.



  APPEND GS_STUDENT TO GT_STUDENT.



  MOVE GS_STUDENT TO GS_STUDENT2. "## COPY



  APPEND GS_STUDENT2 TO GT_STUDENT2.



BREAK-POINT.