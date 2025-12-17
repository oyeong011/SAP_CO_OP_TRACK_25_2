
*&---------------------------------------------------------------------*

*&  Include           ZEDR08_PRACTICE008_F01

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

  S_ZJDATE-SIGN = 'I'.

  S_ZJDATE-OPTION = 'BT'.

  S_ZJDATE-LOW = LV_FIRST.

  S_ZDDATE-SIGN = 'I'.

  S_ZDDATE-OPTION = 'BT'.

  S_ZDDATE-LOW = LV_FIRST.



  " ## #### ## ## ### ### ##

  CALL FUNCTION 'LAST_DAY_OF_MONTHS'

    EXPORTING DAY_IN = LV_FIRST

    IMPORTING LAST_DAY_OF_MONTH = LV_LAST.



  " #### ###

  S_ZJDATE-HIGH = LV_LAST.

  " #### ###

  S_ZDDATE-HIGH = LV_LAST.



  " ### ## ### ##

  APPEND S_ZJDATE.

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




FORM SET_SCREEN . " ### ### ## ## ## ###, ##### ## ### ## ##



  " ### ## ## ##

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M4'.

      " ## ## ## ## ## ##

      IF P_RBUT1 = C_X.

        SCREEN-ACTIVE = 1.

      ELSE.

        SCREEN-ACTIVE = 0.

      ENDIF.

      MODIFY SCREEN.

    ENDIF.



    IF SCREEN-GROUP1 = 'M5'.

      " ## ## ## ## ## ##

      IF P_RBUT2 = C_X.

        SCREEN-ACTIVE = 1.

      ELSE.

        SCREEN-ACTIVE = 0.

      ENDIF.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.



  " #### ## ## ## ## ## ##

  IF P_RBUT1 = C_X.

    REFRESH R_FG.

    R_FG-SIGN = 'I'.

    R_FG-OPTION = 'EQ'.

    R_FG-LOW = '1'. " ## ##

    APPEND R_FG.



    " ###### ## ## ## ## ## ##

    IF P_CHK1 = C_X.

      R_FG-LOW = '2'. " ## ##

      APPEND R_FG.

    ENDIF.



  " #### ## ## ## ## ## ##

  ELSEIF P_RBUT2 = C_X.

    REFRESH R_FG.

    R_ZG-SIGN = 'I'.

    R_ZG-OPTION = 'EQ'.

    R_ZG-LOW = ' '. " ## ##

    APPEND R_ZG.



    " ###### ## ## ## ## ## ##

    IF P_CHK1 = C_X.

      R_ZG-LOW = C_X. " ## ##

      APPEND R_ZG.

    ENDIF.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_ORDER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA_ORDER . " ZEDT08_100 ##### ### ## ### ##



  SELECT * FROM ZEDT08_100 INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

    WHERE ZORDNO IN S_ZORDNO AND ZIDCODE IN S_ZCODE AND ZMATNR IN S_ZMATNR

    AND ZJDATE IN S_ZJDATE AND ZSALE_FG IN R_FG.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_DELIVER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA_DELIVERY . " ZEDT08_101 ##### ### ## ### ##



  SELECT * FROM ZEDT08_101 INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY

    WHERE ZORDNO IN S_ZORDNO AND ZIDCODE IN S_ZCODE AND ZMATNR IN S_ZMATNR

    AND ZDDATE IN S_ZDDATE AND ZFLAG IN R_ZG.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_ORDER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA_ORDER . " ### ORDER #### ALV ### #### ##

  CLEAR: GS_ORDER, GS_0100.



  " ## #### # ## ##

  LOOP AT GT_ORDER INTO GS_ORDER.

    " ALV ### GS_0100# # ##

    MOVE-CORRESPONDING GS_ORDER TO GS_0100.



    " #### ### #### #### ##

    PERFORM ZMART_NAME USING GS_ORDER-ZMTART CHANGING GS_0100-ZMAT_NAME.



    " ## ## #### ## #### ### ##

    IF GS_ORDER-ZSALE_FG = '1'.

      GS_0100-ZSALE_NAME = '##'.

      GS_0100-ICON = '@08@'.

    ELSEIF GS_ORDER-ZSALE_FG = '2'.

      GS_0100-ZSALE_NAME = '##'.

      GS_0100-ICON = '@OA@'.

    ENDIF.



    " #### ##### ### #### ## ## ##

    IF P_CHK1 = C_X.

      PERFORM ZRET_NAME USING GS_ORDER-ZRET_FG CHANGING GS_0100-ZRET_NAME.

    ENDIF.



    " ### #### ALV# ### #### ##

    APPEND GS_0100 TO GT_0100.

    CLEAR: GS_ORDER, GS_0100.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZMART_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER_ZMART  text

