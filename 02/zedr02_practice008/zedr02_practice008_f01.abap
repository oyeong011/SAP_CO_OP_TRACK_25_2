
*&---------------------------------------------------------------------*

*&  Include           ZEDR02_PRACTICE008_F01

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



  GV_SDATE = SY-DATUM.

  GV_EDATE = SY-DATUM.

  GV_SDATE+6(2) = '01'. "# ## #### ##

  "# ## ##### ##

  CASE GV_SDATE+4(2).

    WHEN '01' OR '03' OR '05' OR '07' OR '08' OR '10' OR '12'.

      GV_EDATE+6(2) = '31'.

    WHEN '04' OR '06' OR '09' OR '11'.

      GV_EDATE+6(2) = '30'.

    WHEN '02'.

      IF ( GV_SDATE(4) MOD 4 = 0  AND GV_SDATE(4) MOD 100 <> 0 ) OR ( GV_SDATE(4) MOD 400 = 0 ).

        GV_EDATE+6(2) = '29'.

      ELSE.

        GV_EDATE+6(2) = '28'.

      ENDIF.

    ENDCASE.

  S_ZJDATE-LOW = GV_SDATE.

  S_ZJDATE-HIGH = GV_EDATE.

  APPEND S_ZJDATE.

  S_ZDDATE-LOW = GV_SDATE.

  S_ZDDATE-HIGH = GV_EDATE.

  APPEND S_ZDDATE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_SCREEN .



  LOOP AT SCREEN.

    "#### ##### ### ##### ##

    IF SCREEN-GROUP1 = 'M1'.

      IF P_ORDER = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSEIF P_SHIP = 'X'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    "#### ##### ### ##### ##

    IF SCREEN-GROUP1 = 'M2'.

      IF P_ORDER = 'X'.

        SCREEN-ACTIVE = '0'.

      ELSEIF P_SHIP = 'X'.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ORDER_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_ORDER_DATA .



  SELECT * FROM ZEDT02_100

    INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

    WHERE ZIDCODE IN S_ZCODE "####

    AND ZORDNO IN S_ZORDNO "##ID

    AND ZMATNR IN S_ZMATNR "####

    AND ZJDATE IN S_ZJDATE "####

    AND ZRDATE IN GR_REFUND. "RANGE ## ##->##### ### ### ######



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_GET_DATA .

  GR_REFUND-SIGN = 'I'.

  GR_REFUND-LOW = '00000000'.

  IF P_RE IS INITIAL. "###### ##### #### ## ## ##

    GR_REFUND-OPTION = 'EQ'. "##### ### ### ##### #

  ELSE. "###### ##### ### ##

    GR_REFUND-OPTION = 'GE'. "##### ### ## ### ##### #

  ENDIF.

  APPEND GR_REFUND.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  APPEND_ORDER_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM APPEND_ORDER_DATA .



  LOOP AT GT_ORDER INTO GS_ORDER.

    GS_OUTPUT-ZORDNO = GS_ORDER-ZORDNO. "####

    GS_OUTPUT-ZIDCODE = GS_ORDER-ZIDCODE. "##ID

    GS_OUTPUT-ZMATNR = GS_ORDER-ZMATNR. "####

    GS_OUTPUT-ZMATNAME = GS_ORDER-ZMATNAME. "###



    PERFORM SET_MTART. "####



    GS_OUTPUT-ZVOLUM = GS_ORDER-ZVOLUM. "##

    GS_OUTPUT-VRKME = GS_ORDER-VRKME. "Sales Unit

    GS_OUTPUT-ZNSAMT = GS_ORDER-ZNSAMT. "####

    GS_OUTPUT-ZSLAMT = GS_ORDER-ZSLAMT. "####

    GS_OUTPUT-ZDCAMT = GS_ORDER-ZDCAMT. "####

    GS_OUTPUT-ZWAERS = GS_ORDER-ZWAERS. "##



    CASE GS_ORDER-ZSALE_FG. "##(####)

      WHEN '1'.

        GS_OUTPUT-ZSALE_FG = '##'.

        GS_OUTPUT-ZCOLOR = GC_STAT_NRT.

      WHEN '2'.

        GS_OUTPUT-ZSALE_FG = '##'.

        GS_OUTPUT-ZCOLOR = GC_STAT_RTN.

    ENDCASE.



    GS_OUTPUT-ZJDATE = GS_ORDER-ZJDATE. "####



    IF P_RE IS NOT INITIAL. "######

      PERFORM SET_RET_FG. "####



      "####

      IF GS_ORDER-ZRDATE = '00000000'.

        GS_OUTPUT-ZRDATE = ''. "#### ### ## ##

      ELSE.

        WRITE: GS_ORDER-ZRDATE TO GS_OUTPUT-ZRDATE USING EDIT MASK '____.__.__'. "#### ### YYYY.MM.DD #### ##

      ENDIF.

    ENDIF.



    APPEND GS_OUTPUT TO GT_OUTPUT.

    CLEAR: GS_OUTPUT, GS_ORDER.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_SHIP_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_SHIP_DATA .



  SELECT * FROM ZEDT02_101

    INTO CORRESPONDING FIELDS OF TABLE GT_SHIP

    WHERE ZIDCODE IN S_ZCODE "####

    AND ZORDNO IN S_ZORDNO "##ID

    AND ZMATNR IN S_ZMATNR "####

    AND ZDDATE IN S_ZDDATE "####

    AND ZRDATE IN GR_REFUND. "RANGE ## ##->##### ### ### ######



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  APPEND_SHIP_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM APPEND_SHIP_DATA .



  LOOP AT GT_SHIP INTO GS_SHIP.

    GS_OUTPUT-ZORDNO = GS_SHIP-ZORDNO. "####

    GS_OUTPUT-ZIDCODE = GS_SHIP-ZIDCODE. "##ID

    GS_OUTPUT-ZMATNR = GS_SHIP-ZMATNR. "####

    GS_OUTPUT-ZMATNAME = GS_SHIP-ZMATNAME. "###



    PERFORM SET_MTART. "####



    GS_OUTPUT-ZVOLUM = GS_SHIP-ZVOLUM. "##

    GS_OUTPUT-VRKME = GS_SHIP-VRKME. "Sales Unit

    GS_OUTPUT-ZSLAMT = GS_SHIP-ZSLAMT. "####

    GS_OUTPUT-ZWAERS = GS_SHIP-ZWAERS. "##



    CASE GS_SHIP-ZDFLAG. "####

      WHEN '1'.

        GS_OUTPUT-ZDFLAG = '####'.

      WHEN '2'.

        GS_OUTPUT-ZDFLAG = '###'.

      WHEN '3'.

        GS_OUTPUT-ZDFLAG = '####'.

    ENDCASE.

    IF GS_SHIP-ZFLAG = 'X'. "#### ### #### # ##

      GS_OUTPUT-ZDFLAG = ''.

      GS_OUTPUT-ZCOLOR = GC_STAT_RTN.

    ELSE.

      GS_OUTPUT-ZCOLOR = GC_STAT_NRT.

    ENDIF.



    PERFORM SET_DGUBUN. "###



    GS_OUTPUT-ZDDATE = GS_SHIP-ZDDATE. "####



    IF P_RE IS NOT INITIAL. "#### ##

      IF GS_SHIP-ZRDATE = '00000000'.

        GS_OUTPUT-ZRDATE = ''. "#### ### ## ##

      ELSE.

        WRITE: GS_SHIP-ZRDATE TO GS_OUTPUT-ZRDATE USING EDIT MASK '____.__.__'. "#### ### YYYY.MM.DD #### ##

        GS_OUTPUT-ZRET_FG = 'X'. "####

      ENDIF.



    ENDIF.



    APPEND GS_OUTPUT TO GT_OUTPUT.

    CLEAR: GS_OUTPUT, GS_SHIP.

  ENDLOOP.

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



  CREATE OBJECT GC_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_DOCKING




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



  CLEAR: GS_VARIANT.

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



  GS_SORT-SPOS = 1. "## ##

  GS_SORT-FIELDNAME = 'ZIDCODE'. "### ### ###

  GS_SORT-UP = 'X'. "####

  GS_SORT-SUBTOT = 'X'. "## ##

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




