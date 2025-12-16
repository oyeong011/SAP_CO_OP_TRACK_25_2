
*&---------------------------------------------------------------------*

*& Report ZEDR12_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_PRACTICE003.

TABLES: ZEDT12_100.

TABLES: ZEDT12_101.

"RANGES: GR_

DATA: LV_FIRST TYPE D. "### 1#

DATA: LV_LAST TYPE D. "### ##



"ITAB##

DATA : BEGIN OF GS_ORDER, "#### ###

  ZORDNO LIKE ZEDT12_100-ZORDNO, "####

  ZIDCODE LIKE ZEDT12_100-ZIDCODE, "##ID

  ZMATNR LIKE ZEDT12_100-ZMATNR, "####

  ZMTART LIKE ZEDT12_100-ZMTART, "####

  ZMATNAME LIKE ZEDT12_100-ZMATNAME, "###

  ZVOLUM LIKE ZEDT12_100-ZVOLUM, "##

  VRKME LIKE ZEDT12_100-VRKME, "####

  ZNSAMT LIKE ZEDT12_100-ZNSAMT, "####

  ZSLAMT LIKE ZEDT12_100-ZSLAMT, "####

  ZDCAMT LIKE ZEDT12_100-ZDCAMT, "####

  ZDC_FG LIKE ZEDT12_100-ZDC_FG, "####

  ZSALE_FG LIKE ZEDT12_100-ZSALE_FG, "####

  ZRET_FG LIKE ZEDT12_100-ZRET_FG, "####

  ZJDATE LIKE ZEDT12_100-ZJDATE, "####

  ZRDATE LIKE ZEDT12_100-ZRDATE, "####

  END OF GS_ORDER.

DATA : GT_ORDER LIKE TABLE OF GS_ORDER.



DATA : BEGIN OF GS_DELIVERY, "#### ###

  ZORDNO LIKE ZEDT12_101-ZORDNO, "####

  ZIDCODE LIKE ZEDT12_101-ZIDCODE, "##ID

  ZMATNR LIKE ZEDT12_101-ZMATNR, "####

  ZMTART LIKE ZEDT12_101-ZMTART, "####

  ZMATNAME LIKE ZEDT12_101-ZMATNAME, "###

  ZVOLUM LIKE ZEDT12_101-ZVOLUM, "##

  VRKME LIKE ZEDT12_101-VRKME, "####

  ZSLAMT LIKE ZEDT12_101-ZSLAMT, "####

  ZDFLAG LIKE ZEDT12_101-ZDFLAG, "####

  ZDGUBUN LIKE ZEDT12_101-ZDGUBUN, "####

  ZDDATE LIKE ZEDT12_101-ZDDATE, "####

  ZRDATE LIKE ZEDT12_101-ZRDATE, "####

  ZFLAG LIKE ZEDT12_101-ZFLAG, "FLAG

  END OF GS_DELIVERY.

DATA : GT_DELIVERY LIKE TABLE OF GS_DELIVERY.



"4. ### ### ###

DATA: BEGIN OF GS_OUT_ORDER,

  ZORDNO LIKE ZEDT12_100-ZORDNO, "####

  ZIDCODE LIKE ZEDT12_100-ZIDCODE, "##ID

  ZMATNR LIKE ZEDT12_100-ZMATNR, "####

  ZMTART LIKE ZEDT12_100-ZMTART, "####

  ZMATNAME LIKE ZEDT12_100-ZMATNAME, "###

  ZVOLUM LIKE ZEDT12_100-ZVOLUM, "##

  VRKME LIKE ZEDT12_100-VRKME, "####

  LV_ZNSAMT TYPE I, "####

  LV_ZSLAMT TYPE I, "####

  LV_ZDCAMT TYPE I, "####

  ZDC_FG LIKE ZEDT12_100-ZDC_FG, "####

  ZSALE_FG LIKE ZEDT12_100-ZSALE_FG, "####

  ZRET_FG LIKE ZEDT12_100-ZRET_FG, "####

  ZJDATE LIKE ZEDT12_100-ZJDATE, "####

  ZRDATE LIKE ZEDT12_100-ZRDATE, "####

  ZMTART_NAME(10) TYPE C, "####, #### ### ##

  ZSALE_FG_NAME(4) TYPE C, "####

  ZRET_FG_NAME(10) TYPE C, "####

END OF GS_OUT_ORDER.

DATA: GT_OUT_ORDER LIKE TABLE OF GS_OUT_ORDER.



