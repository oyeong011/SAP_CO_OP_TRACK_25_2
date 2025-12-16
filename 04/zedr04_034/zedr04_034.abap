
*&---------------------------------------------------------------------*

*& Report ZEDR04_034

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_034.



" #### ### ### ### ##

DATA : BEGIN OF GT_STUDENT OCCURS 0,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 10,

  ZENAME TYPE C LENGTH 10,

  END OF GT_STUDENT.



DATA : BEGIN OF GT_STUDENT2 OCCURS 0,

  ZCLASS TYPE C,

  ZCODE(10),

  ZKNAME(10),

  ZENAME(10),

  END OF GT_STUDENT2.



" ### ### ##

GT_STUDENT-ZCODE = 'SSU-01'.

GT_STUDENT-ZKNAME = '###'.

GT_STUDENT-ZENAME = 'DONG'.



" ####### ### ##

APPEND GT_STUDENT.



" ##1## ##2# ##

"MOVE-CORRESPONDING GT_STUDENT TO GT_STUDENT2.



" ##1## ##2# ##

MOVE-CORRESPONDING GT_STUDENT[] TO GT_STUDENT2[].



BREAK-POINT.