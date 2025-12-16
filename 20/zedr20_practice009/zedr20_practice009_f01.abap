
*&---------------------------------------------------------------------*

*&  Include           ZEDR20_PRACTICE009_F01

*&---------------------------------------------------------------------*

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




*      PARENT                      =




      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR




*      SIDE                        = DOCK_AT_LEFT




      EXTENSION                   = 2000




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

      ROWS              = 2

      COLUMNS           = 1




*      NO_AUTODEF_PROGID_DYNNR =

*      NAME              =

*    EXCEPTIONS

*      CNTL_ERROR        = 1

*      CNTL_SYSTEM_ERROR = 2

*      others            = 3




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 2

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER1

      .

  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER2

      .

  CREATE OBJECT GC_SPLITTER2

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




      PARENT            = GC_CONTAINER2

      ROWS              = 1

      COLUMNS           = 2




*      NO_AUTODEF_PROGID_DYNNR =

*      NAME              =

*    EXCEPTIONS

*      CNTL_ERROR        = 1

*      CNTL_SYSTEM_ERROR = 2

*      others            = 3




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CALL METHOD GC_SPLITTER2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER3

      .

  CALL METHOD GC_SPLITTER2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 2

    RECEIVING

      CONTAINER = GC_CONTAINER4

      .



  CREATE OBJECT GC_GRID1

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_CONTAINER1




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

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

  CREATE OBJECT GC_GRID2

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_CONTAINER3




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

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

  CREATE OBJECT GC_GRID3

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_CONTAINER4




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

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELDCATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELDCATALOG .

  PERFORM MAKE_FIELDCAT1.

  PERFORM MAKE_FIELDCAT2.

  PERFORM MAKE_FIELDCAT3.

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

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  APPEND GS_SORT TO GT_SORT.

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

  CLEAR: GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-TOTALS_BEF = 'X'.



  CLEAR: GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

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

  CALL METHOD GC_GRID1->SET_TABLE_FOR_FIRST_DISPLAY

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

      IT_OUTTAB                     = GT_ZPINFO_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT1

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

  CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY

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

      IT_OUTTAB                     = GT_RANK_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT2

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

  CALL METHOD GC_GRID3->SET_TABLE_FOR_FIRST_DISPLAY

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

      IT_OUTTAB                     = GT_SALARY_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT3

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_DEFAULT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DEFAULT .

  GV_DATE = SY-DATUM.

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN                  = GV_DATE

   IMPORTING

     LAST_DAY_OF_MONTH       = S_ZDATE-LOW




*   EXCEPTIONS

*     DAY_IN_NO_DATE          = 1

*     OTHERS                  = 2




            .

  IF SY-SUBRC <> 0.




