
*&---------------------------------------------------------------------*

*& Report ZEDR21_013

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR21_013.




*  DATA: BEGIN OF GS_STUDENT.

*  INCLUDE TYPE ZEDT21_001.

*DATA : END OF GS_STUDENT.

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*   DATA : GV_PNAME(20) VALUE 'ZEDR21_012'.

*   DATA : GV_FORNAME(20) VALUE 'GET_DATA'.

*

*   TRANSLATE GV_PNAME TO UPPER CASE.

*   TRANSLATE GV_PNAME TO UPPER CASE.

*

*   PERFORM (GV_FORNAME) IN PROGRAM (GV_PNAME) IF FOUND CHANGING GT_STUDENT.

*

*   LOOP AT GT_STUDENT INTO GS_STUDENT.

*     WRITE :/ GS_STUDENT-ZCODE21, GS_STUDENT-ZKNAME21.

*     ENDLOOP.




    "=======================

     "LIST ### SUBROUTINE ##




*     DO 2 TIMES.

*       PERFORM SY-INDEX OF SUBR1 SUBR2.

*       ENDDO.

*       FORM SUBR1.

*         WRITE :/ SY-INDEX, '## ####'.

*       ENDFORM.

*       FORM SUBR2.

*         WRITE :/ SY-INDEX, '## ####'.

*       ENDFORM.






"==================================================

"PERFORM ON COMMIT

DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT21_001
.

  DATA : END OF GS_STUDENT.



DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA : GV_FLAG.



SELECT SINGLE * FROM ZEDT21_001

  INTO GS_STUDENT WHERE ZCODE21 = 'SSU-28'.



 PERFORM DELETE_DATA USING GS_STUDENT.

  PERFORM INSERT_DATA ON COMMIT.



  IF GV_FLAG = 'X'.

    COMMIT WORK.

  ENDIF.





  FORM DELETE_DATA USING PS_STUDENT LIKE GS_STUDENT.



    DELETE ZEDT11_001 FROM PS_STUDENT.

    IF SY-SUBRC = 0.

      GV_FLAG = 'X'.

     ENDIF.

     ENDFORM.



     FORM INSERT_DATA.

       INSERT ZEDT21_001 FROM GS_STUDENT.

       ENDFORM.