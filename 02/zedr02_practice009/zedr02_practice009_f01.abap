
*&---------------------------------------------------------------------*

*&  Include           ZEDR02_PRACTICE009_F01

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

  P_DATE = SY-DATUM.

  CALL FUNCTION 'LAST_DAY_OF_MONTHS' "### # ##

    EXPORTING

      DAY_IN                  = P_DATE

   IMPORTING

     LAST_DAY_OF_MONTH       = P_DATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VALIDATE_INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM VALIDATE_INPUT .

  IF P_DATE = '00000000' OR ( S_ZPERNR IS INITIAL AND P_DEPCO = '' ). "####, (#### ## ####) ## ##)

    MESSAGE E000.

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




FORM GET_DATA.



  IF P_DEPCO IS NOT INITIAL. "##### #### ## ##

    GR_DEP-OPTION = 'EQ'.

    GR_DEP-LOW = P_DEPCO.

    GR_DEP-SIGN = 'I'.

    APPEND GR_DEP.

  ENDIF.



  SELECT A~ZPERNR "####

         B~ZPNAME "####

         A~ZDEPCODE "####

         A~ZDEPRANK "####

         A~ZEDATE "###

         A~ZQFLAG "####

         B~ZGENDER "##

         B~ZADDRESS "##

         A~DATBI "####_FR

         A~DATAB "####_TO

         A~ZQDATE "####

    INTO CORRESPONDING FIELDS OF TABLE GT_EMP

    FROM ZEDT02_102 AS A "#### ###

    LEFT OUTER JOIN ZEDT02_103 AS B ON A~ZPERNR = B~ZPERNR. "####-#### ###



  DELETE GT_EMP WHERE ZPERNR NOT IN S_ZPERNR. "#### ##### ## ## ### ##

  DELETE GT_EMP WHERE DATBI > P_DATE. "#### ### ### ### ##

  DELETE GT_EMP WHERE DATAB < P_DATE. "#### ### ### ### ##

  DELETE GT_EMP WHERE ZDEPCODE NOT IN GR_DEP. "#### ##### ## ## ### ##



  IF P_RE IS INITIAL. "#### #### ## ##

    DELETE GT_EMP WHERE ZQFLAG = 'X'. "### ##

  ENDIF.



  IF GT_EMP IS INITIAL.

    MESSAGE E001.

    STOP.

  ENDIF.



  SELECT * FROM ZEDT02_104 "#### ###

      INTO TABLE GT_EVAL

      FOR ALL ENTRIES IN GT_EMP

      WHERE ZPERNR = GT_EMP-ZPERNR.



  SELECT * FROM ZEDT02_106 "#### ###

      INTO TABLE GT_CONT

      FOR ALL ENTRIES IN GT_EMP

      WHERE ZPERNR = GT_EMP-ZPERNR.





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



  CREATE OBJECT GC_SPLITTER_BOTTOM

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



  CALL METHOD GC_SPLITTER_BOTTOM->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER_TOP "## ####

      .



  CALL METHOD GC_SPLITTER_BOTTOM->GET_CONTAINER

    EXPORTING

      ROW       = 2

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER_EMP "####(###) ####

      .



  CREATE OBJECT GC_SPLITTER_TOP

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




      PARENT            = GC_CONTAINER_TOP

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



  CALL METHOD GC_SPLITTER_TOP->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER_EVAL "####(## #) ####

      .



  CALL METHOD GC_SPLITTER_TOP->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 2

    RECEIVING

      CONTAINER = GC_CONTAINER_CONT "####(### #) ####

      .



  CREATE OBJECT GC_GRID_EMP

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_CONTAINER_EMP




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



  CREATE OBJECT GC_GRID_EVAL

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_CONTAINER_EVAL




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



  CREATE OBJECT GC_GRID_CONT

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_CONTAINER_CONT




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

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .



  CLEAR : GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-TOTALS_BEF = 'X'. "### ### ##



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



  GS_SORT-SPOS = 1. "## ##

  GS_SORT-FIELDNAME = 'ZPERNR'. "### ### ###

  GS_SORT-UP = 'X'. "####

  APPEND GS_SORT TO GT_SORT.



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



  PERFORM FCAT_EMP.

  PERFORM FCAT_EVAL.

  PERFORM FCAT_CONT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV USING GC_GRID TYPE REF TO CL_GUI_ALV_GRID CHANGING GT_FIELDCAT TYPE LVC_T_FCAT GT_OUTPUT TYPE STANDARD TABLE.

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =

