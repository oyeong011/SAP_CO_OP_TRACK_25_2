
*&---------------------------------------------------------------------*

*&  Include           ZEDR24_PRACTICE009_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_INIT .

  DATA : LV_YEAR TYPE DATS,

         LV_MONTH TYPE DATS,

         LV_FIRST_DAY TYPE DATS,

         LV_LAST_DAY TYPE DATS.



  CONCATENATE SY-DATUM+0(6) '01' INTO LV_FIRST_DAY.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN = SY-DATUM

  IMPORTING

    LAST_DAY_OF_MONTH = LV_LAST_DAY.

  S_TERM-LOW = LV_LAST_DAY.

  APPEND S_TERM.



  IF P_ISQUIT <> 'X'.

    CLEAR GR_ISQUIT.

    GR_ISQUIT-OPTION = 'NE'.

    GR_ISQUIT-LOW = 'X'.

    GR_ISQUIT-SIGN = 'I'.

    APPEND GR_ISQUIT.

  ENDIF.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA1

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA1 .

  DATA : LV_DATE TYPE DATS.

  LV_DATE = S_TERM-LOW.



  IF P_ISQUIT <> 'X'.

    SELECT * FROM ZEDT24_102 AS 102

    JOIN ZEDT24_103 AS 103 ON 102~ZPERNR = 103~ZPERNR

    INTO CORRESPONDING FIELDS OF TABLE GT_EMPLOYEE

    WHERE 102~ZPERNR IN S_ZPERNR

       AND ZDEPCODE IN S_ZDCODE

       AND 102~DATBI <= LV_DATE

       AND 102~DATAB >= LV_DATE

       AND ZQFLAG IN GR_ISQUIT.

  ELSEIF P_ISQUIT = 'X'.

    SELECT * FROM ZEDT24_102 AS 102

    JOIN ZEDT24_103 AS 103 ON 102~ZPERNR = 103~ZPERNR

    INTO CORRESPONDING FIELDS OF TABLE GT_EMPLOYEE

    WHERE 102~ZPERNR IN S_ZPERNR

       AND ZDEPCODE IN S_ZDCODE

       AND 102~DATBI <= LV_DATE

       AND 102~DATAB >= LV_DATE.

  ENDIF.



  SELECT * FROM ZEDT24_104

    INTO CORRESPONDING FIELDS OF TABLE GT_EVAL

    FOR ALL ENTRIES IN GT_EMPLOYEE

    WHERE ZPERNR = GT_EMPLOYEE-ZPERNR.





  SELECT * FROM ZEDT24_104 AS 104

    INNER JOIN ZEDT24_106 AS 106 ON 104~ZPERNR = 106~ZPERNR

    INTO CORRESPONDING FIELDS OF TABLE GT_CONTRACT

    FOR ALL ENTRIES IN GT_EMPLOYEE

    WHERE 104~ZPERNR = GT_EMPLOYEE-ZPERNR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA1

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GT_EMPLOYEE  text

*----------------------------------------------------------------------*




FORM MODIFY_DATA1.

  DATA : LV_ZDEPNAME TYPE C LENGTH 10,

         LV_ZDEPRANKNAME TYPE C LENGTH 10,

         LV_ZGENDERNAME TYPE C LENGTH 5.



  "#### -> ### (ZDEPCODE -> ZDEPNAME)

  LOOP AT GT_EMPLOYEE INTO GS_EMPLOYEE.

    CLEAR GS_EMP_RESULT.



    MOVE-CORRESPONDING GS_EMPLOYEE TO GS_EMP_RESULT.



    PERFORM CONVERT_ZDEPCODE CHANGING LV_ZDEPNAME GS_EMPLOYEE-ZDEPCODE.

    GS_EMP_RESULT-ZDEPNAME = LV_ZDEPNAME.



    PERFORM CONVERT_ZDEPRANK CHANGING LV_ZDEPRANKNAME GS_EMPLOYEE-ZDEPRANK.

    GS_EMP_RESULT-ZDEPRANKNAME = LV_ZDEPRANKNAME.



    PERFORM CONVERT_ZGENDER CHANGING LV_ZGENDERNAME GS_EMPLOYEE-ZGENDER.

    GS_EMP_RESULT-ZGENDERNAME = LV_ZGENDERNAME.



    GS_EMP_RESULT-ZICON = ICON_GREEN_LIGHT.

    IF GS_EMPLOYEE-ZQFLAG = 'X'.

      GS_EMP_RESULT-ZICON = ICON_RED_LIGHT.

    ELSEIF LV_ZDEPRANKNAME = '##'.

      GS_EMP_RESULT-ZICON = ICON_YELLOW_LIGHT.

    ENDIF.



    APPEND GS_EMP_RESULT TO GT_EMP_RESULT.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GT_EVAL  text