*      <--P_GS_0100_ZMAT_NAME  text

*----------------------------------------------------------------------*




FORM ZMART_NAME  USING    P_GS_ORDER_ZMART

                 CHANGING P_GS_0100_ZMAT_NAME. " ## #### #### ### #### ##



  CASE P_GS_ORDER_ZMART.

    WHEN '001'.

      P_GS_0100_ZMAT_NAME = '##'.

    WHEN '002'.

      P_GS_0100_ZMAT_NAME = '##'.

    WHEN '003'.

      P_GS_0100_ZMAT_NAME = '##'.

    WHEN '004'.

      P_GS_0100_ZMAT_NAME = '##'.

    WHEN '005'.

      P_GS_0100_ZMAT_NAME = '##'.

    WHEN '006'.

      P_GS_0100_ZMAT_NAME = '###'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZRET_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER_ZRET_FG  text

*      <--P_GS_0100_ZRET_NAME  text

*----------------------------------------------------------------------*




FORM ZRET_NAME  USING    P_GS_ORDER_ZRET_FG

                CHANGING P_GS_0100_ZRET_NAME. " ## #### ## ## ### #### ##



  CASE P_GS_ORDER_ZRET_FG.

    WHEN '1'.

      P_GS_0100_ZRET_NAME = '####'.

    WHEN '2'.

      P_GS_0100_ZRET_NAME = '####'.

    WHEN '3'.

      P_GS_0100_ZRET_NAME = '####'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT . " ### GRID ## ##



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

*&      Form  FIELD_CATALOG_0100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_0100 . " ## ## ALV# ## ### ##



  CLEAR: GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-SCRTEXT_M = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMAT_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZNSAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-QFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDCAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZSALE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZJDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_CHK1 = C_X.

    CLEAR: GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZRET_NAME'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR: GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 16.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '10'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT . " ## ## ##



  CLEAR: GS_SORT, GT_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZIDCODE'.

  GS_SORT-UP = 'X'.

  GS_SORT-SUBTOT = 'X'.

  APPEND GS_SORT TO GT_SORT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  LAYOUT_SET

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM LAYOUT_SET . " ALV# ### # VARIANT ##



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY USING PT_TABLE TYPE STANDARD TABLE . " ALV GRID# ### ##



  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

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

      IT_OUTTAB                     = PT_TABLE

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

