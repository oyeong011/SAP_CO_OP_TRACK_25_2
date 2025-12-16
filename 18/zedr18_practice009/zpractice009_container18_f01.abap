
*&---------------------------------------------------------------------*

*&  Include           ZPRACTICE009_CONTAINER18_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  INIT_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INIT_DATE .



  IF S_ZEDATE[] IS INITIAL.

    S_ZEDATE-LOW = SY-DATUM(6) && '01'.

    S_ZEDATE-SIGN = 'I'.

    S_ZEDATE-OPTION = 'EQ'.



    CALL FUNCTION 'LAST_DAY_OF_MONTHS'

      EXPORTING

        DAY_IN            = S_ZEDATE-LOW

      IMPORTING

        LAST_DAY_OF_MONTH = S_ZEDATE-LOW.



    APPEND S_ZEDATE.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING




*     PARENT    =




      REPID     = SY-REPID

      DYNNR     = SY-DYNNR




*     SIDE      = DOCK_AT_LEFT




      EXTENSION = 2000




*     STYLE     =

*     LIFETIME  = lifetime_default

*     CAPTION   =

*     METRIC    = 0

*     RATIO     =

*     NO_AUTODEF_PROGID_DYNNR     =

*     NAME      =

*  EXCEPTIONS

*     CNTL_ERROR                  = 1

*     CNTL_SYSTEM_ERROR           = 2

*     CREATE_ERROR                = 3

*     LIFETIME_ERROR              = 4

*     LIFETIME_DYNPRO_DYNPRO_LINK = 5

*     OTHERS    = 6




    .

  IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT GC_SPLITTER

    EXPORTING




*     LINK_DYNNR        =

*     LINK_REPID        =

*     SHELLSTYLE        =

*     LEFT    =

*     TOP     =

*     WIDTH   =

*     HEIGHT  =

*     METRIC  = cntl_metric_dynpro

*     ALIGN   = 15




      PARENT  = GC_DOCKING

      ROWS    = 2

      COLUMNS = 1




*     NO_AUTODEF_PROGID_DYNNR =

*     NAME    =

*  EXCEPTIONS

*     CNTL_ERROR        = 1

*     CNTL_SYSTEM_ERROR = 2

*     OTHERS  = 3




    .

  IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER1.



  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 2

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER2.



  CREATE OBJECT GC_SPLITTER2

    EXPORTING




*     LINK_DYNNR        =

*     LINK_REPID        =

*     SHELLSTYLE        =

*     LEFT    =

*     TOP     =

*     WIDTH   =

*     HEIGHT  =

*     METRIC  = cntl_metric_dynpro

*     ALIGN   = 15




      PARENT  = GC_CONTAINER1

      ROWS    = 1

      COLUMNS = 2




*     NO_AUTODEF_PROGID_DYNNR =

*     NAME    =

*  EXCEPTIONS

*     CNTL_ERROR        = 1

*     CNTL_SYSTEM_ERROR = 2

*     OTHERS  = 3




    .

  IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CALL METHOD GC_SPLITTER2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER3.



  CALL METHOD GC_SPLITTER2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 2

    RECEIVING

      CONTAINER = GC_CONTAINER4.



  CREATE OBJECT GC_GRID1 "#######

    EXPORTING




*     I_SHELLSTYLE      = 0

*     I_LIFETIME        =




      I_PARENT = GC_CONTAINER2




*     I_APPL_EVENTS     = space

*     I_PARENTDBG       =

*     I_APPLOGPARENT    =

*     I_GRAPHICSPARENT  =

*     I_NAME   =

*     I_FCAT_COMPLETE   = SPACE

*  EXCEPTIONS

*     ERROR_CNTL_CREATE = 1

*     ERROR_CNTL_INIT   = 2

*     ERROR_CNTL_LINK   = 3

*     ERROR_DP_CREATE   = 4

*     OTHERS   = 5




    .

  IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT GC_GRID2 "####

    EXPORTING




