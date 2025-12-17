
REPORT ZEDR11_013.






*TABLES: ZEDT11_001, ZEDT11_002.

*

*"-------------------------------------------------------

*" ## ## ##

*"-------------------------------------------------------

*TYPES: BEGIN OF TY_JOIN,

*         ZCODE    TYPE ZEDT11_001-ZCODE,

*         ZPERNR   TYPE ZEDT11_001-ZPERNR,

*         ZKNAME   TYPE ZEDT11_001-ZKNAME,

*         ZENAME   TYPE ZEDT11_001-ZENAME,

*         ZMAJOR   TYPE ZEDT11_002-ZMAJOR,

*         ZMNAME   TYPE ZEDT11_002-ZMNAME,

*         ZSUM     TYPE ZEDT11_002-ZSUM,

*         ZWAERS   TYPE C LENGTH 3, " ##

*         CRDATE   TYPE D,          " ###

*       END OF TY_JOIN.

*

*DATA: GS_JOIN TYPE TY_JOIN,

*      GT_JOIN TYPE TABLE OF TY_JOIN.

*

*DATA: GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV,

*      GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,

*      GS_LAYOUT   TYPE SLIS_LAYOUT_ALV.

*

*DATA: GS_SORT TYPE SLIS_SORTINFO_ALV.

*DATA: GT_SORT TYPE SLIS_T_SORTINFO_ALV.

*

*"-------------------------------------------------------

*" ## ##

*"-------------------------------------------------------

*START-OF-SELECTION.

*  PERFORM GET_DATA.

*  IF GT_JOIN IS INITIAL.

*    MESSAGE '### #### ####.' TYPE 'I'.

*  ELSE.

*    PERFORM FIELD_CATALOG.

*    PERFORM ALV_LAYOUT.

*    PERFORM CALL_ALV.

*    PERFORM ALV_SORT.

*  ENDIF.

*

*"-------------------------------------------------------

*" SORT ##(SORT)

*"-------------------------------------------------------

*FORM ALV_SORT.

*  CLEAR GS_SORT.

*  GS_SORT-SPOS = 1.

*  GS_SORT-FIELDNAME = 'ZCODE'.

*  GS_SORT-UP = ' '.

*  GS_SORT-DOWN = 'X'.

*  APPEND GS_SORT TO GT_SORT.

*ENDFORM.

*

*"-------------------------------------------------------

*" ### ## (JOIN)

*"-------------------------------------------------------

*FORM GET_DATA.

*  CLEAR GT_JOIN.

*  SELECT

*    A~ZCODE

*    A~ZPERNR

*    A~ZKNAME

*    A~ZENAME

*    B~ZMAJOR

*    B~ZMNAME

*    B~ZSUM

*    INTO CORRESPONDING FIELDS OF TABLE GT_JOIN

*    FROM ZEDT11_001 AS A

*    INNER JOIN ZEDT11_002 AS B

*      ON A~ZPERNR = B~ZCODE

*    WHERE A~ZPERNR BETWEEN 'SSU-01' AND 'SSU-11'.

*

*  LOOP AT GT_JOIN INTO GS_JOIN.

*    GS_JOIN-ZWAERS = 'KRW'.

*    GS_JOIN-CRDATE = SY-DATUM.

*    MODIFY GT_JOIN FROM GS_JOIN.

*  ENDLOOP.

*ENDFORM.

*

*"-------------------------------------------------------

*" ## #### ##

*"-------------------------------------------------------

*FORM FIELD_CATALOG.

*  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

*

*  " 1. ####

*  GS_FIELDCAT-COL_POS   = 1.

*  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

*  GS_FIELDCAT-SELTEXT_M = '####'.

*  GS_FIELDCAT-KEY       = 'X'.

*  GS_FIELDCAT-JUST      = 'L'.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.

*

*  " 2. ####

*  CLEAR GS_FIELDCAT.

