
*&---------------------------------------------------------------------*

*&  Include           ZEDR24_PRACTICE008_F01

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

  DATA : LV_YEAR TYPE DATS,

         LV_MONTH TYPE DATS,

         LV_FIRST_DAY TYPE DATS,

         LV_LAST_DAY TYPE DATS.



  CONCATENATE SY-DATUM+0(6) '01' INTO LV_FIRST_DAY.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN = SY-DATUM

  IMPORTING

    LAST_DAY_OF_MONTH = LV_LAST_DAY.

  S_ZJDATE-LOW = LV_FIRST_DAY.

  S_ZJDATE-HIGH = LV_LAST_DAY.

  S_ZJDATE-OPTION = 'BT'.

  S_ZJDATE-SIGN = 'I'.

  APPEND S_ZJDATE.



  S_ZDDATE-LOW = LV_FIRST_DAY.

  S_ZDDATE-HIGH = LV_LAST_DAY.

  S_ZDDATE-OPTION = 'BT'.

  S_ZDDATE-SIGN = 'I'.

  APPEND S_ZDDATE.

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

  IF P_R1 = 'X'.



    IF P_CH1 = 'X'.

      GR_ZSALE-SIGN = 'I'.

      GR_ZSALE-OPTION = 'BT'.

      GR_ZSALE-LOW = '1'.

      GR_ZSALE-HIGH = '2'.

      APPEND GR_ZSALE.

    ELSEIF P_CH1 <> 'X'.

      GR_ZSALE-SIGN = 'I'.

      GR_ZSALE-OPTION = 'BT'.

      GR_ZSALE-LOW = '1'.

      GR_ZSALE-HIGH = '1'.

      APPEND GR_ZSALE.

    ENDIF.



    SELECT * FROM ZEDT24_100

      INTO CORRESPONDING FIELDS OF TABLE GT_100

      WHERE ZORDNO IN S_ZORDNO

        AND ZMATNR IN S_MATNR

        AND ZJDATE IN S_ZJDATE

        AND ZSALE_FG IN GR_ZSALE.

    IF P_IDCODE IS NOT INITIAL.

      DELETE GT_100 WHERE ZIDCODE <> P_IDCODE.

    ENDIF.

  ELSEIF P_R2 = 'X'.

      SELECT * FROM ZEDT24_101

      INTO CORRESPONDING FIELDS OF TABLE GT_101

      WHERE ZORDNO IN S_ZORDNO

        AND ZMATNR IN S_MATNR

        AND ZDDATE IN S_ZDDATE.

    IF P_IDCODE IS NOT INITIAL.

      DELETE GT_101 WHERE ZIDCODE <> P_IDCODE.

    ENDIF.



    IF P_CH1 <> 'X'.

      DELETE GT_101 WHERE ZFLAG = 'X'.

    ENDIF.

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

  IF P_R1 = 'X'.

    PERFORM MODIFY_DATA_ORDER.

  ELSEIF P_R2 = 'X'.

    PERFORM MODIFY_DATA_DELI.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_ORDER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA_ORDER .

  DATA : LV_ZMTART TYPE C LENGTH 8,

         LV_ZSALE TYPE C LENGTH 4,

         LV_ZRET TYPE C LENGTH 10.



  LOOP AT GT_100 INTO GS_100.

    CLEAR GS_T100_RESULT.

    CLEAR LV_ZMTART.

    CLEAR LV_ZSALE.

    CLEAR LV_ZRET.



    MOVE-CORRESPONDING GS_100 TO GS_T100_RESULT.



    "ENUM ## #### ##

    PERFORM CONVERT_ZMTART USING LV_ZMTART GS_100-ZMTART.

    PERFORM CONVERT_ZSALE USING LV_ZSALE GS_100-ZSALE_FG.

    PERFORM CONVERT_ZRET USING LV_ZRET GS_100-ZRET_FG.

    GS_T100_RESULT-ZMTART = LV_ZMTART.

    GS_T100_RESULT-ZSALE = LV_ZSALE.

    GS_T100_RESULT-ZRET = LV_ZRET.



    "#### ###

    IF LV_ZRET IS INITIAL.

      GS_T100_RESULT-ZRDATE = 0.

    ENDIF.



    IF GS_100-ZSALE_FG = '1'. "##

      GS_T100_RESULT-ZICON = ICON_GREEN_LIGHT.

    ELSEIF GS_100-ZSALE_FG = '2'.

      GS_T100_RESULT-ZICON = ICON_RED_LIGHT.

    ENDIF.



    APPEND GS_T100_RESULT TO GT_T100_RESULT.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_DELI

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA_DELI .

  DATA : LV_ZMTART TYPE C LENGTH 8,

         LV_ZDFLAG TYPE C LENGTH 8,

         LV_ZDGUBUN TYPE C LENGTH 8.



  LOOP AT GT_101 INTO GS_101.

    CLEAR GS_T101_RESULT.

    CLEAR LV_ZMTART.

    CLEAR LV_ZDFLAG.

    CLEAR LV_ZDGUBUN.



    MOVE-CORRESPONDING GS_101 TO GS_T101_RESULT.



    "ENUM ## #### ##

    PERFORM CONVERT_ZMTART USING LV_ZMTART GS_101-ZMTART.

    PERFORM CONVERT_ZDFLAGE USING LV_ZDFLAG GS_101-ZDFLAG.

    PERFORM CONVERT_ZDGUBUN  USING LV_ZDGUBUN GS_101-ZDGUBUN.

    GS_T101_RESULT-ZMTART = LV_ZMTART.

    GS_T101_RESULT-ZDFLAG = LV_ZDFLAG.

    GS_T101_RESULT-ZDGUBUN = LV_ZDGUBUN.



    GS_T101_RESULT-ZICON = ICON_GREEN_LIGHT.

    IF GS_T101_RESULT-ZFLAG = 'X'.

      GS_T101_RESULT-ZICON = ICON_RED_LIGHT.

    ENDIF.



    APPEND GS_T101_RESULT TO GT_T101_RESULT.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CONVERT_ZMTART

