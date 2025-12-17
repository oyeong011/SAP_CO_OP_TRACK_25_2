
*&---------------------------------------------------------------------*

*& Report ZEDR20_021

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_021.



TABLES: ZEDT20_002.



DATA: BEGIN OF GS_STUDENT.

  include structure
ZEDT20_002
.

  DATA: END OF GS_STUDENT.

DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA: GT_FIELDCAT TYPE slis_t_fieldcat_alv.

DATA: GS_FIELDCAT TYPE slis_fieldcat_alv.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS: S_ZCODE FOR ZEDT20_002-ZCODE.

  PARAMETERS: P_ZPERNR LIKE ZEDT20_002-ZPERNR.

SELECTION-SCREEN END OF BLOCK B1.



INITIALIZATION.

  S_ZCODE-LOW = 'SSU-01'.

  S_ZCODE-HIGH = 'SSU-99'.

  APPEND S_ZCODE.



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




FORM GET_DATA.

  IF S_ZCODE IS INITIAL.

    WRITE:/ '#### ######.'.

  ENDIF.

  SELECT *

    FROM ZEDT20_002

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




*  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'

*  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

*   EXPORTING

*     I_STRUCTURE_NAME = 'ZEDT20_001'

*    TABLES

*      T_OUTTAB = GT_STUDENT.




  PERFORM FIELD_CATALOG.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

   EXPORTING

     IT_FIELDCAT = GT_FIELDCAT

    TABLES

      T_OUTTAB = GT_STUDENT.

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

  CLEAR: GT_FIELDCAT, GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-JUST = 'L'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-JUST = 'R'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  GS_FIELDCAT-NO_OUT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-JUST = 'L'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSUM'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-CURRENCY = 'KRW'.

  GS_FIELDCAT-JUST = 'R'.

  GS_FIELDCAT-NO_ZERO = 'X'.

  GS_FIELDCAT-NO_SIGN = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 11.

  GS_FIELDCAT-EDIT_MASK = '____-__-__'.

  GS_FIELDCAT-NO_CONVEXT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.