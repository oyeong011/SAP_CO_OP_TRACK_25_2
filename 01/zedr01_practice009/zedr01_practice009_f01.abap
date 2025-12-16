
*&---------------------------------------------------------------------*

*&  Include           ZEDR01_PRACTICE009_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  INIT_DATA

*&---------------------------------------------------------------------*

*       ## #### #### #### ####

*----------------------------------------------------------------------*




FORM INIT_DATA .

  CLEAR GR_BANKCODE_WAERS.  "##### ### #### BANKCODE 001~010 BT ## ZWAERS = KRW# ###

  GR_BANKCODE_WAERS-SIGN = 'I'.

  GR_BANKCODE_WAERS-OPTION = 'BT'.

  GR_BANKCODE_WAERS-LOW = '001'.

  GR_BANKCODE_WAERS-HIGH = '010'.

  APPEND GR_BANKCODE_WAERS.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'  "## ### ### #### ####

    EXPORTING

      DAY_IN                  = SY-DATUM

   IMPORTING

     LAST_DAY_OF_MONTH       = S_DATE.




*   EXCEPTIONS

*     DAY_IN_NO_DATE          = 1

*     OTHERS                  = 2




  .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAIN

*&---------------------------------------------------------------------*

*       ##### #### ####

*----------------------------------------------------------------------*




FORM MAIN .

  PERFORM CHECK_DATA.        "##### ##### ###### ##

  PERFORM GET_DATA.          "#### ###

  PERFORM CHECK_RESIGN_DATA. "### ### ## #### ##

  PERFORM MODIFY_FIRST_DATA. "### ### ##

  PERFORM MODIFY_SECOND_DATA."### ### ##

  PERFORM MODIFY_THIRD_DATA. "### ### ##

  CALL SCREEN 100.           "# #### ALV# ##

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_DATA

*&---------------------------------------------------------------------*

*       #### ### #### ###### ### ####

*----------------------------------------------------------------------*




FORM CHECK_DATA .

  IF S_ZPERNR IS INITIAL AND S_ZCODE IS INITIAL.

    MESSAGE S000 DISPLAY LIKE 'E'.

    STOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       #### ### #### ###### #### ####

*----------------------------------------------------------------------*




FORM GET_DATA .

" ### ###

  SELECT A~ZPERNR,

         A~ZDEPCODE,

         A~ZDEPRANK,

         A~ZQFLAG,

         A~ZQDATE,

         A~ZEDATE,

         A~DATBI,

         A~DATAB,

         B~ZPNAME,

         B~ZGENDER,

         B~ZADDRESS

    FROM ZEDT01_102 AS A

    INNER JOIN ZEDT01_103 AS B

    ON A~ZPERNR = B~ZPERNR

    INTO TABLE @GT_INFO_FIRST

    WHERE A~ZPERNR IN @S_ZPERNR

    AND   A~DATBI <= @S_DATE

    AND   A~DATAB >= @S_DATE.



  PERFORM CHECK_TABLE_DATA USING GT_INFO_FIRST. "### ## ##

" ### ###

  IF GT_INFO_FIRST IS NOT INITIAL.

    SELECT ZPERNR,

           ZDEPCODE,

           ZYEAR,

           DATBI,

           DATAB,

           ZRANK

      FROM ZEDT01_104

      INTO TABLE @GT_INFO_SECOND

      FOR ALL ENTRIES IN @GT_INFO_FIRST

      WHERE ZPERNR = @GT_INFO_FIRST-ZPERNR.

  ENDIF.



  PERFORM CHECK_TABLE_DATA USING GT_INFO_SECOND. "### ## ##

" ### ###

  IF GT_INFO_FIRST IS NOT INITIAL.

    SELECT ZPERNR,

           ZBANKCODE,

           ZACCOUNT,

           ZSALARY,

           ZYEAR,

           DATBI,

           DATAB

      FROM ZEDT01_106

      INTO TABLE @GT_INFO_THIRD

      FOR ALL ENTRIES IN @GT_INFO_FIRST

      WHERE ZPERNR = @GT_INFO_FIRST-ZPERNR.

  ENDIF.



  PERFORM CHECK_TABLE_DATA USING GT_INFO_THIRD. "### ## ##



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_FIRST_DATA

*&---------------------------------------------------------------------*

*       ### ### ###### #### ####

*----------------------------------------------------------------------*




