
*&---------------------------------------------------------------------*

*& Report ZEDR09_005_2

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_005_2.






* 1) #### '##' ###### ##




DATA : GT_STUDENT TYPE ZTT_STUDENT.

DATA : GS_STUDENT LIKE LINE OF GT_STUDENT.



GS_STUDENT-ZCODE = 'ssu-09'.

GS_STUDENT-ZPERNR = '0000000009'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'KIM'.

GS_STUDENT-ZGENDER = 'F'.



APPEND GS_STUDENT TO GT_STUDENT.










* 2) #### '##' ###### ##




DATA : GT_STUDENT_WITH_HEADER TYPE ZEDT09_001 OCCURS 0 WITH HEADER LINE.



GT_STUDENT_WITH_HEADER-ZCODE = 'ssu-09'.

GT_STUDENT_WITH_HEADER-ZPERNR = '0000000009'.

GT_STUDENT_WITH_HEADER-ZKNAME = '###'.

GT_STUDENT_WITH_HEADER-ZENAME = 'KIM'.

GT_STUDENT_WITH_HEADER-ZGENDER = 'F'.



" APPEND GT_STUDENT_WITH_HEADER TO GT_STUDENT_WITH_HEADER.

APPEND GT_STUDENT_WITH_HEADER.