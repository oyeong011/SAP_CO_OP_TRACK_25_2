
*&---------------------------------------------------------------------*

*& Report ZEDR00_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR00_PRACTICE003.

"1. DATA ##.

"####

TABLES : ZEDT00_100, ZEDT00_101.



CONSTANTS : C_X TYPE CHAR1 VALUE 'X'.

CONSTANTS : C_A TYPE CHAR1 VALUE 'A'.

CONSTANTS : C_0 TYPE CHAR1 VALUE '0'.

CONSTANTS : C_1 TYPE CHAR1 VALUE '1'.

CONSTANTS : C_2 TYPE CHAR1 VALUE '2'.

CONSTANTS : C_3 TYPE CHAR1 VALUE '3'.

CONSTANTS : C_4 TYPE CHAR1 VALUE '4'.

CONSTANTS : C_5 TYPE CHAR1 VALUE '5'.

CONSTANTS : C_6 TYPE CHAR1 VALUE '6'.

CONSTANTS : C_7 TYPE CHAR1 VALUE '7'.

CONSTANTS : C_01 TYPE CHAR2 VALUE '01'.

CONSTANTS : C_02 TYPE CHAR2 VALUE '02'.

CONSTANTS : C_03 TYPE CHAR2 VALUE '03'.

CONSTANTS : C_04 TYPE CHAR2 VALUE '04'.

CONSTANTS : C_05 TYPE CHAR2 VALUE '05'.

CONSTANTS : C_06 TYPE CHAR2 VALUE '06'.

CONSTANTS : C_07 TYPE CHAR2 VALUE '07'.

CONSTANTS : C_08 TYPE CHAR2 VALUE '08'.

CONSTANTS : C_09 TYPE CHAR2 VALUE '09'.

CONSTANTS : C_10 TYPE CHAR2 VALUE '10'.

CONSTANTS : C_11 TYPE CHAR2 VALUE '11'.

CONSTANTS : C_12 TYPE CHAR2 VALUE '12'.

CONSTANTS : C_28 TYPE CHAR2 VALUE '28'.

CONSTANTS : C_30 TYPE CHAR2 VALUE '30'.

CONSTANTS : C_31 TYPE CHAR2 VALUE '31'.

CONSTANTS : C_M1 TYPE CHAR2 VALUE 'M1'.

CONSTANTS : C_M2 TYPE CHAR2 VALUE 'M2'.

CONSTANTS : C_001 TYPE CHAR3 VALUE '001'.

CONSTANTS : C_002 TYPE CHAR3 VALUE '002'.

CONSTANTS : C_003 TYPE CHAR3 VALUE '003'.

CONSTANTS : C_004 TYPE CHAR3 VALUE '004'.

CONSTANTS : C_005 TYPE CHAR3 VALUE '005'.

CONSTANTS : C_006 TYPE CHAR3 VALUE '006'.



RANGES : R_FG FOR ZEDT00_100-ZSALE_FG.

RANGES : R_ZG FOR ZEDT00_101-ZFLAG.



"ITAB##

DATA : BEGIN OF GS_ORDER, "#### ###

  ZORDNO LIKE ZEDT00_100-ZORDNO, "####

  ZIDCODE LIKE ZEDT00_100-ZIDCODE, "##ID

  ZMATNR LIKE ZEDT00_100-ZMATNR, "####

  ZMTART LIKE ZEDT00_100-ZMTART, "####

  ZMATNAME LIKE ZEDT00_100-ZMATNAME, "###

  ZVOLUM LIKE ZEDT00_100-ZVOLUM, "##

  VRKME LIKE ZEDT00_100-VRKME, "####

  ZNSAMT LIKE ZEDT00_100-ZNSAMT, "####

  ZSLAMT LIKE ZEDT00_100-ZSLAMT, "####

  ZDCAMT LIKE ZEDT00_100-ZDCAMT, "####

  ZDC_FG LIKE ZEDT00_100-ZDC_FG, "####

  ZSALE_FG LIKE ZEDT00_100-ZSALE_FG, "####

  ZRET_FG LIKE ZEDT00_100-ZRET_FG, "####

  ZJDATE LIKE ZEDT00_100-ZJDATE, "####

  ZRDATE LIKE ZEDT00_100-ZRDATE, "####

  END OF GS_ORDER.