FORM CALL_ALV USING GT_FIELDCAT TYPE LVC_T_FCAT.



  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

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

*&      Form  FIELD_CATALOG_100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_100 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT1.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-COLTEXT = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMTART'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'. "## ### ### #

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZNSAMT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'. "## ### ## ### #

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDCAMT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZSALE_FG'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZJDATE'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  IF P_RE = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZRET_FG'.

    GS_FIELDCAT-COLTEXT = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT1.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 16.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-COLTEXT = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_200 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT2.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-COLTEXT = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMTART'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDFLAG'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZDGUBUN'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZDDATE'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  IF P_RE = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 14.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-COLTEXT = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT2.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZRET_FG'.

    GS_FIELDCAT-COLTEXT = '####'.

    GS_FIELDCAT-EMPHASIZE = 'X'.

    GS_FIELDCAT-JUST = 'C'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT2.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_MTART

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_MTART .

  CASE GS_ORDER-ZMTART. "####

    WHEN '001'.

      GS_OUTPUT-ZMTART = '##'.

    WHEN '002'.

      GS_OUTPUT-ZMTART = '##'.

    WHEN '003'.

      GS_OUTPUT-ZMTART = '##'.

    WHEN '004'.

      GS_OUTPUT-ZMTART = '##'.

    WHEN '005'.

      GS_OUTPUT-ZMTART = '##'.

    WHEN '006'.

      GS_OUTPUT-ZMTART = '###'.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_RET_FG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_RET_FG .

  CASE GS_ORDER-ZRET_FG. "####

    WHEN '1'.

      GS_OUTPUT-ZRET_FG = '####'.

    WHEN '2'.

      GS_OUTPUT-ZRET_FG = '####'.

    WHEN '3'.

      GS_OUTPUT-ZRET_FG = '####'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_DGUBUN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DGUBUN .

  CASE GS_SHIP-ZDGUBUN. "####

    WHEN '1'.

      GS_OUTPUT-ZDGUBUN = '##'.

    WHEN '2'.

      GS_OUTPUT-ZDGUBUN = '###'.

    WHEN '3'.

      GS_OUTPUT-ZDGUBUN = '###'.

    WHEN '4'.

      GS_OUTPUT-ZDGUBUN = '###'.

    WHEN '5'.

      GS_OUTPUT-ZDGUBUN = '###'.

    WHEN '6'.

      GS_OUTPUT-ZDGUBUN = '###'.

    WHEN '7'.

      GS_OUTPUT-ZDGUBUN = '###'.

  ENDCASE.

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

  IF P_ORDER = 'X'. "####

    IF S_ZJDATE IS INITIAL AND S_ZORDNO IS INITIAL.

      MESSAGE E000.

      EXIT.

    ENDIF.

  ELSEIF P_SHIP = 'X'. "####

    IF S_ZDDATE IS INITIAL AND S_ZORDNO IS INITIAL.

      MESSAGE E000.

      EXIT.

    ENDIF.

  ENDIF.

ENDFORM.