DATA: BEGIN OF GS_OUT_DELIVERY,

  ZORDNO LIKE ZEDT12_101-ZORDNO, "####

  ZIDCODE LIKE ZEDT12_101-ZIDCODE, "##ID

  ZMATNR LIKE ZEDT12_101-ZMATNR, "####

  ZMTART LIKE ZEDT12_101-ZMTART, "####

  ZMATNAME LIKE ZEDT12_101-ZMATNAME, "###

  ZVOLUM LIKE ZEDT12_101-ZVOLUM, "##

  VRKME LIKE ZEDT12_101-VRKME, "####

  LV_ZSLAMT TYPE I,  "####

  ZDFLAG LIKE ZEDT12_101-ZDFLAG, "####

  ZDGUBUN LIKE ZEDT12_101-ZDGUBUN, "####

  ZDDATE LIKE ZEDT12_101-ZDDATE, "####

  ZRDATE LIKE ZEDT12_101-ZRDATE, "####

  ZFLAG LIKE ZEDT12_101-ZFLAG, "FLAG

  ZMTART_NAME(10) TYPE C,

  ZDFLAG_NAME(10) TYPE C,

  ZDGUBUN_NAME(10) TYPE C,

  END OF GS_OUT_DELIVERY.

  DATA: GT_OUT_DELIVERY LIKE TABLE OF GS_OUT_DELIVERY.



"##

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS: S_ZORDNO FOR ZEDT12_100-ZORDNO. "####

  SELECT-OPTIONS: S_ZID FOR ZEDT12_100-ZIDCODE NO INTERVALS NO-EXTENSION .  "##ID

  SELECT-OPTIONS: S_ZMATNR FOR ZEDT12_100-ZMATNR.  "####

  SELECT-OPTIONS: S_ZJDATE FOR ZEDT12_100-ZJDATE MODIF ID M1. "####, ####

  SELECT-OPTIONS: S_ZDDATE FOR ZEDT12_101-ZDDATE MODIF ID M2. "####

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS: P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. "####

  PARAMETERS: P_R2 RADIOBUTTON GROUP R1.  "####

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS: P_CH1 AS CHECKBOX DEFAULT 'X'. "######.

SELECTION-SCREEN END OF BLOCK B3.



INITIALIZATION. "SELECTION SCREEN### ### # ##### ###

"##

  PERFORM SET_DATE.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



  PERFORM WRITE_DATA.






*&---------------------------------------------------------------------*

