
*&---------------------------------------------------------------------*

*& Report ZEDR24_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR24_PRACTICE003.



TABLES : ZEDT24_100.

TABLES : ZEDT24_101.



"0. ### # ## # ###

"0-1. ## ## ##

CONSTANTS : C_RATE TYPE I VALUE '100'.



"0-2. RANGE ### ## DB### # ### # ### # ##

RANGES GR_ZSALE FOR ZEDT24_100-ZSALE_FG.

RANGES GR_ZDFLAG FOR ZEDT24_101-ZDFLAG.

RANGES GR_ZDGUBUN FOR ZEDT24_101-ZDGUBUN.

RANGES GR_ZFLAG FOR ZEDT24_101-ZFLAG.



GR_ZSALE-SIGN = 'I'.

GR_ZSALE-OPTION = 'BT'.

GR_ZSALE-LOW = '1'.

GR_ZSALE-HIGH = '2'.

APPEND GR_ZSALE.



GR_ZDFLAG-SIGN = 'I'.

GR_ZDFLAG-OPTION = 'BT'.

GR_ZDFLAG-LOW = '1'.

GR_ZDFLAG-HIGH = '3'.

APPEND GR_ZDFLAG.



GR_ZDGUBUN-SIGN = 'I'.

GR_ZDGUBUN-OPTION = 'BT'.

GR_ZDGUBUN-LOW = '1'.

GR_ZDGUBUN-HIGH = '7'.

APPEND GR_ZDGUBUN.



"1. ## ## ##

"1-1. B1 ####, ## ID, ####, ## ##or#### ##

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZORDNO FOR ZEDT24_100-ZORDNO.

  PARAMETERS : P_IDCODE LIKE ZEDT24_100-ZIDCODE.

  SELECT-OPTIONS : S_MATNR FOR ZEDT24_100-ZMATNR.

  SELECT-OPTIONS : S_ZJDATE FOR ZEDT24_100-ZJDATE MODIF ID M1. "## ## ### ###

  SELECT-OPTIONS : S_ZDDATE FOR ZEDT24_101-ZDDATE MODIF ID M2. "## ## ## # ###

SELECTION-SCREEN END OF BLOCK B1.



"1-2. B2 ####or#### ##

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.  "## ##

  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.                               "## ##

SELECTION-SCREEN END OF BLOCK B2.



"1-3. B3 #### ## ## ##

SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X' USER-COMMAND UC1 MODIF ID M3.  "#### ##

SELECTION-SCREEN END OF BLOCK B3.



"2. ## ## ###

