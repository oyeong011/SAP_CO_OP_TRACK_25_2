
*&---------------------------------------------------------------------*

*& Report ZEDR09_028_2

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_028_2.



TABLES : ZEDT09_001.



"#### ## #### ######

DATA : GS_STUDENT LIKE ZEDT09_001,

       GT_STUDENT LIKE TABLE OF GS_STUDENT.



"######

DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



"####

DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.



"##

DATA : GS_SORT TYPE SLIS_SORTINFO_ALV,

       GT_SORT TYPE SLIS_T_SORTINFO_ALV.



SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT09_001-ZCODE.

  PARAMETERS : P_ZGEN LIKE ZEDT09_001-ZGENDER MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK b1.



INITIALIZATION.

  S_ZCODE-LOW = 'SSU-01'.

  S_ZCODE-HIGH = 'SSU-99'.

  APPEND S_ZCODE.



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



"get_data

FORM GET_DATA.

  SELECT *

    FROM ZEDT09_001

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE IN S_ZCODE.

ENDFORM.



"modify_data

FORM MODIFY_DATA.

  UPDATE ZEDT09_001 SET ZENAME = 'LEE'

    WHERE ZCODE = 'SSU-01'.

ENDFORM.



"alv_display

FORM ALV_DISPLAY.

  PERFORM FIELD_CATALOG.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.      "## ## ##

  PERFORM CALL_ALV.

ENDFORM.



FORM FIELD_CATALOG.

  "###### ####

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.         "col_pos : ### output ##

  GS_FIELDCAT-FIELDNAME = 'ZCODE'. "fieldname : ####### ## ## **#, alv###, ####### #### ####!

  GS_FIELDCAT-SELTEXT_M = '####'. "seltext_m : ### ###

  GS_FIELDCAT-KEY = 'X'.            "key : ### ##

  GS_FIELDCAT-JUST = 'L'.           "## L ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-JUST = 'C'.           "## C : center

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  GS_FIELDCAT-JUST      = 'R'.      "## R : Right

  GS_FIELDCAT-NO_OUT    = 'X'.      "## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSUM'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-CURRENCY = 'KRW'.     "## 100# ### ### alv######## currency# ##### #

  GS_FIELDCAT-DO_SUM   = 'X'.       "alv## ## ##### ## ## ####

  GS_FIELDCAT-OUTPUTLEN = 20.       "### # ##

  GS_FIELDCAT-EMPHASIZE = 'X'.      "## ##

  GS_FIELDCAT-EDIT      = 'X'.       "####

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZWARES'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  GS_FIELDCAT-EDIT_MASK = '____-__-__'. "## ### ### ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.



FORM ALV_LAYOUT.

  GS_LAYOUT-NO_COLHEAD = 'X'.   "## ## ## - #### | #### | ### | #### | ## | ###

  GS_LAYOUT-ZEBRA = 'X'.        "###### ### ## ##

  GS_LAYOUT-NO_VLINE = 'X'.     "GRID# #### ### ## ##

  GS_LAYOUT-NO_HLINE = 'X'.     "GRID# #### ### ## ##

  GS_LAYOUT-EDIT     = 'X'.     "## ## -> ## ## ###### ### ##, ######## ###### ### ###### ## ### ##

  GS_LAYOUT-TOTALS_BEFORE_ITEMS = 'X'. "##### # # ### ## (#### ### ### ## #?)

ENDFORM.



FORM ALV_SORT.

  GS_SORT-SPOS = 1.             "spos : #### ##

  GS_SORT-FIELDNAME = 'ZCODE'.  "fieldname : ### ### ### ##

 " GS_SORT-UP = 'X'.             "up : #### ##

  GS_SORT-DOWN = 'X'.            "down : #### ##

  GS_SORT-SUBTOT = 'X'.           "subtot : (subtotal) ## ##

  APPEND GS_SORT TO GT_SORT.

ENDFORM.



FORM CALL_ALV.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IT_FIELDCAT = GT_FIELDCAT

      IS_LAYOUT = GS_LAYOUT

      IT_SORT = GT_SORT        "alv ## ###, IT_SORT ##

    TABLES

      T_OUTTAB = GT_STUDENT.

ENDFORM.