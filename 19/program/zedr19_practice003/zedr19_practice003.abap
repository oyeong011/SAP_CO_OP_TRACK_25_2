
*&---------------------------------------------------------------------*

*& Report ZEDR19_038

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_PRACTICE003 LINE-SIZE 200 LINE-COUNT 65(3) NO STANDARD PAGE HEADING.






*## ##




TABLES : ZEDT19_100, ZEDT19_101.



CONSTANTS : C_X TYPE CHAR1 VALUE 'X'.



"Range ##

RANGES : R_FG FOR ZEDT19_100-ZSALE_FG. "####

RANGES : R_ZG FOR ZEDT19_101-ZFLAG.



"### ## ##

DATA : FIRST_DAY TYPE D,

       LAST_DAY TYPE D.



"## ### ###

DATA : LV_AMT1 TYPE CHAR15,

       LV_AMT2 TYPE CHAR15,

       LV_AMT3 TYPE CHAR15,

       LV_AMT21 TYPE CHAR15.



"####, #### 0 #### ## ###

DATA lv TYPE string.



"### ### 4#

DATA : BEGIN OF GS_ZUMUN, "#### ###

         ZORDNO  LIKE ZEDT19_100-ZORDNO, "####

         ZIDCODE LIKE ZEDT19_100-ZIDCODE, "####

         ZMATNR LIKE ZEDT19_100-ZMATNR, "####

         ZMTART LIKE ZEDT19_100-ZMTART, "####

         ZMATNAME LIKE ZEDT19_100-ZMATNAME, "###

         ZVOLUM LIKE ZEDT19_100-ZVOLUM, "##

         VRKME LIKE ZEDT19_101-VRKME, "####

         ZNSAMT LIKE ZEDT19_100-ZNSAMT, "####

         ZSLAMT LIKE ZEDT19_100-ZSLAMT, "####

         ZDCAMT LIKE ZEDT19_100-ZDCAMT, "####

         ZDC_FG LIKE ZEDT19_100-ZDC_FG, "####

         ZSALE_FG LIKE ZEDT19_100-ZSALE_FG, "####

         ZRET_FG LIKE ZEDT19_100-ZRET_FG, "####

         ZJDATE LIKE ZEDT19_100-ZJDATE, "####

         ZRDATE LIKE ZEDT19_100-ZRDATE, "####

       END OF GS_ZUMUN.

DATA: GT_ZUMUN LIKE TABLE OF GS_ZUMUN.



DATA : BEGIN OF GS_DELIVERY, "#### ###

  ZORDNO LIKE ZEDT19_101-ZORDNO, "####

  ZIDCODE LIKE ZEDT19_101-ZIDCODE, "##ID

  ZMATNR LIKE ZEDT19_101-ZMATNR, "####

  ZMTART LIKE ZEDT19_101-ZMTART, "####

  ZMATNAME LIKE ZEDT19_101-ZMATNAME, "###

  ZVOLUM LIKE ZEDT19_101-ZVOLUM, "##

  VRKME LIKE ZEDT19_101-VRKME, "####

  ZSLAMT LIKE ZEDT19_101-ZSLAMT, "####

  ZDFLAG LIKE ZEDT19_101-ZDFLAG, "####

  ZDGUBUN LIKE ZEDT19_101-ZDGUBUN, "####

  ZDDATE LIKE ZEDT19_101-ZDDATE, "####

  ZRDATE LIKE ZEDT19_101-ZRDATE, "####

  ZFLAG LIKE ZEDT19_101-ZFLAG, "####

  END OF GS_DELIVERY.

DATA : GT_DELIVERY LIKE TABLE OF GS_DELIVERY.



