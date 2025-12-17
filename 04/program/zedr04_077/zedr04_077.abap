
*&---------------------------------------------------------------------*

*& Report ZEDR04_077

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_077.



TABLES : ZEDT04_002.  " SELECT-OPTIONS# #### ##



DATA GS_STUDENT TYPE ZEDT04_002.

DATA GT_STUDENT LIKE TABLE OF GS_STUDENT.



" ## ####. FUNCTION 'REUSE_ALV_GRID_DISPLAY'## ###

DATA GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



" ALV ####

DATA GS_LAYOUT TYPE SLIS_LAYOUT_ALV.



" ALV SORT ### ##

DATA GS_SORT TYPE SLIS_SORTINFO_ALV.

DATA GT_SORT TYPE SLIS_T_SORTINFO_ALV.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT04_002-ZCODE.    " ## ## #### SELECT-OPTIONS#

SELECTION-SCREEN END OF BLOCK B1.





INITIALIZATION. " ### ##. START-OF-SELECTION ### ##.

  S_ZCODE-LOW = 'SSU-01'.

  S_ZCODE-HIGH = 'SSU-99'.

  APPEND S_ZCODE.



START-OF-SELECTION. " ### F8 ### SELECT## #### ##

  PERFORM GET_DATA.

END-OF-SELECTION. " ### F8 ### SELECT## #### ### #

  PERFORM ALV_DISPLAY.





" SUBROUTINE ##






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .

  SELECT * FROM ZEDT04_002

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.

ENDFORM.






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

  GS_FIELDCAT-seltext_m = '####'.

  GS_FIELDCAT-KEY = 'X'.  " ###. ## ##. #### # ##.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-seltext_m = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-seltext_m = '##'.

  GS_FIELDCAT-NO_OUT = 'X'.     " ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

  GS_FIELDCAT-seltext_m = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSUM'.

  GS_FIELDCAT-seltext_m = '####'.

  GS_FIELDCAT-CURRENCY = 'KRW'.   " ### ##

  GS_FIELDCAT-JUST = 'R'.         " '####' ## ### ##

  GS_FIELDCAT-DO_SUM = 'X'.       " ## ##. ## ### ### ###.

  GS_FIELDCAT-NO_ZERO = 'X'.      " 0# ## ##.

  GS_FIELDCAT-NO_SIGN = 'X'.      " #### ## ##. #, ### ### ###.

  GS_FIELDCAT-EMPHASIZE = 'X'.    " ##### # ##




*  GS_FIELDCAT-EDIT = 'X'.         " #### ## ##




  GS_FIELDCAT-OUTPUTLEN = 15.           " # ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-seltext_m = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

  GS_FIELDCAT-seltext_m = '###'.

  GS_FIELDCAT-EDIT_MASK = '____-__-__'.   " ### ## ##

  GS_FIELDCAT-OUTPUTLEN = 15.           " # ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .




*  GS_LAYOUT-NO_COLHEAD = 'X'.     " ## ## ##




  GS_LAYOUT-ZEBRA = 'X'.          " ## ## # ### ##




*  GS_LAYOUT-NO_VLINE = 'X'.       " ### ##

*  GS_LAYOUT-NO_HLINE = 'X'.       " ### ##

*  GS_LAYOUT-EDIT = 'X'.           " ## ## ##




  GS_LAYOUT-TOTALS_BEFORE_ITEMS = 'X'.  " ### # ##

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT .

  GS_SORT-SPOS = 1.             " ## ## (## ####?)

  GS_SORT-FIELDNAME = 'ZCODE'.

  GS_SORT-UP = 'X'.             " ####




*  GS_SORT-DOWN = 'X'.           " ####

*  GS_SORT-SUBTOT = 'X'.         " # #### ## ## ##




  APPEND GS_SORT TO GT_SORT.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*




FORM CALL_ALV .



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IT_FIELDCAT                       = GT_FIELDCAT   " ### ## ## #### ##

      IS_LAYOUT                         = GS_LAYOUT     " ALV #### ##

      IT_SORT                           = GT_SORT       " ALV SORT ## ##

    TABLES

      T_OUTTAB                          = GT_STUDENT.



ENDFORM.