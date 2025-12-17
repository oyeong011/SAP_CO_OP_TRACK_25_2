
*&---------------------------------------------------------------------*

*& Report ZEDR04_060

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_060.



DATA GS_STUDENT TYPE ZEDT04_001.

DATA GT_STUDENT LIKE TABLE OF GS_STUDENT.



" 1. SINGLE LINE ##

GS_STUDENT-ZCODE = 'SSU-29'.

GS_STUDENT-ZPERNR = '0000000029'.



DELETE ZEDT04_001 FROM GS_STUDENT.



IF SY-SUBRC = 0.

  WRITE / '##'.

ELSE.

  WRITE / '##'.

ENDIF.



" 2. SEVERAL LINES ##

CLEAR : GS_STUDENT, GT_STUDENT.

GS_STUDENT-ZCODE = 'SSU-28'.

GS_STUDENT-ZPERNR = '0000000028'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZCODE = 'SSU-27'.

GS_STUDENT-ZPERNR = '0000000027'.

APPEND GS_STUDENT TO GT_STUDENT.



DELETE ZEDT04_001 FROM TABLE GT_STUDENT.



IF SY-SUBRC = 0.

  WRITE / '##'.

ELSE.

  WRITE / '##'.

ENDIF.



" 2-1. DELETE WHERE

DELETE FROM ZEDT04_001 WHERE ZTEL = '212-6666-6666'.



IF SY-SUBRC = 0.

  WRITE / '##'.

ELSE.

  WRITE / '##'.

ENDIF.