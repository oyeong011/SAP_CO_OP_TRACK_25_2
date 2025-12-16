
*&---------------------------------------------------------------------*

*& Report ZEDR10_0912

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR10_0912.



" TYPE# ## STRUCTURE# #### #### FIELD# ### # ##.

DATA: BEGIN OF TY_STUDENT.

  DATA: ZGNAME TYPE C LENGTH 10.

  include structure
ZEDT10_001
.

DATA: END OF TY_STUDENT.



DATA: GS_STUDENT LIKE TY_STUDENT,

      GT_STUDENT LIKE TABLE OF GS_STUDENT,

      GT_ORI_STUDENT TYPE TABLE OF ZEDT10_001.



SELECT *

  FROM ZEDT10_001

  INTO TABLE @GT_ORI_STUDENT.



MOVE-CORRESPONDING GT_ORI_STUDENT[] TO GT_STUDENT[].



SORT GT_STUDENT BY ZCODE ZKNAME ZENAME ZGENDER.



LOOP AT GT_STUDENT INTO GS_STUDENT.

  GS_STUDENT-ZGNAME = '####'.

  AT NEW ZENAME.

    GS_STUDENT-ZGNAME = '####'.

  ENDAT.



  CLEAR GS_STUDENT.

ENDLOOP.