
*&---------------------------------------------------------------------*

*& Report ZEDR04_033

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_033.



" #### ### ### ### ##

DATA : BEGIN OF GT_STUDENT OCCURS 0,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 10,

  ZENAME TYPE C LENGTH 10,

  ZCLASS TYPE C,

  END OF GT_STUDENT.



DATA : BEGIN OF GT_STUDENT2 OCCURS 0,

  ZCODE(10),

  ZKNAME(10),

  ZENAME(10),

  ZCLASS,

  END OF GT_STUDENT2.



" ### ### ##

GT_STUDENT-ZCODE = 'SSU-01'.

GT_STUDENT-ZKNAME = '###'.

GT_STUDENT-ZENAME = 'DONG'.



" ####### ### ##

APPEND GT_STUDENT.



" ##1## ##2# ##

"MOVE GT_STUDENT TO GT_STUDENT2.



" ##1## ##2# ##

MOVE GT_STUDENT[] TO GT_STUDENT2[].



BREAK-POINT.