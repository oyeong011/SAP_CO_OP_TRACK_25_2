
*&---------------------------------------------------------------------*

*& Report ZEDR08_018

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR08_018.



DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT08_001
.

  DATA : END OF GS_STUDENT.



DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA : GV_FLAG.



SELECT SINGLE * FROM ZEDT08_001

  INTO GS_STUDENT WHERE ZCODE = 'SSU-08'.



PERFORM DELETE_DATA USING GS_STUDENT.

PERFORM INSERT_DATA ON COMMIT.



IF GV_FLAG = 'X'.

  COMMIT WORK.

ENDIF.






*&---------------------------------------------------------------------*

*&      Form  DELETE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_STUDENT  text

*----------------------------------------------------------------------*




FORM DELETE_DATA  USING    PS_STUDENT LIKE GS_STUDENT.



  DELETE ZEDT08_001 FROM PS_STUDENT.

  IF SY-SUBRC = 0.

    GV_FLAG = 'X'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INSERT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INSERT_DATA .



  INSERT ZEDT08_001 FROM GS_STUDENT.



ENDFORM.