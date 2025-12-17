
*&---------------------------------------------------------------------*

*&  Include           ZEDR12_PRACTICE008_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_DATE

*&---------------------------------------------------------------------*




FORM SET_DATE .

  "### 1#

  LV_FIRST = |{ SY-DATUM+0(6) }01|.

  "### ##

CALL FUNCTION 'LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN                  = SY-DATUM

  IMPORTING

    LAST_DAY_OF_MONTH       = LV_LAST.



  CLEAR: S_ZJDATE[], S_ZDDATE[].

   " #### ## ##

  S_ZJDATE-SIGN   = 'I'.

  S_ZJDATE-OPTION = 'BT'.

  S_ZJDATE-LOW    = LV_FIRST.

  S_ZJDATE-HIGH   = LV_LAST.

  APPEND S_ZJDATE.



  " #### ## ##

  S_ZDDATE-SIGN   = 'I'.

  S_ZDDATE-OPTION = 'BT'.

  S_ZDDATE-LOW   = LV_FIRST.

  S_ZDDATE-HIGH   = LV_LAST.

  APPEND S_ZDDATE.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN #######

*&---------------------------------------------------------------------*




FORM SET_SCREEN .

LOOP AT SCREEN.

  IF SCREEN-GROUP1 = 'M1'.

    IF P_R1 = 'X'.

      SCREEN-ACTIVE = '1'.

    ELSEIF P_R2 = 'X'.

      SCREEN-ACTIVE = '0'.

    ENDIF.

  ELSEIF SCREEN-GROUP1 = 'M2'.

    IF P_R2 = 'X'.

      SCREEN-ACTIVE = '1'.

    ELSEIF P_R1 = 'X'.

      SCREEN-ACTIVE = '0'.

    ENDIF.

  ENDIF.

  MODIFY SCREEN.

ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_R1

*&---------------------------------------------------------------------*




FORM GET_DATA_R1 .

  SELECT * FROM ZEDT12_100

    INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

    WHERE ZORDNO IN S_ZORDNO

    AND ZIDCODE IN S_ZID

    AND ZMATNR IN S_ZMATNR

    AND ZJDATE IN S_ZJDATE

    AND ZSALE_FG IN R_FG.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_R2

*&---------------------------------------------------------------------*




FORM GET_DATA_R2 .

  SELECT * FROM ZEDT12_101

    INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY

    WHERE ZORDNO IN S_ZORDNO

    AND ZIDCODE IN S_ZID

    AND ZMATNR IN S_ZMATNR

    AND ZDDATE IN S_ZDDATE

    AND ZFLAG IN R_ZG.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_R1

*&---------------------------------------------------------------------*




FORM MODIFY_DATA_R1 .

 "#### ### ZMTART_NAME, #### ### ZSALE_FG_NAME, #### ### ZRET_FG_NAME

 "### ##, ### ##.

  LOOP AT GT_ORDER INTO GS_ORDER.

    CLEAR GS_OUT_ORDER.

    MOVE-CORRESPONDING GS_ORDER TO GS_OUT_ORDER.



    PERFORM WRITE_ZMTART_NAME USING GS_OUT_ORDER-ZMTART CHANGING GS_OUT_ORDER-ZMTART_NAME.

    PERFORM WRITE_ZSALE_FG_NAME USING GS_OUT_ORDER-ZSALE_FG CHANGING GS_OUT_ORDER-ZSALE_FG_NAME.

    PERFORM WRITE_ZRET_FG_NAME USING GS_OUT_ORDER-ZRET_FG CHANGING GS_OUT_ORDER-ZRET_FG_NAME.



    IF GS_OUT_ORDER-ZSALE_FG = '1'.

      GS_OUT_ORDER-ZCOLOR = '@08@'.

    ELSEIF GS_OUT_ORDER-ZSALE_FG = '2'.

      GS_OUT_ORDER-ZCOLOR = '@0A@'.

    ENDIF.



    APPEND GS_OUT_ORDER TO GT_OUT_ORDER.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_ZMTART_NAME

*&---------------------------------------------------------------------*




FORM WRITE_ZMTART_NAME  USING    P_ZMTART

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

*&      Form  WRITE_ZSALE_FG_NAME

*&---------------------------------------------------------------------*




FORM WRITE_ZSALE_FG_NAME  USING    P_ZSALE_FG

                          CHANGING P_ZSALE_FG_NAME.

      CASE P_ZSALE_FG.

        WHEN '1'.

          P_ZSALE_FG_NAME = '##'.

        WHEN '2'.

          P_ZSALE_FG_NAME = '##'.

      ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_ZRET_FG_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_OUT_ORDER_ZRET_FG  text

*      <--P_GS_OUT_ORDER_ZRET_FG_NAME  text

*----------------------------------------------------------------------*




FORM WRITE_ZRET_FG_NAME  USING    P_ZRET_FG

                         CHANGING P_ZRET_FG_NAME.

        CASE P_ZRET_FG.

          WHEN '1'.

            P_ZRET_FG_NAME = '####'.

          WHEN '2'.

            P_ZRET_FG_NAME = '####'.

          WHEN '3'.

            P_ZRET_FG_NAME = '####'.

        ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING




*      PARENT                      =




      REPID                       = SY-REPID "DOCKING CONTAINER#### ###, ####ID&#######.

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

  CREATE OBJECT GC_GRID_100

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_DOCKING "CONTAINER# GRID###.




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



    CREATE OBJECT GC_GRID_200

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_DOCKING "CONTAINER# GRID###.




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