*      IS_VARIANT                    =

*      I_SAVE                        =

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

      IT_OUTTAB                     = GT_OUTPUT

      IT_FIELDCATALOG               = GT_FIELDCAT

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

*&      Form  FCAT_EMP

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FCAT_EMP .



  CLEAR : GS_FIELDCAT, GT_FIELDCAT_EMP.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_EMP.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_EMP.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_EMP.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_EMP.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_EMP.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_EMP.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANKNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_EMP.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_EMP.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_EMP.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_EMP.



  IF P_RE = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 11.

    GS_FIELDCAT-FIELDNAME = 'ZQDATE'.

    GS_FIELDCAT-COLTEXT = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT_EMP.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 12.

    GS_FIELDCAT-FIELDNAME = 'ZQFLAG'.

    GS_FIELDCAT-COLTEXT = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT_EMP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FCAT_EVAL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FCAT_EVAL .



  CLEAR : GS_FIELDCAT, GT_FIELDCAT_EVAL.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_EVAL.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_EVAL.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_EVAL.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_EVAL.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_EVAL.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_EVAL.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FCAT_CONT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FCAT_CONT .



  CLEAR : GS_FIELDCAT, GT_FIELDCAT_CONT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_CONT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_CONT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_CONT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_CONT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-DO_SUM = 'X'. "## ##

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'. "## ### ## ### #

  GS_FIELDCAT-OUTPUTLEN = 20. "# ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT_CONT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZBANKNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_CONT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_CONT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  APPEND_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM APPEND_DATA .



  LOOP AT GT_EMP INTO GS_EMP.

    CLEAR: GS_EMP_OUTPUT, GS_EVAL_OUTPUT, GS_CONT_OUTPUT.



    READ TABLE GT_EVAL INTO GS_EVAL WITH KEY ZPERNR = GS_EMP-ZPERNR.

    READ TABLE GT_CONT INTO GS_CONT WITH KEY ZPERNR = GS_EMP-ZPERNR.



    GS_EMP_OUTPUT-ZCOLOR = GC_STAT_ACTIVE. "## #(##) ##



    "#### ##

    GS_EMP_OUTPUT-ZPERNR = GS_EMP-ZPERNR.

    GS_EVAL_OUTPUT-ZPERNR = GS_EMP-ZPERNR.

    GS_CONT_OUTPUT-ZPERNR = GS_EMP-ZPERNR.



    "## ##

    GS_EVAL_OUTPUT-ZYEAR = GS_EVAL-ZYEAR.

    GS_CONT_OUTPUT-ZYEAR = GS_CONT-ZYEAR.



    "### ##

    GS_EMP_OUTPUT-DATBI = GS_EMP-DATBI.

    GS_EVAL_OUTPUT-DATBI = GS_EVAL-DATBI.

    GS_CONT_OUTPUT-DATBI = GS_CONT-DATBI.



    "### ##

    GS_EMP_OUTPUT-DATAB = GS_EMP-DATAB.

    GS_EVAL_OUTPUT-DATAB = GS_EVAL-DATAB.

    GS_CONT_OUTPUT-DATAB = GS_CONT-DATAB.



    GS_EMP_OUTPUT-ZPNAME = GS_EMP-ZPNAME. "## ##

    GS_EMP_OUTPUT-ZEDATE = GS_EMP-ZEDATE. "#### ##

    GS_EMP_OUTPUT-ZADDRESS = GS_EMP-ZADDRESS. "## ##

    GS_EVAL_OUTPUT-ZRANK = GS_EVAL-ZRANK. "## ##

    GS_CONT_OUTPUT-ZSALARY = GS_CONT-ZSALARY. "#### ##

    GS_CONT_OUTPUT-ZACCOUNT = GS_CONT-ZACCOUNT. "#### ##



    PERFORM SET_GENDER USING GS_EMP-ZGENDER CHANGING GS_EMP_OUTPUT-ZGENDER. "## ##



    PERFORM SET_DEPRANKNAME USING GS_EMP-ZDEPRANK CHANGING GS_EMP_OUTPUT-ZDEPRANKNAME. "### ##



    IF GS_EMP_OUTPUT-ZDEPRANKNAME = '##'. "#### ##### ##

      GS_EMP_OUTPUT-ZCOLOR = GC_STAT_INTERN.

    ENDIF.



    PERFORM SET_DEPNAME USING GS_EMP-ZDEPCODE CHANGING GS_EMP_OUTPUT-ZDEPNAME. "### ##

    GS_EVAL_OUTPUT-ZDEPNAME = GS_EMP_OUTPUT-ZDEPNAME.



    PERFORM SET_BANKNAME USING GS_CONT-ZBANKCODE CHANGING GS_CONT_OUTPUT-ZBANKNAME GS_CONT_OUTPUT-ZWAERS. "### # ## ##



    IF P_RE = 'X'. "###### ##

      GS_EMP_OUTPUT-ZQFLAG = GS_EMP-ZQFLAG. "####

      GS_EMP_OUTPUT-ZQDATE = GS_EMP-ZQDATE. "####

      IF GS_EMP-ZQFLAG = 'X'. "#### ### ##

        GS_EMP_OUTPUT-ZCOLOR = GC_STAT_RETIREE.

      ENDIF.

    ENDIF.



    APPEND GS_EMP_OUTPUT TO GT_EMP_OUTPUT.

    APPEND GS_EVAL_OUTPUT TO GT_EVAL_OUTPUT.

    APPEND GS_CONT_OUTPUT TO GT_CONT_OUTPUT.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_GENDER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP_ZGENDER  text

