
*&---------------------------------------------------------------------*

*&  Include           ZPRACTICE008_CONTAINER18_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT USING P_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER

      P_GRID TYPE REF TO CL_GUI_ALV_GRID.

  CREATE OBJECT P_DOCKING

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

*    EXCEPTIONS

*     CNTL_ERROR                  = 1

*     CNTL_SYSTEM_ERROR           = 2

*     CREATE_ERROR                = 3

*     LIFETIME_ERROR              = 4

*     LIFETIME_DYNPRO_DYNPRO_LINK = 5

*     OTHERS    = 6




    .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT P_GRID

    EXPORTING




*     I_SHELLSTYLE      = 0

*     I_LIFETIME        =




      I_PARENT = P_DOCKING




*     I_APPL_EVENTS     = space

*     I_PARENTDBG       =

*     I_APPLOGPARENT    =

*     I_GRAPHICSPARENT  =

*     I_NAME   =

*     I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*     ERROR_CNTL_CREATE = 1

*     ERROR_CNTL_INIT   = 2

*     ERROR_CNTL_LINK   = 3

*     ERROR_DP_CREATE   = 4

*     OTHERS   = 5




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

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = C_X.



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

  "## ID ## SORT.

  CLEAR : GS_SORT, GT_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZIDCODE'.

  GS_SORT-UP = C_X. "#### #####

  GS_SORT-SUBTOT = C_X.

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




FORM ALV_DISPLAY USING PT_ITAB TYPE STANDARD TABLE

      P_GRID TYPE REF TO CL_GUI_ALV_GRID

  PS_LAYOUT TYPE LVC_S_LAYO

  PS_VARIANT TYPE DISVARIANT.



  CALL METHOD P_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*     I_BUFFER_ACTIVE =

*     I_BYPASSING_BUFFER            =

*     I_CONSISTENCY_CHECK           =

*     I_STRUCTURE_NAME              =




      IS_VARIANT      = PS_VARIANT

      I_SAVE          = 'A'




*     I_DEFAULT       = 'X'




      IS_LAYOUT       = PS_LAYOUT




*     IS_PRINT        =

*     IT_SPECIAL_GROUPS             =

*     IT_TOOLBAR_EXCLUDING          =

*     IT_HYPERLINK    =

*     IT_ALV_GRAPHICS =

*     IT_EXCEPT_QINFO =

*     IR_SALV_ADAPTER =




    CHANGING

      IT_OUTTAB       = PT_ITAB

      IT_FIELDCATALOG = GT_FIELDCAT

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

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_SCREEN .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = C_X.

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R2 = C_X.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    IF SCREEN-GROUP1 = 'M2'.

      IF P_R2 = C_X.

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R1 = C_X.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.

