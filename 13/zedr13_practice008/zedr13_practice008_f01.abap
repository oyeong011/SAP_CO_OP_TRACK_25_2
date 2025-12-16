
*&---------------------------------------------------------------------*

*&  Include           ZEDR13_PRACTICE008_F01

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  DATE_SETTING

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--S_DATE_LOW  text

*      <--S_DATE_HIGH  text

*----------------------------------------------------------------------*




FORM DATE_SETTING.

  S_ZJDATE-LOW = SY-DATUM(6) && '01'. "## ### 01# ##"

  S_ZJDATE-SIGN = 'I'.

  S_ZJDATE-OPTION = 'BT'.



  S_DDATE-LOW = SY-DATUM(6) && '01'. "## ### 01# ##"

  S_DDATE-SIGN = 'I'.

  S_DDATE-OPTION = 'BT'.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

   EXPORTING

     DAY_IN                  = S_ZJDATE-LOW

   IMPORTING

     LAST_DAY_OF_MONTH       = S_ZJDATE-HIGH.

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

   EXPORTING

     DAY_IN                  = S_DDATE-LOW

   IMPORTING

     LAST_DAY_OF_MONTH       = S_DDATE-HIGH.

  APPEND S_ZJDATE.

  APPEND S_DDATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SCREEN_CHANGING

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SCREEN_CHANGING .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'. "## ##"

      IF P1 = 'X'.  "## ### ## ## ### ## SELECT-OPTION ###"

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'. "## ##"

      IF P2 = 'X'.   "## ### ## ## ### ## SELECT-OPTION ###"

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_FG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_FG.

  IF P1 = 'X'. "## ## ##"

    R_FG-SIGN = 'I'. "## ##"

    R_FG-OPTION = 'EQ'. "LOW# ## #### ## ##"

    R_FG-LOW = '1'. "## ## ##"

    APPEND R_FG.

    IF P3 = 'X'.

      R_FG-LOW = '2'. "## # ### ## ## ##"

      APPEND R_FG.

    ENDIF.

  ELSEIF P2 = 'X'. "## ## ##"

    R_CH-SIGN = 'I'. "## ##"

    R_CH-OPTION = 'EQ'. "LOW# ## #### ## ##"

    R_CH-LOW = ' '. "## ## ##### # ##"

    APPEND R_CH.

    IF P3 = 'X'.

      R_CH-LOW = 'X'. "## ## ## ## ## ## # ##"

      APPEND R_CH.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAIN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MAIN.

  IF S_ZORDNO IS INITIAL AND S_ZJDATE IS INITIAL.           "##### ##### ##### #####"

    MESSAGE S000 DISPLAY LIKE 'E'.

    STOP.

  ELSEIF S_ZORDNO IS INITIAL AND S_DDATE IS INITIAL.        "##### ##### ##### #####"

    MESSAGE S000 DISPLAY LIKE 'E'.

    STOP.

  ENDIF.



  PERFORM CHECK_FG.



  IF P1 = 'X'.                                               "## ##"

    PERFORM GET_ORDER_DATA.                                  "## ## ####"

    PERFORM MODIFY_ORDER_DATA.                               "## ## ####"

    IF GT_ORDER IS NOT INITIAL.

      CALL SCREEN 100.

    ELSE.

      MESSAGE I001.

      EXIT.

    ENDIF.

  ELSEIF P2 = 'X'.                                           "## ##"

    PERFORM GET_DELIVERY_DATA.                               "## ## ####"

    PERFORM MODIFY_DELIVERY_DATA.                            "## ## ####"

    IF GT_DELIVERY IS NOT INITIAL.

      CALL SCREEN 200.

    ELSE.

      MESSAGE I001.

      EXIT.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ORDER_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_ORDER_DATA.

  SELECT * FROM ZEDT13_100

    INTO CORRESPONDING FIELDS OF TABLE GT_ORDER "GT_ORDER #### ## ####"

    WHERE ZORDNO IN S_ZORDNO

    AND ZIDCODE IN S_IDCODE

    AND ZMATNR IN S_MATNR

    AND ZJDATE IN S_ZJDATE

    AND ZSALE_FG IN R_FG. "### ## ### ####"

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DELIVERY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DELIVERY_DATA.

  SELECT * FROM ZEDT13_101

    INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY "GT_DELIVERY #### ## ####"

    WHERE ZORDNO IN S_ZORDNO

    AND ZIDCODE IN S_IDCODE

    AND ZMATNR IN S_MATNR

    AND ZDDATE IN S_DDATE

    AND ZFLAG IN R_CH. "### ## ### ####"

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ORDER_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_ORDER_DATA.

  CLEAR GS_ORDER.

  LOOP AT GT_ORDER INTO GS_ORDER.

    MOVE-CORRESPONDING GS_ORDER TO GS_WORDER.



    PERFORM DATE_ZOM CHANGING GS_WORDER-ZJDATE. "## ## ## . ##"

    PERFORM DATE_ZOM CHANGING GS_WORDER-ZRDATE.



    PERFORM ZMTART_NAME USING GS_ORDER-ZMTART

                        CHANGING GS_WORDER-ZMTART.



    CASE GS_ORDER-ZSALE_FG. "## ## ### ##"

      WHEN '1'.

        GS_WORDER-ZSALE_FG = '##'.

        GS_WORDER-ZICON = '@08@'. "RED"

        CLEAR : GS_WORDER-ZRDATE. "### ## ##### ##"

      WHEN '2'.

        GS_WORDER-ZSALE_FG = '##'.

        GS_WORDER-ZICON = '@0A@'. "GREEN"

    ENDCASE.



    PERFORM ZRET_FG_NAME USING GS_ORDER-ZRET_FG

                         CHANGING GS_WORDER-ZRET_FG.



    APPEND GS_WORDER TO GT_WORDER.

    CLEAR : GS_ORDER, GS_WORDER.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DELIVERY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DELIVERY_DATA.

  CLEAR GS_DELIVERY.

  LOOP AT GT_DELIVERY INTO GS_DELIVERY.

    MOVE-CORRESPONDING GS_DELIVERY TO GS_WDELIVERY.



    SHIFT GS_WDELIVERY-ZORDNO LEFT DELETING LEADING '0'. "0000000001 -> 1"

    SHIFT GS_WDELIVERY-ZMATNR LEFT DELETING LEADING '0'.



    PERFORM DATE_ZOM CHANGING GS_WDELIVERY-ZDDATE. "## ## ## . ##"

    PERFORM DATE_ZOM CHANGING GS_WDELIVERY-ZRDATE.



    CASE GS_DELIVERY-ZDFLAG. "## ## ### ##"

      WHEN '1'.

        GS_WDELIVERY-ZDFLAG = '####'.

      WHEN '2'.

        GS_WDELIVERY-ZDFLAG = '###'.

      WHEN '3'.

        GS_WDELIVERY-ZDFLAG = '####'.

    ENDCASE.



    PERFORM ZMTART_NAME USING GS_DELIVERY-ZMTART

                        CHANGING GS_WDELIVERY-ZMTART.



    PERFORM DELIVERY_NAME USING GS_DELIVERY-ZDGUBUN

                          CHANGING GS_WDELIVERY-ZDGUBUN.





    IF GS_DELIVERY-ZFLAG = 'X'. "## ### GS_DELIVERY## #### # #### ## ## ##"

      CLEAR : GS_WDELIVERY-ZDFLAG.  "## ### ## ## ## #### ##"

      GS_WDELIVERY-ZICON = '@0A@'.        "RED"

    ELSE.

      CLEAR : GS_WDELIVERY-ZRDATE.  "### ## ## #### ##"

      GS_WDELIVERY-ZICON = '@08@'.        "GREEN"

    ENDIF.



    APPEND GS_WDELIVERY TO GT_WDELIVERY.

    CLEAR : GS_DELIVERY, GS_WDELIVERY.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DATE_ZOM

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DATE_ZOM CHANGING DATE.

  DATE = DATE+0(4) && '.' && DATE+4(2) && '.' && DATE+6(2). "## ### .# ## ##"

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZMTART_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER_ZMTART  text

