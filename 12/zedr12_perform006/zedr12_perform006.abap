
*&---------------------------------------------------------------------*

*& Report ZEDR12_PERFORM006

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_PERFORM006.

DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT12_001
.

DATA: END OF GS_STUDENT.

DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA: GV_FLAG.



SELECT SINGLE * FROM ZEDT12_001

  INTO GS_STUDENT WHERE ZCODE = 'SSU-01'. "SELECT DATA



PERFORM DELETE-DATA USING GS_STUDENT. "DELETE DATA PERFORM ##

PERFORM INSERT-DATA ON COMMIT.  "PERFORM SKIP  (INSERT DATA PERFORM# COMMIT WORK## # ##)



IF GV_FLAG = 'X'.

  COMMIT WORK. "INSERT DATA PERFORM ##

ENDIF.




*&---------------------------------------------------------------------*

*&      Form  DELETE-DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_STUDENT  text

*----------------------------------------------------------------------*




FORM DELETE-DATA  USING PS_STUDENT LIKE GS_STUDENT.

  DELETE ZEDT12_001 FROM PS_STUDENT. "#####

  IF SY-SUBRC = 0.

    GV_FLAG = 'X'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INSERT-DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INSERT-DATA .

  INSERT ZEDT12_001 FROM GS_STUDENT. "### ##

ENDFORM.