DATA : GT_ORDER LIKE TABLE OF GS_ORDER.



DATA : BEGIN OF GS_0100, "###

  ZORDNO LIKE ZEDT00_100-ZORDNO, "####

  ZIDCODE LIKE ZEDT00_100-ZIDCODE, "##ID

  ZMATNR LIKE ZEDT00_100-ZMATNR, "####

  ZMATNAME LIKE ZEDT00_100-ZMATNAME, "#####

  ZMAT_NAME TYPE C LENGTH 8, "#####

  ZVOLUM LIKE ZEDT00_100-ZVOLUM, "##

  VRKME LIKE ZEDT00_100-VRKME, "##

  AMT1 TYPE I, "####

  AMT2 TYPE I, "####

  AMT3 TYPE I, "####

  ZSALE_NAME TYPE C LENGTH 4, "####

  ZJDATE LIKE ZEDT00_100-ZJDATE, "####

  ZRET_NAME TYPE C LENGTH 10, "####

  ZDATE(10), "####

  END OF GS_0100.

DATA : GT_0100 LIKE TABLE OF GS_0100.



DATA : BEGIN OF GS_DELIVERY, "#### ###

  ZORDNO LIKE ZEDT00_101-ZORDNO, "####

  ZIDCODE LIKE ZEDT00_101-ZIDCODE, "##ID

  ZMATNR LIKE ZEDT00_101-ZMATNR, "####

  ZMTART LIKE ZEDT00_101-ZMTART, "####

  ZMATNAME LIKE ZEDT00_101-ZMATNAME, "###

  ZVOLUM LIKE ZEDT00_101-ZVOLUM, "##

  VRKME LIKE ZEDT00_101-VRKME, "####

  ZSLAMT LIKE ZEDT00_101-ZSLAMT, "####

  ZDFLAG LIKE ZEDT00_101-ZDFLAG, "####

  ZDGUBUN LIKE ZEDT00_101-ZDGUBUN, "####

  ZDDATE LIKE ZEDT00_101-ZDDATE, "####

  ZRDATE LIKE ZEDT00_101-ZRDATE, "####

  ZFLAG LIKE ZEDT00_101-ZFLAG, "FLAG

  END OF GS_DELIVERY.

DATA : GT_DELIVERY LIKE TABLE OF GS_DELIVERY.



DATA : BEGIN OF GS_0200, "###

  ZORDNO LIKE ZEDT00_101-ZORDNO, "####

  ZIDCODE LIKE ZEDT00_101-ZIDCODE, "##ID

  ZMATNR LIKE ZEDT00_101-ZMATNR, "####

  ZMATNAME LIKE ZEDT00_101-ZMATNAME, "###

  ZMAT_NAME TYPE C LENGTH 8, "#####

  ZVOLUM LIKE ZEDT00_101-ZVOLUM, "##

  VRKME LIKE ZEDT00_101-VRKME, "####

  AMT2 TYPE I, "####

  ZDFLAG_NAME TYPE C LENGTH 8, "####

  ZDGUBUN_NAME TYPE C LENGTH 6, "####

  ZDDATE LIKE ZEDT00_101-ZDDATE, "####

  ZDATE(10), "####

  ZFLAG LIKE ZEDT00_101-ZFLAG, "FLAG

  END OF GS_0200.

DATA : GT_0200 LIKE TABLE OF GS_0200.



"2. SCREEN.

"SCREEN##

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

 SELECT-OPTIONS : S_ZORDNO FOR ZEDT00_100-ZORDNO.

 SELECT-OPTIONS : S_ZID FOR ZEDT00_100-ZIDCODE NO INTERVALS NO-EXTENSION.

 SELECT-OPTIONS : S_ZMATNR FOR ZEDT00_100-ZMATNR.

 SELECT-OPTIONS : S_ZJDATE FOR ZEDT00_100-ZJDATE MODIF ID M1.

 SELECT-OPTIONS : S_ZDDATE FOR ZEDT00_101-ZDDATE MODIF ID M2.



SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

 PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.

 PARAMETERS : P_R2 RADIOBUTTON GROUP R1.

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

 PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X'.

SELECTION-SCREEN END OF BLOCK B3.



