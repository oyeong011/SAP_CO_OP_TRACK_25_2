
*&---------------------------------------------------------------------*

*& Report ZEDR09_030

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_030.






* =====================================================================

* >> alv layout <<



* (### ### ###)

* 1. select## ####### ##

* 2. ## #### ##

* 3. layout

* 4. call function## ##



* => ### layout ### ###

* >> ####### #### ##? - ## ## ## #####, ## ### ### <<

* - ## #### : # ## ### ## ##

* - #### : alv ## ### #### # #### ###



* => #####, ###  ####### ##### SLIS## ##, slis_layout_alv# ##



* => ## #### ### # ## 2##

* 1. alv layout - grid # # ##

* 2. alv sort - alv## #, #### ### ### ##### ##



* =====================================================================






"1) data ##

DATA : GS_FIELDCAT TYPE slis_fieldcat_alv, "######

       GT_FIELDCAT TYPE slis_t_fieldcat_alv.



DATA : GS_LAYOUT TYPE slis_layout_alv. "layout



DATA : GS_SORT TYPE slis_sortinfo_alv, "sort

       GT_SORT TYPE slis_t_sortinfo_alv.



DATA : GS_STUDENT TYPE ZEDT09_002, "#### ## #### ######

       GT_STUDENT LIKE TABLE OF GS_STUDENT.





PERFORM GET_DATA.

PERFORM ALV_DISPLAY.





"3) alv ## ## #, #### IS_LAYOUT ##

FORM GET_DATA.

  SELECT *

    FROM ZEDT09_002

    INTO TABLE GT_STUDENT.

ENDFORM.



FORM ALV_DISPLAY.

  PERFORM FIELD_CATALOG.

  PERFORM ALV_LAYOUT. "layout (##)

  PERFORM ALV_SORT. "sort (##)

  PERFORM CALL_ALV.

ENDFORM.



FORM ALV_LAYOUT. "2) #### ### ## ##

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





FORM CALL_ALV.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IT_FIELDCAT = GT_FIELDCAT

      IS_LAYOUT = GS_LAYOUT

      IT_SORT = GT_SORT

    TABLES

      T_OUTTAB = GT_STUDENT.



ENDFORM.