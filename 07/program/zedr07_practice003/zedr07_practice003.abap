
*&---------------------------------------------------------------------*

*& Report ZEDR07_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_PRACTICE003.



TABLES : ZEDT07_100, ZEDT07_101.



"## ##

CONSTANTS : C_A TYPE CHAR1 VALUE 'A'.

CONSTANTS : C_M1 TYPE CHAR2 VALUE 'M1'.

CONSTANTS : C_M2 TYPE CHAR2 VALUE 'M2'.

CONSTANTS : C_001 TYPE CHAR3 VALUE '001'.

CONSTANTS : C_002 TYPE CHAR3 VALUE '002'.

CONSTANTS : C_003 TYPE CHAR3 VALUE '003'.

CONSTANTS : C_004 TYPE CHAR3 VALUE '004'.

CONSTANTS : C_005 TYPE CHAR3 VALUE '005'.

CONSTANTS : C_006 TYPE CHAR3 VALUE '006'.



DATA : GV_DATE TYPE D. "## ## ##



"### ###

DATA : BEGIN OF GS_ORDER, "##

  ZORDNO LIKE ZEDT07_100-ZORDNO, "####

  ZIDCODE LIKE ZEDT07_100-ZIDCODE, "ID

  ZMATNR LIKE ZEDT07_100-ZMATNR, "####

  ZMTART LIKE ZEDT07_100-ZMTART, "####

  ZMATNAME LIKE ZEDT07_100-ZMATNAME, "###

  ZVOLUM LIKE ZEDT07_100-ZVOLUM, "##

  VRKME LIKE ZEDT07_100-VRKME, "####

  ZNSAMT LIKE ZEDT07_100-ZNSAMT, "####

  ZSLAMT LIKE ZEDT07_100-ZSLAMT, "####

  ZDCAMT LIKE ZEDT07_100-ZDCAMT, "####

  ZDC_FG LIKE ZEDT07_100-ZDC_FG, "####

  ZSALE_FG LIKE ZEDT07_100-ZSALE_FG, "####

  ZRET_FG LIKE ZEDT07_100-ZRET_FG, "####

  ZJDATE LIKE ZEDT07_100-ZJDATE, "####

  ZRDATE LIKE ZEDT07_100-ZRDATE, "####

  END OF GS_ORDER.

DATA : GT_ORDER LIKE TABLE OF GS_ORDER.



DATA : BEGIN OF GS_PRINT_ORDER, "##

  ZORDNO LIKE ZEDT07_100-ZORDNO, "####

  ZIDCODE LIKE ZEDT00_100-ZIDCODE, "ID

  ZMATNR LIKE ZEDT00_100-ZMATNR, "####

  ZMATNAME LIKE ZEDT00_100-ZMATNAME, "#####

  ZMAT_NAME TYPE C LENGTH 8, "#####

  ZVOLUM LIKE ZEDT00_100-ZVOLUM, "##

  VRKME LIKE ZEDT00_100-VRKME, "##

  REVENUE TYPE I, "####

  SALES TYPE I, "####

  DISCOUNT TYPE I, "####

  ZSALE_NAME TYPE C LENGTH 4, "####

  ZJDATE LIKE ZEDT07_100-ZJDATE, "####

  ZRET_NAME TYPE C LENGTH 10, "####

  ZDATE(10), "####

  END OF GS_PRINT_ORDER.

DATA : GT_PRINT_ORDER LIKE TABLE OF GS_PRINT_ORDER.



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



DATA : BEGIN OF GS_PRINT_DELIVERY, "###

  ZORDNO LIKE ZEDT00_101-ZORDNO, "####

  ZIDCODE LIKE ZEDT00_101-ZIDCODE, "##ID

  ZMATNR LIKE ZEDT00_101-ZMATNR, "####

  ZMATNAME LIKE ZEDT00_101-ZMATNAME, "###

  ZMAT_NAME TYPE C LENGTH 8, "#####

  ZVOLUM LIKE ZEDT00_101-ZVOLUM, "##

  VRKME LIKE ZEDT00_101-VRKME, "####

  SALES TYPE I, "####

  ZDFLAG_NAME TYPE C LENGTH 8, "####

  ZDGUBUN_NAME TYPE C LENGTH 6, "####

  ZDDATE LIKE ZEDT00_101-ZDDATE, "####

  ZDATE(10), "####

  ZFLAG LIKE ZEDT00_101-ZFLAG, "FLAG

  END OF GS_PRINT_DELIVERY.