FORM MAKE_RANGES.



  " --- ##ID ---

  CLEAR GR_ZID.

  IF P_ZID IS INITIAL.

    GR_ZID-SIGN = 'I'.

    GR_ZID-OPTION = 'CP'.

    GR_ZID-LOW  = C_ID.

  ELSE.

    GR_ZID-SIGN = 'I'.

    GR_ZID-OPTION = 'EQ'.

    GR_ZID-LOW  = P_ZID.

  ENDIF.

  APPEND GR_ZID.



  " --- #### ---

  CLEAR GR_ZORDNO.

  GR_ZORDNO-SIGN   = 'I'.

  GR_ZORDNO-OPTION = 'BT'.

  IF S_ZORDNO[] IS INITIAL.

    GR_ZORDNO-LOW    = C_NMIN.

    GR_ZORDNO-HIGH   = C_NMAX.

  ELSE.

    GR_ZORDNO-LOW    = S_ZORDNO-LOW.

    GR_ZORDNO-HIGH   = S_ZORDNO-HIGH.

  ENDIF.

  APPEND GR_ZORDNO.



  " --- #### ---

  CLEAR GR_ZMATNR.

  GR_ZMATNR-SIGN   = 'I'.

  GR_ZMATNR-OPTION = 'BT'.

  IF S_ZMATNR[] IS INITIAL.

    GR_ZMATNR-LOW    = C_NMIN.

    GR_ZMATNR-HIGH   = C_NMAX.

  ELSE.

    GR_ZMATNR-LOW    = S_ZMATNR-LOW.

    GR_ZMATNR-HIGH   = S_ZMATNR-HIGH.

  ENDIF.

  APPEND GR_ZMATNR.



  " --- #### ---

  CLEAR GR_ZJDATE.

  GR_ZJDATE-SIGN   = 'I'.

  GR_ZJDATE-OPTION = 'BT'.

  IF S_ZJDATE[] IS INITIAL.

    GR_ZJDATE-LOW    = C_DMIN.

    GR_ZJDATE-HIGH   = C_DMAX.

  ELSE.

    GR_ZJDATE-LOW    = S_ZJDATE-LOW.

    GR_ZJDATE-HIGH   = S_ZJDATE-HIGH.

  ENDIF.

  APPEND GR_ZJDATE.



  " --- #### ---

  CLEAR GR_ZDDATE.

  GR_ZDDATE-SIGN   = 'I'.

  GR_ZDDATE-OPTION = 'BT'.

  IF S_ZDDATE[] IS INITIAL.

    GR_ZDDATE-LOW    = C_DMIN.

    GR_ZDDATE-HIGH   = C_DMAX.

  ELSE.

    GR_ZDDATE-LOW    = S_ZDDATE-LOW.

    GR_ZDDATE-HIGH   = S_ZDDATE-HIGH.

  ENDIF.

  APPEND GR_ZDDATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INIT_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INIT_DATE .

  LV_FIRST = SY-DATUM.

  LV_FIRST+6(2) = '01'.



  CALL FUNCTION 'LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN            = LV_FIRST

    IMPORTING

      LAST_DAY_OF_MONTH = LV_LAST.



  CLEAR LR_DATE.

  LR_DATE-SIGN = 'I'.

  LR_DATE-OPTION = 'BT'.

  LR_DATE-LOW = LV_FIRST.

  LR_DATE-HIGH = LV_LAST.



  CLEAR S_ZJDATE. APPEND LR_DATE TO S_ZJDATE.

  CLEAR S_ZDDATE. APPEND LR_DATE TO S_ZDDATE.

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

  IF P_CH = C_X.

    PV_ZRET = C_X.

    PERFORM GET_DATA_ALL.

  ELSE.

    CLEAR PV_ZRET.

    PERFORM GET_DATA_NO_RET.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_ALL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA_ALL .

  IF P_R1 = C_X. "####

    CLEAR GT_ORDER.

    SELECT * FROM ZEDT018_100

      INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

      WHERE ZORDNO IN GR_ZORDNO

      AND ZIDCODE IN GR_ZID

      AND ZMATNR IN GR_ZMATNR

      AND ZJDATE IN GR_ZJDATE

      .

  ELSE. "####

    CLEAR GT_DELIVERY.

    SELECT * FROM ZEDT018_101

      INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY

      WHERE ZORDNO IN GR_ZORDNO

      AND ZIDCODE IN GR_ZID

      AND ZMATNR IN GR_ZMATNR

      AND ZDDATE IN GR_ZDDATE.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_NO_RET

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA_NO_RET .

  IF P_R1 = C_X. "####

    CLEAR GT_ORDER.

    SELECT * FROM ZEDT018_100

      INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

      WHERE ZORDNO IN GR_ZORDNO

      AND ZIDCODE IN GR_ZID

      AND ZMATNR IN GR_ZMATNR

      AND ZJDATE IN GR_ZJDATE

      AND ZRET_FG NOT IN ( 1,2,3 ).

  ELSE. "####

    CLEAR GT_DELIVERY.

    SELECT * FROM ZEDT018_101

      INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY

      WHERE ZORDNO IN GR_ZORDNO

      AND ZIDCODE IN GR_ZID

      AND ZMATNR IN GR_ZMATNR

      AND ZDDATE IN GR_ZDDATE

      AND ZFLAG NE 'X'.

  ENDIF.

ENDFORM.

" ### ## ### ##

FORM MODIFY_TABLE_FOR_PRINT USING ITAB TYPE STANDARD TABLE.

  IF P_R1 = C_X. "####

    LOOP AT ITAB INTO GS_ORDER.

      GS_ORDER-I_ZNSAMT = GS_ORDER-ZNSAMT * 100.

      GS_ORDER-I_ZSLAMT = GS_ORDER-ZSLAMT * 100.

      GS_ORDER-I_ZDCAMT = GS_ORDER-ZDCAMT * 100.



      PERFORM CHANGE_ZMTART USING GS_ORDER-ZMTART CHANGING GS_ORDER-C_ZMTART.

      "## ## ##### ## ###



      PERFORM CHANGE_ZSALE_FG USING GS_ORDER-ZSALE_FG CHANGING GS_ORDER-C_ZSALE GS_ORDER-C_ICON.

      "## ##



      PERFORM CHANGE_ZRET_FG USING GS_ORDER-ZRET_FG CHANGING GS_ORDER-C_ZRET.

      "## ##

      MODIFY ITAB FROM GS_ORDER INDEX SY-TABIX.

    ENDLOOP.

  ELSE.

    LOOP AT ITAB INTO GS_DELIVERY.

      GS_DELIVERY-I_ZSLAMT = GS_DELIVERY-ZSLAMT * 100.



      PERFORM CHANGE_ZMTART USING GS_DELIVERY-ZMTART CHANGING GS_DELIVERY-C_ZMTART.

      "## ## ##### ## ###



      PERFORM CHANGE_ZDFLAG USING GS_DELIVERY-ZDFLAG CHANGING GS_DELIVERY-C_ZDFLAG.

      " ####

      PERFORM CHANGE_ZDGUBUN USING GS_DELIVERY-ZDGUBUN CHANGING GS_DELIVERY-C_ZDGUBUN.

      " ## ##



      IF GS_DELIVERY-ZFLAG = 'X'.

        GS_DELIVERY-C_ICON = '@0A@'. "##

      ELSE.

        GS_DELIVERY-C_ICON = '@08@'. "##

      ENDIF.



      " ## ##

      "IF GS_ORDER-ZRDATE IS NOT INITIAL.

      " WRITE GS_ORDER-ZRDATE TO GS_ORDER-C_ZRDATE.

      "ENDIF.



      MODIFY ITAB FROM GS_DELIVERY INDEX SY-TABIX.

    ENDLOOP.

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




