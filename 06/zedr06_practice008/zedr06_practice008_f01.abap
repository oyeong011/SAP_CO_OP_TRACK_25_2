
*&---------------------------------------------------------------------*

*&  Include           ZEDR06_PRACTICE008_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  DATA_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DATA_INIT .

  " ####, #### ##

  DATA : LV_YEAR TYPE C LENGTH 4.

  DATA : LV_MONTH TYPE C LENGTH 2.

  DATA : LV_LAST_OF_MONTH TYPE SY-DATUM.



  LV_YEAR = SY-DATUM(4).

  LV_MONTH = SY-DATUM+4(2).



  S_ZDDATE-SIGN = 'I'.

  S_ZDDATE-OPTION = 'BT'.

  CONCATENATE LV_YEAR LV_MONTH '01' INTO S_ZDDATE-LOW.



  S_ZJDATE-SIGN = 'I'.

  S_ZJDATE-OPTION = 'BT'.

  CONCATENATE LV_YEAR LV_MONTH '01' INTO S_ZJDATE-LOW.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN                  = SY-DATUM

   IMPORTING

     LAST_DAY_OF_MONTH       = LV_LAST_OF_MONTH

            .



  S_ZDDATE-HIGH = LV_LAST_OF_MONTH.

  S_ZJDATE-HIGH = LV_LAST_OF_MONTH.



  IF SY-SUBRC <> 0.




* Implement suitable error handling here




  ENDIF.



  APPEND S_ZDDATE.

  APPEND S_ZJDATE.



  R_IDCODE-SIGN = 'I'.

  R_IDCODE-OPTION = 'EQ'.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SCREEN_SETTING

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SCREEN_SETTING .

  LOOP AT SCREEN.



    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = C_X.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'.

      IF P_R2 = C_X.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.



  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DATA_VAILD_CHECK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DATA_VAILD_CHECK .

  IF S_ZORDNO IS INITIAL AND S_ZJDATE-LOW IS INITIAL AND S_ZJDATE-HIGH IS INITIAL.

    MESSAGE E001.

  ENDIF.



  IF S_IDCODE IS NOT INITIAL.

    R_IDCODE-LOW = S_IDCODE.

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




FORM GET_ORDER_DATA .

  SELECT * FROM ZEDT06_100 AS A

    INTO CORRESPONDING FIELDS OF TABLE @GT_ORDER

    WHERE A~ZORDNO IN @S_ZORDNO

    AND A~ZIDCODE IN @S_IDCODE

    AND A~ZMATNR IN @S_ZMATNT

    AND A~ZJDATE IN @S_ZJDATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ORDER_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_ORDER_DATE .

  " 1. ## ### #

  IF P_CHECK1 <> C_X.

    DELETE GT_ORDER WHERE ZRET_FG IS NOT INITIAL.

  ENDIF.



  " 2. ### ## ##.

  CLEAR GS_ORDER.

  LOOP AT GT_ORDER INTO GS_ORDER.



    MOVE-CORRESPONDING GS_ORDER TO GS_ORDER_0100.



    " #### -> ####(#) ##

    PERFORM SET_ZMTART_NAME USING GS_ORDER-ZMTART CHANGING GS_ORDER_0100-ZMTART_NAME.

    " #### -> ####(#) ##

    PERFORM SET_ZSALE_NAME USING GS_ORDER-ZSALE_FG CHANGING GS_ORDER_0100-ZSALE_NAME.

    " #### -> ####(#) ##

    IF GS_ORDER-ZRET_FG IS NOT INITIAL.

      PERFORM SET_ZRET_NAME USING GS_ORDER-ZRET_FG CHANGING GS_ORDER_0100-ZRET_NAME.

    ENDIF.



    IF GS_ORDER-ZSALE_FG = '1'.

      GS_ORDER_0100-ICON = '@08@'.

    ELSEIF GS_ORDER-ZSALE_FG = '2'.

      GS_ORDER_0100-ICON = '@0A@'.

    ENDIF.



    APPEND GS_ORDER_0100 TO GT_ORDER_0100.

    CLEAR : GS_ORDER, GS_ORDER_0100.



  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_ZMTART_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_ZMTART_NAME USING P_ZMTART

                     CHANGING P_ZMTART_NAME.

  CASE P_ZMTART.

    WHEN '001'.

      P_ZMTART_NAME = '##'.

    WHEN '002'.

      P_ZMTART_NAME = '##'.

    WHEN '003'.

      P_ZMTART_NAME = '##'.

    WHEN '004'.

      P_ZMTART_NAME = '##'.

    WHEN '005'.

      P_ZMTART_NAME = '##'.

    WHEN '006'.

      P_ZMTART_NAME = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_ZSALE_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GT_ORDER_ZSALE_FG  text

*      <--P_GT_ORDER_ZSALE_NAME  text

*      <--P_ENDFORM  text

*----------------------------------------------------------------------*




FORM SET_ZSALE_NAME  USING    P_ZSALE_FG

                     CHANGING P_ZSALE_NAME.

  CASE P_ZSALE_FG.

    WHEN '1'.

      P_ZSALE_NAME = '##'.

    WHEN '2'.

      P_ZSALE_NAME = '##'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_ZDGB_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_DELIVERY_ZDGUBUN  text

*      <--P_GS_DELIVERY_0200_ZDGB_NAME  text

*----------------------------------------------------------------------*