*&      Form  SET_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DATE .

  "### 1#.

  LV_FIRST = |{ SY-DATUM+0(6) }01|.

  "### ##.

  CALL FUNCTION 'LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN      = SY-DATUM

    IMPORTING

      LAST_DAY_OF_MONTH = LV_LAST.

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

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  IF P_R1 = 'X'. "## DATA

   SELECT * FROM ZEDT12_100

     INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

     WHERE ZORDNO IN S_ZORDNO "####

     AND ZIDCODE IN S_ZID "## ID

     AND ZMATNR IN S_ZMATNR "####

     AND ZJDATE IN S_ZJDATE. "####, ####

  ELSEIF P_R2 = 'X'. "## DATA

    SELECT * FROM ZEDT12_101

     INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY

     WHERE ZORDNO IN S_ZORDNO "####

     AND ZIDCODE IN S_ZID "## ID

     AND ZMATNR IN S_ZMATNR "####

     AND ZDDATE IN S_ZDDATE. "####

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

  IF P_R1 = 'X'. "####

    LOOP AT GT_ORDER INTO GS_ORDER.

      CLEAR: GS_OUT_ORDER.

      MOVE-CORRESPONDING GS_ORDER TO GS_OUT_ORDER.



      CASE GS_ORDER-ZMTART.

        WHEN '001'.

          GS_OUT_ORDER-ZMTART_NAME = '##'.

        WHEN '002'.

          GS_OUT_ORDER-ZMTART_NAME = '##'.

        WHEN '003'.

          GS_OUT_ORDER-ZMTART_NAME = '##'.

        WHEN '004'.

          GS_OUT_ORDER-ZMTART_NAME = '##'.

        WHEN '005'.

          GS_OUT_ORDER-ZMTART_NAME = '##'.

        WHEN '006'.

          GS_OUT_ORDER-ZMTART_NAME = '###'.

      ENDCASE.

      CASE GS_ORDER-ZSALE_FG.

        WHEN '1'.

          GS_OUT_ORDER-ZSALE_FG_NAME = '##'.

        WHEN '2'.

          GS_OUT_ORDER-ZSALE_FG_NAME = '##'.

      ENDCASE.



      GS_OUT_ORDER-LV_ZNSAMT = GS_ORDER-ZNSAMT * 100.

      GS_OUT_ORDER-LV_ZSLAMT = GS_ORDER-ZSLAMT * 100.

      GS_OUT_ORDER-LV_ZDCAMT = GS_ORDER-ZDCAMT * 100.



      IF P_CH1 = 'X'. "######

        CASE GS_ORDER-ZRET_FG.

          WHEN '1'.

            GS_OUT_ORDER-ZRET_FG_NAME = '####'.

          WHEN '2'.

            GS_OUT_ORDER-ZRET_FG_NAME = '####'.

          WHEN '3'.

            GS_OUT_ORDER-ZRET_FG_NAME = '####'.

        ENDCASE.

      ENDIF.

    APPEND GS_OUT_ORDER TO GT_OUT_ORDER.



    ENDLOOP.



  ELSEIF P_R2 = 'X'.  "####

    LOOP AT GT_DELIVERY INTO GS_DELIVERY.

      CLEAR: GS_OUT_DELIVERY.

      MOVE-CORRESPONDING GS_DELIVERY TO GS_OUT_DELIVERY.



      CASE GS_DELIVERY-ZMTART. "####

        WHEN '001'.

          GS_OUT_DELIVERY-ZMTART_NAME = '##'.

        WHEN '002'.

          GS_OUT_DELIVERY-ZMTART_NAME = '##'.

        WHEN '003'.

          GS_OUT_DELIVERY-ZMTART_NAME = '##'.

        WHEN '004'.

          GS_OUT_DELIVERY-ZMTART_NAME = '##'.

        WHEN '005'.

          GS_OUT_DELIVERY-ZMTART_NAME = '##'.

        WHEN '006'.

          GS_OUT_DELIVERY-ZMTART_NAME = '###'.

      ENDCASE.

      CASE GS_DELIVERY-ZDFLAG. "####

        WHEN '1'.

          GS_OUT_DELIVERY-ZDFLAG_NAME = '####'.

        WHEN '2'.

          GS_OUT_DELIVERY-ZDFLAG_NAME = '###'.

        WHEN '3'.

          GS_OUT_DELIVERY-ZDFLAG_NAME = '####'.

      ENDCASE.

      CASE GS_DELIVERY-ZDGUBUN. "####

        WHEN '1'.

          GS_OUT_DELIVERY-ZDGUBUN_NAME = '###'.

        WHEN '2'.

          GS_OUT_DELIVERY-ZDGUBUN_NAME = '###'.

        WHEN '3'.

          GS_OUT_DELIVERY-ZDGUBUN_NAME = '###'.

        WHEN '4'.

          GS_OUT_DELIVERY-ZDGUBUN_NAME = '###'.

        WHEN '5'.

          GS_OUT_DELIVERY-ZDGUBUN_NAME = '###'.

        WHEN '6'.

          GS_OUT_DELIVERY-ZDGUBUN_NAME = '###'.

        WHEN '7'.

          GS_OUT_DELIVERY-ZDGUBUN_NAME = '###'.

      ENDCASE.



      GS_OUT_DELIVERY-LV_ZSLAMT = GS_DELIVERY-ZSLAMT * 100.

      APPEND GS_OUT_DELIVERY TO GT_OUT_DELIVERY.



    ENDLOOP.

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

