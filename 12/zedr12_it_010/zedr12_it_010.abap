
*&---------------------------------------------------------------------*

*& Report ZEDR12_IT_10

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_IT_010.

DATA: BEGIN OF GS_STUDENT,

  ZCODE(10) TYPE C,

  ZKNAME(10) TYPE C,

  ZENAME(10) TYPE C,

  END OF GS_STUDENT.



  DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.  "LIKE TABLE OF



  GS_STUDENT-ZCODE = 'SSU-02'.

  GS_STUDENT-ZKNAME = '###'.

  GS_STUDENT-ZENAME = 'LEE'.

  APPEND GS_STUDENT TO GT_STUDENT.



  GS_STUDENT-ZCODE = 'SSU-01'.

  GS_STUDENT-ZKNAME = '###'.

  GS_STUDENT-ZENAME = 'KANG'.

  APPEND GS_STUDENT TO GT_STUDENT.



  GS_STUDENT-ZCODE = 'SSU-03'.

  GS_STUDENT-ZKNAME = '###'.

  GS_STUDENT-ZENAME = 'SONG'.

  APPEND GS_STUDENT TO GT_STUDENT.

  BREAK-POINT.



  SORT GT_STUDENT. "##

  "SORT GT_STUDENT ASCENDING. " #### ## SSU-01,02,03

  "SORT GT_STUDENT DECENDING. " #### ## SSU-03,02,01

  "SORT GT_STUDENT BY ZKNAME. " ZKNAME## ASCENDING #### ##(#,#,#,#,#,#,#)

  "SORT GT_STUDENT BY ZKNAME BY DESCENDING. " ZKNAME## DECENDING #### ##

  "SORT GT_STUDENT BY ZKNAME ZCODE BY DESCENDING. " ZKNAME, ZCODE## DECENDING #### ##



  BREAK-POINT.