*&      Form  START_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM START_SCREEN . " ## # ## ## ### ##

  IF S_ZORDNO[] IS INITIAL AND S_ZJDATE[] IS INITIAL AND S_ZDDATE[] IS INITIAL.

    MESSAGE '####, ####, #### # ### ## ### #### ###.' TYPE 'E'.

  ENDIF.



  " ### ## ### ## ##

  CASE C_X.

    WHEN P_RBUT1.

      PERFORM GET_DATA_ORDER. " ## ### ##

      PERFORM MODIFY_DATA_ORDER. " ## ### ##

      IF GT_ORDER[] IS INITIAL.

        MESSAGE '## #### ####.' TYPE 'I'.

        EXIT.

      ELSE.

        CALL SCREEN 100.

      ENDIF.

    WHEN P_RBUT2.

      PERFORM GET_DATA_DELIVERY. " ## ### ##

      PERFORM MODIFY_DATA_DELIVERY. " ## ### ##

      IF GT_DELIVERY[] IS INITIAL.

        MESSAGE '##### ####.' TYPE 'I'.

        EXIT.

      ELSE.

        CALL SCREEN 200.

      ENDIF.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_DELIVERY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA_DELIVERY . " ### ## #### ALV# #### ##

  CLEAR: GS_DELIVERY, GS_0200.



  LOOP AT GT_DELIVERY INTO GS_DELIVERY.

    MOVE-CORRESPONDING GS_DELIVERY TO GS_0200.



    " ## ## ### ## ##

    PERFORM ZMTART_NAME USING GS_DELIVERY-ZMTART CHANGING GS_0200-ZMAT_NAME.



    " ## ## #### #### ##

    IF GS_DELIVERY-ZDFLAG = '1'.

      GS_0200-ZDFLAG_NAME = '####'.

    ELSEIF GS_DELIVERY-ZDFLAG = '2'.

      GS_0200-ZDFLAG_NAME = '####'.

    ENDIF.



    " ###### ## ### ##

    IF GS_DELIVERY-ZFLAG = 'X'.

      GS_0200-ICON = '@0A@'.

    ELSE.

      GS_0200-ICON = '@08@'.

    ENDIF.



    " #### ### #### ##

    PERFORM ZDGUBUN_NAME USING GS_DELIVERY-ZDGUBUN CHANGING GS_0200-ZDGUBUN_NAME.



    APPEND GS_0200 TO GT_0200.

    CLEAR: GS_DELIVERY, GS_0200.



  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZMTART_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_DELIVERY_ZMTART  text

*      <--P_GS_0200_ZMAT_NAME  text

*----------------------------------------------------------------------*




FORM ZMTART_NAME  USING    P_GS_DELIVERY_ZMTART

                  CHANGING P_GS_0200_ZMAT_NAME. " ## #### ## ## ### #### ##



  CASE P_GS_DELIVERY_ZMTART.

    WHEN '001'.

      P_GS_0200_ZMAT_NAME = '##'.

    WHEN '002'.

      P_GS_0200_ZMAT_NAME = '##'.

    WHEN '003'.

      P_GS_0200_ZMAT_NAME = '##'.

    WHEN '004'.

      P_GS_0200_ZMAT_NAME = '##'.

    WHEN '005'.

      P_GS_0200_ZMAT_NAME = '##'.

    WHEN '006'.

      P_GS_0200_ZMAT_NAME = '###'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZDGUBUN_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_DELIVERY_ZDGUBUN  text

*      <--P_GS_0200_ZDGUBUN_NAME  text

*----------------------------------------------------------------------*




FORM ZDGUBUN_NAME  USING    P_GS_DELIVERY_ZDGUBUN

                   CHANGING P_GS_0200_ZDGUBUN_NAME. " ## #### #### ### #### ##



  CASE P_GS_DELIVERY_ZDGUBUN.

    WHEN '1'.

      P_GS_0200_ZDGUBUN_NAME = '####'.

    WHEN '2'.

      P_GS_0200_ZDGUBUN_NAME = '####'.

    WHEN '3'.

      P_GS_0200_ZDGUBUN_NAME = '####'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_0200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_0200 . " ## ## ALV# ## ### ##



  CLEAR: GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-SCRTEXT_M = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMAT_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZDFLAG_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CURRENCY = 'KRW'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZDGUBUN_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZDDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_CHK1 = C_X.

    CLEAR: GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '10'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR: GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 16.

    GS_FIELDCAT-FIELDNAME = 'ZFLAG'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '8'.

    GS_FIELDCAT-JUST = 'C'.

    GS_FIELDCAT-EMPHASIZE = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.





ENDFORM.