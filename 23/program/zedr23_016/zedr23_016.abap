
*&---------------------------------------------------------------------*

*& Report ZEDR23_016

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR23_016.



TABLES : ZEDT23_001.



DATA : GS_STUDENT TYPE ZEDT23_001.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT23_001-ZCODE.

SELECTION-SCREEN END OF BLOCK B1.



INITIALIZATION.



START-OF-SELECTION.

  PERFORM GET_DATA.



END-OF-SELECTION.

  PERFORM ALV_DISPLAY.



FORM ALV_DISPLAY.

  PERFORM FIELD_CATALOG.

  PERFORM CALL_ALV.

ENDFORM.



FORM GET_DATA.

  SELECT * FROM ZEDT23_001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.

ENDFORM.



FORM CALL_ALV.

  "## ### Structure ### # ## field catalog #### #### #.

  " ALV_LIST ## ALV_GRID # ## #

  "CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'

  "EXPORTING

  "  IT_FIELDCAT                    = GT_FIELDCAT

  "TABLES

  "  T_OUTTAB                       = GT_STUDENT.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

   EXPORTING

     IT_FIELDCAT                       = GT_FIELDCAT

    TABLES

      T_OUTTAB                          = GT_STUDENT.



ENDFORM.



FORM FIELD_CATALOG.

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.  " ## ##

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.  "## ## ### ## ### #

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.  " ## ##

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.  "## ## ### ## ### #

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.  " ## ##

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.  "## ## ### ## ### #

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "GS_FIELDCAT-CURRENCY = 'KRW'.    "## ### ##

  "GS_FIELDCAT-KEY = 'X'.    "### # ### ##

  "GS_FIELDCAT-JUST = 'L'.    "## ## L, C, R

  "GS_FIELDCAT-DO_SUM = 'X'.    "## ##

  "GS_FIELDCAT-NO_ZERO = 'X'.    "0## # ### ##

  "GS_FIELDCAT-NO_SIGN = 'X'.    "## # ## ##

  "GS_FIELDCAT-OUTPUTLEN = 'X'.    "# ##

  "GS_FIELDCAT-EMPHASIZE = 'X'.    "# ##

  "GS_FIELDCAT-NO_OUT = 'X'.    "## ##

  "GS_FIELDCAT-EDIT_MASK = '____-__-__'.    "### ## ##

  "GS_FIELDCAT-EDIT = 'X'.    "## ## on



ENDFORM.