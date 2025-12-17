
*&---------------------------------------------------------------------*

*&  Include           ZEDR01_PRACTICE008_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  INIT_DATA

*&---------------------------------------------------------------------*




" ### #### #### ##, RANGE # SCREEN# ### ##### ####

FORM INIT_DATA .

  CLEAR GR_CHECK.           "RANGE ### ## " 1 ~ 3 BT "

    GR_CHECK-SIGN = 'I'.

    GR_CHECK-OPTION = 'BT'.

    GR_CHECK-LOW = '1'.

    GR_CHECK-HIGH = '3'.

  APPEND GR_CHECK.



  CONCATENATE SY-DATUM(4) SY-DATUM+4(2) '01' INTO S_ZJDATE-LOW.          " ### ### ## ####,01# 01# # ##

  CONCATENATE SY-DATUM(4) SY-DATUM+4(2) '01' INTO S_ZDDATE-LOW.          " ### ### ## ####,01# 01# # ##

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'                                  " ### ### ## #### ## ## ##

    EXPORTING

      DAY_IN                  = SY-DATUM

    IMPORTING

      LAST_DAY_OF_MONTH       = S_ZJDATE-HIGH.

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'                                  " ### ### ## #### ## ## ##

    EXPORTING

      DAY_IN                  = SY-DATUM

    IMPORTING

      LAST_DAY_OF_MONTH       = S_ZDDATE-HIGH.

  APPEND S_ZJDATE.

  APPEND S_ZDDATE.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*






FORM SET_SCREEN .



  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M2'.                                          " M2## ## (####)

      IF P_R1 = 'X'.                                                  " #### ON

        SCREEN-ACTIVE = '0'.                                          " #### OFF

      ELSEIF P_R2 = 'X'.                                              " #### ON

        SCREEN-ACTIVE = '1'.                                          " #### ON

      ENDIF.

    ENDIF.



    IF SCREEN-GROUP1 = 'M1'.                                          " M1## ## (#### )

      IF P_R1 = 'X'.                                                  " #### ON

        SCREEN-ACTIVE = '1'.                                          " #### OFF

      ELSEIF P_R2 = 'X'.                                              " #### OFF

        SCREEN-ACTIVE = '0'.                                          " #### ON

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DATA_CHECK

*&---------------------------------------------------------------------*




FORM MAIN .

  IF S_ZORDNO IS INITIAL AND S_ZJDATE IS INITIAL.                      " #### # ##### ##### #####

    MESSAGE E000.

  ELSEIF S_ZORDNO IS INITIAL AND S_ZDDATE IS INITIAL.                  " #### # ##### ##### #####

    MESSAGE E000.

  ENDIF.



  IF P_R1 = 'X'.                                                       " ## ## ON

    PERFORM GET_ORDER_DATA.                                            " #### ### ## ### ####

    PERFORM MODIFY_ORDER_DATA.                                         " ### ### ### #### ##

    CALL SCREEN 100.

  ENDIF.



  IF P_R2 = 'X'.                                                       " ## ## ON

    PERFORM GET_DELIVERY_DATA.                                         " #### ### ## ### ####

    PERFORM MODIFY_DELIVERY_DATA.                                      " ### ### ### #### ##

    CALL SCREEN 200.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ORDER_DATA

*&---------------------------------------------------------------------*




" ###### #### #### , #### ### ###### ##

FORM GET_ORDER_DATA .

  SELECT * FROM ZEDT01_100

    INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

    WHERE ZJDATE IN S_ZJDATE

    AND ZORDNO IN S_ZORDNO

    AND ZMATNR IN S_ZMATNR.



  IF GT_ORDER IS INITIAL.

    MESSAGE E001.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DELIVERY_DATA

*&---------------------------------------------------------------------*




" ###### #### #### , #### ### ###### ##

FORM GET_DELIVERY_DATA .

  SELECT * FROM ZEDT01_101

    INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY

    WHERE ZDDATE IN S_ZDDATE

    AND ZORDNO IN S_ZORDNO

    AND ZMATNR IN S_ZMATNR.



  IF GT_DELIVERY IS INITIAL.

    MESSAGE E001.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ORDER_DATA

*&---------------------------------------------------------------------*




"### ###### #### # ### #### ####