*&---------------------------------------------------------------------*

*       text  ZMTART# #### ### ##

*----------------------------------------------------------------------*

*      <--LV_ZMTART        ### #### ## ##

*      -->GS_ORDER_ZMTART  ###

*----------------------------------------------------------------------*




FORM CONVERT_ZMTART  USING    LV_ZMTART

                              GS_ORDER_ZMTART.

  CASE GS_ORDER_ZMTART.

    WHEN '001'.

      LV_ZMTART = '##'.

    WHEN '002'.

      LV_ZMTART = '##'.

    WHEN '003'.

      LV_ZMTART = '##'.

    WHEN '004'.

      LV_ZMTART = '##'.

    WHEN '005'.

      LV_ZMTART = '##'.

    WHEN '006'.

      LV_ZMTART = '###'.

  ENDCASE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CONVERT_ZRET

*&---------------------------------------------------------------------*

*       text  ZRET# #### ### ##

*----------------------------------------------------------------------*

*      <--LV_ZRET           ### #### ## ##

*      -->GS_ORDER_ZRET_FG  ###

*----------------------------------------------------------------------*




FORM CONVERT_ZRET  USING    LV_ZRET

                            GS_ORDER_ZRET_FG.

  CASE GS_ORDER_ZRET_FG.

    WHEN '1'.

      LV_ZRET = '####'.

    WHEN '2'.

      LV_ZRET = '####'.

    WHEN '3'.

      LV_ZRET = '####'.

  ENDCASE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CONVERT_ZSALE

*&---------------------------------------------------------------------*

*       text  ZSALE# #### ### ##

*----------------------------------------------------------------------*

*      <--LV_ZSALE           ### #### ## ##

*      -->GS_ORDER_ZSALE_FG  ###

*----------------------------------------------------------------------*




FORM CONVERT_ZSALE  USING    LV_ZSALE

                             GS_ORDER_ZSALE_FG.

  CASE GS_ORDER_ZSALE_FG.

    WHEN '1'.

      LV_ZSALE = '##'.

    WHEN '2'.

      LV_ZSALE = '##'.

  ENDCASE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CONVERT_ZDFLAGE