DATA : GT_PRINT_DELIVERY LIKE TABLE OF GS_PRINT_DELIVERY.



"### ##

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

SELECT-OPTIONS : S_ZORDNO FOR ZEDT07_100-ZORDNO.

SELECT-OPTIONS : S_IDCODE FOR ZEDT07_100-ZIDCODE NO INTERVALS NO-EXTENSION.

SELECT-OPTIONS : S_ZMATNR FOR ZEDT07_100-ZMATNR.

SELECT-OPTIONS : S_ZJDATE FOR ZEDT07_100-ZJDATE MODIF ID M1.

SELECT-OPTIONS : S_ZDDATE FOR ZEDT07_101-ZDDATE MODIF ID M2.

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. "## ##

PARAMETERS : P_R2 RADIOBUTTON GROUP R1. "## ##

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X'. "## ## ## ##

SELECTION-SCREEN END OF BLOCK B3.



"### ##

RANGES : R_FG FOR ZEDT07_100-ZSALE_FG. "## ##

RANGES : R_ZG FOR ZEDT07_101-ZFLAG. "## ##



INITIALIZATION.

PERFORM ZJDATE. "#### ##

PERFORM ZDDATE. "#### ##



AT SELECTION-SCREEN OUTPUT.

PERFORM DEFAULT-SCREEN. "## ## ##



START-OF-SELECTION.

PERFORM CHECKBOX. "#### ##

PERFORM SELECT_DATA. "### ##

PERFORM MODIFY_DATA. "### ##



PERFORM WRITE_DATA. "### ##






*&---------------------------------------------------------------------*

*&      Form  ZJDATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ZJDATE. "#### ##

  S_ZJDATE-LOW = SY-DATUM(6) && '01'. "### ## # #



  IF SY-DATUM+4(2) = '01' OR SY-DATUM+4(2) = '03' OR SY-DATUM+4(2) = '05' OR

     SY-DATUM+4(2) = '07' OR SY-DATUM+4(2) = '08' OR SY-DATUM+4(2) = '10' OR

     SY-DATUM+4(2) = '12'. "1, 3, 5, 7, 8, 10, 12## 31### ##

    S_ZJDATE-HIGH = SY-DATUM(6) && '31'. "### ## ### # 31##

  ELSEIF SY-DATUM+4(2) = '02'. "2## 28###

    S_ZJDATE-HIGH = SY-DATUM(6) && '28'. "### ## ### # 28##

  ELSE.

    S_ZJDATE-HIGH = SY-DATUM(6) && '30'. "### ## 30#

  ENDIF.



  S_ZJDATE-SIGN = 'I'.

  S_ZJDATE-OPTION = 'BT'.



  APPEND S_ZJDATE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ZDDATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ZDDATE. "#### ##

  S_ZDDATE-LOW = SY-DATUM(6) && '01'. "### ## # #



  IF SY-DATUM+4(2) = '01' OR SY-DATUM+4(2) = '03' OR SY-DATUM+4(2) = '05' OR

     SY-DATUM+4(2) = '07' OR SY-DATUM+4(2) = '08' OR SY-DATUM+4(2) = '10' OR

     SY-DATUM+4(2) = '12'. "1, 3, 5, 7, 8, 10, 12## 31### ##

    S_ZDDATE-HIGH = SY-DATUM(6) && '31'. "### ## ### # 31##

  ELSEIF SY-DATUM+4(2) = '02'. "2## 28###

    S_ZDDATE-HIGH = SY-DATUM(6) && '28'. "### ## ### # 28##

  ELSE.

    S_ZDDATE-HIGH = SY-DATUM(6) && '30'. "### ## 30#

  ENDIF.



  S_ZDDATE-SIGN = 'I'.

  S_ZDDATE-OPTION = 'BT'.



  APPEND S_ZDDATE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DEFAULT-SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DEFAULT-SCREEN. "## ## ##

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R2 = 'X'.

        SCREEN-ACTIVE = '0'.

      ENDIF.



    ELSEIF SCREEN-GROUP1 = 'M2'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '0'.

      ELSEIF P_R2 = 'X'.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.






