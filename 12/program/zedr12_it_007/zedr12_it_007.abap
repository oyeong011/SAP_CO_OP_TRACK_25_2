
*&---------------------------------------------------------------------*

*& Report ZEDR12_IT_7

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_IT_007.



DATA: BEGIN OF GT_STUDENT OCCURS 0,   "###### ##

  ZCODE(10) TYPE C,

  ZKNAME(10) TYPE C,

  ZENAME(10) TYPE C,

  END OF GT_STUDENT.



  DATA: BEGIN OF GT_STUDENT2 OCCURS 0,

    ZCLASS TYPE C,

  ZCODE(10) TYPE C,

  ZKNAME(10) TYPE C,

  ZENAME(10) TYPE C,

  END OF GT_STUDENT2.



  GT_STUDENT-ZCODE = 'SSU01'.

  GT_STUDENT-ZKNAME = '###'.

  GT_STUDENT-ZENAME = 'KANG'.



  APPEND GT_STUDENT.



  "MOVE GT_STUDENT TO GT_STUDENT2. "## COPY, ### ##

  "APPEND GT_STUDENT.  "BODY# ## ## APPEND



  MOVE-CORRESPONDING GT_STUDENT[] TO GT_STUDENT2[]. "BODY COPY



  BREAK-POINT.