DATA : BEGIN OF GS_0100, "### ##

  ZORDNO LIKE ZEDT19_100-ZORDNO, "####

  ZIDCODE LIKE ZEDT19_100-ZIDCODE, "##ID

  ZMATNR LIKE ZEDT19_100-ZMATNR, "####

  ZMATNAME LIKE ZEDT19_100-ZMATNAME, "#####

  ZMAT_NAME TYPE C LENGTH 8, "#####

  ZVOLUM LIKE ZEDT19_100-ZVOLUM, "##

  VRKME LIKE ZEDT19_100-VRKME, "##

  AMT1 TYPE I, "####

  AMT2 TYPE I, "####

  AMT3 TYPE I, "####

  ZSALE_NAME TYPE C LENGTH 4, "####

  ZJDATE(10),

  ZRET_NAME TYPE C LENGTH 10, "####

  ZDATE(10), "####

  END OF GS_0100.

DATA : GT_0100 LIKE TABLE OF GS_0100.



DATA : BEGIN OF GS_0200, "###

  ZORDNO LIKE ZEDT19_101-ZORDNO, "####

  ZIDCODE LIKE ZEDT19_101-ZIDCODE, "##ID

  ZMATNR LIKE ZEDT19_101-ZMATNR, "####

  ZMATNAME LIKE ZEDT19_101-ZMATNAME, "###

  ZMAT_NAME TYPE C LENGTH 8, "#####

  ZVOLUM LIKE ZEDT19_101-ZVOLUM, "##

  VRKME LIKE ZEDT19_101-VRKME, "####

  AMT2 TYPE I, "####

  ZDFLAG_NAME TYPE C LENGTH 8, "####

  ZDGUBUN_NAME TYPE C LENGTH 6, "####

  ZDDATE(10),

  ZDATE(10), "####

  ZFLAG LIKE ZEDT19_101-ZFLAG, "FLAG

  END OF GS_0200.

DATA : GT_0200 LIKE TABLE OF GS_0200.






*## ##






"#### ## -> block 1

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZORDNO FOR ZEDT19_100-ZORDNO MODIF ID M1.

  SELECT-OPTIONS : S_ZID FOR ZEDT19_100-ZIDCODE NO INTERVALS NO-EXTENSION MODIF ID M1.

  SELECT-OPTIONS : S_ZMATNR FOR ZEDT19_100-ZMATNR MODIF ID M1.

  SELECT-OPTIONS : S_ZJDATE FOR ZEDT19_100-ZJDATE MODIF ID M1.

SELECTION-SCREEN END OF BLOCK B1.






*#### ## -> block 3




SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  SELECT-OPTIONS : S_ZORDN FOR ZEDT19_100-ZORDNO MODIF ID M2.

  SELECT-OPTIONS : S_ZI  FOR ZEDT19_101-ZIDCODE NO INTERVALS NO-EXTENSION MODIF ID M2.

  SELECT-OPTIONS : S_ZMATN FOR ZEDT19_100-ZMATNR MODIF ID M2.

  SELECT-OPTIONS : S_ZDDATE FOR ZEDT19_101-ZDDATE MODIF ID M2.

SELECTION-SCREEN END OF BLOCK B3.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.

  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.

SELECTION-SCREEN END OF BLOCK B2.






*#### -> block 4




SELECTION-SCREEN BEGIN OF BLOCK B4 WITH FRAME.

  PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X'.

SELECTION-SCREEN END OF BLOCK B4.






*## ### : ## # 1#~##




INITIALIZATION.

"## ## 1#

FIRST_DAY = SY-DATUM(6) && '01'.



"## ## ### #

CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

  EXPORTING

   day_in = SY-DATUM

  IMPORTING

   last_day_of_month = LAST_DAY.



S_ZJDATE-LOW = FIRST_DAY.

S_ZJDATE-HIGH = LAST_DAY.

S_ZDDATE-LOW = FIRST_DAY.

S_ZDDATE-HIGH = LAST_DAY.

APPEND S_ZJDATE.

APPEND S_ZDDATE.






*## ## ##