*----------------------------------------------------------------------*




FORM MODIFY_DATA2.

  DATA : LV_ZDEPNAME TYPE C LENGTH 10.



  "#### -> ### (ZBANKCODE->ZBANKNAME)

  LOOP AT GT_EVAL INTO GS_EVAL.

    CLEAR GS_EVAL_RESULT.



    MOVE-CORRESPONDING GS_EVAL TO GS_EVAL_RESULT.



    PERFORM CONVERT_ZDEPCODE CHANGING LV_ZDEPNAME GS_EVAL-ZDEPCODE.

    GS_EVAL_RESULT-ZDEPNAME = LV_ZDEPNAME.



    APPEND GS_EVAL_RESULT TO GT_EVAL_RESULT.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GT_CONTRACT  text

*----------------------------------------------------------------------*




FORM MODIFY_DATA3.

  DATA : LV_BANKNAME TYPE C LENGTH 10.



  "#### -> ###

  LOOP AT GT_CONTRACT INTO GS_CONTRACT.

    CLEAR GS_CON_RESULT.



    MOVE-CORRESPONDING GS_CONTRACT TO GS_CON_RESULT.



    PERFORM CONVERT_ZBANKCODE CHANGING LV_BANKNAME GS_CONTRACT-ZBANKCODE.

    GS_CON_RESULT-ZBANKNAME = LV_BANKNAME.





    GS_CON_RESULT-ZWAERS = 'USD'.

    IF GS_CONTRACT-ZBANKCODE BETWEEN '001' AND '010'.

        GS_CON_RESULT-ZWAERS = 'KRW'.

    ENDIF.



    APPEND GS_CON_RESULT TO GT_CON_RESULT.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONVERT_ZDEPCODE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_LV_ZDEPNAME  text

*      <--P_GS_EVAL_ZDEPCODE  text

*----------------------------------------------------------------------*




FORM CONVERT_ZDEPRANK  CHANGING P_ZDEPRANKNAME

                                P_ZDEPRANK.

  CASE P_ZDEPRANK.

    WHEN 'A'.

      P_ZDEPRANKNAME = '##'.

    WHEN 'B'.

      P_ZDEPRANKNAME = '##'.

    WHEN 'C'.

      P_ZDEPRANKNAME = '##'.

    WHEN 'D'.

      P_ZDEPRANKNAME = '##'.

    WHEN 'E'.

      P_ZDEPRANKNAME = '##'.

    WHEN 'F'.

      P_ZDEPRANKNAME = '##'.

    WHEN 'G'.

      P_ZDEPRANKNAME = '##'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONVERT_ZDEPCODE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_LV_ZDEPNAME  text

*      <--P_GS_EVAL_ZDEPCODE  text

*----------------------------------------------------------------------*




FORM CONVERT_ZGENDER  CHANGING P_ZGENDERNAME

                                P_ZGENDER.

  CASE P_ZGENDER.

    WHEN 'M' OR 'm'.

      P_ZGENDERNAME = '##'.

    WHEN 'W' OR 'w'.

      P_ZGENDERNAME = '##'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONVERT_ZDEPCODE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_LV_ZDEPNAME  text

*      <--P_GS_EVAL_ZDEPCODE  text

*----------------------------------------------------------------------*




FORM CONVERT_ZDEPCODE  CHANGING P_ZDEPNAME

                                P_ZDEPCODE.

  CASE P_ZDEPCODE.

    WHEN 'SS0001'.

      P_ZDEPNAME = '###'.

    WHEN 'SS0002'.

      P_ZDEPNAME = '###'.

    WHEN 'SS0003'.

      P_ZDEPNAME = '###'.

    WHEN 'SS0004'.

      P_ZDEPNAME = '###'.

    WHEN 'SS0005'.

      P_ZDEPNAME = '###'.

    WHEN 'SS0006'.

      P_ZDEPNAME = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONVERT_ZBANKCODE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_LV_BANKNAME  text

*      <--P_GS_CONTRACT_ZBANKCODE  text

*----------------------------------------------------------------------*




FORM CONVERT_ZBANKCODE  CHANGING P_BANKNAME

                                 P_ZBANKCODE.

  CASE P_ZBANKCODE.

    WHEN '001'.

      P_BANKNAME = '####'.

    WHEN '002'.

      P_BANKNAME = '####'.

    WHEN '003'.

      P_BANKNAME = '####'.

    WHEN '004'.

      P_BANKNAME = '####'.

    WHEN '005'.

      P_BANKNAME = '#####'.

  ENDCASE.

ENDFORM.



FORM CREATE_OBJECT.

CREATE OBJECT GC_DOCKING

  EXPORTING




*    PARENT                      =




    REPID                       = SY-REPID

    DYNNR                       = SY-DYNNR