FORM MODIFY_FIRST_DATA .

  LOOP AT GT_INFO_FIRST INTO GS_INFO_FIRST.

    PERFORM GUBUN_COLORING USING GS_INFO_FIRST-ZDEPRANK GS_INFO_FIRST-ZQFLAG "## ## ##

                           CHANGING GS_INFO_FIRST-ZGUBUN_COLOR.

    PERFORM DEPCODE_NAMEING USING GS_INFO_FIRST-ZDEPCODE              "### ##

                            CHANGING GS_INFO_FIRST-ZDEPCODE_NAME.

    PERFORM DEPRANK_NAMEING USING GS_INFO_FIRST-ZDEPRANK              " ### ##

                            CHANGING GS_INFO_FIRST-ZDEPRANK_NAME.

    PERFORM GENDER_NAMEING USING GS_INFO_FIRST-ZGENDER                "##_## ##

                           CHANGING GS_INFO_FIRST-ZGENDER_NAME.

    MODIFY GT_INFO_FIRST FROM GS_INFO_FIRST.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_SECOND_DATA

*&---------------------------------------------------------------------*

*       ### ### ###### #### ####

*----------------------------------------------------------------------*




FORM MODIFY_SECOND_DATA .

  LOOP AT GT_INFO_SECOND INTO GS_INFO_SECOND.

    PERFORM DEPCODE_NAMEING USING GS_INFO_SECOND-ZDEPCODE          "### ##

                            CHANGING GS_INFO_SECOND-ZDEPCODE_NAME.

    MODIFY GT_INFO_SECOND FROM GS_INFO_SECOND.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_THIRD_DATA

*&---------------------------------------------------------------------*

*       ### ### ###### #### ####

*----------------------------------------------------------------------*




FORM MODIFY_THIRD_DATA .

  LOOP AT GT_INFO_THIRD INTO GS_INFO_THIRD.

    PERFORM GET_WAERS USING GS_INFO_THIRD-ZBANKCODE               "##### ## ## ##

                      CHANGING GS_INFO_THIRD-ZWAERS.

    PERFORM BANKCODE_NAMEING USING GS_INFO_THIRD-ZBANKCODE        "### ##

                             CHANGING GS_INFO_THIRD-ZBANKCODE_NAME.

    MODIFY GT_INFO_THIRD FROM GS_INFO_THIRD.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       ### #### ### ### ####

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING




*      PARENT                      =




      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      SIDE                        = GC_DOCKING->DOCK_AT_TOP

      EXTENSION                   = C_CONTAINER_SIZE




*      STYLE                       =

*      LIFETIME                    = lifetime_default

*      CAPTION                     =

*      METRIC                      = 0

*      RATIO                       =

*      NO_AUTODEF_PROGID_DYNNR     =

*      NAME                        =

*    EXCEPTIONS

*      CNTL_ERROR                  = 1

*      CNTL_SYSTEM_ERROR           = 2

*      CREATE_ERROR                = 3

*      LIFETIME_ERROR              = 4

*      LIFETIME_DYNPRO_DYNPRO_LINK = 5

*      others                      = 6




      .

   CREATE OBJECT GC_DOCKING2

    EXPORTING




*      PARENT                      =




      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      SIDE                        = GC_DOCKING2->DOCK_AT_BOTTOM

      EXTENSION                   = C_CONTAINER_SIZE




*      STYLE                       =

*      LIFETIME                    = lifetime_default

*      CAPTION                     =

*      METRIC                      = 0

*      RATIO                       =

*      NO_AUTODEF_PROGID_DYNNR     =

*      NAME                        =

*    EXCEPTIONS

*      CNTL_ERROR                  = 1

*      CNTL_SYSTEM_ERROR           = 2

*      CREATE_ERROR                = 3

*      LIFETIME_ERROR              = 4

*      LIFETIME_DYNPRO_DYNPRO_LINK = 5

*      others                      = 6




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

  CREATE OBJECT GC_SPLITTER

    EXPORTING




*      LINK_DYNNR        =

*      LINK_REPID        =

*      SHELLSTYLE        =

*      LEFT              =

*      TOP               =

*      WIDTH             =

*      HEIGHT            =

*      METRIC            = cntl_metric_dynpro

*      ALIGN             = 15




      PARENT            = GC_DOCKING

      ROWS              = 1

      COLUMNS           = 2




*      NO_AUTODEF_PROGID_DYNNR =

*      NAME              =

*    EXCEPTIONS

*      CNTL_ERROR        = 1

*      CNTL_SYSTEM_ERROR = 2

*      others            = 3




      .




*  CALL METHOD GC_SPLITTER->GET_CONTAINER

*    EXPORTING

*      ROW       = 2

*      COLUMN    = 1

*    RECEIVING

*      CONTAINER = GC_FIRST_CONTAINER