FORM FIELD_CATALOG_0100 .



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-ICON = 'X'. "###



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

  GS_FIELDCAT-FIELDNAME = 'ZSALE_FG_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZJDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_CH1 = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZRET_FG_NAME'.

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




FORM ALV_LAYOUT .

   CLEAR GS_LAYOUT.

   GS_LAYOUT-ZEBRA = 'X'.



   CLEAR GS_VARIANT.

   GS_VARIANT-REPORT = SY-REPID.  "VARIANT# #### ### ######

   GS_VARIANT-USERNAME = SY-UNAME. "#### ##### #### #### ###



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT .



  GS_SORT-SPOS = 1. " ## ## (## ####?)

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

*      -->P_GT_OUT_ORDER[]  text

*      -->P_GC_GRID_100  text

*      -->P_GS_LAYOUT  text

*      -->P_GS_VARIANT  text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY  USING   PT_ITAB TYPE STANDARD TABLE

                     P_GRID  TYPE REF TO CL_GUI_ALV_GRID

                     PS_LAYOUT TYPE LVC_S_LAYO

                     PS_VARIANT LIKE DISVARIANT.



  CALL METHOD GC_GRID_100->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =




      IS_VARIANT                    = PS_VARIANT

      I_SAVE                        = 'A'




*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = PS_LAYOUT




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = PT_ITAB

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

*&      Form  CHECK_DATA

*&---------------------------------------------------------------------*




FORM CHECK_DATA .

  "#### ##

  IF P_R1 = 'X'.

    IF S_ZJDATE IS INITIAL.

      IF S_ZORDNO IS INITIAL.

        MESSAGE I000.

        STOP.

      ENDIF.

    ENDIF.

  ELSEIF P_R2 = 'X'.

    IF S_ZDDATE IS INITIAL.

      IF S_ZORDNO IS INITIAL.

        MESSAGE I000.

        STOP.

      ENDIF.

    ENDIF.

  ENDIF.



  "#### ##

  IF P_R1 = 'X'.

    R_FG-SIGN = 'I'.

    R_FG-OPTION = 'EQ'.

    R_FG-LOW = '1'.

    APPEND R_FG.



    IF P_CH1 = 'X'.

      R_FG-LOW = '2'.

      APPEND R_FG.

    ENDIF.

  ELSEIF P_R2 = 'X'.

    R_ZG-SIGN = 'I'.

    R_ZG-OPTION = 'EQ'.

    R_ZG-LOW = ' '.

    APPEND R_ZG.



    IF P_CH1 = 'X'.

      R_ZG-LOW = 'X'.

      APPEND R_ZG.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_R2

*&---------------------------------------------------------------------*




FORM MODIFY_DATA_R2 .

  LOOP AT GT_DELIVERY INTO GS_DELIVERY.

    CLEAR GS_OUT_DELIVERY.

    MOVE-CORRESPONDING GS_DELIVERY TO GS_OUT_DELIVERY.



    PERFORM WRITE_ZMTART_NAME USING GS_OUT_DELIVERY-ZMTART CHANGING GS_OUT_DELIVERY-ZMTART_NAME.

    PERFORM WRITE_ZDGUBUN_NAME USING GS_OUT_DELIVERY-ZDGUBUN CHANGING GS_OUT_DELIVERY-ZDGUBUN_NAME.

     IF GS_DELIVERY-ZDFLAG = '1'.

      GS_OUT_DELIVERY-ZDFLAG_NAME = '####'.

    ELSEIF GS_DELIVERY-ZDFLAG = '2'.

      GS_OUT_DELIVERY-ZDFLAG_NAME = '####'.

    ENDIF.



    IF GS_DELIVERY-ZFLAG = 'X'.

      GS_OUT_DELIVERY-ZCOLOR = '@0A@'. "##

    ELSE.

      GS_OUT_DELIVERY-ZCOLOR = '@08@'. "##

    ENDIF.



  APPEND GS_OUT_DELIVERY TO GT_OUT_DELIVERY.



  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_ZDGUBUN_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_OUT_DELIEVERY_ZDGUBUN  text

*      <--P_GS_OUT_DELIEVERY_ZDGUBUN_NAME  text

*----------------------------------------------------------------------*




FORM WRITE_ZDGUBUN_NAME  USING    P_ZDGUBUN

                         CHANGING P_ZDGUBUN_NAME.

    CASE P_ZDGUBUN.

    WHEN '1'.

      P_ZDGUBUN_NAME = '##'.

    WHEN '2'.

      P_ZDGUBUN_NAME = '###'.

    WHEN '3'.

      P_ZDGUBUN_NAME = '###'.

    WHEN '4'.

      P_ZDGUBUN_NAME = '###'.

    WHEN '5'.

      P_ZDGUBUN_NAME = '###'.

    WHEN '6'.

      P_ZDGUBUN_NAME = '###'.

    WHEN '7'.

      P_ZDGUBUN_NAME = '###'.

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




FORM FIELD_CATALOG_0200 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-ICON = 'X'. "###



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

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDFLAG'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZDGUBUN'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZDDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_CH1 = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 14.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 16.

    GS_FIELDCAT-FIELDNAME = 'ZFLAG'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-EMPHASIZE = 'X'.

    GS_FIELDCAT-OUTPUTLEN = '10'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.

ENDFORM.