*     I_SHELLSTYLE      = 0

*     I_LIFETIME        =




      I_PARENT = GC_CONTAINER3




*     I_APPL_EVENTS     = space

*     I_PARENTDBG       =

*     I_APPLOGPARENT    =

*     I_GRAPHICSPARENT  =

*     I_NAME   =

*     I_FCAT_COMPLETE   = SPACE

*  EXCEPTIONS

*     ERROR_CNTL_CREATE = 1

*     ERROR_CNTL_INIT   = 2

*     ERROR_CNTL_LINK   = 3

*     ERROR_DP_CREATE   = 4

*     OTHERS   = 5




    .

  IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT GC_GRID3 "####

    EXPORTING




*     I_SHELLSTYLE      = 0

*     I_LIFETIME        =




      I_PARENT = GC_CONTAINER4




*     I_APPL_EVENTS     = space

*     I_PARENTDBG       =

*     I_APPLOGPARENT    =

*     I_GRAPHICSPARENT  =

*     I_NAME   =

*     I_FCAT_COMPLETE   = SPACE

*  EXCEPTIONS

*     ERROR_CNTL_CREATE = 1

*     ERROR_CNTL_INIT   = 2

*     ERROR_CNTL_LINK   = 3

*     ERROR_DP_CREATE   = 4

*     OTHERS   = 5




    .

  IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



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

  PERFORM GRID1_FIELD.

  PERFORM GRID2_FIELD.

  PERFORM GRID3_FIELD.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GRID1_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GRID1_FIELD . "##

  CLEAR : GS_FIELDCAT, GT_FIELDCAT1.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'CODE'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANK_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  IF P_CH = C_X.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 11.

    GS_FIELDCAT-FIELDNAME = 'ZQDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '10'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT1.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 12.

    GS_FIELDCAT-FIELDNAME = 'ZQFLAG'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '8'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GRID2_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GRID2_FIELD . "##

  CLEAR : GS_FIELDCAT , GT_FIELDCAT3.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GRID3_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GRID3_FIELD . "##

  CLEAR : GS_FIELDCAT , GT_FIELDCAT2.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-OUTPUTLEN = '16'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-NO_OUT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZBANK_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-TOTALS_BEF = 'X'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT .

  CLEAR : GS_SORT, GT_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.

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

  PERFORM CALL_ALV_DISPLAY USING GT_PERNR_ALV GC_GRID1 GT_FIELDCAT1. "####

  PERFORM CALL_ALV_DISPLAY USING GT_ASSESS_ALV GC_GRID2 GT_FIELDCAT2. "####

  PERFORM CALL_ALV_DISPLAY USING GT_SALARY_ALV GC_GRID3 GT_FIELDCAT3. "####

ENDFORM.

FORM CALL_ALV_DISPLAY USING PT_ITAB TYPE STANDARD TABLE

      P_GRID TYPE REF TO CL_GUI_ALV_GRID

  P_FIELDCAT TYPE LVC_T_FCAT.



  CALL METHOD P_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*     I_BUFFER_ACTIVE =

*     I_BYPASSING_BUFFER            =

*     I_CONSISTENCY_CHECK           =

*     I_STRUCTURE_NAME              =




      IS_VARIANT      = GS_VARIANT

      I_SAVE          = 'A'




*     I_DEFAULT       = 'X'




      IS_LAYOUT       = GS_LAYOUT




*     IS_PRINT        =

*     IT_SPECIAL_GROUPS             =

*     IT_TOOLBAR_EXCLUDING          =

*     IT_HYPERLINK    =

*     IT_ALV_GRAPHICS =

*     IT_EXCEPT_QINFO =

*     IR_SALV_ADAPTER =




    CHANGING

      IT_OUTTAB       = PT_ITAB

      IT_FIELDCATALOG = P_FIELDCAT

      IT_SORT         = GT_SORT




*     IT_FILTER       =

*    EXCEPTIONS