*&      Form  WRITE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM WRITE_DATA .

  IF P_R1 = 'X'.

    LOOP AT GT_OUT_ORDER INTO GS_OUT_ORDER.

      AT FIRST.

        IF P_CH1 = 'X'.

          WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | ####   |## |## |  ####   |   ####  |  ####   | ## |  ####  |  ####  |  ####  | '.

          WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | ####   |## |## |  ####   |   ####  |  ####   | ## |  ####  | '.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDAT.



    IF P_CH1 = 'X'.

    WRITE:/ '|',GS_OUT_ORDER-ZORDNO,

            '|',GS_OUT_ORDER-ZIDCODE,

            '|',GS_OUT_ORDER-ZMATNR,

            '|',GS_OUT_ORDER-ZMATNAME,

            '|',GS_OUT_ORDER-ZMTART_NAME,

            '|',GS_OUT_ORDER-ZVOLUM,

            '|',GS_OUT_ORDER-VRKME,

            '|',GS_OUT_ORDER-LV_ZNSAMT,"####

            '|',GS_OUT_ORDER-LV_ZSLAMT,"####

            '|',GS_OUT_ORDER-LV_ZDCAMT,"####

            '|',GS_OUT_ORDER-ZSALE_FG_NAME,"##

            '|',GS_OUT_ORDER-ZJDATE,"####

            '|',GS_OUT_ORDER-ZRET_FG_NAME."####

      IF GS_OUT_ORDER-ZRET_FG IS NOT INITIAL.

        WRITE: '|',GS_OUT_ORDER-ZRDATE,"####

                '|'.

      ELSE.

        WRITE:'|            |'.

      ENDIF.



    WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

    ELSE.

    WRITE:/ '|',GS_OUT_ORDER-ZORDNO,

            '|',GS_OUT_ORDER-ZIDCODE,

            '|',GS_OUT_ORDER-ZMATNR,

            '|',GS_OUT_ORDER-ZMATNAME,

            '|',GS_OUT_ORDER-ZMTART_NAME,

            '|',GS_OUT_ORDER-ZVOLUM,

            '|',GS_OUT_ORDER-VRKME,

            '|',GS_OUT_ORDER-LV_ZNSAMT,

            '|',GS_OUT_ORDER-LV_ZSLAMT,

            '|',GS_OUT_ORDER-LV_ZDCAMT,"####

            '|',GS_OUT_ORDER-ZSALE_FG_NAME,"##

            '|',GS_OUT_ORDER-ZJDATE,"####

            '|'.

    WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

    ENDIF.

    ENDLOOP.

  ENDIF.

    IF P_R2 = 'X'.

    LOOP AT GT_OUT_DELIVERY INTO GS_OUT_DELIVERY.

      AT FIRST.

        IF P_CH1 = 'X'.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | ####   |## |## |  ####   | ####   |   ##     |  ####  |  ####  |'.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE.

          WRITE :/ '---------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | ####   |## |## |  ####   | ####   |   ##     |  ####  | '.

          WRITE :/ '---------------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDAT.



    IF P_CH1 = 'X'.

    WRITE:/ '|',GS_OUT_DELIVERY-ZORDNO,

            '|',GS_OUT_DELIVERY-ZIDCODE,

            '|',GS_OUT_DELIVERY-ZMATNR,

            '|',GS_OUT_DELIVERY-ZMATNAME,

            '|',GS_OUT_DELIVERY-ZMTART_NAME,

            '|',GS_OUT_DELIVERY-ZVOLUM,

            '|',GS_OUT_DELIVERY-VRKME,

            '|',GS_OUT_DELIVERY-LV_ZSLAMT. "####

      IF GS_OUT_DELIVERY-ZFLAG IS NOT INITIAL.

        WRITE:'|           '.

      ELSE.

        WRITE: '|',GS_OUT_DELIVERY-ZDFLAG_NAME. "####



      ENDIF.



        WRITE:'|',GS_OUT_DELIVERY-ZDGUBUN_NAME, "##

              '|',GS_OUT_DELIVERY-ZDDATE."####



      IF GS_OUT_DELIVERY-ZFLAG IS NOT INITIAL.

        WRITE: '|',GS_OUT_DELIVERY-ZRDATE,"####

               '|'.

      ELSE.

        WRITE:'|            |'.

      ENDIF.

    WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------------'.

    ELSE.

    WRITE:/ '|',GS_OUT_DELIVERY-ZORDNO,

            '|',GS_OUT_DELIVERY-ZIDCODE,

            '|',GS_OUT_DELIVERY-ZMATNR,

            '|',GS_OUT_DELIVERY-ZMATNAME,

            '|',GS_OUT_DELIVERY-ZMTART_NAME,

            '|',GS_OUT_DELIVERY-ZVOLUM,

            '|',GS_OUT_DELIVERY-VRKME,

            '|',GS_OUT_DELIVERY-LV_ZSLAMT, "####

            '|',GS_OUT_DELIVERY-ZDFLAG_NAME, "####

            '|',GS_OUT_DELIVERY-ZDGUBUN_NAME, "##

            '|',GS_OUT_DELIVERY-ZDDATE,"####

            '|'.

    WRITE :/ '---------------------------------------------------------------------------------------------------------------------------------------------'.

    ENDIF.

    ENDLOOP.

  ENDIF.

ENDFORM.