"### ## ## ## ## ##/## ## ##

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = C_X. "## ## ###

        SCREEN-ACTIVE = 1.

      ELSE.

        SCREEN-ACTIVE = 0.

      ENDIF.

      MODIFY SCREEN.

    ENDIF.



    IF SCREEN-GROUP1 = 'M2'.

      IF P_R2 = C_X. "## ## ###

        SCREEN-ACTIVE = 1.

      ELSE.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

ENDLOOP.






*## ##




START-OF-SELECTION.

  PERFORM SELECT_DATA. "### ##

  PERFORM WRITE_OUTPUT. "## (### ### #### ##)

  PERFORM WRITE_DATA. "##






*### ### ## (#### ##)




"##### ### ## #### ##

FORM SELECT_DATA .

  CLEAR GT_ZUMUN[]. "###

  CLEAR GT_DELIVERY[]. "###



  IF P_R1 = C_X. "##

    SELECT * FROM ZEDT19_100

    INTO CORRESPONDING FIELDS OF TABLE GT_ZUMUN

    WHERE ZORDNO IN S_ZORDNO

    AND ZIDCODE IN S_ZID

    AND ZMATNR IN S_ZMATNR

    AND ZJDATE IN S_ZJDATE

    AND ZSALE_FG IN R_FG. "####

  ELSEIF P_R2 = C_X. "##

    SELECT * FROM ZEDT19_101

    INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY

    WHERE ZORDNO IN S_ZORDN

    AND ZIDCODE IN S_ZI

    AND ZMATNR IN S_ZMATN

    AND ZDDATE IN S_ZDDATE

    AND ZFLAG IN R_ZG. "####

  ENDIF.

ENDFORM.



"## D#### ##### ##### FORM

"DATS(2025-10-01) > CHAR(2025.10.01)# ##"

FORM FMT_DATE_10 USING P_DATE TYPE D

                 CHANGING P_TEXT TYPE CHAR10.



  IF P_DATE IS INITIAL. "### #### ####

    CLEAR P_TEXT.

  ELSE.

    P_TEXT = P_DATE+0(4) && '.' && P_DATE+4(2) && '.' && P_DATE+6(2).

  ENDIF.

ENDFORM.






*fixed value ## ## #### ###



*#### ## -> ##




FORM GET_MAT_NAME USING P_ZMTART

                  CHANGING P_NAME.



  CASE P_ZMTART.

    WHEN '001'. P_NAME = '##'.

    WHEN '002'. P_NAME = '##'.

    WHEN '003'. P_NAME = '##'.

    WHEN '004'. P_NAME = '##'.

    WHEN '005'. P_NAME = '##'.

    WHEN '006'. P_NAME = '###'.

  ENDCASE.

ENDFORM.






*#### ## -> ##




FORM GET_SALE_NAME USING P_SALE_FG

                   CHANGING P_NAME.



  CASE P_SALE_FG.

    WHEN '1'. P_NAME = '##'.

    WHEN '2'. P_NAME = '##'.

  ENDCASE.

ENDFORM.






*#### -> ##




FORM GET_RET_NAME USING P_RET_FG

                  CHANGING P_NAME.



  CASE P_RET_FG.

    WHEN '1'. P_NAME = '####'.

    WHEN '2'. P_NAME = '####'.

    WHEN '3'. P_NAME = '####'.

  ENDCASE.

ENDFORM.






*#### -> ##




FORM GET_DFLAG_NAME USING P_DFLAG

                    CHANGING P_NAME.



  CASE P_DFLAG.

    WHEN '1'. P_NAME = '####'.

    WHEN '2'. P_NAME = '###'.

    WHEN '3'. P_NAME = '####'.

  ENDCASE.

ENDFORM.






*#### -> ##




FORM GET_DGUBUN_NAME USING P_GUBUN

                     CHANGING P_NAME.



  CASE P_GUBUN.

    WHEN '1'. P_NAME = '###'.

    WHEN '2'. P_NAME = '###'.

    WHEN '3'. P_NAME = '###'.

    WHEN '4'. P_NAME = '###'.

    WHEN '5'. P_NAME = '###'.

    WHEN '6'. P_NAME = '###'.

    WHEN '7'. P_NAME = '###'.

  ENDCASE.