*     INVALID_PARAMETER_COMBINATION = 1

*     PROGRAM_ERROR   = 2

*     TOO_MANY_LINES  = 3

*     OTHERS          = 4




    .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.





ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MAKE_RANGES

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MAKE_RANGES .

  CLEAR : GR_FG, GR_FG[].



  " P_CH# #### ### ('X') -> ### #### # ## #.

  " Range #### ##### WHERE #### #### '## ##'# #.

  IF P_CH = 'X'.

    " ### ### #### ## -> GR_FG# ###### ## ##



    " P_CH# ## #### ### (' ') -> #### ## #.

    " ZQFLAG# #### #### ##

  ELSE.

    GR_FG-SIGN   = 'I'.

    GR_FG-OPTION = 'EQ'.

    GR_FG-LOW    = ' '. " ZQFLAG# ####(Space) ### ##

    APPEND GR_FG.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_DATA .

  IF ( S_ZDEPCD IS INITIAL ) AND ( S_ZPERNR IS INITIAL ) AND ( S_ZEDATE IS INITIAL ).

    MESSAGE I000.

    STOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT

    A~ZPERNR      "####

         B~ZPNAME      "##

         A~ZDEPRANK    "####

         A~ZDEPCODE    "####

         B~ZGENDER     "##

         A~DATBI       "####

         A~DATAB       "####

         A~ZEDATE      "####

         A~ZQDATE      "####

         A~ZQFLAG      "####

         B~ZADDRESS    "##

    FROM ZEDT18_102 AS A INNER JOIN ZEDT18_103 AS B

    ON A~ZPERNR = B~ZPERNR

    INTO CORRESPONDING FIELDS OF TABLE GT_PERNR

    WHERE A~ZPERNR IN S_ZPERNR

    AND A~ZDEPCODE IN S_ZDEPCD

    AND A~DATBI <= S_ZEDATE-LOW AND A~DATAB >= S_ZEDATE-LOW

    AND ZQFLAG IN GR_FG.



  IF GT_PERNR[] IS NOT INITIAL.

    SELECT * FROM ZEDT18_104

      INTO CORRESPONDING FIELDS OF TABLE GT_ASSESS

      FOR ALL ENTRIES IN GT_PERNR

      WHERE ZPERNR = GT_PERNR-ZPERNR

      AND ZDEPCODE = GT_PERNR-ZDEPCODE

      AND ZYEAR = S_ZEDATE-LOW+0(4)

      AND DATBI <= S_ZEDATE-LOW AND DATAB >= S_ZEDATE-LOW .





    SELECT * FROM ZEDT18_106

    INTO CORRESPONDING FIELDS OF TABLE GT_SALARY

    FOR ALL ENTRIES IN GT_PERNR

    WHERE ZPERNR = GT_PERNR-ZPERNR

    AND ZYEAR = S_ZEDATE-LOW+0(4)

    AND DATBI <= S_ZEDATE-LOW AND DATAB >= S_ZEDATE-LOW .

  ENDIF.

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

  CLEAR : GS_PERNR, GS_PERNR_ALV.

  CLEAR : GS_ASSESS, GS_ASSESS_ALV.

  CLEAR : GS_SALARY, GS_SALARY_ALV.





  "####

  LOOP AT GT_PERNR INTO GS_PERNR.

    MOVE-CORRESPONDING GS_PERNR TO GS_PERNR_ALV.



    "### ####

    PERFORM ZDEPCODE_NAME USING GS_PERNR-ZDEPCODE

                          CHANGING GS_PERNR_ALV-ZDEPCODE_NAME.

    "## ####

    PERFORM ZRANK_NAME USING GS_PERNR-ZDEPRANK

                       CHANGING GS_PERNR_ALV-ZDEPRANK_NAME.



    "## ####

    IF GS_PERNR-ZGENDER = 'M'.

      GS_PERNR_ALV-ZGENDER_NAME = '##'.

    ELSEIF GS_PERNR-ZGENDER = 'F'.

      GS_PERNR_ALV-ZGENDER_NAME = '##'.

    ENDIF.

    "### ##

    IF GS_PERNR-ZQFLAG = 'X'.

      GS_PERNR_ALV-CODE = '@0A@'.

    ELSE.

      IF GS_PERNR-ZDEPRANK = 'A'.

        GS_PERNR_ALV-CODE = '@09@'.

      ELSE.

        GS_PERNR_ALV-CODE = '@08@'.

      ENDIF.

    ENDIF.



    APPEND GS_PERNR_ALV TO GT_PERNR_ALV.

    CLEAR : GS_PERNR, GS_PERNR_ALV.

  ENDLOOP.



  "## ####

  LOOP AT GT_SALARY INTO GS_SALARY.

    MOVE-CORRESPONDING GS_SALARY TO GS_SALARY_ALV.

    "### ####

    PERFORM ZBANKS_NAME USING GS_SALARY-ZBANKCODE

                        CHANGING GS_SALARY_ALV-ZBANK_NAME.



    IF GS_SALARY-ZBANKCODE BETWEEN '001' AND '010'.

      GS_SALARY_ALV-ZWAERS = 'KRW'.

    ENDIF.



    APPEND GS_SALARY_ALV TO GT_SALARY_ALV.

    CLEAR : GS_SALARY, GS_SALARY_ALV.

  ENDLOOP.



  "####

  LOOP AT GT_ASSESS INTO GS_ASSESS.

    MOVE-CORRESPONDING GS_ASSESS TO GS_ASSESS_ALV.

    "### ####

    PERFORM ZDEPCODE_NAME USING GS_ASSESS-ZDEPCODE

                          CHANGING GS_ASSESS_ALV-ZDEPCODE_NAME.



    APPEND GS_ASSESS_ALV TO GT_ASSESS_ALV.

    CLEAR : GS_ASSESS, GS_ASSESS_ALV.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZDEPCODE_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_PERNR_ZDEPCODE  text