FORM FIELD_CATALOG_0100 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'C_ICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-SCRTEXT_M = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'C_ZMTART'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZNSAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'. "##

  GS_FIELDCAT-DO_SUM = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'. "##

  GS_FIELDCAT-DO_SUM = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDCAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'. "##

  GS_FIELDCAT-DO_SUM = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EMPHASIZE = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'C_ZSALE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZJDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_CH = C_X.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'C_ZRET'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 16.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '10'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_0200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_0200 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'C_ICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-SCRTEXT_M = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'C_ZMTART'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'. "##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'. "##

  GS_FIELDCAT-DO_SUM = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EMPHASIZE = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'C_ZDFLAG'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CURRENCY = 'KRW'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'C_ZDGUBUN'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EMPHASIZE = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZDDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_CH = C_X.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '10'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 16.

    GS_FIELDCAT-FIELDNAME = 'ZFLAG'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '8'.

    GS_FIELDCAT-JUST = 'C'.

    GS_FIELDCAT-EMPHASIZE = C_X.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHANGE_ZMTART

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER_ZMTART  text

*      <--P_GS_ORDER_C_ZMTART  text

*----------------------------------------------------------------------*




FORM CHANGE_ZMTART  USING    P_ZMTART LIKE GS_ORDER-ZMTART

                    CHANGING P_C_ZMTART LIKE GS_ORDER-C_ZMTART.

  CASE P_ZMTART.

    WHEN '001'.

      P_C_ZMTART = '##'.

    WHEN '002'.

      P_C_ZMTART = '##'.

    WHEN '003'.

      P_C_ZMTART = '##'.

    WHEN '004'.

      P_C_ZMTART = '##'.

    WHEN '005'.

      P_C_ZMTART = '##'.

    WHEN '006'.

      P_C_ZMTART = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHANGE_ZSALE_FG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER_ZSALE_FG  text

*      <--P_GS_ORDER_C_ZSALE  text

*----------------------------------------------------------------------*




FORM CHANGE_ZSALE_FG  USING    P_ZSALE_FG LIKE GS_ORDER-ZSALE_FG

                      CHANGING P_C_ZSALE LIKE GS_ORDER-C_ZSALE P_C_ICON LIKE GS_ORDER-C_ICON.



  CASE P_ZSALE_FG.

    WHEN '1'.

      P_C_ZSALE = '##'.

      P_C_ICON = '@08@'.

    WHEN '2'.

      P_C_ZSALE = '##'.

      P_C_ICON = '@0A@'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHANGE_ZRET_FG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER_ZRET_FG  text

*      <--P_GS_ORDER_C_ZRET  text

*----------------------------------------------------------------------*




FORM CHANGE_ZRET_FG  USING    P_ZRET_FG LIKE GS_ORDER-ZRET_FG

                     CHANGING P_C_ZRET LIKE GS_ORDER-C_ZRET.

  CASE P_ZRET_FG.

    WHEN '1'.

      P_C_ZRET = '####'.

    WHEN '2'.

      P_C_ZRET = '####'.

    WHEN '3'.

      P_C_ZRET = '####'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHANGE_ZDFLAG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_DELIVERY_ZDFLAG  text

*      <--P_GS_DELIVERY_C_ZDFLAG  text

*----------------------------------------------------------------------*




FORM CHANGE_ZDFLAG  USING    P_ZDFLAG LIKE GS_DELIVERY-ZDFLAG

                    CHANGING P_C_ZDFLAG LIKE GS_DELIVERY-C_ZDFLAG.

  CASE P_ZDFLAG.

    WHEN '1'.

      P_C_ZDFLAG = '####'.

    WHEN '2'.

      P_C_ZDFLAG = '###'.

    WHEN '3'.

      P_C_ZDFLAG = '####'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHANGE_ZDGUBUN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_DELIVERY_ZDGUBUN  text

*      <--P_GS_DELIVERY_C_ZDGUBUN  text

*----------------------------------------------------------------------*




FORM CHANGE_ZDGUBUN  USING    P_ZDGUBUN LIKE GS_DELIVERY-ZDGUBUN

                     CHANGING P_C_ZDGUBUN LIKE GS_DELIVERY-C_ZDGUBUN.

  CASE P_ZDGUBUN.

    WHEN '1'.

      P_C_ZDGUBUN = '###'.

    WHEN '2'.

      P_C_ZDGUBUN = '###'.

    WHEN '3'.

      P_C_ZDGUBUN = '###'.

    WHEN '4'.

      P_C_ZDGUBUN = '###'.

    WHEN '5'.

      P_C_ZDGUBUN = '###'.

    WHEN '6'.

      P_C_ZDGUBUN = '###'.

    WHEN '7'.

      P_C_ZDGUBUN = '###'.

  ENDCASE.

ENDFORM.