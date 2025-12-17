
*&---------------------------------------------------------------------*

*& Report ZEDR09_029

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_029.






* =====================================================================

* >> ### ## ## # ## ## <<



* "#, ALV ### ####.."

* 1) select# ## itab# ### ##

* 2) ## ##### ## ### #### ## (## #### ##)

* 3) ###### alv## # ##

* 4) #### call function## grid ##



* ### ## ## ##### ### ##



* SLIS# SAP## ALV ##### ## #### "## ##(=## #)"##,

* # ##, SLIS_T_FIELDCAT_ALV # ## ## ##(=##)## ####.

* ### ## ### ##, ## #### #### ## ## # ##!



* => ## ### ## ###, ## #### ### ## ##!

* se11## type group## SLIS #### ##### !



* =====================================================================






DATA : GS_STUDENT LIKE ZEDT09_002.

DATA : GT_STUDENT LIKE TABLE OF ZEDT09_002.



"SLIS ####

DATA : GS_FIELDCAT TYPE slis_fieldcat_alv.

DATA : GT_FIELDCAT TYPE slis_t_fieldcat_alv.



PERFORM GET_DATA.

PERFORM ALV_DISPLAY.



FORM GET_DATA.

  SELECT *

    FROM ZEDT09_002

    INTO TABLE GT_STUDENT.

ENDFORM.





FORM ALV_DISPLAY.

  PERFORM FIELD_CATALOG. "######

  PERFORM CALL_ALV. "###### #### alv ##



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

  "####### ### alv function ##

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

     EXPORTING

       IT_FIELDCAT = GT_FIELDCAT

     TABLES

       T_OUTTAB = GT_STUDENT.

ENDFORM.