INITIALIZATION.

  PERFORM ZJDATE_INIT_. "######

  PERFORM ZDDATE_INIT_. "######



"SCREEN##

AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_SETTING. "#####



"3. READ DATA.

START-OF-SELECTION.

  PERFORM CHECKBOX_INIT. "#### ##

  PERFORM SELECT_DATA.

  PERFORM MODIFY_DATA.



"4. WRITE DATA.

  PERFORM WRITE_DATA.






*&---------------------------------------------------------------------*

*&      Form  ZJDATE_INIT_

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ZJDATE_INIT_ .

  "#### ##

  S_ZJDATE-LOW = SY-DATUM(6) && C_01. " && : CONCATENATE# ## ##

  IF SY-DATUM+4(2) = C_01 OR SY-DATUM+4(2) = C_03 OR SY-DATUM+4(2) = C_05 OR

  SY-DATUM+4(2) = C_07 OR SY-DATUM+4(2) = C_08 OR SY-DATUM+4(2) = C_10 OR

  SY-DATUM+4(2) = C_12.

    S_ZJDATE-HIGH = SY-DATUM(6) && C_31.

  ELSE.

    IF SY-DATUM+4(2) = C_02.

      S_ZJDATE-HIGH = SY-DATUM(6) && C_28.

    ELSE.

      S_ZJDATE-HIGH = SY-DATUM(6) && C_30.

    ENDIF.

  ENDIF.

  S_ZJDATE-SIGN = 'I'.

  S_ZJDATE-OPTION = 'BT'.



  APPEND S_ZJDATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZDDATE_INIT_

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ZDDATE_INIT_ .

  "#### ##

  S_ZDDATE-LOW = SY-DATUM(6) && C_01. " && : CONCATENATE# ## ##

  IF SY-DATUM+4(2) = C_01 OR SY-DATUM+4(2) = C_03 OR SY-DATUM+4(2) = C_05 OR

  SY-DATUM+4(2) = C_07 OR SY-DATUM+4(2) = C_08 OR SY-DATUM+4(2) = C_10 OR

  SY-DATUM+4(2) = C_12.

    S_ZDDATE-HIGH = SY-DATUM(6) && C_31.

  ELSE.

    IF SY-DATUM+4(2) = C_02.

      S_ZDDATE-HIGH = SY-DATUM(6) && C_28.

    ELSE.

      S_ZDDATE-HIGH = SY-DATUM(6) && C_30.

    ENDIF.

  ENDIF.

  S_ZDDATE-SIGN = 'I'.

  S_ZDDATE-OPTION = 'BT'.



  APPEND S_ZDDATE.

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

    IF SCREEN-GROUP1 = C_M2.

      IF P_R1 = C_X.

        SCREEN-ACTIVE = C_0.

      ELSEIF P_R2 = C_X.

        SCREEN-ACTIVE = C_1.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = C_M1.

      IF P_R1 = C_X.

        SCREEN-ACTIVE = C_1.

      ELSEIF P_R2 = C_X.

        SCREEN-ACTIVE = C_0.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECKBOX_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECKBOX_INIT .

  IF P_R1 = C_X.

    R_FG-SIGN = 'I'.

    R_FG-OPTION = 'EQ'.

    R_FG-LOW = '1'.

    APPEND R_FG.



    IF P_CH1 = C_X.

      R_FG-LOW = '2'.

      APPEND R_FG.

    ENDIF.

  ELSEIF P_R2 = C_X.

    R_ZG-SIGN = 'I'.

    R_ZG-OPTION = 'EQ'.

    R_ZG-LOW = ' '.

    APPEND R_ZG.



    IF P_CH1 = C_X.

      R_ZG-LOW = C_X.

      APPEND R_ZG.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SELECT_DATA .

  IF P_R1 = C_X. "##

    SELECT * FROM ZEDT00_100

    INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

    WHERE ZORDNO IN S_ZORDNO

    AND ZIDCODE IN S_ZID

    AND ZMATNR IN S_ZMATNR

    AND ZJDATE IN S_ZJDATE

    AND ZSALE_FG IN R_FG.

  ELSEIF P_R2 = C_X. "##

    SELECT * FROM ZEDT00_101

    INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY

    WHERE ZORDNO IN S_ZORDNO

    AND ZIDCODE IN S_ZID

    AND ZMATNR IN S_ZMATNR

    AND ZDDATE IN S_ZDDATE

    AND ZFLAG IN R_ZG.

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



  IF P_R1 = C_X. "####

    LOOP AT GT_ORDER INTO GS_ORDER.

      CLEAR GS_0100.



      MOVE-CORRESPONDING GS_ORDER TO GS_0100.



      IF GS_ORDER-ZSALE_FG = C_1. "####

        GS_0100-ZSALE_NAME = '##'.

      ELSEIF GS_ORDER-ZSALE_FG = C_2.

        GS_0100-ZSALE_NAME = '##'.

      ENDIF.



      IF GS_ORDER-ZMTART = C_001.

        GS_0100-ZMAT_NAME = '##'.

      ELSEIF GS_ORDER-ZMTART = C_002.

        GS_0100-ZMAT_NAME = '##'.

      ELSEIF GS_ORDER-ZMTART = C_003.

        GS_0100-ZMAT_NAME = '##'.

      ELSEIF GS_ORDER-ZMTART = C_004.

        GS_0100-ZMAT_NAME = '##'.

      ELSEIF GS_ORDER-ZMTART = C_005.

        GS_0100-ZMAT_NAME = '##'.

      ELSEIF GS_ORDER-ZMTART = C_006.

         GS_0100-ZMAT_NAME = '###'.

      ENDIF.



      IF P_CH1 = C_X.

        IF GS_ORDER-ZRET_FG = C_1. "#####

          GS_0100-ZRET_NAME = '####'.

        ELSEIF GS_ORDER-ZRET_FG = C_2.

          GS_0100-ZRET_NAME = '####'.

        ELSEIF GS_ORDER-ZRET_FG = C_3.

          GS_0100-ZRET_NAME = '####'.

        ENDIF.

      ENDIF.



      GS_0100-AMT1 = GS_ORDER-ZNSAMT * 100.

      GS_0100-AMT2 = GS_ORDER-ZSLAMT * 100.

      GS_0100-AMT3 = GS_ORDER-ZDCAMT * 100.



      IF GS_ORDER-ZRDATE IS INITIAL.

      ELSE.

        CONCATENATE GS_ORDER-ZRDATE+0(4) '.' GS_ORDER-ZRDATE+4(2) '.' GS_ORDER-ZRDATE+6(2)

        INTO GS_0100-ZDATE.

      ENDIF.



      APPEND GS_0100 TO GT_0100.

      CLEAR : GS_ORDER, GS_0100.

    ENDLOOP.

  ELSEIF P_R2 = C_X. "####

    LOOP AT GT_DELIVERY INTO GS_DELIVERY.

      CLEAR GS_0200.



      MOVE-CORRESPONDING GS_DELIVERY TO GS_0200.



      IF GS_DELIVERY-ZMTART = C_001.

        GS_0200-ZMAT_NAME = '##'.

      ELSEIF GS_DELIVERY-ZMTART = C_002.

        GS_0200-ZMAT_NAME = '##'.

      ELSEIF GS_DELIVERY-ZMTART = C_003.

        GS_0200-ZMAT_NAME = '##'.

      ELSEIF GS_DELIVERY-ZMTART = C_004.

        GS_0200-ZMAT_NAME = '##'.

      ELSEIF GS_DELIVERY-ZMTART = C_005.

        GS_0200-ZMAT_NAME = '##'.

      ELSEIF GS_DELIVERY-ZMTART = C_006.

         GS_0200-ZMAT_NAME = '###'.

      ENDIF.



      IF GS_DELIVERY-ZDFLAG = C_1.

        GS_0200-ZDFLAG_NAME = '####'.

      ELSEIF GS_DELIVERY-ZDFLAG = C_2.

        GS_0200-ZDFLAG_NAME = '####'.

      ENDIF.



      IF GS_DELIVERY-ZDGUBUN = C_1.

        GS_0200-ZDGUBUN_NAME = '###'.

      ELSEIF GS_DELIVERY-ZDGUBUN = C_2.

        GS_0200-ZDGUBUN_NAME = '###'.

      ELSEIF GS_DELIVERY-ZDGUBUN = C_3.

        GS_0200-ZDGUBUN_NAME = '###'.

      ELSEIF GS_DELIVERY-ZDGUBUN = C_4.

        GS_0200-ZDGUBUN_NAME = '###'.

      ELSEIF GS_DELIVERY-ZDGUBUN = C_5.

        GS_0200-ZDGUBUN_NAME = '###'.

      ELSEIF GS_DELIVERY-ZDGUBUN = C_6.

        GS_0200-ZDGUBUN_NAME = '###'.

      ELSEIF GS_DELIVERY-ZDGUBUN = C_7.

        GS_0200-ZDGUBUN_NAME = '###'.

      ENDIF.



      GS_0200-AMT2 = GS_DELIVERY-ZSLAMT * 100.



      IF GS_DELIVERY-ZRDATE IS INITIAL.

      ELSE.

        CONCATENATE GS_DELIVERY-ZRDATE+0(4) '.' GS_DELIVERY-ZRDATE+4(2) '.' GS_DELIVERY-ZRDATE+6(2)

        INTO GS_0200-ZDATE.

      ENDIF.



      APPEND GS_0200 TO GT_0200.

      CLEAR : GS_DELIVERY , GS_0200.

    ENDLOOP.

  ENDIF.



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



  IF P_R1 = C_X. "####

    LOOP AT GT_0100 INTO GS_0100.

      AT FIRST.

        IF P_CH1 = C_X.

          WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |   ####  |  ####   | ## |  ####  |  ####  |  ####  | '.

          WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |   ####  |  ####   | ## |  ####  | '.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDAT.



      IF P_CH1 = C_X.

      WRITE :/ '|',GS_0100-ZORDNO,'|',GS_0100-ZIDCODE,'|',GS_0100-ZMATNR,'|',GS_0100-ZMATNAME,'|',GS_0100-ZMAT_NAME,'|'

      ,GS_0100-ZVOLUM,'|',GS_0100-VRKME,'|',GS_0100-AMT1,'|',GS_0100-AMT2,'|'

      ,GS_0100-AMT3,'|',GS_0100-ZSALE_NAME,'|',GS_0100-ZJDATE,'|',GS_0100-ZRET_NAME,'|',GS_0100-ZDATE,'|'.

      WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.

      WRITE :/ '|',GS_0100-ZORDNO,'|',GS_0100-ZIDCODE,'|',GS_0100-ZMATNR,'|',GS_0100-ZMATNAME,'|',GS_0100-ZMAT_NAME,'|'

      ,GS_0100-ZVOLUM,'|',GS_0100-VRKME,'|',GS_0100-AMT1,'|',GS_0100-AMT2,'|'

      ,GS_0100-AMT3,'|',GS_0100-ZSALE_NAME,'|',GS_0100-ZJDATE,'|'.

      WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDLOOP.

  ELSEIF P_R2 = C_X. "####

    LOOP AT GT_0200 INTO GS_0200.

      AT FIRST.

        IF P_CH1 = C_X.

          WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   | #### |  ##  |  ####  |  ####  |'.

          WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE.

          WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   | #### |  ##  |  ####  | '.

          WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDAT.



      IF P_CH1 = C_X.

      WRITE :/ '|',GS_0200-ZORDNO,'|',GS_0200-ZIDCODE,'|',GS_0200-ZMATNR,'|',GS_0200-ZMATNAME,'|',GS_0200-ZMAT_NAME,'|'

      ,GS_0200-ZVOLUM,'|',GS_0200-VRKME,'|',GS_0200-AMT2,'|',GS_0200-ZDFLAG_NAME,'|'

      ,GS_0200-ZDGUBUN_NAME,'|',GS_0200-ZDDATE,'|',GS_0200-ZDATE,'|'.

      WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.

      WRITE :/ '|',GS_0200-ZORDNO,'|',GS_0200-ZIDCODE,'|',GS_0200-ZMATNR,'|',GS_0200-ZMATNAME,'|',GS_0200-ZMAT_NAME,'|'

      ,GS_0200-ZVOLUM,'|',GS_0200-VRKME,'|',GS_0200-AMT2,'|',GS_0200-ZDFLAG_NAME,'|'

      ,GS_0200-ZDGUBUN_NAME,'|',GS_0200-ZDDATE,'|'.

      WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDLOOP.

  ENDIF.



ENDFORM.