ENDFORM.






*## ##




FORM FMT_AMT USING P_VAL TYPE I

             CHANGING P_TEXT TYPE CHAR15.



P_VAL = P_VAL * 100.

WRITE P_VAL TO P_TEXT CURRENCY 'KRW' DECIMALS 0.



ENDFORM.






*### ### 0 ##




FORM DELETE_ZERO USING p_in TYPE C

                 CHANGING p_out TYPE C.



  lv = p_in.

  SHIFT lv LEFT DELETING LEADING '0'. "### ### 0# ###.



  IF lv IS INITIAL.

    lv = '0'.

  ENDIF.

  p_out = lv.

ENDFORM.






*GT_ZUMUN/GT_DELIVERY -> ### ###(GT_0100/GT_0200) ##




FORM WRITE_OUTPUT.

  CLEAR GT_0100[].

  CLEAR GT_0200[].



  IF P_R1 = C_X. "###

    LOOP AT GT_ZUMUN INTO GS_ZUMUN.

      CLEAR GS_0100.

      MOVE-CORRESPONDING GS_ZUMUN TO GS_0100.



      GS_0100-AMT1 = GS_ZUMUN-ZNSAMT. "###

      GS_0100-AMT2 = GS_ZUMUN-ZSLAMT. "####

      GS_0100-AMT3 = GS_ZUMUN-ZDCAMT. "####



      "FIXED_VALUE -> ##

      PERFORM GET_MAT_NAME USING GS_ZUMUN-ZMTART CHANGING GS_0100-ZMAT_NAME. "####

      PERFORM GET_SALE_NAME USING GS_ZUMUN-ZSALE_FG CHANGING GS_0100-ZSALE_NAME. "####

      PERFORM GET_RET_NAME USING GS_ZUMUN-ZRET_FG CHANGING GS_0100-ZRET_NAME. "####



      "0##

      PERFORM DELETE_ZERO USING GS_ZUMUN-ZORDNO CHANGING GS_0100-ZORDNO.

      PERFORM DELETE_ZERO USING GS_ZUMUN-ZMATNR CHANGING GS_0100-ZMATNR.



      PERFORM FMT_DATE_10 USING GS_ZUMUN-ZJDATE CHANGING GS_0100-ZJDATE.



      "## ##### ## ### ## ## ## ### #

      IF GS_ZUMUN-ZRDATE IS NOT INITIAL.

        PERFORM FMT_DATE_10 USING GS_ZUMUN-ZRDATE CHANGING GS_0100-ZDATE.

      ELSE.

        CLEAR GS_0100-ZDATE.

      ENDIF.



      APPEND GS_0100 TO GT_0100.

    ENDLOOP.



  ELSEIF P_R2 = C_X. "## ##

    LOOP AT GT_DELIVERY INTO GS_DELIVERY.

      CLEAR GS_0200.

      MOVE-CORRESPONDING GS_DELIVERY TO GS_0200.



      GS_0200-AMT2 = GS_DELIVERY-ZSLAMT.



      PERFORM GET_MAT_NAME USING GS_DELIVERY-ZMTART CHANGING GS_0200-ZMAT_NAME.

      PERFORM GET_DFLAG_NAME USING GS_DELIVERY-ZDFLAG CHANGING GS_0200-ZDFLAG_NAME.

      PERFORM GET_DGUBUN_NAME USING GS_DELIVERY-ZDGUBUN CHANGING GS_0200-ZDGUBUN_NAME.



      "0##

      PERFORM DELETE_ZERO USING GS_DELIVERY-ZORDNO CHANGING GS_0200-ZORDNO.

      PERFORM DELETE_ZERO USING GS_DELIVERY-ZMATNR CHANGING GS_0200-ZMATNR.



      PERFORM FMT_DATE_10 USING GS_DELIVERY-ZDDATE CHANGING GS_0200-ZDDATE.



      IF GS_DELIVERY-ZRDATE IS NOT INITIAL.

        PERFORM FMT_DATE_10 USING GS_DELIVERY-ZRDATE CHANGING GS_0200-ZDATE.

      ELSE.

        CLEAR GS_0200-ZDATE.

      ENDIF.



      APPEND GS_0200 TO GT_0200.

    ENDLOOP.

  ENDIF.

