
*&---------------------------------------------------------------------*

*& Report ZEDR12_DBTDELETE002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_DBTDELETE002.






* 2. Several lines

*#######WHERE################

*DELETE FROM <TABLE> WHERE[COND]

* DELETE <TABLE> FROM TABLE ITAB






DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT12_001
.

  DATA: END OF GS_STUDENT.

  DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



DELETE FROM ZEDT12_001 WHERE ZTEL = '01022601111'.



CLEAR: GS_STUDENT, GT_STUDENT.

GS_STUDENT-ZCODE = 'SSU-26'.

GS_STUDENT-ZPERNR = '0000000026'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR: GS_STUDENT.

GS_STUDENT-ZCODE = 'SSU-27'.

GS_STUDENT-ZPERNR = '0000000027'.

APPEND GS_STUDENT TO GT_STUDENT.



DELETE ZEDT12_001 FROM TABLE GT_STUDENT.

  IF SY-SUBRC = 0.

    WRITE:/ '### ## ##'.

  ENDIF.