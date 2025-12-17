
*&---------------------------------------------------------------------*

*&  Include           ZEDR05_PRACTICE008_F01



*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form SET_SCREEN .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M2'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '0'.

      ELSEIF P_R2 = 'X'.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 ='M1'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R2 = 'X'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

endform.




*&---------------------------------------------------------------------*

*&      Form  CHECK_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form CHECK_DATA .

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

    R_FG-SIGN = 'I'.

    R_FG-OPTION = 'EQ'.

    R_FG-LOW = ' '.

    APPEND R_FG.



    IF P_CH1 = 'X'.

      R_ZG-LOW = '2'.

      APPEND R_ZG.

    ENDIF.

  ENDIF.

endform.




*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form SET_INIT .

  IF S_ZJDATE[] IS INITIAL.

    S_ZJDATE-LOW = SY-DATUM(6) && '01'.

    S_ZJDATE-HIGH = SY-DATUM(6) && '01'.

    S_ZJDATE-SIGN = 'I'.

    S_ZJDATE-OPTION = 'BT'.



    CALL FUNCTION 'LAST_DAY_OF_MONTHS'

      exporting

        DAY_IN            = S_ZJDATE-HIGH

      importing

        LAST_DAY_OF_MONTH = S_ZJDATE-HIGH.



    APPEND S_ZJDATE.

  ENDIF.



  IF S_ZDDATE[] IS INITIAL.

    S_ZDDATE-LOW = SY-DATUM(6) && '01'.

    S_ZDDATE-HIGH = SY-DATUM(6) && '01'.

    S_ZDDATE-SIGN = 'I'.

    S_ZDDATE-OPTION = 'BT'.

    CALL FUNCTION 'LAST_DAY_OF_MONTHS'

      exporting

        DAY_IN            =     S_ZDDATE-HIGH

      importing

        LAST_DAY_OF_MONTH =     S_ZDDATE-HIGH.

    APPEND S_ZDDATE.

  ENDIF.

endform.




*&---------------------------------------------------------------------*

*&      Form  GET_ORDER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form GET_ORDER .

  SELECT * FROM ZEDT05_100 INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

  WHERE ZJDATE IN S_ZJDATE AND ZIDCODE IN S_ZID AND ZMATNR IN S_MATNR AND ZORDNO IN S_ZORDNO

  AND ZSALE_FG IN R_FG.



  DATA : LV_NAMETYPE TYPE CHAR1.

  LOOP AT GT_ORDER INTO GS_ORDER.

    MOVE-CORRESPONDING GS_ORDER TO GS_100.



    LV_NAMETYPE = 1.

    PERFORM CONVERT_NAME USING GS_ORDER-ZMTART LV_NAMETYPE CHANGING GS_100-ZMAT_NAME.



    IF GS_ORDER-ZSALE_FG = '1'.

      GS_100-ZSALE_NAME = '##'.

      GS_100-ICON = '@08@'.

    ELSEIF GS_ORDER-ZSALE_FG = '2' .

      GS_100-ZSALE_NAME = '##'.

      GS_100-ICON = '@0A@'.

    ENDIF.



    IF P_CH1 = 'X'.

      LV_NAMETYPE = 2.

      PERFORM CONVERT_NAME USING GS_ORDER-ZRET_FG LV_NAMETYPE CHANGING GS_100-ZRET_NAME.

    ENDIF.



    APPEND GS_100 TO GT_100.

    CLEAR : GS_ORDER, GS_100.

  ENDLOOP.

endform.




*&---------------------------------------------------------------------*

*&      Form  GET_DELIVERY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form GET_DELIVERY .

  SELECT * FROM ZEDT05_101 INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY

  WHERE ZDDATE IN S_ZDDATE AND ZIDCODE IN S_ZID AND ZMATNR IN S_MATNR AND ZORDNO IN S_ZORDNO.



  DATA : LV_NAMETYPE TYPE CHAR1.

  LOOP AT GT_DELIVERY INTO GS_DELIVERY.

    MOVE-CORRESPONDING GS_DELIVERY TO GS_200.



    LV_NAMETYPE = 1.

    PERFORM CONVERT_NAME USING GS_DELIVERY-ZMTART LV_NAMETYPE CHANGING GS_200-ZMAT_NAME.



    LV_NAMETYPE = 3.

    PERFORM CONVERT_NAME USING GS_DELIVERY-ZDGUBUN LV_NAMETYPE CHANGING GS_200-ZDGUBUN_NAME.



    IF GS_DELIVERY-ZDFLAG = '1'.

      GS_200-ZDFLAG_NAME = '####'.

    ELSE.

      GS_200-ZDFLAG_NAME = '####'.

    ENDIF.



    IF GS_DELIVERY-ZFLAG = 'X'.

      GS_200-ICON = '@0A@'. "##

    ELSE.

      GS_200-ICON = '@08@'. "##

    ENDIF.



    APPEND GS_200 TO GT_200.

    CLEAR : GS_DELIVERY , GS_200.

  ENDLOOP.

endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form ALV_DISPLAY .



endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form ALV_LAYOUT .

  CLEAR : GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.



  CLEAR : GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form ALV_SORT .

  CLEAR : GS_SORT, GT_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZIDCODE'.

  GS_SORT-UP = 'X'.

  GS_SORT-SUBTOT = 'X'.

  APPEND GS_SORT TO GT_SORT.

endform.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GC_DOCKING  text

*      -->P_GC_GRID_100  text

*----------------------------------------------------------------------*




form CREATE_OBJECT  using    P_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER

                             P_GRID TYPE REF TO CL_GUI_ALV_GRID.

  create object P_DOCKING

    exporting

      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      EXTENSION                   = 2000.



  create object P_GRID

    exporting

      I_PARENT          = P_DOCKING.



endform.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form FIELD_CATALOG_100 .

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

  GS_FIELDCAT-FIELDNAME = 'ZMAT_NAME'.

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



  IF P_CH1 = 'X'.

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

endform.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form FIELD_CATALOG_200 .

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

  GS_FIELDCAT-FIELDNAME = 'ZMAT_NAME'.

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

  GS_FIELDCAT-FIELDNAME = 'ZDFLAG_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CURRENCY = 'KRW'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZDGUBUN_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZDDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_CH1 = 'X'.

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

    GS_FIELDCAT-EMPHASIZE = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.

endform.




*&---------------------------------------------------------------------*

*&      Form  CONVERT_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER_ZMTART  text

*      -->P_LV_NAMETYPE  text

*      <--P_GS_100_ZMAT_NAME  text

*----------------------------------------------------------------------*




form CONVERT_NAME  using    P_INPUT_VAL

                            P_NAMETYPE

                   changing P_CONVERT_VAL.



  CASE P_NAMETYPE.

    WHEN '1'. "####

      CASE P_INPUT_VAL.

        WHEN '001'.

          P_CONVERT_VAL = '##'.

        WHEN '002'.

          P_CONVERT_VAL = '##'.

        WHEN '003'.

          P_CONVERT_VAL = '##'.

        WHEN '004'.

          P_CONVERT_VAL = '##'.

        WHEN '005'.

          P_CONVERT_VAL = '##'.

        WHEN '006'.

          P_CONVERT_VAL = '###'.

      ENDCASE.

    WHEN '2'. "####

      CASE P_INPUT_VAL.

        WHEN '1'.

          P_CONVERT_VAL = '####'.

        WHEN '2'.

          P_CONVERT_VAL = '####'.

        WHEN '3'.

          P_CONVERT_VAL = '####'.

      ENDCASE.

    WHEN '3'. "####

      CASE P_INPUT_VAL.

        WHEN '1'.

          P_CONVERT_VAL = '###'.

        WHEN '2'.

          P_CONVERT_VAL = '###'.

        WHEN '3'.

          P_CONVERT_VAL = '###'.

        WHEN '4'.

          P_CONVERT_VAL = '###'.

        WHEN '5'.

          P_CONVERT_VAL = '###'.

        WHEN '6'.

          P_CONVERT_VAL = '###'.

        WHEN '7'.

          P_CONVERT_VAL = '###'.

      ENDCASE.



  ENDCASE.

endform.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GT_100  text

*      -->P_GC_GRID_100  text

*      -->P_GS_LAYOUT  text

*      -->P_GS_VARIANT  text

*----------------------------------------------------------------------*




form CALL_ALV  using    P_OUTTAB TYPE STANDARD TABLE

                        P_GRID TYPE REF TO CL_GUI_ALV_GRID

                        P_LAYOUT TYPE LVC_S_LAYO

                        P_VARIANT LIKE DISVARIANT.

call method P_GRID->SET_TABLE_FOR_FIRST_DISPLAY

  exporting

    IS_VARIANT                    =  P_VARIANT

    I_SAVE                        = 'A'

    IS_LAYOUT                     = P_LAYOUT



  changing

    IT_OUTTAB                     = P_OUTTAB

    IT_FIELDCATALOG               = GT_FIELDCAT

    IT_SORT                       = GT_SORT.



endform.