*      <--P_GS_PERNR_ALV_ZDEPCODE_NAME  text

*----------------------------------------------------------------------*




FORM ZDEPCODE_NAME  USING P_ZDEPCODE

                    CHANGING P_NAME.

  CASE P_ZDEPCODE.

    WHEN 'SS0001'.

      P_NAME = '###'.

    WHEN 'SS0002'.

      P_NAME = '###'.

    WHEN 'SS0003'.

      P_NAME = '###'.

    WHEN 'SS0004'.

      P_NAME = '###'.

    WHEN 'SS0005'.

      P_NAME = '###'.

    WHEN 'SS0006'.

      P_NAME = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZRANK_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_PERNR_ZDEPRANK  text

*      <--P_GS_PERNR_ALV_ZRANK_NAME  text

*----------------------------------------------------------------------*




FORM ZRANK_NAME  USING P_ZRANK

                 CHANGING P_NAME.

  CASE P_ZRANK.

    WHEN 'A'.

      P_NAME = '##'.

    WHEN 'B'.

      P_NAME = '##'.

    WHEN 'C'.

      P_NAME = '##'.

    WHEN 'D'.

      P_NAME = '##'.

    WHEN 'E'.

      P_NAME = '##'.

    WHEN 'F'.

      P_NAME = '##'.

    WHEN 'G'.

      P_NAME = '##'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZBANKS_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_SALARY_ZBANKCODE  text

*      <--P_GS_SALARY_ALV_ZBANK_NAME  text

*----------------------------------------------------------------------*




FORM ZBANKS_NAME  USING P_ZBANK

                  CHANGING P_NAME.

  CASE P_ZBANK.

    WHEN '001'.

      P_NAME = '####'.

    WHEN '002'.

      P_NAME = '####'.

    WHEN '003'.

      P_NAME = '####'.

    WHEN '004'.

      P_NAME = '####'.

    WHEN '005'.

      P_NAME = '#####'.

  ENDCASE.

ENDFORM.