INITIALIZATION.

  "2-1. DB## ##### ### ###, ITAB

  DATA : GS_ORDER LIKE ZEDT24_100,

         GT_ORDER LIKE TABLE OF GS_ORDER, "100# ##

         GS_DELI LIKE ZEDT24_101,

         GT_DELI LIKE TABLE OF GS_DELI. "101# ##



  "2-2. #### ### ###

  DATA : BEGIN OF GS_T100_RESULT, "###### ## ###

    ZORDNO TYPE I,

    ZIDCODE LIKE ZEDT24_100-ZIDCODE,

    ZMATNR TYPE I,

    ZMATNAME LIKE ZEDT24_100-ZMATNAME,

    ZMTART TYPE C LENGTH 8,

    ZVOLUM TYPE I,

    VRKME LIKE ZEDT24_100-VRKME,

    ZNSAMT TYPE I,

    ZSLAMT TYPE I,

    ZDCAMT TYPE I,

    ZSALE TYPE C LENGTH 4,

    ZJDATE LIKE ZEDT24_100-ZJDATE,

    ZRET TYPE C LENGTH 10,

    ZRDATE LIKE ZEDT24_100-ZRDATE,

  END OF GS_T100_RESULT.



  "2-3. #### ### ###

  DATA : BEGIN OF GS_T101_RESULT, "###### ## ###

    ZORDNO TYPE I,

    ZIDCODE LIKE ZEDT24_101-ZIDCODE,

    ZMATNR TYPE I,

    ZMATNAME LIKE ZEDT24_101-ZMATNAME,

    ZMTART TYPE C LENGTH 8,

    ZVOLUM TYPE I,

    VRKME LIKE ZEDT24_101-VRKME,

    ZSLAMT TYPE I,

    ZDFLAG TYPE C LENGTH 8,

    ZDGUBUN TYPE C LENGTH 8,

    ZDDATE LIKE ZEDT24_101-ZDDATE,

    ZRDATE LIKE ZEDT24_101-ZRDATE,

    ZFLAG LIKE ZEDT24_101-ZFLAG,

  END OF GS_T101_RESULT.



  "2-4. #### #### ### ITAB

  DATA : GT_T100_RESULT LIKE TABLE OF GS_T100_RESULT,

         GT_T101_RESULT LIKE TABLE OF GS_T101_RESULT.



  "2-5. ####, ##### ###### ### ##

  DATA : GV_START_DATE TYPE DATS,

         GV_END_DATE TYPE DATS.



  "2-5-1. #### #### #### ###

  GV_START_DATE = SY-DATUM.

  GV_START_DATE+6(2) = '01'.

  GV_END_DATE = SY-DATUM.

  PERFORM GET_LAST_DAY USING GV_END_DATE.



  S_ZJDATE-LOW = GV_START_DATE.

  S_ZJDATE-HIGH = GV_END_DATE.

  APPEND S_ZJDATE.



  S_ZDDATE-LOW = GV_START_DATE.

  S_ZDDATE-HIGH = GV_END_DATE.

  APPEND S_ZDDATE.





"3. ####

AT SELECTION-SCREEN OUTPUT.

  "3-1. #### ### #### ##

  IF P_R1 = 'X'.

    LOOP AT SCREEN.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = '1'.

      ENDIF.

      IF SCREEN-GROUP1 = 'M2'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

      MODIFY SCREEN.

    ENDLOOP.

  "3-2. #### ### #### ##

  ELSE.

    LOOP AT SCREEN.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

      IF SCREEN-GROUP1 = 'M2'.

        SCREEN-ACTIVE = '1'.

      ENDIF.

      MODIFY SCREEN.

    ENDLOOP.

  ENDIF.



"4. DB## # #### MODIFY##

START-OF-SELECTION.



  "4-1. ## ## MODIFY

  IF P_R1 = 'X'.

    PERFORM GET_DATA_ORDER.   "#### # ####

    PERFORM MODIFY_DATA_ORDER."### ### ##### ##

  "4-2. ## ## MODIFY

  ELSE.

    PERFORM GET_DATA_DELI.

    PERFORM MODIFY_DATA_DELI.

  ENDIF.



"5. ## ##

END-OF-SELECTION.

  IF P_R1 = 'X'.

    PERFORM PRINT_ORDER.

  ELSE.

    PERFORM PRINT_DELI.

  ENDIF.






*&---------------------------------------------------------------------*

*&      Form  GET_LAST_DAY

*&---------------------------------------------------------------------*

*       text #### ## ## ## ### ### ### ##### ##

*----------------------------------------------------------------------*

*  <--  GV_END_DATE ### ## # ## ## ### ##

*----------------------------------------------------------------------*




FORM GET_LAST_DAY USING GV_END_DATE TYPE SY-DATUM.

  DATA :LV_YEAR TYPE N LENGTH 4,

        LV_MONTH TYPE N LENGTH 2,

        LV_LAST_DAY TYPE N LENGTH 2.



  "### # ###.

  LV_YEAR = GV_END_DATE(4).

  LV_MONTH = GV_END_DATE+4(2).



  "# ##

  IF LV_MONTH = '01' OR LV_MONTH = '03' OR LV_MONTH = '05' OR LV_MONTH = '07' OR LV_MONTH = '08'

     OR LV_MONTH = '10' OR LV_MONTH = '12'.

    LV_LAST_DAY = '31'.

   ELSE.

     LV_LAST_DAY = '30'.

   ENDIF.



   GV_END_DATE+6(2) = LV_LAST_DAY.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA_ORDER

