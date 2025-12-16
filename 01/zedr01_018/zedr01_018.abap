
*&---------------------------------------------------------------------*

*& Report ZEDR01_018

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR01_018.

TABLES : ZEDT01_002.



DATA : GS_STUDENT TYPE ZEDT01_002.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.

DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.



DATA : GS_SORT TYPE SLIS_SORTINFO_ALV.

DATA : GT_SORT TYPE SLIS_T_SORTINFO_ALV.

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT01_002-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT01_002-ZPERNR.

SELECTION-SCREEN END OF BLOCK B1.



INITIALIZATION.

S_ZCODE-SIGN = 'I'.

S_ZCODE-OPTION = 'BT'.

S_ZCODE-LOW = 'SSU-01'.

S_ZCODE-HIGH = 'SSU-99'.

APPEND S_ZCODE.



SELECT * FROM ZEDT01_002 INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

  WHERE ZCODE IN S_ZCODE.



END-OF-SELECTION.

  PERFORM ALV_DISPLAY.






*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY .



  PERFORM FIELD_CATALOG.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM CALL_ALV.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'. "# ### ## ### ###### ###

  GS_FIELDCAT-JUST = 'L'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-JUST = 'C'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  GS_FIELDCAT-JUST = 'R'.

  GS_FIELDCAT-NO_OUT = 'X'. "## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-JUST = 'C'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSUM'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-CURRENCY = 'KRW'.  " ## KRW## ### 100 ### ###

  GS_FIELDCAT-JUST = 'R'.    " ### ##

  GS_FIELDCAT-DO_SUM = 'X'.  "##

  GS_FIELDCAT-NO_ZERO = 'X'. "0# ## ### ## #####

  GS_FIELDCAT-NO_SIGN = 'X'. "#### ## -## ## ## ##

  GS_FIELDCAT-OUTPUTLEN = 15. " ## # ##

  GS_FIELDCAT-EMPHASIZE = 'X'. " ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  GS_FIELDCAT-JUST = 'C'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-EDIT_MASK = '____-__-__'. "#### ##

  GS_FIELDCAT-OUTPUTLEN = 10.

  GS_FIELDCAT-EDIT = 'X'. "## #####

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*






FORM CALL_ALV .

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

   EXPORTING

     IT_FIELDCAT = GT_FIELDCAT

     IS_LAYOUT = GS_LAYOUT

     IT_SORT = GT_SORT

   TABLES

      T_OUTTAB   = GT_STUDENT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*






FORM ALV_LAYOUT .



  GS_LAYOUT-NO_COLHEAD = 'X'. "## ##

  GS_LAYOUT-ZEBRA = 'X'. " ### ## ###

  GS_LAYOUT-NO_VLINE = 'X'. " ### ##

  GS_LAYOUT-NO_HLINE = 'X'. " ### ##




*  GS_LAYOUT-EDIT = 'X'. " ####




  GS_LAYOUT-TOTALS_BEFORE_ITEMS = 'X'. "## ## ####

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT .



    GS_SORT-SPOS = 1.

    GS_SORT-FIELDNAME = 'ZCODE'.




*    GS_SORT-UP = 'X'. "##




    GS_SORT-DOWN = 'X'.

    GS_SORT-SUBTOT = 'X'.

    APPEND GS_SORT TO GT_SORT.



ENDFORM.