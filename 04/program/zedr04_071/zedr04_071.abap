
*&---------------------------------------------------------------------*

*& Report ZEDR04_071

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_071.



DATA GS_STUDENT TYPE ZEDT04_001.

DATA GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA GV_FLAG.



SELECT SINGLE * FROM ZEDT04_001

  INTO GS_STUDENT

  WHERE ZCODE = 'SSU-01'.



PERFORM DELETE_DATA USING GS_STUDENT.

PERFORM INSERT_DATA ON COMMIT.  " INSERT_DATA ####



IF GV_FLAG = 'X'.

  COMMIT WORK.  " INSERT_DATA ##

ENDIF.






*&---------------------------------------------------------------------*

*&      Form  DELETE_DATA

*&---------------------------------------------------------------------*




FORM DELETE_DATA  USING    PS_STUDENT LIKE GS_STUDENT.

  DELETE ZEDT04_001 FROM PS_STUDENT.

  IF SY-SUBRC = 0.

    GV_FLAG = 'X'.

    WRITE : / PS_STUDENT-ZCODE, '## ##'.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  INSERT_DATA

*&---------------------------------------------------------------------*




FORM INSERT_DATA .

  INSERT ZEDT04_001 FROM GS_STUDENT.

  IF SY-SUBRC = 0.

    WRITE : / GS_STUDENT-ZCODE, '## ##'.

  ENDIF.

ENDFORM.