*    SIDE                        = DOCK_AT_LEFT




    EXTENSION                   = 2000




*    STYLE                       =

*    LIFETIME                    = lifetime_default

*    CAPTION                     =

*    METRIC                      = 0

*    RATIO                       =

*    NO_AUTODEF_PROGID_DYNNR     =

*    NAME                        =

*  EXCEPTIONS

*    CNTL_ERROR                  = 1

*    CNTL_SYSTEM_ERROR           = 2

*    CREATE_ERROR                = 3

*    LIFETIME_ERROR              = 4

*    LIFETIME_DYNPRO_DYNPRO_LINK = 5

*    others                      = 6




    .

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




ENDIF.



"## (#-##) ##

CREATE OBJECT GC_SPLITTER_MAIN

  EXPORTING




*    LINK_DYNNR        =

*    LINK_REPID        =

*    SHELLSTYLE        =

*    LEFT              =

*    TOP               =

*    WIDTH             =

*    HEIGHT            =

*    METRIC            = cntl_metric_dynpro

*    ALIGN             = 15




    PARENT            = GC_DOCKING

    ROWS              = 2

    COLUMNS           = 1




*    NO_AUTODEF_PROGID_DYNNR =

*    NAME              =

*  EXCEPTIONS

*    CNTL_ERROR        = 1

*    CNTL_SYSTEM_ERROR = 2

*    others            = 3




    .

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




ENDIF.



CALL METHOD GC_SPLITTER_MAIN->GET_CONTAINER

  EXPORTING

    ROW       = 1

    COLUMN    = 1

  RECEIVING

    CONTAINER = GC_CONTAINER_TOP.

    .



CALL METHOD GC_SPLITTER_MAIN->GET_CONTAINER

  EXPORTING

    ROW       = 2

    COLUMN    = 1

  RECEIVING

    CONTAINER = GC_CONTAINER_BOTTOM.

    .



"## ## ##

CREATE OBJECT GC_SPLITTER_DOWN

  EXPORTING




*    LINK_DYNNR        =

*    LINK_REPID        =

*    SHELLSTYLE        =

*    LEFT              =

*    TOP               =

*    WIDTH             =

*    HEIGHT            =

*    METRIC            = cntl_metric_dynpro

*    ALIGN             = 15




    PARENT            = GC_CONTAINER_TOP

    ROWS              = 1

    COLUMNS           = 2




*    NO_AUTODEF_PROGID_DYNNR =

*    NAME              =

*  EXCEPTIONS

*    CNTL_ERROR        = 1

*    CNTL_SYSTEM_ERROR = 2

*    others            = 3




.



CALL METHOD GC_SPLITTER_DOWN->GET_CONTAINER

  EXPORTING

    ROW       = 1

    COLUMN    = 1

  RECEIVING

    CONTAINER = GC_CONTAINER_TOP1.

    .



CALL METHOD GC_SPLITTER_DOWN->GET_CONTAINER

  EXPORTING

    ROW       = 1

    COLUMN    = 2

  RECEIVING

    CONTAINER = GC_CONTAINER_TOP2.

    .



    .

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




ENDIF.



CREATE OBJECT GC_GRID_TOP1

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_CONTAINER_TOP1




*    I_APPL_EVENTS     = space

*    I_PARENTDBG       =

*    I_APPLOGPARENT    =

*    I_GRAPHICSPARENT  =

*    I_NAME            =

*    I_FCAT_COMPLETE   = SPACE

*  EXCEPTIONS

*    ERROR_CNTL_CREATE = 1

*    ERROR_CNTL_INIT   = 2

*    ERROR_CNTL_LINK   = 3

*    ERROR_DP_CREATE   = 4

*    others            = 5




    .

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




ENDIF.



CREATE OBJECT GC_GRID_TOP2

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_CONTAINER_TOP2




*    I_APPL_EVENTS     = space

*    I_PARENTDBG       =

*    I_APPLOGPARENT    =

*    I_GRAPHICSPARENT  =

*    I_NAME            =

*    I_FCAT_COMPLETE   = SPACE

*  EXCEPTIONS

*    ERROR_CNTL_CREATE = 1

*    ERROR_CNTL_INIT   = 2

*    ERROR_CNTL_LINK   = 3

*    ERROR_DP_CREATE   = 4

*    others            = 5




    .

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




ENDIF.



CREATE OBJECT GC_GRID_BOTTOM

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_CONTAINER_BOTTOM




*    I_APPL_EVENTS     = space

*    I_PARENTDBG       =

*    I_APPLOGPARENT    =

*    I_GRAPHICSPARENT  =

*    I_NAME            =

*    I_FCAT_COMPLETE   = SPACE

*  EXCEPTIONS

*    ERROR_CNTL_CREATE = 1