*&---------------------------------------------------------------------*

*       text  ZDFLAG# #### ### ##

*----------------------------------------------------------------------*

*      <--LV_ZDFLAG        ### #### ## ##

*      -->GS_DELI_ZDFLAG   ###

*----------------------------------------------------------------------*




FORM CONVERT_ZDFLAGE  USING    LV_ZDFLAG

                               GS_DELI_ZDFLAG.

  CASE GS_DELI_ZDFLAG.

    WHEN '1'.

      LV_ZDFLAG = '####'.

    WHEN '2'.

      LV_ZDFLAG = '###'.

    WHEN '3'.

      LV_ZDFLAG = '####'.

  ENDCASE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CONVERT_ZDGUBUN

*&---------------------------------------------------------------------*

*       text  ZDGUBUN# #### ### ##

*----------------------------------------------------------------------*

*      <--LV_ZDGUBUN        ### #### ## ##

*      -->GS_DELI_ZDGUBUN   ###

*----------------------------------------------------------------------*




FORM CONVERT_ZDGUBUN  USING    LV_ZDGUBUN

                               GS_DELI_ZDGUBUN.

  CASE GS_DELI_ZDGUBUN.

    WHEN '1'.

      LV_ZDGUBUN = '###'.

    WHEN '2'.

      LV_ZDGUBUN = '###'.

    WHEN '3'.

      LV_ZDGUBUN = '###'.

    WHEN '4'.

      LV_ZDGUBUN = '###'.

    WHEN '5'.

      LV_ZDGUBUN = '###'.

    WHEN '6'.

      LV_ZDGUBUN = '###'.

    WHEN '7'.

      LV_ZDGUBUN = '###'.

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




      NAME                        = 'R1 ######'




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