*&---------------------------------------------------------------------*

*       text 100# #### ##### ## #### #### #### ###

*----------------------------------------------------------------------*

*       GT_ORDER# ##### APPEND

*----------------------------------------------------------------------*




FORM GET_DATA_ORDER.

  DATA : LS_ORDER LIKE LINE OF GT_ORDER,

         LT_ORDER LIKE TABLE OF LS_ORDER.



  SELECT * FROM ZEDT24_100

    INTO CORRESPONDING FIELDS OF TABLE LT_ORDER

    WHERE ZSALE_FG IN GR_ZSALE.



  LOOP AT LT_ORDER INTO LS_ORDER.

    IF ( S_ZORDNO IS INITIAL OR LS_ORDER-ZORDNO IN S_ZORDNO )

      AND ( P_IDCODE IS INITIAL OR LS_ORDER-ZIDCODE = P_IDCODE )

      AND ( S_MATNR IS INITIAL OR LS_ORDER-ZMATNR IN S_MATNR )

      AND ( S_ZJDATE IS INITIAL OR LS_ORDER-ZJDATE IN S_ZJDATE ).

      APPEND LS_ORDER TO GT_ORDER.

    ENDIF.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA_DELI

*&---------------------------------------------------------------------*

*       text  101# #### ##### ## #### #### #### ###

*----------------------------------------------------------------------*

*       GT_DELI# ##### APPEND

*----------------------------------------------------------------------*




FORM GET_DATA_DELI .

  DATA : LS_DELI LIKE LINE OF GT_DELI,

         LT_DELI LIKE TABLE OF LS_DELI.



  GR_ZFLAG-SIGN = 'I'.

  IF P_CH1 = 'X'.

    CLEAR GR_ZFLAG.

  ELSE.

    GR_ZFLAG-LOW = 'X'.

    GR_ZFLAG-OPTION = 'NE'.

  ENDIF.

  APPEND GR_ZFLAG.



  SELECT * FROM ZEDT24_101

    INTO CORRESPONDING FIELDS OF TABLE LT_DELI

    WHERE ZDFLAG IN GR_ZDFLAG

      AND ZDGUBUN IN GR_ZDGUBUN.



  LOOP AT LT_DELI INTO LS_DELI.

    IF ( S_ZORDNO IS INITIAL OR LS_DELI-ZORDNO IN S_ZORDNO )

      AND ( P_IDCODE IS INITIAL OR LS_DELI-ZIDCODE = P_IDCODE )

      AND ( S_MATNR IS INITIAL OR LS_DELI-ZMATNR IN S_MATNR )

      AND ( S_ZDDATE IS INITIAL OR LS_DELI-ZDDATE IN S_ZDDATE )

      AND ( GR_ZFLAG IS INITIAL OR LS_DELI-ZFLAG IN GR_ZFLAG ).

      APPEND LS_DELI TO GT_DELI.

    ENDIF.

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

*&      Form  MODIFY_DATA_ORDER

*&---------------------------------------------------------------------*

*       text  ##### ### DB### ## #### ## ### ## ##

*----------------------------------------------------------------------*

*       GT_ORDER## ## ## ### ## #

*       GT_T100_RESULT# ## ## APPEND

*----------------------------------------------------------------------*