FORM SET_ZDGB_NAME  USING    P_GS_DELIVERY_ZDGUBUN

                    CHANGING P_GS_DELIVERY_0200_ZDGB_NAME.



  CASE P_GS_DELIVERY_ZDGUBUN.

    WHEN '1'.

      P_GS_DELIVERY_0200_ZDGB_NAME = '###'.

    WHEN '2'.

      P_GS_DELIVERY_0200_ZDGB_NAME = '###'.

    WHEN '3'.

      P_GS_DELIVERY_0200_ZDGB_NAME = '###'.

    WHEN '4'.

      P_GS_DELIVERY_0200_ZDGB_NAME = '###'.

    WHEN '5'.

      P_GS_DELIVERY_0200_ZDGB_NAME = '###'.

    WHEN '6'.

      P_GS_DELIVERY_0200_ZDGB_NAME = '###'.

    WHEN '7'.

      P_GS_DELIVERY_0200_ZDGB_NAME = '###'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_ZRET_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER_ZRET_FG  text

*      <--P_GS_ORDER_0100_ZRET_NAME  text

*----------------------------------------------------------------------*




FORM SET_ZRET_NAME  USING    P_GS_ORDER_ZRET_FG

                    CHANGING P_GS_ORDER_0100_ZRET_NAME.



  CASE P_GS_ORDER_ZRET_FG.

    WHEN '1'.

      P_GS_ORDER_0100_ZRET_NAME = '####'.

    WHEN '2'.

      P_GS_ORDER_0100_ZRET_NAME = '####'.

    WHEN '3'.

      P_GS_ORDER_0100_ZRET_NAME = '####'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_ZDFLAG_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_DELIVERY_ZDFLAG  text

*      <--P_GS_DELIVERY_0200_ZDFLAG_NAME  text

*----------------------------------------------------------------------*




FORM SET_ZDFLAG_NAME  USING    P_GS_DELIVERY_ZDFLAG

                      CHANGING P_GS_DELIVERY_0200_ZDFLAG_NAME.



    CASE P_GS_DELIVERY_ZDFLAG.

      WHEN '1'.

        P_GS_DELIVERY_0200_ZDFLAG_NAME = '####'.

      WHEN '2'.

        P_GS_DELIVERY_0200_ZDFLAG_NAME = '###'.

      WHEN '3'.

        P_GS_DELIVERY_0200_ZDFLAG_NAME = '####'.

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




FORM CREATE_OBJECT CHANGING P_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER

                         P_GRID TYPE REF TO CL_GUI_ALV_GRID.

CREATE OBJECT P_DOCKING

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



CREATE OBJECT P_GRID

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = P_DOCKING




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

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY USING P_GC_GRID TYPE REF TO CL_GUI_ALV_GRID

                       PT_ITAB TYPE STANDARD TABLE.

CALL METHOD P_GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

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

    IT_OUTTAB                     = PT_ITAB

    IT_FIELDCATALOG               = GT_FIELDCAT

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

  GS_FIELDCAT-FIELDNAME = 'ICON'.

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

  GS_FIELDCAT-FIELDNAME = 'ZMTART_NAME'.

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

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZSALE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZJDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_CHECK1 = C_X.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZRET_NAME'.

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

  GS_SORT-FIELDNAME = 'ZIDCODE'.

  GS_SORT-UP = C_X.

  GS_SORT-SUBTOT = C_X.

  APPEND GS_SORT TO GT_SORT.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  GET_DELIVERY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DELIVERY_DATA .

  SELECT * FROM ZEDT06_101 AS A

    INTO CORRESPONDING FIELDS OF TABLE @GT_DELIVERY

    WHERE A~ZORDNO IN @S_ZORDNO

    AND A~ZIDCODE IN @S_IDCODE

    AND A~ZMATNR IN @S_ZMATNT

    AND A~ZDDATE IN @S_ZDDATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DELIVERY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DELIVERY_DATA .



  " 1. ## ### # ## ### ##.

  IF P_CHECK1 <> C_X.

      DELETE GT_DELIVERY WHERE ZFLAG = C_X.

  ENDIF.



  " 2. ## ## # ## ##.

  LOOP AT GT_DELIVERY INTO GS_DELIVERY.

    MOVE-CORRESPONDING GS_DELIVERY TO GS_DELIVERY_0200.



    " #### -> #### #

    PERFORM SET_ZMTART_NAME USING GS_DELIVERY-ZMTART CHANGING GS_DELIVERY_0200-ZMTART_NAME.

    " #### -> #### #

    PERFORM SET_ZDFLAG_NAME USING GS_DELIVERY-ZDFLAG CHANGING GS_DELIVERY_0200-ZDFLAG_NAME.

    " #### -> #### #

    PERFORM SET_ZDGB_NAME USING GS_DELIVERY-ZDGUBUN CHANGING GS_DELIVERY_0200-ZDGB_NAME.



    " ###

    IF GS_DELIVERY-ZFLAG <> C_X.

      GS_DELIVERY_0200-ICON = '@08@'.

    ELSE.

      GS_DELIVERY_0200-ICON = '@0A@'.

    ENDIF.



    APPEND GS_DELIVERY_0200 TO GT_DELIVERY_0200.

  ENDLOOP.

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

  GS_FIELDCAT-FIELDNAME = 'ICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-COLTEXT = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMTART_NAME'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDFLAG_NAME'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZDGB_NAME'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZDDATE'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_CHECK1 = C_X.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 14.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-COLTEXT = '####'.

    GS_FIELDCAT-OUTPUTLEN = '10'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZFLAG'.

    GS_FIELDCAT-COLTEXT = '####'.

    GS_FIELDCAT-JUST = 'C'.

    GS_FIELDCAT-EMPHASIZE = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.



ENDFORM.