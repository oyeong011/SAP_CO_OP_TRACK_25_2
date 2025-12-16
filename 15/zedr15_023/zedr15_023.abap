
*&---------------------------------------------------------------------*

*& Report ZEDR15_023

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR15_023.



TABLES : ZEDT15_001.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT15_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT15_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT15_001-ZGENDER MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.



DATA : GS_STUDENT TYPE ZEDT15_001.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV. "SLIS TYPE GROUP## ### TYPE

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



INITIALIZATION.

S_ZCODE-LOW = 'SSU-01'.

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

  PERFORM MODIFY_DATA.

END-OF-SELECTION.

  PERFORM ALV_DISPLAY.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT * FROM ZEDT15_001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA .



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .

  "1) ALV_LIST




*  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'

*    EXPORTING

*      I_STRUCTURE_NAME = 'ZEDT15_001' "Internal output table structure name

*    TABLES

*      T_OUTTAB = GT_STUDENT. "Table with data to be displayed




  "2)ALV-GRID




*  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

*    EXPORTING

*      I_STRUCTURE_NAME = 'ZEDT15_001' "Internal output table structure name

*    TABLES

*      T_OUTTAB = GT_STUDENT. "Table with data to be displayed




  "3) ## ####

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

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1. "## ##

  GS_FIELDCAT-FIELDNAME = 'ZCODE'. "#### ITAB### #### #

  GS_FIELDCAT-SELTEXT_M = '####'. "##TEXT

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

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

    IT_FIELDCAT = GT_FIELDCAT "Field catalog with field descriptions

  TABLES

    T_OUTTAB = GT_STUDENT.



ENDFORM.