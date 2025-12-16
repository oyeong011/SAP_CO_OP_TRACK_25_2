
*&---------------------------------------------------------------------*

*&  Include           ZEDR08_PRACTICE009_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DATE . "## ### ## ## ## ##



  DATA LV_FIRST TYPE D.

  DATA LV_LAST TYPE D.

  LV_FIRST = SY-DATUM.

  LV_FIRST+6(2) = '01'.



  " ### ##

  S_DATE-SIGN = 'I'.

  S_DATE-OPTION = 'EQ'.

  S_DATE-LOW = LV_FIRST.



  " ## #### ## ## ### ### ##

  CALL FUNCTION 'LAST_DAY_OF_MONTHS'

    EXPORTING DAY_IN = LV_FIRST

    IMPORTING LAST_DAY_OF_MONTH = LV_FIRST.



  " ### ## ### ##

  APPEND S_DATE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  START_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM START_SCREEN . " ## # ## ## ### ##



  PERFORM CHECK_DATA.

  PERFORM SCREEN_DISPLAY.



  PERFORM GET_DATA. " ### ##

  PERFORM MODIFY_DATA. " ### ##



  IF GT_EMPLOYEE[] IS INITIAL.

    MESSAGE '#### #### ####.' TYPE 'I'.

    EXIT.

  ELSE.

    CALL SCREEN 100.

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



  IF S_DATE IS NOT INITIAL.

    IF ( S_ZDEP IS INITIAL ) AND ( S_ZEMP IS INITIAL ).

      MESSAGE '##### #### ## ######.' TYPE 'I'.

      STOP.

    ENDIF.

  ELSE.

    MESSAGE '### ######.' TYPE 'I'.

    STOP.

  ENDIF.



  CLEAR: R_FG, R_FG[].



  R_FG-SIGN = 'I'.

  R_FG-OPTION = 'EQ'.

  R_FG-LOW = ' '.



  APPEND R_FG.



  IF P_CHK1 = C_X.

    R_FG-LOW = 'X'.



    APPEND R_FG.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SCREEN_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SCREEN_DISPLAY .



  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'

    EXPORTING

      TEXT = '#### #### ####.'.



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



  SELECT A~ZPERNR

         B~ZPNAME

         A~ZDEPRANK

         A~ZDEPCODE

         B~ZGENDER

         A~DATBI

         A~DATAB

         A~ZDEPRANK

         A~ZEDATE

         A~ZQDATE

         A~ZQFLAG

         B~ZADDRESS

    INTO CORRESPONDING FIELDS OF TABLE GT_EMPLOYEE FROM ZEDT08_102 AS A INNER JOIN ZEDT08_103 AS B

    ON A~ZPERNR = B~ZPERNR WHERE A~ZPERNR IN S_ZEMP AND A~ZDEPCODE IN S_ZDEP

    AND ( DATBI LE S_DATE-LOW AND DATAB GE S_DATE-LOW )

    AND ZQFLAG IN R_FG.



    IF GT_EMPLOYEE[] IS NOT INITIAL.

      SELECT * FROM ZEDT08_106 INTO CORRESPONDING FIELDS OF TABLE GT_CONTACT

        FOR ALL ENTRIES IN GT_EMPLOYEE WHERE ZPERNR = GT_EMPLOYEE-ZPERNR AND ZYEAR = S_DATE-LOW+0(4)

        AND ( DATBI LE S_DATE-LOW AND DATAB GE S_DATE-LOW ).



      SELECT * FROM ZEDT08_104 INTO CORRESPONDING FIELDS OF TABLE GT_ASSESS

        FOR ALL ENTRIES IN GT_EMPLOYEE WHERE ZPERNR = GT_EMPLOYEE-ZPERNR AND ZDEPCODE = GT_EMPLOYEE-ZDEPCODE

        AND ZYEAR = S_DATE-LOW+0(4) AND ( DATBI LE S_DATE-LOW AND DATAB GE S_DATE-LOW ).

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



  CLEAR: GS_EMPLOYEE, GT_EMPLOYEE_ALV, GS_CONTACT, GS_CONTACT_ALV, GS_ASSESS, GS_ASSESS_ALV.



  LOOP AT GT_EMPLOYEE INTO GS_EMPLOYEE.

    MOVE-CORRESPONDING GS_EMPLOYEE TO GS_EMPLOYEE_ALV.



    PERFORM ZDEPCODE_NAME USING GS_EMPLOYEE-ZDEPCODE CHANGING GS_EMPLOYEE_ALV-ZDEPCODE_NAME.

    PERFORM ZRANK_NAME USING GS_EMPLOYEE-ZDEPRANK CHANGING GS_EMPLOYEE_ALV-ZRANK_NAME.



    IF GS_EMPLOYEE-ZGENDER = 'M'.

      GS_EMPLOYEE_ALV-ZGENDER_NAME = '##'.

    ELSEIF GS_EMPLOYEE-ZGENDER = 'F'.

      GS_EMPLOYEE_ALV-ZGENDER_NAME = '##'.

    ENDIF.



    IF GS_EMPLOYEE-ZQFLAG = 'X'.

      GS_EMPLOYEE_ALV-ICON = '@0A@'.

    ELSE.

      IF GS_EMPLOYEE-ZDEPRANK = 'A'.

        GS_EMPLOYEE_ALV-ICON = '@09@'.

      ELSE.

        GS_EMPLOYEE_ALV-ICON = '@08@'.

      ENDIF.

    ENDIF.



    APPEND GS_EMPLOYEE_ALV TO GT_EMPLOYEE_ALV.



    CLEAR : GS_EMPLOYEE, GS_EMPLOYEE_ALV.

  ENDLOOP.



  " ## ## ## ALV

  LOOP AT GT_CONTACT INTO GS_CONTACT.

    MOVE-CORRESPONDING GS_CONTACT TO GS_CONTACT_ALV.



    PERFORM ZBANKS_NAME USING GS_CONTACT-ZBANKCODE CHANGING GS_CONTACT_ALV-ZBANK_NAME.



    IF GS_CONTACT-ZBANKCODE BETWEEN '001' AND '010'.

      GS_CONTACT_ALV-ZWAERS = 'KRW'.

    ENDIF.



    APPEND GS_CONTACT_ALV TO GT_CONTACT_ALV.



    CLEAR: GS_CONTACT, GS_CONTACT_ALV.

  ENDLOOP.



  " ## ## ALV

  LOOP AT GT_ASSESS INTO GS_ASSESS.

    MOVE-CORRESPONDING GS_ASSESS TO GS_ASSESS_ALV.



    PERFORM ZDEPCODE_NAME USING GS_ASSESS-ZDEPCODE CHANGING GS_ASSESS_ALV-ZDEPCODE_NAME.



    APPEND GS_ASSESS_ALV TO GT_ASSESS_ALV.



    CLEAR: GS_ASSESS, GS_ASSESS_ALV.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZDEPCODE_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMPLOYEE_ZDEPCODE  text