*      <--P_GS_EMP_OUTPUT_ZGENDER  text

*----------------------------------------------------------------------*




FORM SET_GENDER  USING    LS_GENDER_CODE TYPE ZGENDER02

                 CHANGING LS_GENDER_NAME TYPE C.

  CASE : LS_GENDER_CODE. "##

    WHEN 'M'. LS_GENDER_NAME = '##'.

    WHEN 'F'. LS_GENDER_NAME = '##'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_DEPRANKNAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP_ZDEPRANK  text

*      <--P_GS_EMP_OUTPUT_ZDEPRANKNAME  text

*----------------------------------------------------------------------*




FORM SET_DEPRANKNAME  USING    LS_DEPRANK TYPE ZDEPRANK02

                      CHANGING LS_DEPRANKNAME TYPE C.

  CASE: LS_DEPRANK. "###

    WHEN 'A'. LS_DEPRANKNAME = '##'.

    WHEN 'B'. LS_DEPRANKNAME = '##'.

    WHEN 'C'. LS_DEPRANKNAME = '##'.

    WHEN 'D'. LS_DEPRANKNAME = '##'.

    WHEN 'E'. LS_DEPRANKNAME = '##'.

    WHEN 'F'. LS_DEPRANKNAME = '##'.

    WHEN 'G'. LS_DEPRANKNAME = '##'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_DEPNAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP_DEPCODE  text

*      <--P_GS_EMP_OUTPUT_ZDEPNAME  text

*----------------------------------------------------------------------*




FORM SET_DEPNAME  USING    LS_DEPCODE TYPE ZDEPCODE02

                  CHANGING LS_DEPNAME TYPE C.

    CASE: LS_DEPCODE. "###

      WHEN 'SS0001'. LS_DEPNAME = '###'.

      WHEN 'SS0002'. LS_DEPNAME = '###'.

      WHEN 'SS0003'. LS_DEPNAME = '###'.

      WHEN 'SS0004'. LS_DEPNAME = '###'.

      WHEN 'SS0005'. LS_DEPNAME = '###'.

      WHEN 'SS0006'. LS_DEPNAME = '###'.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_BANKNAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_CONT_BANKCODE  text

*      <--P_GS_CONT_ZBANKNAME  text

*----------------------------------------------------------------------*




FORM SET_BANKNAME  USING    LS_BANKCODE TYPE ZBANKCODE02

                   CHANGING LS_BANKNAME TYPE C

                            LS_WAERS TYPE WAERS.

    CASE : LS_BANKCODE. "###

      WHEN '001'. LS_BANKNAME = '####'.

      WHEN '002'. LS_BANKNAME = '####'.

      WHEN '003'. LS_BANKNAME = '####'.

      WHEN '004'. LS_BANKNAME = '####'.

      WHEN '005'. LS_BANKNAME = '#####'.

    ENDCASE.



    IF LS_BANKCODE >= 001 AND LS_BANKCODE <= 010. "##### 001~010## KRW

      LS_WAERS = 'KRW'.

    ENDIF.



ENDFORM.