FORM MODIFY_ORDER_DATA .

  LOOP AT GT_ORDER INTO GS_ORDER.

    PERFORM GET_GUBUN_COLOR USING GS_ORDER-ZRET_FG             " ### ##

                            CHANGING GS_ORDER-ZGUBUN.

    PERFORM GET_ZMTART_NAME USING GS_ORDER-ZMTART              " #### ####

                            CHANGING GS_ORDER-ZMTART_NAME.

    PERFORM GET_ZSALE_FG_NAME USING GS_ORDER-ZSALE_FG          " #### ####

                              CHANGING GS_ORDER-ZSALE_FG_NAME.

    PERFORM GET_ZRET_FG_NAME USING GS_ORDER-ZRET_FG            " #### ####

                             CHANGING GS_ORDER-ZRET_FG_NAME GS_ORDER-ZRDATE.



    PERFORM FORMAT_DATE USING GS_ORDER-ZJDATE     " YYMMDD -> YY.MM.DD# ###

                        CHANGING GS_ORDER-ZJDATE_SHOW.

    IF GS_ORDER-ZRET_FG <> ' '.                   " ##### ##### YY.MM.DD# ##

      PERFORM FORMAT_DATE USING GS_ORDER-ZRDATE

                          CHANGING GS_ORDER-ZRDATE_SHOW.

    ENDIF.



    MODIFY GT_ORDER FROM GS_ORDER.               "### ## GT# ##

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DELIVERY_DATA

*&---------------------------------------------------------------------*




"### ###### #### # ### #### ####

FORM MODIFY_DELIVERY_DATA .

  LOOP AT GT_DELIVERY INTO GS_DELIVERY.

    PERFORM GET_ZFLAG_COLOR USING GS_DELIVERY-ZFLAG             " ### ##

                           CHANGING GS_DELIVERY-ZGUBUN.

    PERFORM GET_ZMTART_NAME USING GS_DELIVERY-ZMTART            " #### ####

                            CHANGING GS_DELIVERY-ZMTART_NAME.

    IF GS_DELIVERY-ZFLAG = 'X'.                                 " ##### #### ####

      GS_DELIVERY-ZDFLAG = ' '.

    ELSE.                                                       " ### #### #### ####

      GS_DELIVERY-ZRDATE = ' '.

      PERFORM GET_ZDFLAG_NAME USING GS_DELIVERY-ZDFLAG          " ### #### #### ####

                              CHANGING GS_DELIVERY-ZDFLAG_NAME.

    ENDIF.

    PERFORM GET_ZDGUBUN_NAME USING GS_DELIVERY-ZDGUBUN

                             CHANGING GS_DELIVERY-ZDGUBUN_NAME. " #### ####



    PERFORM FORMAT_DATE USING GS_DELIVERY-ZDDATE                " YYMMDD -> YY.MM.DD# ###

                        CHANGING GS_DELIVERY-ZDDATE_SHOW.



    IF GS_DELIVERY-ZFLAG = 'X'.                                 " ### ## # ## ##### YY.MM.DD# ###

      PERFORM FORMAT_DATE USING GS_DELIVERY-ZRDATE

                          CHANGING GS_DELIVERY-ZRDATE_SHOW.

    ENDIF.



    MODIFY GT_DELIVERY FROM GS_DELIVERY.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ZMTART_NAME

*&---------------------------------------------------------------------*




" ##### ## ### #### ####

FORM GET_ZMTART_NAME  USING    P_MTART

                      CHANGING P_MTART_NAME.

  CASE P_MTART.

    WHEN '001'.

      P_MTART_NAME = '##'.

    WHEN '002'.

      P_MTART_NAME = '##'.

    WHEN '003'.

      P_MTART_NAME = '##'.

    WHEN '004'.

      P_MTART_NAME = '##'.

    WHEN '005'.

      P_MTART_NAME = '##'.

    WHEN '006'.

      P_MTART_NAME = '###'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ZSALE_FG_NAME

*&---------------------------------------------------------------------*




" ##### ## ### #### ####

FORM GET_ZSALE_FG_NAME  USING    P_SALE_FG

                        CHANGING P_SALE_FG_NAME.

   CASE P_SALE_FG.

     WHEN '1'.

       P_SALE_FG_NAME = '##'.

     WHEN '2'.

       P_SALE_FG_NAME = '##'.

   ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ZRET_FG_NAME

*&---------------------------------------------------------------------*




" ##### ## ### #### ####

FORM GET_ZRET_FG_NAME  USING    P_RET_FG

                       CHANGING P_RET_FG_NAME P_RDATE.

  CASE P_RET_FG.

    WHEN ' '.

      P_RET_FG_NAME = ' '.

      P_RDATE = ' '.

    WHEN '1'.

      P_RET_FG_NAME = '####'.

    WHEN '2'.

      P_RET_FG_NAME = '####'.

    WHEN '3'.

      P_RET_FG_NAME = '####'.

   ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FORMAT_DATE