*  GS_FIELDCAT-COL_POS   = 2.

*  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

*  GS_FIELDCAT-SELTEXT_M = '####'.

*  GS_FIELDCAT-KEY       = 'X'.

*  GS_FIELDCAT-JUST      = 'C'.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.

*

*  " 3. #### (##)

*  CLEAR GS_FIELDCAT.

*  GS_FIELDCAT-COL_POS   = 3.

*  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

*  GS_FIELDCAT-SELTEXT_M = '####'.

*  GS_FIELDCAT-JUST      = 'R'.

*  GS_FIELDCAT-NO_OUT    = 'X'.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.

*

*  " 4. ###

*  CLEAR GS_FIELDCAT.

*  GS_FIELDCAT-COL_POS   = 4.

*  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

*  GS_FIELDCAT-SELTEXT_M = '###'.

*  GS_FIELDCAT-JUST      = 'L'.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.

*

*  " 5. #### (##)

*  CLEAR GS_FIELDCAT.

*  GS_FIELDCAT-COL_POS   = 5.

*  GS_FIELDCAT-FIELDNAME = 'ZSUM'.

*  GS_FIELDCAT-SELTEXT_M = '####'.

*  GS_FIELDCAT-CURRENCY  = 'KRW'.

*  GS_FIELDCAT-DO_SUM    = 'X'.

*  GS_FIELDCAT-NO_ZERO   = 'X'.

*  GS_FIELDCAT-NO_SIGN   = 'X'.

*  GS_FIELDCAT-OUTPUTLEN = 20.

*  GS_FIELDCAT-EMPHASIZE = 'C300'.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.

*

*  " 6. ##

*  CLEAR GS_FIELDCAT.

*  GS_FIELDCAT-COL_POS   = 6.

*  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

*  GS_FIELDCAT-SELTEXT_M = '##'.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.

*

*  " 7. ####

*  CLEAR GS_FIELDCAT.

*  GS_FIELDCAT-COL_POS   = 7.

*  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

*  GS_FIELDCAT-SELTEXT_M = '####'.

*  GS_FIELDCAT-EMPHASIZE = 'C710'.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.

*

*  " 8. ####

*  CLEAR GS_FIELDCAT.

*  GS_FIELDCAT-COL_POS   = 8.

*  GS_FIELDCAT-FIELDNAME = 'ZENAME'.

*  GS_FIELDCAT-SELTEXT_M = '####'.

*  GS_FIELDCAT-JUST      = 'C'.

*  GS_FIELDCAT-EMPHASIZE = 'C510'.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.

*

*  " 9. ###

*  CLEAR GS_FIELDCAT.

*  GS_FIELDCAT-COL_POS   = 9.

*  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

*  GS_FIELDCAT-SELTEXT_M = '###'.

*  GS_FIELDCAT-EDIT      = 'X'.

*  GS_FIELDCAT-EDIT_MASK = '____-__-__'.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.

*ENDFORM.

*

*"-------------------------------------------------------

*" Layout ##

*"-------------------------------------------------------

*FORM ALV_LAYOUT.

*  CLEAR GS_LAYOUT.

*  GS_LAYOUT-ZEBRA             = 'X'.

*  GS_LAYOUT-NO_VLINE          = 'X'.

*  GS_LAYOUT-NO_HLINE          = 'X'.

*  GS_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.

*  GS_LAYOUT-TOTALS_TEXT       = '###'.

*ENDFORM.

*

*"-------------------------------------------------------

*" ALV Display

*"-------------------------------------------------------

*FORM CALL_ALV.

*  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

*    EXPORTING

*      I_CALLBACK_PROGRAM = SY-REPID

*      IS_LAYOUT          = GS_LAYOUT

*      IT_FIELDCAT        = GT_FIELDCAT

*      I_SAVE             = 'A'

*      IT_SORT            = GT_SORT

*    TABLES