ENDFORM.






*##




FORM WRITE_DATA.



  IF P_R1 = C_X. "####

    LOOP AT GT_0100 INTO GS_0100.



    PERFORM fmt_amt USING gs_0100-amt1 CHANGING lv_amt1.

    PERFORM fmt_amt USING gs_0100-amt2 CHANGING lv_amt2.

    PERFORM fmt_amt USING gs_0100-amt3 CHANGING lv_amt3.



      AT FIRST.

        IF P_CH1 = C_X. "####

          WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |     ####    |     ####    |    ####     | ## |  ####  |  ####  |  ####  | '.

          WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |     ####    |     ####    |     ####    | ## |  ####  | '.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDAT.



      IF P_CH1 = C_X.

      WRITE :/ '|',GS_0100-ZORDNO,'|',GS_0100-ZIDCODE,'|',GS_0100-ZMATNR,'|',GS_0100-ZMATNAME,'|',GS_0100-ZMAT_NAME,'|'

      ,GS_0100-ZVOLUM,'|',GS_0100-VRKME,'|',LV_AMT1,'|',LV_AMT2,'|'

      ,LV_AMT3,'|',GS_0100-ZSALE_NAME,'|',GS_0100-ZJDATE,'|',GS_0100-ZRET_NAME,'|',GS_0100-ZDATE,'|'.

      WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.

      WRITE :/ '|',GS_0100-ZORDNO,'|',GS_0100-ZIDCODE,'|',GS_0100-ZMATNR,'|',GS_0100-ZMATNAME,'|',GS_0100-ZMAT_NAME,'|'

      ,GS_0100-ZVOLUM,'|',GS_0100-VRKME,'|',LV_AMT1,'|',LV_AMT2,'|'

      ,LV_AMT3,'|',GS_0100-ZSALE_NAME,'|',GS_0100-ZJDATE,'|'.

      WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDLOOP.

  ELSEIF P_R2 = C_X.

    LOOP AT GT_0200 INTO GS_0200.

      PERFORM FMT_AMT USING GS_0200-AMT2 CHANGING LV_AMT21. "####

      AT FIRST.

        IF P_CH1 = C_X.

          WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |     ####    | #### |  ##  |  ####  |  ####  |'.

          WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE.

          WRITE :/ '-----------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |     ####    | #### |  ##  |  ####  | '.

          WRITE :/ '-----------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDAT.



      IF P_CH1 = C_X.

      WRITE :/ '|',GS_0200-ZORDNO,'|',GS_0200-ZIDCODE,'|',GS_0200-ZMATNR,'|',GS_0200-ZMATNAME,'|',GS_0200-ZMAT_NAME,'|'

      ,GS_0200-ZVOLUM,'|',GS_0200-VRKME,'|',LV_AMT21,'|',GS_0200-ZDFLAG_NAME,'|'

      ,GS_0200-ZDGUBUN_NAME,'|',GS_0200-ZDDATE,'|',GS_0200-ZDATE,'|'.

      WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.

      WRITE :/ '|',GS_0200-ZORDNO,'|',GS_0200-ZIDCODE,'|',GS_0200-ZMATNR,'|',GS_0200-ZMATNAME,'|',GS_0200-ZMAT_NAME,'|'

      ,GS_0200-ZVOLUM,'|',GS_0200-VRKME,'|',LV_AMT21,'|',GS_0200-ZDFLAG_NAME,'|'

      ,GS_0200-ZDGUBUN_NAME,'|',GS_0200-ZDDATE,'|'.

      WRITE :/ '-----------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDLOOP.

  ENDIF.



ENDFORM.