CREATE OBJECT GC_GRID

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_DOCKING




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

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG .

  CLEAR : GS_FC_100, GT_FC_100.



  GS_FC_100-COL_POS = 1.

  GS_FC_100-FIELDNAME = 'ZICON'.

  GS_FC_100-COLTEXT = '##'.

  GS_FC_100-ICON = 'X'.

  APPEND GS_FC_100 TO GT_FC_100.



  CLEAR : GS_FC_100.

  GS_FC_100-COL_POS = 2.

  GS_FC_100-FIELDNAME = 'ZORDNO'.

  GS_FC_100-COLTEXT = '####'.

  GS_FC_100-OUTPUTLEN = 10.

  APPEND GS_FC_100 TO GT_FC_100.



  CLEAR : GS_FC_100.

  GS_FC_100-COL_POS = 3.

  GS_FC_100-FIELDNAME = 'ZIDCODE'.

  GS_FC_100-COLTEXT = '##ID'.

  APPEND GS_FC_100 TO GT_FC_100.



  CLEAR : GS_FC_100.

  GS_FC_100-COL_POS = 4.

  GS_FC_100-FIELDNAME = 'ZMATNR'.

  GS_FC_100-COLTEXT = '####'.

  APPEND GS_FC_100 TO GT_FC_100.



  CLEAR : GS_FC_100.

  GS_FC_100-COL_POS = 5.

  GS_FC_100-FIELDNAME = 'ZMATNAME'.

  GS_FC_100-COLTEXT = '###'.

  APPEND GS_FC_100 TO GT_FC_100.



  CLEAR : GS_FC_100.

  GS_FC_100-COL_POS = 6.

  GS_FC_100-FIELDNAME = 'ZMTART'.

  GS_FC_100-COLTEXT = '####'.

  APPEND GS_FC_100 TO GT_FC_100.



  CLEAR : GS_FC_100.

  GS_FC_100-COL_POS = 7.

  GS_FC_100-FIELDNAME = 'ZVOLUM'.

  GS_FC_100-COLTEXT = '##'.

  APPEND GS_FC_100 TO GT_FC_100.



  CLEAR : GS_FC_100.

  GS_FC_100-COL_POS = 8.

  GS_FC_100-FIELDNAME = 'VRKME'.

  GS_FC_100-COLTEXT = '##'.

  APPEND GS_FC_100 TO GT_FC_100.



  CLEAR : GS_FC_100.

  GS_FC_100-COL_POS = 9.

  GS_FC_100-FIELDNAME = 'ZNSAMT'.

  GS_FC_100-COLTEXT = '####'.

  GS_FC_100-DO_SUM = 'X'.

  GS_FC_100-CFIELDNAME = 'ZWAERS'.

  APPEND GS_FC_100 TO GT_FC_100.



  CLEAR : GS_FC_100.

  GS_FC_100-COL_POS = 10.

  GS_FC_100-FIELDNAME = 'ZSLAMT'.

  GS_FC_100-COLTEXT = '####'.

  GS_FC_100-DO_SUM = 'X'.

  GS_FC_100-CFIELDNAME = 'ZWAERS'.

  APPEND GS_FC_100 TO GT_FC_100.



  CLEAR : GS_FC_100.

  GS_FC_100-COL_POS = 11.

  GS_FC_100-FIELDNAME = 'ZDCAMT'.

  GS_FC_100-COLTEXT = '####'.

  GS_FC_100-DO_SUM = 'X'.

  GS_FC_100-CFIELDNAME = 'ZWAERS'.

  APPEND GS_FC_100 TO GT_FC_100.



  CLEAR : GS_FC_100.

  GS_FC_100-COL_POS = 12.

  GS_FC_100-FIELDNAME = 'ZWAERS'.

  GS_FC_100-COLTEXT = '##'.

  GS_FC_100-EMPHASIZE = 'C300'.

  APPEND GS_FC_100 TO GT_FC_100.



  CLEAR : GS_FC_100.

  GS_FC_100-COL_POS = 13.

  GS_FC_100-FIELDNAME = 'ZSALE'.

  GS_FC_100-COLTEXT = '####'.

  APPEND GS_FC_100 TO GT_FC_100.



  CLEAR : GS_FC_100.

  GS_FC_100-COL_POS = 14.

  GS_FC_100-FIELDNAME = 'ZJDATE'.

  GS_FC_100-COLTEXT = '####'.

  APPEND GS_FC_100 TO GT_FC_100.



  CLEAR : GS_FC_100.

  GS_FC_100-COL_POS = 15.

  GS_FC_100-FIELDNAME = 'ZRET'.

  GS_FC_100-COLTEXT = '####'.

  APPEND GS_FC_100 TO GT_FC_100.



  CLEAR : GS_FC_100.

  GS_FC_100-COL_POS = 16.

  GS_FC_100-FIELDNAME = 'ZRDATE'.

  GS_FC_100-COLTEXT = '####'.

  APPEND GS_FC_100 TO GT_FC_100.



  CLEAR : GS_FC_101, GT_FC_101.



  GS_FC_101-COL_POS = 1.

  GS_FC_101-COLTEXT = '##'.

  GS_FC_100-FIELDNAME = 'ZICON'.

  APPEND GS_FC_101 TO GT_FC_101.



  CLEAR : GS_FC_101.

  GS_FC_101-COL_POS = 2.

  GS_FC_101-FIELDNAME = 'ZORDNO'.

  GS_FC_101-COLTEXT = '####'.

  APPEND GS_FC_101 TO GT_FC_101.



  CLEAR : GS_FC_101.

  GS_FC_101-COL_POS = 3.

  GS_FC_101-FIELDNAME = 'ZIDCODE'.

  GS_FC_101-COLTEXT = '##ID'.

  APPEND GS_FC_101 TO GT_FC_101.



  CLEAR : GS_FC_101.

  GS_FC_101-COL_POS = 4.

  GS_FC_101-FIELDNAME = 'ZMATNR'.

  GS_FC_101-COLTEXT = '####'.

  APPEND GS_FC_101 TO GT_FC_101.



  CLEAR : GS_FC_101.

  GS_FC_101-COL_POS = 5.

  GS_FC_101-FIELDNAME = 'ZMATNAME'.

  GS_FC_101-COLTEXT = '###'.

  APPEND GS_FC_101 TO GT_FC_101.



  CLEAR : GS_FC_101.

  GS_FC_101-COL_POS = 6.

  GS_FC_101-FIELDNAME = 'ZMTART'.

  GS_FC_101-COLTEXT = '####'.

  APPEND GS_FC_101 TO GT_FC_101.



  CLEAR : GS_FC_101.

  GS_FC_101-COL_POS = 7.

  GS_FC_101-FIELDNAME = 'ZVOLUM'.

  GS_FC_101-COLTEXT = '##'.

  APPEND GS_FC_101 TO GT_FC_101.



  CLEAR : GS_FC_101.

  GS_FC_101-COL_POS = 8.

  GS_FC_101-FIELDNAME = 'VRKME'.

  GS_FC_101-COLTEXT = '##'.

  APPEND GS_FC_101 TO GT_FC_101.



  CLEAR : GS_FC_101.

  GS_FC_101-COL_POS = 9.

  GS_FC_101-FIELDNAME = 'ZSLAMT'.

  GS_FC_101-COLTEXT = '####'.

  GS_FC_101-CFIELDNAME = 'ZWAERS'.

  APPEND GS_FC_101 TO GT_FC_101.



  CLEAR : GS_FC_101.

  GS_FC_101-COL_POS = 10.

  GS_FC_101-FIELDNAME = 'ZWAERS'.

  GS_FC_101-COLTEXT = '##'.

  GS_FC_100-EMPHASIZE = 'C300'.

  APPEND GS_FC_101 TO GT_FC_101.



  CLEAR : GS_FC_101.

  GS_FC_101-COL_POS = 11.

  GS_FC_101-FIELDNAME = 'ZDFLAG'.

  GS_FC_101-COLTEXT = '####'.

  APPEND GS_FC_101 TO GT_FC_101.



  CLEAR : GS_FC_101.

  GS_FC_101-COL_POS = 12.

  GS_FC_101-FIELDNAME = 'ZDGUBUN'.

  GS_FC_101-COLTEXT = '####'.

  APPEND GS_FC_101 TO GT_FC_101.



  CLEAR : GS_FC_101.

  GS_FC_101-COL_POS = 13.

  GS_FC_101-FIELDNAME = 'ZDDATE'.

  GS_FC_101-COLTEXT = '####'.

  APPEND GS_FC_101 TO GT_FC_101.



  CLEAR : GS_FC_101.

  GS_FC_101-COL_POS = 14.

  GS_FC_101-FIELDNAME = 'ZRDATE'.

  GS_FC_101-COLTEXT = '####'.

  APPEND GS_FC_101 TO GT_FC_101.



  CLEAR : GS_FC_101.

  GS_FC_101-COL_POS = 15.

  GS_FC_101-FIELDNAME = 'ZFLAG'.

  GS_FC_101-COLTEXT = '####'.

  APPEND GS_FC_101 TO GT_FC_101.

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

  GS_LAYOUT-ZEBRA = 'X'.

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

    CLEAR GS_SORT.

    GS_SORT-SPOS = 1.

    GS_SORT-FIELDNAME = 'ZIDCODE'.

    GS_SORT-UP = 'X'.

    GS_SORT-SUBTOT = 'X'.

    APPEND GS_SORT TO GT_SORT.





    CLEAR GS_SORT.

    GS_SORT-SPOS = 2.

    GS_SORT-FIELDNAME = 'ZORDNO'.

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




FORM CALL_ALV.



IF P_R1 = 'X'.

CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = GS_VARIANT




*    I_SAVE                        =

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

    IT_OUTTAB                     = GT_T100_RESULT

    IT_FIELDCATALOG               = GT_FC_100

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

ENDIF.



IF P_R2 = 'X'.

CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = GS_VARIANT




*    I_SAVE                        =

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

    IT_OUTTAB                     = GT_T101_RESULT

    IT_FIELDCATALOG               = GT_FC_101

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

ENDIF.



ENDFORM.