* Implement suitable error handling here




  ENDIF.

  APPEND S_ZDATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT_ERROR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INPUT_ERROR .

  IF ( S_ZDATE IS INITIAL ) OR ( S_ZPERNR IS INITIAL AND S_ZDEP IS INITIAL ).

    MESSAGE S000 DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

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

   "PERFORM SET_DATE.

  IF P_C1 = 'X'.

    PERFORM GET_ZPINFO_DATA.

  ELSE.

    PERFORM GET_EXCEPTED_ZPINFO_DATA.

  ENDIF.

  PERFORM GET_RANK_DATA.

  PERFORM GET_SALARY_DATA.

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

  PERFORM MODIFY_ZPINFO_DATA.

  PERFORM MODIFY_RANK_DATA.

  PERFORM MODIFY_SALARY_DATA.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ZPINFO_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_ZPINFO_DATA .

  SELECT

        A~ZPERNR

        B~ZPNAME

        A~ZDEPCODE

        A~DATBI

        A~DATAB

        A~ZDEPRANK

        B~ZGENDER

        A~ZEDATE

        B~ZADDRESS

        A~ZQFLAG

        A~ZQDATE

      INTO CORRESPONDING FIELDS OF TABLE GT_ZPINFO_DATA

      FROM ZEDT20_102 AS A

        INNER JOIN ZEDT20_103 AS B ON B~ZPERNR = A~ZPERNR

      WHERE A~DATBI LE S_ZDATE-LOW

      AND A~DATAB GE S_ZDATE-LOW

      AND A~ZPERNR IN S_ZPERNR

      AND A~ZDEPCODE IN S_ZDEP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_RANK_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_RANK_DATA .

  SELECT

  *

  INTO CORRESPONDING FIELDS OF TABLE GT_RANK_DATA

  FROM ZEDT20_104

  FOR ALL ENTRIES IN GT_ZPINFO_DATA

  WHERE ZPERNR = GT_ZPINFO_DATA-ZPERNR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_SALARY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_SALARY_DATA .

  SELECT

    *

    INTO CORRESPONDING FIELDS OF TABLE GT_SALARY_DATA

    FROM ZEDT20_106

    FOR ALL ENTRIES IN GT_ZPINFO_DATA

    WHERE ZPERNR = GT_ZPINFO_DATA-ZPERNR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DATE .

  CONCATENATE SY-DATUM+0(6) '01' INTO R_DATE-LOW.

  R_DATE-HIGH = S_ZDATE-LOW.

  R_DATE-SIGN = 'I'.

  R_DATE-OPTION = 'BT'.

  APPEND R_DATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZPINFO_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_ZPINFO_DATA .

  LOOP AT GT_ZPINFO_DATA INTO GS_ZPINFO_DATA.

    CLEAR: GS_ZPINFO_ALV.

    MOVE-CORRESPONDING GS_ZPINFO_DATA TO GS_ZPINFO_ALV.

    PERFORM GET_ZDEPNAME USING GS_ZPINFO_DATA-ZDEPCODE

                            CHANGING GS_ZPINFO_ALV-ZDEPNAME.

    PERFORM GET_ZRNAME USING GS_ZPINFO_DATA-ZDEPRANK

                       CHANGING GS_ZPINFO_ALV-ZRNAME.

    PERFORM GET_ZCOLOR USING GS_ZPINFO_ALV-ZRNAME GS_ZPINFO_DATA-ZQFLAG

                       CHANGING GS_ZPINFO_ALV-ZCOLOR.

    PERFORM GET_ZGENDER_KR USING GS_ZPINFO_DATA-ZGENDER

                           CHANGING GS_ZPINFO_ALV-ZGENDER_KR.

    APPEND GS_ZPINFO_ALV TO GT_ZPINFO_ALV.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_RANK_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_RANK_DATA .

  LOOP AT GT_RANK_DATA INTO GS_RANK_DATA.

    CLEAR: GS_RANK_ALV.

    MOVE-CORRESPONDING GS_RANK_DATA TO GS_RANK_ALV.

    PERFORM GET_ZDEPNAME USING GS_RANK_DATA-ZDEPCODE

                            CHANGING GS_RANK_ALV-ZDEPNAME.

    APPEND GS_RANK_ALV TO GT_RANK_ALV.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_SALARY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_SALARY_DATA .

  LOOP AT GT_SALARY_DATA INTO GS_SALARY_DATA.

    CLEAR: GS_SALARY_ALV.

    MOVE-CORRESPONDING GS_SALARY_DATA TO GS_SALARY_ALV.

    PERFORM GET_ZBANKNAME USING GS_SALARY_DATA-ZBANKCODE

                            CHANGING GS_SALARY_ALV-ZBANKNAME.

    PERFORM GET_ZWAERS USING GS_SALARY_DATA-ZBANKCODE

                        CHANGING GS_SALARY_ALV-ZWAERS.

    APPEND GS_SALARY_ALV TO GT_SALARY_ALV.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ZDEPNAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ZPINFO_DATA_ZDEPCODE  text

*      <--P_GS_ZPINFO_ALV_ZDEPNAME  text

*----------------------------------------------------------------------*




FORM GET_ZDEPNAME  USING    P_ZDEPCODE

                   CHANGING P_ZDEPNAME.

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

*&      Form  GET_ZRNAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ZPINFO_DATA_ZDEPRANK  text

*      <--P_GS_ZPINFO_ALV_ZRNAME  text

*----------------------------------------------------------------------*




