
*&---------------------------------------------------------------------*

*& Report ZEDR12_FUNCTIONALV003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_FUNCTIONALV003.



TABLES: ZEDT12_001.



DATA: GS_STUDENT TYPE ZEDT12_001.

DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA: GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA: GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT12_001-ZCODE.

  PARAMETERS: P_ZPERNR LIKE ZEDT12_001-ZPERNR.

  PARAMETERS: P_ZGEN LIKE ZEDT12_001-ZGENDER MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.



START-OF-SELECTION.

  PERFORM GET_DATA.

  "PERFORM MODIFY_DATA.

END-OF-SELECTION.

  PERFORM ALV_DISPLAY.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .



  PERFORM FIELD_CATALOG.

  PERFORM CALL_ALV.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG .



  CLEAR: GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV .

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

  EXPORTING

    IT_FIELDCAT = GT_FIELDCAT

  TABLES

    T_OUTTAB = GT_STUDENT.

ENDFORM.




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