FORM MODIFY_DATA_ORDER .

  DATA : LV_ZMTART TYPE C LENGTH 8,

         LV_ZSALE TYPE C LENGTH 4,

         LV_ZRET TYPE C LENGTH 10.



  LOOP AT GT_ORDER INTO GS_ORDER.

    CLEAR GS_T100_RESULT.

    CLEAR LV_ZMTART.

    CLEAR LV_ZSALE.

    CLEAR LV_ZRET.



    MOVE-CORRESPONDING GS_ORDER TO GS_T100_RESULT.



    "ENUM ## #### ##

    PERFORM CONVERT_ZMTART USING LV_ZMTART GS_ORDER-ZMTART.

    PERFORM CONVERT_ZSALE USING LV_ZSALE GS_ORDER-ZSALE_FG.

    PERFORM CONVERT_ZRET USING LV_ZRET GS_ORDER-ZRET_FG.

    GS_T100_RESULT-ZMTART = LV_ZMTART.

    GS_T100_RESULT-ZSALE = LV_ZSALE.

    GS_T100_RESULT-ZRET = LV_ZRET.



    "## ### ##

    GS_T100_RESULT-ZNSAMT = GS_T100_RESULT-ZNSAMT * C_RATE.

    GS_T100_RESULT-ZSLAMT = GS_T100_RESULT-ZSLAMT * C_RATE.

    GS_T100_RESULT-ZDCAMT = GS_T100_RESULT-ZDCAMT * C_RATE.



    "#### ###

    IF LV_ZRET IS INITIAL.

      GS_T100_RESULT-ZRDATE = 0.

    ENDIF.



    APPEND GS_T100_RESULT TO GT_T100_RESULT.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_DELI

*&---------------------------------------------------------------------*

*       text  ##### ### DB### ## #### ## ### ## ##

*----------------------------------------------------------------------*

*       GT_DELI## ## ## ### ## #

*       GT_T101_RESULT# ## ## APPEND

*----------------------------------------------------------------------*




FORM MODIFY_DATA_DELI.

  DATA : LV_ZMTART TYPE C LENGTH 8,

         LV_ZDFLAG TYPE C LENGTH 8,

         LV_ZDGUBUN TYPE C LENGTH 8.



  LOOP AT GT_DELI INTO GS_DELI.

    CLEAR GS_T101_RESULT.

    CLEAR LV_ZMTART.

    CLEAR LV_ZDFLAG.

    CLEAR LV_ZDGUBUN.



    MOVE-CORRESPONDING GS_DELI TO GS_T101_RESULT.



    "ENUM ## #### ##

    PERFORM CONVERT_ZMTART USING LV_ZMTART GS_DELI-ZMTART.

    PERFORM CONVERT_ZDFLAGE USING LV_ZDFLAG GS_DELI-ZDFLAG.

    PERFORM CONVERT_ZDGUBUN  USING LV_ZDGUBUN GS_DELI-ZDGUBUN.

    GS_T101_RESULT-ZMTART = LV_ZMTART.

    GS_T101_RESULT-ZDFLAG = LV_ZDFLAG.

    GS_T101_RESULT-ZDGUBUN = LV_ZDGUBUN.



    "## ### ##

    GS_T101_RESULT-ZSLAMT = GS_T101_RESULT-ZSLAMT * C_RATE.



    APPEND GS_T101_RESULT TO GT_T101_RESULT.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  PRINT_ORDER

*&---------------------------------------------------------------------*

*       text  #### ## PERFORM

*----------------------------------------------------------------------*

*       GT_T100_RESULT## ## ## ### ##

*----------------------------------------------------------------------*