*      <--P_GS_EMPLOYEE_ALV_ZDEPCODE_NAME  text

*----------------------------------------------------------------------*




FORM ZDEPCODE_NAME  USING    P_GS_EMPLOYEE_ZDEPCODE

                    CHANGING P_GS_EMPLOYEE_ZDEPCODE_NAME.



  CASE P_GS_EMPLOYEE_ZDEPCODE.

    WHEN 'SS0001'.

      P_GS_EMPLOYEE_ZDEPCODE_NAME = '###'.

    WHEN 'SS0002'.

      P_GS_EMPLOYEE_ZDEPCODE_NAME = '###'.

    WHEN 'SS0003'.

      P_GS_EMPLOYEE_ZDEPCODE_NAME = '###'.

    WHEN 'SS0004'.

      P_GS_EMPLOYEE_ZDEPCODE_NAME = '###'.

    WHEN 'SS0005'.

      P_GS_EMPLOYEE_ZDEPCODE_NAME = '###'.

    WHEN 'SS0006'.

      P_GS_EMPLOYEE_ZDEPCODE_NAME = '###'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZRANK_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMPLOYEE_ZDEPRANK  text

*      <--P_GS_EMPLOYEE_ALV_ZRANK_NAME  text

*----------------------------------------------------------------------*