*      <--P_GS_WORDER_ZMTART  text

*----------------------------------------------------------------------*




FORM ZMTART_NAME  USING    P_ZMTART

                  CHANGING P_WZMTART.

    CASE P_ZMTART. "## ## ### ##"

    WHEN '001'.

      P_WZMTART = '##'.

    WHEN '002'.

      P_WZMTART = '##'.

    WHEN '003'.

      P_WZMTART = '##'.

    WHEN '004'.

      P_WZMTART = '##'.

    WHEN '005'.

      P_WZMTART = '##'.

    WHEN '006'.

       P_WZMTART = '###'.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZRET_FG_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER_ZRET_FG  text

*      <--P_GS_WORDER_ZRET_FG  text

*----------------------------------------------------------------------*




FORM ZRET_FG_NAME  USING    P_ZRET_FG

                   CHANGING P_WZRET_FG.

  CASE P_ZRET_FG.

    WHEN '1'.

      P_WZRET_FG = '####'.

    WHEN '2'.

      P_WZRET_FG = '####'.

    WHEN '3'.

      P_WZRET_FG = '####'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELIVERY_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_DELIVERY_ZDGUBUN  text

*      <--P_GS_WDELIVERY_ZDGUBUN  text

*----------------------------------------------------------------------*