FORM GET_ZRNAME  USING    P_ZDEPRANK

                 CHANGING P_ZRNAME.

  CASE P_ZDEPRANK.

      WHEN 'A'.

        P_ZRNAME = '##'.

      WHEN 'B'.

        P_ZRNAME = '##'.

      WHEN 'C'.

        P_ZRNAME = '##'.

      WHEN 'D'.

        P_ZRNAME = '##'.

      WHEN 'E'.

        P_ZRNAME = '##'.

      WHEN 'F'.

        P_ZRNAME = '##'.

      WHEN 'G'.

        P_ZRNAME = '##'.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ZCOLOR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ZPINFO_ALV_ZRNAME  text

*      <--P_GS_ZPINFO_ALV_ZCOLOR  text

*----------------------------------------------------------------------*




FORM GET_ZCOLOR  USING    P_ZRNAME P_ZQFLAG

                 CHANGING P_ZCOLOR.

  IF P_ZQFLAG = 'X'.

    P_ZCOLOR = '@0A@'.

  ELSEIF P_ZRNAME = '##'.

    P_ZCOLOR = '@09@'.

  ELSE.

    P_ZCOLOR = '@08@'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_EXCEPTED_ZPINFO_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_EXCEPTED_ZPINFO_DATA .

  SELECT

      A~ZPERNR

      B~ZPNAME

      A~ZDEPCODE

      A~DATBI

      A~DATAB

      A~ZDEPRANK

      B~ZGENDER

      A~ZEDATE

      B~ZADDRESS

      A~ZQFLAG

      A~ZQDATE

    INTO CORRESPONDING FIELDS OF TABLE GT_ZPINFO_DATA

    FROM ZEDT20_102 AS A

      INNER JOIN ZEDT20_103 AS B ON B~ZPERNR = A~ZPERNR

    WHERE A~DATBI LT S_ZDATE-LOW

    AND A~DATAB GT S_ZDATE-LOW

    AND A~ZQFLAG NE 'X'

    AND A~ZPERNR IN S_ZPERNR

    AND A~ZDEPCODE IN S_ZDEP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ZBANKNAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_SALARY_DATA_ZBANKCODE  text

*      <--P_GS_SALARY_ALV_ZBANKNAME  text

*----------------------------------------------------------------------*




FORM GET_ZBANKNAME  USING    P_ZBANKCODE

                    CHANGING P_ZBANKNAME.

  CASE P_ZBANKCODE.

      WHEN '001'.

        P_ZBANKNAME = '##'.

      WHEN '002'.

        P_ZBANKNAME = '##'.

      WHEN '003'.

        P_ZBANKNAME = '##'.

      WHEN '004'.

        P_ZBANKNAME = '##'.

      WHEN '005'.

        P_ZBANKNAME = '###'.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAKE_FIELDCAT1

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MAKE_FIELDCAT1 .

  CLEAR: GT_FIELDCAT1, GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZRNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER_KR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CHECK P_C1 = 'X'.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZQDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZQFLAG'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAKE_FIELDCAT2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MAKE_FIELDCAT2 .

  CLEAR: GS_FIELDCAT, GT_FIELDCAT2.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAKE_FIELDCAT3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MAKE_FIELDCAT3 .

  CLEAR: GT_FIELDCAT3, GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZBANKNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ZGENDER_KR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ZPINFO_DATA_ZGENDER  text

*      <--P_GS_ZPINFO_ALV_ZGENDER_KR  text

*----------------------------------------------------------------------*




FORM GET_ZGENDER_KR  USING    P_ZGENDER

                     CHANGING P_ZGENDER_KR.

  CASE P_ZGENDER.

    WHEN 'M'.

      P_ZGENDER_KR = '##'.

    WHEN 'F'.

      P_ZGENDER_KR = '##'.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ZWAERS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_GS_SALARY_ALV_ZWAERS  text

*----------------------------------------------------------------------*




FORM GET_ZWAERS USING P_ZBANKCODE

                CHANGING P_ZWAERS.

  R_BANKCODE-LOW = '001'.

  R_BANKCODE-HIGH = '010'.

  R_BANKCODE-SIGN = 'I'.

  R_BANKCODE-OPTION = 'BT'.

  APPEND R_BANKCODE.

  IF P_ZBANKCODE IN R_BANKCODE.

    P_ZWAERS = 'KRW'.

  ENDIF.

ENDFORM.