FORM PRINT_ORDER .

  LOOP AT GT_T100_RESULT INTO GS_T100_RESULT.

    AT FIRST.

      IF P_CH1 = 'X'.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####   |     ID     |  ####   |        ###        | #### |     ##    |## |  ####   |   ####  |  ####   | ## |  ####  |  ####  |  ####  |'.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.

          WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####   |     ID     |  ####   |        ###        | #### |     ##    |## |  ####   |   ####  |  ####   | ## |  ####  |'.

          WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDAT.



    IF P_CH1 = 'X'.

      WRITE :/ '|',GS_T100_RESULT-ZORDNO,

               '|',GS_T100_RESULT-ZIDCODE,

               '|',GS_T100_RESULT-ZMATNR,

               '|',GS_T100_RESULT-ZMATNAME,

               '|',GS_T100_RESULT-ZMTART,

               '|',GS_T100_RESULT-ZVOLUM,

               '|',GS_T100_RESULT-VRKME,

               '|',GS_T100_RESULT-ZNSAMT,

               '|',GS_T100_RESULT-ZSLAMT,

               '|',GS_T100_RESULT-ZDCAMT,

               '|',GS_T100_RESULT-ZSALE,

               '|',GS_T100_RESULT-ZJDATE,

               '|',GS_T100_RESULT-ZRET.

      IF GS_T100_RESULT-ZRET IS INITIAL.

        WRITE : '|            |'.

      ELSE.

        WRITE : '|',GS_T100_RESULT-ZRDATE,'|'.

      ENDIF.       WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

    ELSE.

      IF GS_T100_RESULT-ZSALE <> '##'.

        WRITE :/ '|',GS_T100_RESULT-ZORDNO,

                 '|',GS_T100_RESULT-ZIDCODE,

                 '|',GS_T100_RESULT-ZMATNR,

                 '|',GS_T100_RESULT-ZMATNAME,

                 '|',GS_T100_RESULT-ZMTART,

                 '|',GS_T100_RESULT-ZVOLUM,

                 '|',GS_T100_RESULT-VRKME,

                 '|',GS_T100_RESULT-ZNSAMT,

                 '|',GS_T100_RESULT-ZSLAMT,

                 '|',GS_T100_RESULT-ZDCAMT,

                 '|',GS_T100_RESULT-ZSALE,

                 '|',GS_T100_RESULT-ZJDATE,'|'.

          WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDIF.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  PRINT_DELI

*&---------------------------------------------------------------------*

*       text  #### ## PERFORM

*----------------------------------------------------------------------*

*       GT_T101_RESULT## ## ## ### ##

*----------------------------------------------------------------------*




FORM PRINT_DELI .

  LOOP AT GT_T101_RESULT INTO GS_T101_RESULT.

    AT FIRST.

      IF P_CH1 = 'X'.

          WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####   |     ID     |  ####   |        ###        | #### |     ##    |## |   ####  | #### |   ##   |  ####  |  ####  |'.

          WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.

          WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####   |     ID     |  ####   |        ###        | #### |     ##    |## |   ####  | #### |   ##   |  ####  |'.

          WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDAT.



    IF P_CH1 = 'X'.

      WRITE :/ '|',GS_T101_RESULT-ZORDNO,

               '|',GS_T101_RESULT-ZIDCODE,

               '|',GS_T101_RESULT-ZMATNR,

               '|',GS_T101_RESULT-ZMATNAME,

               '|',GS_T101_RESULT-ZMTART,

               '|',GS_T101_RESULT-ZVOLUM,

               '|',GS_T101_RESULT-VRKME,

               '|',GS_T101_RESULT-ZSLAMT.

      IF GS_T101_RESULT-ZRDATE IS INITIAL.

        WRITE: '|',GS_T101_RESULT-ZDFLAG.

      ELSE.

        WRITE : '|         '.

      ENDIF.

      WRITE:   '|',GS_T101_RESULT-ZDGUBUN,

               '|',GS_T101_RESULT-ZDDATE.

      IF GS_T101_RESULT-ZRDATE IS INITIAL.

        WRITE : '|            |'.

      ELSE.

        WRITE : '|',GS_T101_RESULT-ZRDATE,'|'.

      ENDIF.

      WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------------------'.

    ELSE.

      IF GS_T101_RESULT-ZFLAG <> 'X'.

        WRITE :/ '|',GS_T101_RESULT-ZORDNO,

                 '|',GS_T101_RESULT-ZIDCODE,

                 '|',GS_T101_RESULT-ZMATNR,

                 '|',GS_T101_RESULT-ZMATNAME,

                 '|',GS_T101_RESULT-ZMTART,

                 '|',GS_T101_RESULT-ZVOLUM,

                 '|',GS_T101_RESULT-VRKME,

                 '|',GS_T101_RESULT-ZSLAMT,

                 '|',GS_T101_RESULT-ZDFLAG,

                 '|',GS_T101_RESULT-ZDGUBUN,

                 '|',GS_T101_RESULT-ZDDATE,'|'.

        WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDIF.

  ENDLOOP.

ENDFORM.