*      T_OUTTAB           = GT_JOIN

*    EXCEPTIONS

*      PROGRAM_ERROR      = 1

*      OTHERS             = 2.

*

*  IF SY-SUBRC <> 0.

*    WRITE :/ 'ALV ## # ## ##.'.

*  ENDIF.

*ENDFORM.



*--------------------------------------------------------------------*

* ### ##

*--------------------------------------------------------------------*




DATA: BEGIN OF GS_STUDENT,

        ZCOLOR    TYPE C LENGTH 4,

        ZCHECKBOX TYPE C,

        ZCODE     LIKE ZEDT11_001-ZCODE,

        ZPERNR    LIKE ZEDT11_001-ZPERNR,

        ZKNAME    LIKE ZEDT11_001-ZKNAME,

        ZENAME    LIKE ZEDT11_001-ZENAME,

        ZGUBUN    LIKE ZEDT11_001-ZGENDER,

        ZMAJOR    LIKE ZEDT11_002-ZMAJOR,

        ZMNAME    LIKE ZEDT11_002-ZMNAME,

      END OF GS_STUDENT.



DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA: GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV,

      GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.






*--------------------------------------------------------------------*

* START-OF-SELECTION

*--------------------------------------------------------------------*




START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM FIELD_CATALOG.

  PERFORM MODIFY_DATA.

  PERFORM ALV_DISPLAY.






*--------------------------------------------------------------------*

* FORM GET_DATA

*--------------------------------------------------------------------*




FORM GET_DATA.

  SELECT

    A~ZCODE

    A~ZPERNR

    A~ZKNAME

    A~ZENAME

    A~ZGENDER

    B~ZMAJOR

    B~ZMNAME

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    FROM ZEDT11_001 AS A

    INNER JOIN ZEDT11_002 AS B

      ON A~ZPERNR = B~ZCODE.



  IF SY-SUBRC = 0.

    WRITE: / '### ## ##:', LINES( GT_STUDENT ), '#'.

  ELSE.

    WRITE: / '### #### ####.'.

  ENDIF.

ENDFORM.






*--------------------------------------------------------------------*

* FORM FIELD_CATALOG

*--------------------------------------------------------------------*




FORM FIELD_CATALOG.

  CLEAR GT_FIELDCAT.



  " 0) ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  GS_FIELDCAT-ICON      = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 1) ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'ZCHECKBOX'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-CHECKBOX  = 'X'.

  GS_FIELDCAT-EDIT      = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 2) ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'ZCODE'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 3) ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 4) ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 5) ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'ZENAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 6) ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'ZGUBUN'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 7) ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 8) ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.






*--------------------------------------------------------------------*

* FORM ALV_DISPLAY

*--------------------------------------------------------------------*




FORM ALV_DISPLAY.




*  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'

*    EXPORTING

*      I_PROGRAM_NAME     = SY-REPID

*      I_INTERNAL_TABNAME = 'GS_STUDENT'

*      I_INCLNAME         = SY-REPID

*    CHANGING

*      CT_FIELDCAT        = GT_FIELDCAT.






  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IT_FIELDCAT = GT_FIELDCAT

    TABLES

      T_OUTTAB    = GT_STUDENT.

ENDFORM.






*--------------------------------------------------------------------*

* FORM MODIFY_DATA

*--------------------------------------------------------------------*




FORM MODIFY_DATA.

  "###### #### ## ## ### ### ##

  "# ###(ZENAME)# ## ### ZCOLOR# ICON ## ##

  LOOP AT GT_STUDENT INTO GS_STUDENT.

    IF GS_STUDENT-ZENAME IS INITIAL.

      GS_STUDENT-ZCOLOR = '@0A@'.

    ENDIF.

    MODIFY GT_STUDENT FROM GS_STUDENT INDEX SY-TABIX.

    CLEAR GS_STUDENT.

  ENDLOOP.

ENDFORM.