*## ## ##

*##### = P_R1 (## ##)

*R_FG ## ####

*###: ZSALE_FG = '1' (## ##)

*####(P_CH1)# ####: ZSALE_FG = '2' (## ## ##) ##

*# #, R_FG = { '1' } ## { '1','2' }

*##### = P_R2 (## ##)

*R_ZG ## ####

*###: ZFLAG = ' ' (## ## # #)

*####(P_CH1)# ####: ZFLAG = 'X' (## ## ## #) ##

*# #, R_ZG = { ' ' } ## { ' ', 'X' }



*&---------------------------------------------------------------------*

*&      Form  CHECKBOX

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECKBOX.

  IF P_R1 = 'X'. "## ### ## ### ## ###

    R_FG-SIGN = 'I'.

    R_FG-OPTION = 'EQ'.

    R_FG-LOW = '1'.

    APPEND R_FG.



    IF P_CH1 = 'X'. "## ## ### ## ###

      R_FG-LOW = '2'.

      APPEND R_FG.

    ENDIF.



  ELSEIF P_R2 = 'X'. "## ### ## ### ## ###

    R_ZG-SIGN = 'I'.

    R_ZG-OPTION = 'EQ'.

    R_FG-LOW = ' '. "## ## ##### ## ### ####

    APPEND R_ZG.



    IF P_CH1 = 'X'. "## ## #### ### ## ###

      R_ZG-LOW = 'X'.

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




FORM SELECT_DATA. "##### ### #### #### ## ###

  IF P_R1 = 'X'. "## ####

    SELECT * FROM ZEDT07_100

      INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

      WHERE ZORDNO IN S_ZORDNO "## ##

      AND ZIDCODE IN S_IDCODE "## ID

      AND ZMATNR IN S_ZMATNR "####

      AND ZJDATE IN S_ZJDATE "## ##

      AND ZSALE_FG IN R_FG. "## ##

  ELSEIF P_R2 = 'X'. "## ####

    SELECT * FROM ZEDT07_101

      INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY

      WHERE ZORDNO IN S_ZORDNO "## ##

      AND ZIDCODE IN S_IDCODE "## ID

      AND ZMATNR IN S_ZMATNR "####

      AND ZDDATE IN S_ZDDATE "## ##

      AND ZFLAG IN R_ZG. "## ##

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




