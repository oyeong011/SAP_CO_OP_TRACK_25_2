
*&---------------------------------------------------------------------*

*& Report ZEDR03_011_PERFORM

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_011_PERFORM.



DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT03_001
.

 DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA :GV_FLAG.



SELECT SINGLE * FROM ZEDT03_001

  INTO GS_STUDENT WHERE ZCODE = 'SSU-03'.





PERFORM DELETE_DATA CHANGING GS_STUDENT.

PERFORM INSERT_DATA ON COMMIT.



IF GV_FLAG = 'X'.

 COMMIT WORK.

ENDIF.





FORM DELETE_DATA CHANGING PS_STUDENT LIKE GS_STUDENT.



  DELETE ZEDT03_001 FROM PS_STUDENT.

  IF SY-SUBRC = 0.

    GV_FLAG = 'X'.

  ENDIF.

ENDFORM.





FORM INSERT_DATA .

  INSERT ZEDT03_001 FROM GS_STUDENT.

ENDFORM.