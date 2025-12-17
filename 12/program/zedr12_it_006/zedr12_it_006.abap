
*&---------------------------------------------------------------------*

*& Report ZEDR12_IT_6

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_IT_006.

DATA: BEGIN OF GS_STUDENT,

  ZCODE(10) TYPE C,

  ZKNAME(10) TYPE C,

  ZENAME(10) TYPE C,



  END OF GS_STUDENT.



  DATA: BEGIN OF GS_STUDENT2,

   ZCLASS TYPE C,

  ZCODE(10) TYPE C,

  ZKNAME(10) TYPE C,

  ZENAME(10) TYPE C,



    END OF GS_STUDENT2.



  DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.

  DATA: GT_STUDENT2 LIKE TABLE OF GS_STUDENT2.



  GS_STUDENT-ZCODE = 'SSU01'.

  GS_STUDENT-ZKNAME = '###'.

  GS_STUDENT-ZENAME = 'KANG'.



  APPEND GS_STUDENT TO GT_STUDENT.



  "MOVE GT_STUDENT[] TO GT_STUDENT2[]. "GT-STUDENT[] # GT_STUDENT2[]# ## ### ##. ### ## ### ####.

  MOVE-CORRESPONDING GT_STUDENT[] TO GT_STUDENT2[]. "MOVE-CORRESPONDING# # ### ####.



  BREAK-POINT.