*    ERROR_CNTL_INIT   = 2

*    ERROR_CNTL_LINK   = 3

*    ERROR_DP_CREATE   = 4

*    others            = 5




    .

IF SY-SUBRC <> 0.




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

  PERFORM FC_BOTTOM.

  PERFORM FC_TOP1.

  PERFORM FC_TOP2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FC_BOTTOM

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FC_BOTTOM .

  CLEAR : GS_FIELDCAT, GT_FC_BOTTOM.



  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FC_BOTTOM.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FC_BOTTOM.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FC_BOTTOM.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FC_BOTTOM.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FC_BOTTOM.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FC_BOTTOM.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANKNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FC_BOTTOM.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDERNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FC_BOTTOM.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FC_BOTTOM.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FC_BOTTOM.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZQDATE'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FC_BOTTOM.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZQFLAG'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FC_BOTTOM.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FC_TOP1

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FC_TOP1 .

  CLEAR : GS_FIELDCAT, GT_FC_TOP1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FC_TOP1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FC_TOP1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FC_TOP1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FC_TOP1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FC_TOP1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FC_TOP1.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FC_TOP2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FC_TOP2 .

  CLEAR : GS_FIELDCAT, GT_FC_TOP2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FC_TOP2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FC_TOP2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FC_TOP2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FC_TOP2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  APPEND GS_FIELDCAT TO GT_FC_TOP2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZBANKNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FC_TOP2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FC_TOP2.

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

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-TOTALS_BEF = 'X'.

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

  CLEAR GS_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV .

CALL METHOD GC_GRID_TOP1->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = GS_VARIANT

    I_SAVE                        = 'A'




*    I_DEFAULT                     = 'X'




    IS_LAYOUT                     = GS_LAYOUT




*    IS_PRINT                      =

*    IT_SPECIAL_GROUPS             =

*    IT_TOOLBAR_EXCLUDING          =

*    IT_HYPERLINK                  =

*    IT_ALV_GRAPHICS               =

*    IT_EXCEPT_QINFO               =

*    IR_SALV_ADAPTER               =




  CHANGING

    IT_OUTTAB                     = GT_EVAL_RESULT

    IT_FIELDCATALOG               = GT_FC_TOP1

    IT_SORT                       = GT_SORT




*    IT_FILTER                     =

*  EXCEPTIONS

*    INVALID_PARAMETER_COMBINATION = 1

*    PROGRAM_ERROR                 = 2

*    TOO_MANY_LINES                = 3

*    others                        = 4




        .

IF SY-SUBRC <> 0.




* Implement suitable error handling here




ENDIF.



CALL METHOD GC_GRID_TOP2->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = GS_VARIANT

    I_SAVE                        = 'A'




*    I_DEFAULT                     = 'X'




    IS_LAYOUT                     = GS_LAYOUT




*    IS_PRINT                      =

*    IT_SPECIAL_GROUPS             =

*    IT_TOOLBAR_EXCLUDING          =

*    IT_HYPERLINK                  =

*    IT_ALV_GRAPHICS               =

*    IT_EXCEPT_QINFO               =

*    IR_SALV_ADAPTER               =




  CHANGING

    IT_OUTTAB                     = GT_CON_RESULT

    IT_FIELDCATALOG               = GT_FC_TOP2

    IT_SORT                       = GT_SORT




*    IT_FILTER                     =

*  EXCEPTIONS

*    INVALID_PARAMETER_COMBINATION = 1

*    PROGRAM_ERROR                 = 2

*    TOO_MANY_LINES                = 3

*    others                        = 4




        .

IF SY-SUBRC <> 0.




* Implement suitable error handling here




ENDIF.



CALL METHOD GC_GRID_BOTTOM->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = GS_VARIANT

    I_SAVE                        = 'A'




*    I_DEFAULT                     = 'X'




    IS_LAYOUT                     = GS_LAYOUT




*    IS_PRINT                      =

*    IT_SPECIAL_GROUPS             =

*    IT_TOOLBAR_EXCLUDING          =

*    IT_HYPERLINK                  =

*    IT_ALV_GRAPHICS               =

*    IT_EXCEPT_QINFO               =

*    IR_SALV_ADAPTER               =




  CHANGING

    IT_OUTTAB                     = GT_EMP_RESULT

    IT_FIELDCATALOG               = GT_FC_BOTTOM

    IT_SORT                       = GT_SORT




*    IT_FILTER                     =

*  EXCEPTIONS

*    INVALID_PARAMETER_COMBINATION = 1

*    PROGRAM_ERROR                 = 2

*    TOO_MANY_LINES                = 3

*    others                        = 4




        .

IF SY-SUBRC <> 0.




* Implement suitable error handling here




ENDIF.



ENDFORM.