*      .




  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_SECOND_CONTAINER

      .

  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 2

    RECEIVING

      CONTAINER = GC_THIRD_CONTAINER

      .



  CREATE OBJECT GC_SECOND_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_SECOND_CONTAINER




*      I_APPL_EVENTS     = space

*      I_PARENTDBG       =

*      I_APPLOGPARENT    =

*      I_GRAPHICSPARENT  =

*      I_NAME            =

*      I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*      ERROR_CNTL_CREATE = 1

*      ERROR_CNTL_INIT   = 2

*      ERROR_CNTL_LINK   = 3

*      ERROR_DP_CREATE   = 4

*      others            = 5




      .

  CREATE OBJECT GC_THIRD_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_THIRD_CONTAINER




*      I_APPL_EVENTS     = space

*      I_PARENTDBG       =

*      I_APPLOGPARENT    =

*      I_GRAPHICSPARENT  =

*      I_NAME            =

*      I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*      ERROR_CNTL_CREATE = 1

*      ERROR_CNTL_INIT   = 2

*      ERROR_CNTL_LINK   = 3

*      ERROR_DP_CREATE   = 4

*      others            = 5




      .

  CREATE OBJECT GC_FIRST_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_DOCKING2




*      I_APPL_EVENTS     = space

*      I_PARENTDBG       =

*      I_APPLOGPARENT    =

*      I_GRAPHICSPARENT  =

*      I_NAME            =

*      I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*      ERROR_CNTL_CREATE = 1

*      ERROR_CNTL_INIT   = 2

*      ERROR_CNTL_LINK   = 3

*      ERROR_DP_CREATE   = 4

*      others            = 5




      .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_FIELD_CATALOG

*&---------------------------------------------------------------------*

*       # #### ##### #### ####

*----------------------------------------------------------------------*




FORM ALV_FIELD_CATALOG .



  CLEAR : GS_FIELDCAT,GT_FIRST_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZGUBUN_COLOR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIRST_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIRST_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIRST_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIRST_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = C_DATE_LEN.

  APPEND GS_FIELDCAT TO GT_FIRST_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = C_DATE_LEN.

  APPEND GS_FIELDCAT TO GT_FIRST_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANK_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIRST_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIRST_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = C_DATE_LEN.

  APPEND GS_FIELDCAT TO GT_FIRST_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIRST_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZQDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = C_DATE_LEN.

  APPEND GS_FIELDCAT TO GT_FIRST_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZQFLAG'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIRST_FIELDCAT.



  CLEAR : GS_FIELDCAT,GT_SECOND_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_SECOND_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_SECOND_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_SECOND_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = C_DATE_LEN.

  APPEND GS_FIELDCAT TO GT_SECOND_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = C_DATE_LEN.

  APPEND GS_FIELDCAT TO GT_SECOND_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_SECOND_FIELDCAT.



  CLEAR : GS_FIELDCAT,GT_THIRD_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_THIRD_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_THIRD_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = C_DATE_LEN.

  APPEND GS_FIELDCAT TO GT_THIRD_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = C_DATE_LEN.

  APPEND GS_FIELDCAT TO GT_THIRD_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-OUTPUTLEN = C_SALARY_LEN.

  APPEND GS_FIELDCAT TO GT_THIRD_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZBANKCODE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_THIRD_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_THIRD_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*      ALV LAYOUT# #### ####

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.     "### ## ###

  GS_LAYOUT-TOTALS_BEF = 'X'."### ## ###



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       ALV SORT# #### ####

*----------------------------------------------------------------------*




FORM ALV_SORT .

  CLEAR : GS_SORT,GT_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       ### ALV# ## ALV# #### ####

*----------------------------------------------------------------------*




FORM CALL_ALV .

  CALL METHOD GC_FIRST_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =




      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'




*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = GS_LAYOUT




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = GT_INFO_FIRST

      IT_FIELDCATALOG               = GT_FIRST_FIELDCAT

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .



  CALL METHOD GC_SECOND_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =




      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'




*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = GS_LAYOUT




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = GT_INFO_SECOND

      IT_FIELDCATALOG               = GT_SECOND_FIELDCAT

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .



   CALL METHOD GC_THIRD_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =




      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'




*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = GS_LAYOUT




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = GT_INFO_THIRD

      IT_FIELDCATALOG               = GT_THIRD_FIELDCAT

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_TABLE_DATA

*&---------------------------------------------------------------------*

*      ### #### ##### ### #### ####

*----------------------------------------------------------------------*




FORM CHECK_TABLE_DATA USING PT_TABLE TYPE STANDARD TABLE.

  IF PT_TABLE IS INITIAL.

    MESSAGE E001.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GUBUN_COLORING

