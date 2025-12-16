
*&---------------------------------------------------------------------*

*& Report ZEDR12_DBTUPDATE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_DBTUPDATE001.




*

**"1.SINGLE LINE

**#### ### ### ##, WA# #### UPDATE ## #### WA# #### ## ### ######.

*UPDATE <TABLE> FROM WA






DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT12_001
.

  DATA: END OF GS_STUDENT.

DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



GS_STUDENT-ZCODE = 'SSU-12'.

GS_STUDENT-ZPERNR = '0000000012'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'JAE'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01000002222'.



UPDATE ZEDT12_001 FROM GS_STUDENT.



IF SY-SUBRC = 0.

  WRITE:/ '### ## ##'.

ENDIF.