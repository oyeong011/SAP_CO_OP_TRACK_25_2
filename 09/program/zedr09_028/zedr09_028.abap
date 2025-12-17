
*&---------------------------------------------------------------------*

*& Report ZEDR09_028

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_028.






* =====================================================================

* ALV (ABAP List Viewer) : WRITE ## ### ##### ### #### ##### #

* - ## 2##

*  1. Function ALV **

*  2. ###, ABAP Object (### ##)

*  ## 1# ## ####(###, ###..)# #### ### # ## 2# ### ## ###



* - Function ALV

*    - REUSE_ALV_LIST_DISPLAY, REUSE_ALV_GRID_DISPLAY ### ###, ALV #### ##

*    - 2# #### ## ##, ### ## ###### ## ## ## ##



* =====================================================================








DATA : GS_STUDENT LIKE ZEDT09_001.

DATA : GT_STUDENT LIKE TABLE OF ZEDT09_001.



"SELECT# ## itab# ### ##

SELECT *

  FROM ZEDT09_001

  INTO TABLE GT_STUDENT.



"### Function ALV ## - list##

" PERFORM ALV_DISPLAY_LIST.



"### Function ALV ## - grid ##

" PERFORM ALV_DISPLAY_GRID.



"## ##### #### alv ##

PERFORM ALV_DISPLAY_FIELDCAT.





"## ####(IT_FIELDCAT)# ## # ###,

"I_STRUCTURE_NAME# ABAP Dictionary ##(## ###) ### ##,

" ALV# # ### #######, ##, ### ### ## ##### ## ##



" T_OUTTAB## ALV# ### ## #### #### ## #### ###.

FORM ALV_DISPLAY_LIST .

  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'

    EXPORTING

      I_STRUCTURE_NAME = 'ZEDT09_001'

    TABLES

      T_OUTTAB = GT_STUDENT

    .



ENDFORM.



" #### List ####, #### #### #### ## ## << ## function ### #### ## ## ##

FORM ALV_DISPLAY_GRID.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      I_STRUCTURE_NAME = 'ZEDT09_001'

    TABLES

      T_OUTTAB = GT_STUDENT.



ENDFORM.






* =====================================================================

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






"SLIS ## ## begin of slis_fieldcat_alv ~ end of slis_fieldcat_alv# #### ### ##

"SLIS ## ## ### slis_t_fieldcat_alv ### ####, ## ##### ###### ##

DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



FORM ALV_DISPLAY_FIELDCAT.

  "## ##### ## ##

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "REUSE_ALV_GRID_DISPLAY ### import# ###### #### #



   CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IT_FIELDCAT = GT_FIELDCAT

    TABLES

      T_OUTTAB = GT_STUDENT.

ENDFORM.