*&---------------------------------------------------------------------*

*       ### ## ## ### ## ### #### ####

*----------------------------------------------------------------------*




FORM GUBUN_COLORING  USING    P_DEPRANK

                              P_ZQFLAG

                     CHANGING P_GUBUN_COLOR.

  IF P_ZQFLAG = 'X'.

    P_GUBUN_COLOR = '@0A@'.   "#### ## ##

  ELSEIF P_DEPRANK = 'A'.

    P_GUBUN_COLOR = '@09@'.   "### ## ##

  ELSE.

    P_GUBUN_COLOR = '@08@'.   "#### ##

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DEPCODE_NAMEING

*&---------------------------------------------------------------------*

*       ### ## #### #### ####

*----------------------------------------------------------------------*




FORM DEPCODE_NAMEING  USING    P_DEPCODE

                      CHANGING P_DEPCODE_NAME.

    CASE P_DEPCODE.

      WHEN 'SS0001'.

        P_DEPCODE_NAME = '###'.

      WHEN 'SS0002'.

        P_DEPCODE_NAME = '###'.

      WHEN 'SS0003'.

        P_DEPCODE_NAME = '###'.

      WHEN 'SS0004'.

        P_DEPCODE_NAME = '###'.

      WHEN 'SS0005'.

        P_DEPCODE_NAME = '###'.

      WHEN 'SS0006'.

        P_DEPCODE_NAME = '###'.

    ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DEPRANK_NAMEING

*&---------------------------------------------------------------------*

*       ### ## #### #### ####

*----------------------------------------------------------------------*




FORM DEPRANK_NAMEING  USING    P_DEPRANK

                      CHANGING P_DEPRANK_NAME.

   CASE P_DEPRANK.

      WHEN 'A'.

        P_DEPRANK_NAME = '##'.

      WHEN 'B'.

        P_DEPRANK_NAME = '##'.

      WHEN 'C'.

        P_DEPRANK_NAME = '##'.

      WHEN 'D'.

        P_DEPRANK_NAME = '##'.

      WHEN 'E'.

        P_DEPRANK_NAME = '##'.

      WHEN 'F'.

        P_DEPRANK_NAME = '##'.

      WHEN 'G'.

        P_DEPRANK_NAME = '##'.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GENDER_NAMEING

*&---------------------------------------------------------------------*

*       ### ## ##_### #### ####

*----------------------------------------------------------------------*




FORM GENDER_NAMEING  USING    P_GENDER

                     CHANGING P_GENDER_NAME.

  CASE P_GENDER.

    WHEN 'M'.

      P_GENDER_NAME = '##'.

    WHEN 'F'.

      P_GENDER_NAME = '##'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  BANKCODE_NAMEING

*&---------------------------------------------------------------------*

*       ##### ## #### #### ####

*----------------------------------------------------------------------*




FORM BANKCODE_NAMEING  USING    P_BANKCODE

                       CHANGING P_BANKCODE_NAME.

  CASE P_BANKCODE.

    WHEN '001'.

      P_BANKCODE_NAME = '####'.

    WHEN '002'.

      P_BANKCODE_NAME = '####'.

    WHEN '003'.

      P_BANKCODE_NAME = '####'.

    WHEN '004'.

      P_BANKCODE_NAME = '####'.

    WHEN '005'.

      P_BANKCODE_NAME = '#####'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_WAERS

*&---------------------------------------------------------------------*

*       ##### ##(001~010)# ##### KRW# #### ####

*----------------------------------------------------------------------*




FORM GET_WAERS  USING    P_BANKCODE

                CHANGING P_WAERS.

  IF P_BANKCODE IN GR_BANKCODE_WAERS.

    P_WAERS = 'KRW'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_RESIGN_DATA

*&---------------------------------------------------------------------*

*       ###### ## ### #### #### ####

*----------------------------------------------------------------------*




FORM CHECK_RESIGN_DATA .

  IF P_CH1 = ' '. "##### ### ####

    LOOP AT GT_INFO_FIRST INTO GS_INFO_FIRST.

      IF GS_INFO_FIRST-ZQFLAG = 'X'.

        DELETE GT_INFO_FIRST WHERE ZPERNR = GS_INFO_FIRST-ZPERNR.

        DELETE GT_INFO_SECOND WHERE ZPERNR = GS_INFO_FIRST-ZPERNR.

        DELETE GT_INFO_THIRD WHERE ZPERNR = GS_INFO_FIRST-ZPERNR.

      ENDIF.

    ENDLOOP.

  ENDIF.

ENDFORM.