FORM DELIVERY_NAME  USING    P_ZDGUBUN

                    CHANGING P_WZDGUBUN.

  CASE P_ZDGUBUN.  "## ## ### ##"

    WHEN '1'.

      P_WZDGUBUN = '###'.

    WHEN '2'.

      P_WZDGUBUN = '###'.

    WHEN '3'.

      P_WZDGUBUN = '###'.

    WHEN '4'.

      P_WZDGUBUN = '###'.

    WHEN '5'.

      P_WZDGUBUN = '###'.

    WHEN '6'.

      P_WZDGUBUN = '###'.

    WHEN '7'.

      P_WZDGUBUN = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_DOCKING  text

*      -->P_GC_GRID_0100  text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT USING P_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER

                         P_GRID TYPE REF TO CL_GUI_ALV_GRID.

  CREATE OBJECT P_DOCKING

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

  CREATE OBJECT P_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = P_DOCKING




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




FORM FIELD_CATALOG_0100.



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZICON'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-ICON = 'X'.

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

  GS_FIELDCAT-KEY = 'X'.

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

  GS_FIELDCAT-FIELDNAME = 'ZMTART'.

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

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDCAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZSALE_FG'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZJDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P3 = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZRET_FG'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 16.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

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




FORM ALV_LAYOUT.

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.



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




FORM ALV_SORT.

  CLEAR : GS_SORT, GT_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZIDCODE'.

  GS_SORT-UP = 'X'.

  GS_SORT-SUBTOT = 'X'.

  APPEND GS_SORT TO GT_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GC_GRID_0100  text

*      -->P_GT_WORDER[]  text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY  USING P_GRID TYPE REF TO CL_GUI_ALV_GRID

                        P_ITAB TYPE STANDARD TABLE.

  CALL METHOD P_GRID->SET_TABLE_FOR_FIRST_DISPLAY

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

      IT_OUTTAB                     = P_ITAB

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

*&      Form  FIELD_CATALOG_0200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_0200.



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

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

  GS_FIELDCAT-FIELDNAME = 'ZMTART'.

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

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZDFLAG'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZDGUBUN'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZDDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P3 = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 16.

    GS_FIELDCAT-FIELDNAME = 'ZFLAG'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-JUST = 'C'.

    GS_FIELDCAT-EMPHASIZE = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.

ENDFORM.