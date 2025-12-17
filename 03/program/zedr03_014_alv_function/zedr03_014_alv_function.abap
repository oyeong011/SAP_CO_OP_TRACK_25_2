
*&---------------------------------------------------------------------*

*& Report ZEDR03_014_ALV_FUNCTION

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_014_ALV_FUNCTION.



TABLES : ZEDT00_001.



DATA : GS_STUDENT TYPE ZEDT00_001.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : GS_FIELDCAT TYPE slis_fieldcat_alv.

DATA : GT_FIELDCAT TYPE slis_t_fieldcat_alv.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT00_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT00_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT00_001-ZGENDER MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.



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




*  PERFORM MODIFY_DATA.






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

  SELECT * FROM ZEDT00_001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.

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

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-JUST = 'L'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-JUST = 'C'.

    GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  GS_FIELDCAT-JUST = 'R'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

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