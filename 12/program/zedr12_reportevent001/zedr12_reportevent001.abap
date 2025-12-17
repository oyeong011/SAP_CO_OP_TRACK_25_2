
*&---------------------------------------------------------------------*

*& Report ZEDR12_REPORTEVENT001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_REPORTEVENT001.

TABLES: ZEDT12_001.



DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT12_001
.

DATA: END OF GS_STUDENT.

DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS: S_ZCODE FOR ZEDT12_001-ZCODE.

  PARAMETERS: P_ZPERNR LIKE ZEDT12_001-ZPERNR.

  PARAMETERS: P_ZGEN LIKE ZEDT12_001-ZGENDER DEFAULT 'M' MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.



INITIALIZATION.

S_ZCODE-LOW = 'SSU-02'.

S_ZCODE-HIGH = 'SSU-99'.

APPEND S_ZCODE.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'SC1'.

      SCREEN-INPUT = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



START-OF-SELECTION.

  PERFORM GET_DATA.

  "PERFORM MODIFY_DATA.

END-OF-SELECTION.

PERFORM WRITE_DATA.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT * FROM ZEDT12_001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM WRITE_DATA .

  LOOP AT GT_STUDENT INTO GS_STUDENT.

    WRITE:/ GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

  ENDLOOP.

ENDFORM.