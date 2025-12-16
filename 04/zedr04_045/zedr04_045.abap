
*&---------------------------------------------------------------------*

*& Report ZEDR04_045

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_045.



DATA : BEGIN OF GS_STUDENT,

  ZPERNR LIKE ZEDT04_001-ZPERNR,  "####

  ZCODE LIKE ZEDT04_001-ZCODE,    "####

  ZKNAME LIKE ZEDT04_001-ZKNAME,  "####

  ZENAME LIKE ZEDT04_001-ZENAME,  "####

  ZGENDER LIKE ZEDT04_001-ZGENDER,"##

  ZGNAME TYPE C LENGTH 4,  "## ## (##, ##)

  ZTEL LIKE ZEDT04_001-ZTEL,      "####

  END OF GS_STUDENT.

DATA GT_STUDENT LIKE TABLE OF GS_STUDENT WITH NON-UNIQUE KEY ZCODE.   " # # ##



CLEAR : GS_STUDENT, GT_STUDENT.

GS_STUDENT-ZPERNR = '0000000001'.

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'DONG'.       " ### ###

GS_STUDENT-ZGENDER = 'F'.         " ### ###

GS_STUDENT-ZTEL = '01012345678'.

APPEND GS_STUDENT TO GT_STUDENT.



"### ## ##

GS_STUDENT-ZENAME = 'KANG'.

GS_STUDENT-ZGENDER = 'M'.




*MODIFY TABLE GT_STUDENT FROM GS_STUDENT.




MODIFY TABLE GT_STUDENT FROM GS_STUDENT TRANSPORTING ZGENDER. " ZGENDER# ##



BREAK-POINT.