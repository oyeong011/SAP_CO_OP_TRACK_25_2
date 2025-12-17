
*&---------------------------------------------------------------------*

*& Report ZEDR23_013

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR23_013.

BREAK-POINT.

DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT23_001
.

  DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA : ZFLAG TYPE C LENGTH 1.



GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = 'JENNY'.

APPEND GS_STUDENT TO GT_STUDENT.



PERFORM DELETE_DATA(ZEDR23_012)

IF FOUND USING GS_STUDENT GT_STUDENT ZFLAG.



GS_STUDENT-ZCODE = 'SSU-02'.

GS_STUDENT-ZKNAME = 'JISOO'.

PERFORM INSERT_DATA(ZEDR23_012)

IF FOUND USING GS_STUDENT GT_STUDENT.



PERFORM PRINT_DATA ON COMMIT.



IF ZFLAG EQ 'X'.

  COMMIT WORK.

ENDIF.



FORM PRINT_DATA.

  LOOP AT GT_STUDENT INTO DATA(line).

  WRITE : / line-ZCODE, line-ZKNAME.

ENDLOOP.

ENDFORM.