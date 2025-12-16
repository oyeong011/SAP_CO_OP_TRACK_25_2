
*&---------------------------------------------------------------------*

*& Report ZEDR09_031

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_031.






* =====================================================================

* >> ## #### ##  <<



* ## ## ####### slis_fieldcat_alv ### ### ## ####### ### ### ####.

*### ##, REUSE_ALV_FIELDCATALOG_MERGE# ####### ## ####, gt_fieldcat#

*#####.

*- ### ##, REUSE_ALV_GRID_DISPLAY# I_STRUCTURE_NAME# ####, ### ## # ####

*### ##### # (## ##)

*## ##, ### ### REUSE_ALV_FIELDCATALOG_MERGE###, ### ######### ######,

*     #### ### ## ##### ## #### ### #.

*-> ### # ### # ## ## ### #. ### #### #####, ## ##### ## ### ### # # ###

*        ## ## ####? ####



* ## ####

*-> #, ####### ### ## ##### '##' ### OCCURS 0 # #### #### # -> ### ## ##



* #### ## #### ## (# merge### ### ## ##)

* 1) ####

* 2) ###

*    -> ## ##, ## ### ### ##### ### ##!

*    -> ### LENGTH 4# ##, type-pool# ### ###





* =====================================================================



*  "1)### ##  - ##, #### ## #######

*  DATA : BEGIN OF GT_STUDENT OCCURS 0,

*    ZCHECKBOX TYPE C,             "##### #### ## ##

*    ZCODE LIKE ZEDT09_001-ZCODE,  "####

*    ZPERNR LIKE ZEDT09_001-ZPERNR, "####

*    ZKNAME LIKE ZEDT09_001-ZKNAME, "##

*    ZENAME LIKE ZEDT09_001-ZENAME, "###

*    ZGENDER LIKE ZEDT09_001-ZGENDER, "##

*    ZMAJOR LIKE ZEDT09_002-ZMAJOR, "##

*    ZMNAME LIKE ZEDT09_002-ZMNAME, "###

*    END OF GT_STUDENT.




 "#### #, gt_student[]# ## ### # ##### ##






* >> ### ### #### ### # ###




DATA : BEGIN OF GS_STUDENT,

  ZCOLOR TYPE C LENGTH 4,         "### ##### ## ##, ### LENGTH 4# ##

  ZCODE LIKE ZEDT09_001-ZCODE,    "####

  ZPERNR LIKE ZEDT09_001-ZPERNR,  "####

  ZKNAME LIKE ZEDT09_001-ZKNAME,  "##

  ZENAME LIKE ZEDT09_001-ZENAME,  "###

  ZGENDER LIKE ZEDT09_001-ZGENDER,  "##

  ZMAJOR LIKE ZEDT09_002-ZMAJOR,   "##

  ZMNAME LIKE ZEDT09_002-ZMNAME,   "###

  END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : GS_FIELDCAT TYPE slis_fieldcat_alv.   "## ####

DATA : GT_FIELDCAT TYPE slis_t_fieldcat_alv.





PERFORM GET_DATA.

PERFORM MODIFY_DATA.

PERFORM FIELD_CATALOG. "#####, #### ## ####

PERFORM ALV_DISPLAY. "reuse_alv_fieldcatalog_merge###,

                     "### ####### ####, ####### #####.





"### ####

FORM GET_DATA.

  SELECT A~ZCODE

         A~ZPERNR

         A~ZKNAME

         A~ZENAME

         A~ZGENDER

         B~ZMAJOR

         B~ZMNAME

    FROM ZEDT09_001 AS A

    INNER JOIN ZEDT09_002 AS B

    ON A~ZCODE = B~ZCODE

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT.



  "#### db ##

  GS_STUDENT-ZCODE = 'ssu-90'.

  GS_STUDENT-ZENAME = ''.

  APPEND GS_STUDENT TO GT_STUDENT.



ENDFORM.



FORM MODIFY_DATA.

  " ###### #### #### ###

  " ## ## ##### ### ####.



  CLEAR GS_STUDENT.



  LOOP AT GT_STUDENT INTO GS_STUDENT.

    IF GS_STUDENT-ZENAME IS INITIAL.

      "ICON# ## ### ## ## -> SLIS## ICON ###

      GS_STUDENT-ZCOLOR = '@0A@'.

    ENDIF.



    MODIFY GT_STUDENT FROM GS_STUDENT INDEX SY-TABIX.

    CLEAR : GS_STUDENT.

  ENDLOOP.

ENDFORM.





FORM FIELD_CATALOG.




* CLEAR : GS_FIELDCAT, GT_FIELDCAT.

* GS_FIELDCAT-COL_POS = 1.

* GS_FIELDCAT-FIELDNAME = 'ZCHECKBOX'.

*  GS_FIELDCAT-SELTEXT_M = '####'.

*  GS_FIELDCAT-CHECKBOX = 'X'.

*  GS_FIELDCAT-EDIT = 'X'.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.






  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZENAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.





ENDFORM.



"2) function# ## ## #### ##

FORM ALV_DISPLAY.




* >>> REUSE_ALV_FIELDCATALOG_MERGE ### <<<

*   "reuse_alv_fieldcatalog_merge##

*   "## # #### ## ### #####(#: GT_STUDENT)# ###,

*   "# ### ##, ######(GT_FIELDCAT)# #### ###### ##



*   "** ## ###### ##### ###

*   CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'

*     EXPORTING

*       I_PROGRAM_NAME = SY-REPID         "## #### ###### ..

*       I_INTERNAL_TABNAME = 'GT_STUDENT' "# #### ###..

*       I_INCLNAME = SY-REPID

*       "(##) ###### include #### ## ###, # include## ###

*     CHANGING

*       CT_FIELDCAT = GT_FIELDCAT         "####### ####.

*     .



*   "**### alv ## #### #

*   CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

*     EXPORTING

*       IT_FIELDCAT = GT_FIELDCAT

*     TABLES

*       T_OUTTAB = GT_STUDENT.





* >>> ##### alv display OR zcolor# alv display <<




  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IT_FIELDCAT = GT_FIELDCAT

    TABLES

      T_OUTTAB = GT_STUDENT.





ENDFORM.