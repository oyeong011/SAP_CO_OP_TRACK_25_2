
*&---------------------------------------------------------------------*

*& Report ZEDR20_018

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_018.



DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT20_001
.

  DATA: END OF GS_STUDENT.

  DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.




*DATA: GV_ZCODE  LIKE ZEDT20_001-ZCODE VALUE 'SSU-02'.

*DATA: GV_ZKNAME  LIKE ZEDT20_001-ZKNAME.

*DATA: GV_PNAME(20) VALUE 'ZEDR20_000'.

*DATA: GV_FORMNAME(20) VALUE 'GET_DATA'.

*

*

*

*TRANSLATE GV_PNAME TO UPPER CASE.

*TRANSLATE GV_FORMNAME TO UPPER CASE.

*

*PERFORM (GV_FORMNAME) IN PROGRAM (GV_PNAME) IF FOUND CHANGING GT_STUDENT.

*

**  PERFORM GET_DATA USING GV_ZCODE

**                   CHANGING GV_ZKNAME.

*  PERFORM GET_DATA CHANGING GT_STUDENT. " GS_STUDENT.

*

*  WRITE: / GV_ZCODE.

*  WRITE: / GV_ZKNAME.

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

**FORM GET_DATA USING P_ZCODE LIKE ZEDT20_001-ZCODE

**                    CHANGING VALUE(P_ZKNAME).

**FORM GET_DATA USING PS_STUDNET STRUCTURE GS_STUDENT

**                    PT_STUDENT LIKE GT_STUDENT.

*FORM GET_DATA CHANGING PT_STUDENT LIKE GT_STUDENT." TYPE STANDARD TABLE.

*

*  DATA: LS_STUDENT LIKE GS_STUDENT.

*  " PS_STUDENT-ZCODE = 'SSU-01'.

*  " DATA: LV_ZCODE LIKE ZEDT20_001-ZCODE VALUE 'SSU-01'.

*  SELECT SINGLE ZKNAME FROM ZEDT20_001

*    INTO LS_STUDENT-ZKNAME "P_ZKNAME

*    WHERE ZCODE = LS_STUDENT-ZCODE.

*  APPEND LS_STUDENT TO PT_STUDENT.

*

*  LS_STUDENT-ZCODE = 'SSU-02'.

*  SELECT SINGLE ZKNAME FROM ZEDT20_001

*    INTO LS_STUDENT-ZKNAME "P_ZKNAME

*    WHERE ZCODE = LS_STUDENT-ZCODE.

*  APPEND LS_STUDENT TO PT_STUDENT.

*  "P_ZKNAME = 'TEST'.

*  WRITE:/ 'PERFORM TEST'.

*ENDFORM.






  DATA: GV_FLAG.



SELECT SINGLE * FROM ZEDT20_001

  INTO GS_STUDENT WHERE ZCODE = 'SSU-01'.

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




FORM DELETE_DATA  USING    PS_STUDENT.

  DELETE ZEDT20_001 FROM PS_STUDENT.

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

  INSERT ZEDT20_001 FROM GS_STUDENT.

ENDFORM.