*&---------------------------------------------------------------------*

*       #### #### ### ##### ### .# ### ##

*        YYMMDD -> YY . MM . DD

*----------------------------------------------------------------------*




FORM FORMAT_DATE  USING P_DATE

                  CHANGING P_DATE_SHOW.



  CONCATENATE P_DATE+0(4) '.' P_DATE+4(2) '.' P_DATE+6(2)

         INTO P_DATE_SHOW.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_ZDFLAG_NAME

*&---------------------------------------------------------------------*




" ##### ## ### #### ####

FORM GET_ZDFLAG_NAME  USING    P_DFLAG

                      CHANGING P_DFLAG_NAME.

  CASE P_DFLAG.

    WHEN '1'.

      P_DFLAG_NAME = '####'.

    WHEN '2'.

      P_DFLAG_NAME = '###'.

    WHEN '3'.

      P_DFLAG_NAME = '####'.

   ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ZDGUBUN_NAME

*&---------------------------------------------------------------------*




" ##### ## ### #### ####

FORM GET_ZDGUBUN_NAME  USING    P_DGUBUN

                       CHANGING P_DGUBUN_NAME.

  CASE P_DGUBUN.

    WHEN '1'.

      P_DGUBUN_NAME = '###'.

    WHEN '2'.

      P_DGUBUN_NAME = '###'.

    WHEN '3'.

      P_DGUBUN_NAME = '###'.

    WHEN '4'.

      P_DGUBUN_NAME = '###'.

    WHEN '5'.

      P_DGUBUN_NAME = '###'.

    WHEN '6'.

      P_DGUBUN_NAME = '###'.

    WHEN '7'.

      P_DGUBUN_NAME = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ORDER_CREATE_OBJECT

*&---------------------------------------------------------------------




" ## #### ####

FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING




*      PARENT                      =




      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR




*      SIDE                        = DOCK_AT_LEFT




      EXTENSION                   = GV_GRID_SIZE




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



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ORDER_FIELD_CATALOG

*&---------------------------------------------------------------------*




" #### #### FCAT# #### ####

FORM ORDER_FIELD_CATALOG .



  CLEAR : GS_FIELDCAT,GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZGUBUN'.

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

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZSALE_FG_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZJDATE_SHOW'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_CH1 = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZRET_FG_NAME'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 16.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE_SHOW'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELIVERY_FIELD_CATALOG

*&---------------------------------------------------------------------*




" #### #### FCAT# #### ####

FORM DELIVERY_FIELD_CATALOG .



  CLEAR : GS_FIELDCAT,GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZGUBUN'.

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

  GS_FIELDCAT-FIELDNAME = 'ZDFLAG_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZDGUBUN_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZDDATE_SHOW'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_CH1 = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 14.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE_SHOW'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZFLAG'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-EMPHASIZE = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ORDER_ALV_LAYOUT

*&---------------------------------------------------------------------*




" LAYOUT# #### ####

FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'. " ### ## ###



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ORDER_ALV_SORT

*&---------------------------------------------------------------------*




" SORT# #### ####

FORM ALV_SORT .

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZIDCODE'.

  GS_SORT-UP = 'X'. "##

  GS_SORT-SUBTOT = 'X'.



  APPEND GS_SORT TO GT_SORT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ORDER_ALV_DISPLAY

*&---------------------------------------------------------------------*




" ALV# #### #### PT_TABLE# ### #### ###

FORM ALV_DISPLAY USING PT_TABLE TYPE STANDARD TABLE.

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

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_GUBUN_COLOR

*&---------------------------------------------------------------------*




" ###### #### #### #### , ##### 1 ,2 ,3 ### RED# #### GREEN# ##

FORM GET_GUBUN_COLOR  USING    P_ZRET_FG

                      CHANGING P_GUBUN.



  IF P_ZRET_FG IN GR_CHECK. " GR_CHECK = 1~3 BT

    P_GUBUN = '@0A@'. " RED COLOR

  ELSE.

    P_GUBUN = '@08@'. " GREEN COLOR

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ZFLAG_COLOR

*----------------------------------------------------------------------*




"###### #### #### ####, ##### X### RED# #### GREEN# ##

FORM GET_ZFLAG_COLOR  USING    P_FLAG

                      CHANGING P_GUBUN.

  IF P_FLAG = 'X'.

    P_GUBUN = '@0A@'.  "RED COLOR

  ELSE.

    P_GUBUN = '@08@'.  "GREEN COLOR

  ENDIF.

ENDFORM.