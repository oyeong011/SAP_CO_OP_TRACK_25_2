
*&---------------------------------------------------------------------*

*& Report ZEDR09_022_2

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_022_2.





DATA : GS_STUDENT LIKE ZEDT09_001,

       GT_STUDENT LIKE TABLE OF GS_STUDENT,

       GV_FLAG TYPE C LENGTH 1.



"select data

SELECT SINGLE *

  FROM ZEDT09_001

  INTO GS_STUDENT

  WHERE ZCODE = 'SSU-01'.



"ssu-01# #### ### ##

PERFORM DELETE_DATA USING GS_STUDENT.



"commit ## ### pass!

PERFORM INSERT_DATA ON COMMIT.



IF GV_FLAG = 'X'.

  COMMIT WORK.     "insert_data ####!

ENDIF.



FORM DELETE_DATA  USING    P_GS_STUDENT STRUCTURE GS_STUDENT.



  DELETE ZEDT09_001 FROM P_GS_STUDENT.



  IF sy-subrc = 0.

    GV_FLAG = 'X'.

  ENDIF.



ENDFORM.



FORM INSERT_DATA .

  INSERT INTO ZEDT09_001 VALUES GS_STUDENT.

ENDFORM.