FORM ZRANK_NAME  USING    P_GS_EMPLOYEE_ZDEPRANK

                 CHANGING P_GS_EMPLOYEE_ZRANK_NAME.



  CASE P_GS_EMPLOYEE_ZDEPRANK.

    WHEN 'A'.

      P_GS_EMPLOYEE_ZRANK_NAME = '##'.

    WHEN 'B'.

      P_GS_EMPLOYEE_ZRANK_NAME = '##'.

    WHEN 'C'.

      P_GS_EMPLOYEE_ZRANK_NAME = '##'.

    WHEN 'D'.

      P_GS_EMPLOYEE_ZRANK_NAME = '##'.

    WHEN 'E'.

      P_GS_EMPLOYEE_ZRANK_NAME = '##'.

    WHEN 'F'.

      P_GS_EMPLOYEE_ZRANK_NAME = '##'.

    WHEN 'G'.

      P_GS_EMPLOYEE_ZRANK_NAME = '##'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZBANKS_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_CONTACT_ZBANKCODE  text

*      <--P_GS_CONTACT_ALV_ZBANK_NAME  text

*----------------------------------------------------------------------*




FORM ZBANKS_NAME  USING    P_GS_CONTACT_ZBANKCODE

                  CHANGING P_GS_CONTACT_ALV_ZBANK_NAME.



  CASE P_GS_CONTACT_ZBANKCODE.

    WHEN '001'.

      P_GS_CONTACT_ALV_ZBANK_NAME = '####'.

    WHEN '002'.

      P_GS_CONTACT_ALV_ZBANK_NAME = '####'.

    WHEN '003'.

      P_GS_CONTACT_ALV_ZBANK_NAME = '####'.

    WHEN '004'.

      P_GS_CONTACT_ALV_ZBANK_NAME = '####'.

    WHEN '005'.

      P_GS_CONTACT_ALV_ZBANK_NAME = '#####'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREAT_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREAT_OBJECT .



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



  CREATE OBJECT GC_SPLITTER1

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



  CALL METHOD GC_SPLITTER1->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER1

      .



  CALL METHOD GC_SPLITTER1->GET_CONTAINER

    EXPORTING

      ROW       = 2

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




      PARENT            = GC_CONTAINER1

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



  CREATE OBJECT GC_GRID2

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



  CREATE OBJECT GC_GRID3

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_CONTAINER2




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

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG .



  PERFORM FIELD_CONTAINER_2.

  PERFORM FIELD_CONTAINER_3.

  PERFORM FIELD_CONTAINER_4.



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



  CLEAR: GS_SORT1, GT_SORT1.



  GS_SORT1-SPOS = 1.

  GS_SORT1-FIELDNAME = 'ZPERNR'.

  GS_SORT1-UP = 'X'.



  APPEND GS_SORT1 TO GT_SORT1.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  LAYOUT_SET

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM LAYOUT_SET .



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-TOTALS_BEF = 'X'.



  CLEAR GS_VARIANT.

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

      I_SAVE                        = C_A




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

      IT_OUTTAB                     = GT_ASSESS_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT3

      IT_SORT                       = GT_SORT1




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

      I_SAVE                        = C_A




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

      IT_OUTTAB                     = GT_CONTACT_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT2

      IT_SORT                       = GT_SORT1




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

      I_SAVE                        = C_A




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

      IT_OUTTAB                     = GT_EMPLOYEE_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT1

      IT_SORT                       = GT_SORT1




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

*&      Form  FIELD_CONTAINER_2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CONTAINER_2 .



  CLEAR : GS_FIELDCAT, GT_FIELDCAT1.



  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ICON'.

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

  GS_FIELDCAT-FIELDNAME = 'ZRANK_NAME'.

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



  IF P_CHK1 = C_X.

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

*&      Form  FIELD_CONTAINER_3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CONTAINER_3 .



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

*&      Form  FIELD_CONTAINER_4

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CONTAINER_4 .



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