FORM MODIFY_DATA.

  IF  P_R1 = 'X'. "## ##

    LOOP AT GT_ORDER INTO GS_ORDER.

      MOVE-CORRESPONDING GS_ORDER TO GS_PRINT_ORDER. "##### ##### ###



      IF GS_ORDER-ZSALE_FG = '1'.

        GS_PRINT_ORDER-ZSALE_NAME = '##'.

      ELSEIF GS_ORDER-ZSALE_FG = '2'.

        GS_PRINT_ORDER-ZSALE_NAME = '##'.

      ENDIF.



      IF GS_ORDER-ZMTART = C_001.

        GS_PRINT_ORDER-ZMAT_NAME = '##'.

      ELSEIF GS_ORDER-ZMTART = C_002.

        GS_PRINT_ORDER-ZMAT_NAME = '##'.

      ELSEIF GS_ORDER-ZMTART = C_003.

        GS_PRINT_ORDER-ZMAT_NAME = '##'.

      ELSEIF GS_ORDER-ZMTART = C_004.

        GS_PRINT_ORDER-ZMAT_NAME = '##'.

      ELSEIF GS_ORDER-ZMTART = C_005.

        GS_PRINT_ORDER-ZMAT_NAME = '##'.

      ELSEIF GS_ORDER-ZMTART = C_006.

        GS_PRINT_ORDER-ZMAT_NAME = '###'.

      ENDIF.



      IF P_CH1 = 'X'.

        IF GS_ORDER-ZRET_FG = '1'.

          GS_PRINT_ORDER-ZRET_NAME = '####'.

        ELSEIF GS_ORDER-ZRET_FG = '2'.

          GS_PRINT_ORDER-ZRET_NAME = '####'.

        ELSEIF GS_ORDER-ZRET_FG = '3'.

          GS_PRINT_ORDER-ZRET_NAME = '####'.

        ENDIF.

      ENDIF.



      GS_PRINT_ORDER-REVENUE = GS_ORDER-ZNSAMT * 100.

      GS_PRINT_ORDER-SALES = GS_ORDER-ZSLAMT * 100.

      GS_PRINT_ORDER-DISCOUNT = GS_ORDER-ZDCAMT * 100.



      IF GS_ORDER-ZRDATE IS NOT INITIAL.

        CONCATENATE GS_ORDER-ZRDATE+0(4) '.' GS_ORDER-ZRDATE+4(2) '.' GS_ORDER-ZRDATE+6(2)

        INTO GS_PRINT_ORDER-ZDATE.

      ENDIF.



      APPEND GS_PRINT_ORDER TO GT_PRINT_ORDER.

      CLEAR : GS_ORDER, GS_PRINT_ORDER.

    ENDLOOP.



  ELSEIF P_R2 = 'X'. "## ##

    LOOP AT GT_DELIVERY INTO GS_DELIVERY.

      MOVE-CORRESPONDING GS_DELIVERY TO GS_PRINT_DELIVERY.



      IF GS_DELIVERY-ZMTART = C_001.

        GS_PRINT_DELIVERY-ZMAT_NAME = '##'.

      ELSEIF GS_DELIVERY-ZMTART = C_002.

        GS_PRINT_DELIVERY-ZMAT_NAME = '##'.

      ELSEIF GS_DELIVERY-ZMTART = C_003.

        GS_PRINT_DELIVERY-ZMAT_NAME = '##'.

      ELSEIF GS_DELIVERY-ZMTART = C_004.

        GS_PRINT_DELIVERY-ZMAT_NAME = '##'.

      ELSEIF GS_DELIVERY-ZMTART = C_005.

        GS_PRINT_DELIVERY-ZMAT_NAME = '##'.

      ELSEIF GS_DELIVERY-ZMTART = C_006.

        GS_PRINT_DELIVERY-ZMAT_NAME = '###'.

      ENDIF.



      IF GS_DELIVERY-ZDFLAG = '1'.

        GS_PRINT_DELIVERY-ZDFLAG_NAME = '####'.

      ELSEIF GS_DELIVERY-ZDFLAG = '2'.

        GS_PRINT_DELIVERY-ZDFLAG_NAME = '####'.

      ENDIF.



      IF GS_DELIVERY-ZDGUBUN = '1'.

        GS_PRINT_DELIVERY-ZDGUBUN_NAME = '###'.

      ELSEIF GS_DELIVERY-ZDGUBUN = '2'.

        GS_PRINT_DELIVERY-ZDGUBUN_NAME = '###'.

      ELSEIF GS_DELIVERY-ZDGUBUN = '3'.

        GS_PRINT_DELIVERY-ZDGUBUN_NAME = '###'.

      ELSEIF GS_DELIVERY-ZDGUBUN = '4'.

        GS_PRINT_DELIVERY-ZDGUBUN_NAME = '###'.

      ELSEIF GS_DELIVERY-ZDGUBUN = '5'.

        GS_PRINT_DELIVERY-ZDGUBUN_NAME = '###'.

      ELSEIF GS_DELIVERY-ZDGUBUN = '6'.

        GS_PRINT_DELIVERY-ZDGUBUN_NAME = '###'.

      ELSEIF GS_DELIVERY-ZDGUBUN = '7'.

        GS_PRINT_DELIVERY-ZDGUBUN_NAME = '###'.

      ENDIF.



      GS_PRINT_DELIVERY-SALES = GS_DELIVERY-ZSLAMT * 100.



      IF GS_DELIVERY-ZRDATE IS NOT INITIAL.

        CONCATENATE GS_DELIVERY-ZRDATE+0(4) '.' GS_DELIVERY-ZRDATE+4(2) '.' GS_DELIVERY-ZRDATE+6(2)

        INTO GS_PRINT_DELIVERY-ZDATE.

      ENDIF.



      APPEND GS_PRINT_DELIVERY TO GT_PRINT_DELIVERY.

      CLEAR : GS_DELIVERY , GS_PRINT_DELIVERY.

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



  IF P_R1 = 'X'. "## ##

    LOOP AT GT_PRINT_ORDER INTO GS_PRINT_ORDER.

      AT FIRST.

        IF P_CH1 = 'X'. "## ## ## ###

          WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |   ####  |  ####   | ## |  ####  |  ####  |  ####  | '.

          WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |   ####  |  ####   | ## |  ####  | '.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDAT.



      IF P_CH1 = 'X'.

      WRITE :/ '|',GS_PRINT_ORDER-ZORDNO,'|',GS_PRINT_ORDER-ZIDCODE,'|',GS_PRINT_ORDER-ZMATNR,'|',GS_PRINT_ORDER-ZMATNAME,'|',GS_PRINT_ORDER-ZMAT_NAME,'|'

      ,GS_PRINT_ORDER-ZVOLUM,'|',GS_PRINT_ORDER-VRKME,'|',GS_PRINT_ORDER-REVENUE,'|',GS_PRINT_ORDER-SALES,'|'

      ,GS_PRINT_ORDER-DISCOUNT,'|',GS_PRINT_ORDER-ZSALE_NAME,'|',GS_PRINT_ORDER-ZJDATE,'|',GS_PRINT_ORDER-ZRET_NAME,'|',GS_PRINT_ORDER-ZDATE,'|'.

      WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.

      WRITE :/ '|',GS_PRINT_ORDER-ZORDNO,'|',GS_PRINT_ORDER-ZIDCODE,'|',GS_PRINT_ORDER-ZMATNR,'|',GS_PRINT_ORDER-ZMATNAME,'|',GS_PRINT_ORDER-ZMAT_NAME,'|'

      ,GS_PRINT_ORDER-ZVOLUM,'|',GS_PRINT_ORDER-VRKME,'|',GS_PRINT_ORDER-REVENUE,'|',GS_PRINT_ORDER-SALES,'|'

      ,GS_PRINT_ORDER-DISCOUNT,'|',GS_PRINT_ORDER-ZSALE_NAME,'|',GS_PRINT_ORDER-ZJDATE,'|'.

      WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDLOOP.



  ELSEIF P_R2 = 'X'. "## ##

    LOOP AT GT_PRINT_DELIVERY INTO GS_PRINT_DELIVERY.

      AT FIRST.

        IF P_CH1 = 'X'. "## ## ## ###

           WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   | #### |  ##  |  ####  |  ####  |'.

          WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE.

          WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   | #### |  ##  |  ####  | '.

          WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDAT.



      IF P_CH1 = 'X'.

        WRITE :/ '|',GS_PRINT_DELIVERY-ZORDNO,'|',GS_PRINT_DELIVERY-ZIDCODE,'|',GS_PRINT_DELIVERY-ZMATNR,'|',GS_PRINT_DELIVERY-ZMATNAME,'|',GS_PRINT_DELIVERY-ZMAT_NAME,'|'

      ,GS_PRINT_DELIVERY-ZVOLUM,'|',GS_PRINT_DELIVERY-VRKME,'|',GS_PRINT_DELIVERY-SALES,'|',GS_PRINT_DELIVERY-ZDFLAG_NAME,'|'

      ,GS_PRINT_DELIVERY-ZDGUBUN_NAME,'|',GS_PRINT_DELIVERY-ZDDATE,'|',GS_PRINT_DELIVERY-ZDATE,'|'.

      WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.

      WRITE :/ '|',GS_PRINT_DELIVERY-ZORDNO,'|',GS_PRINT_DELIVERY-ZIDCODE,'|',GS_PRINT_DELIVERY-ZMATNR,'|',GS_PRINT_DELIVERY-ZMATNAME,'|',GS_PRINT_DELIVERY-ZMAT_NAME,'|'

      ,GS_PRINT_DELIVERY-ZVOLUM,'|',GS_PRINT_DELIVERY-VRKME,'|',GS_PRINT_DELIVERY-SALES,'|',GS_PRINT_DELIVERY-ZDFLAG_NAME,'|'

      ,GS_PRINT_DELIVERY-ZDGUBUN_NAME,'|',GS_PRINT_DELIVERY-ZDDATE,'|'.

      WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDLOOP.

  ENDIF.

ENDFORM.