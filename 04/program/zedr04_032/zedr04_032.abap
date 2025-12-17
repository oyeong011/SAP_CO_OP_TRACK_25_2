
*&---------------------------------------------------------------------*

*& Report ZEDR04_032

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_032.



" ###(## ##) ##

DATA : BEGIN OF GS_STUDENT,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 10,

  ZENAME TYPE C LENGTH 10,

  ZCLASS TYPE C,

  END OF GS_STUDENT.



DATA : BEGIN OF GS_STUDENT2,

  ZCODE(10),

  ZKNAME(10),

  ZENAME(10),

  ZCLASS,

  END OF GS_STUDENT2.



" ###### ##

DATA GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA GT_STUDENT2 LIKE TABLE OF GS_STUDENT.



" ### ### ##

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'DONG'.



" ####### ### ##

APPEND GS_STUDENT TO GT_STUDENT.



"GS_STUDENT-ZCODE = 'SSU-01'.

"GS_STUDENT-ZKNAME = '###'.

"GS_STUDENT-ZENAME = 'DONG'.

"APPEND GS_STUDENT2 TO GT_STUDENT2.



" ##1## ##2# ##

MOVE GS_STUDENT TO GS_STUDENT2.



" ##1## ##2# ##

MOVE GT_STUDENT[] TO GT_STUDENT2[].



BREAK-POINT.