
*&---------------------------------------------------------------------*

*& Report ZEDR08_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR08_PRACTICE003.



" ---------------------------------------------------------------------

" ZEDT08_100, ZEDT08_101 ### ##

" ---------------------------------------------------------------------

TABLES ZEDT08_100.

TABLES ZEDT08_101.



" ---------------------------------------------------------------------

" GS_ORDER ### ##

" ---------------------------------------------------------------------

DATA : BEGIN OF GS_ORDER.

  include structure
ZEDT08_100
.

  DATA : END OF GS_ORDER.



" ---------------------------------------------------------------------

" GS_DELIVER ### ##

" ---------------------------------------------------------------------

DATA : BEGIN OF GS_DELIVER.

  include structure
ZEDT08_101
.

  DATA : END OF GS_DELIVER.



" ---------------------------------------------------------------------

" GS_ORDER_RESULT ### ##

" ---------------------------------------------------------------------

DATA : BEGIN OF GS_ORDER_RESULT,

  ZORDNO LIKE ZEDT08_100-ZORDNO,        " ####

  ZIDCODE LIKE ZEDT08_100-ZIDCODE,      " ##ID

  ZMATNR LIKE ZEDT08_100-ZMATNR,        " ####

  ZMATNAME LIKE ZEDT08_100-ZMATNAME,    " ###

  ZMAT_NAME TYPE C LENGTH 8,            " #####

  ZVOLUM LIKE ZEDT08_100-ZVOLUM,        " ##

  VRKME LIKE ZEDT08_100-VRKME,          " ##

  AMT1 TYPE I,                          " ####

  AMT2 TYPE I,                          " ####

  AMT3 TYPE I,                          " ####

  ZSALE_NAME TYPE C LENGTH 4,           " ####

  ZJDATE LIKE ZEDT08_100-ZJDATE,        " ####

  ZRET_NAME TYPE C LENGTH 10,           " ####

  ZDATE(10),

  END OF GS_ORDER_RESULT.



" ---------------------------------------------------------------------

" GS_DELIVER_RESULT ### ##

" ---------------------------------------------------------------------

DATA : BEGIN OF GS_DELIVER_RESULT,

  ZORDNO LIKE ZEDT08_101-ZORDNO,        " ####

  ZIDCODE LIKE ZEDT08_101-ZIDCODE,      " ##ID

  ZMATNR LIKE ZEDT08_101-ZMATNR,        " ####

  ZMATNAME LIKE ZEDT08_101-ZMATNAME,    " ###

  ZMAT_NAME TYPE C LENGTH 8,            " #####

  ZVOLUM LIKE ZEDT08_101-ZVOLUM,        " ##

  VRKME LIKE ZEDT08_101-VRKME,          " ##

  AMT2 TYPE I,                          " ####

  ZDFLAG_NAME TYPE C LENGTH 8,          " ####

  ZDGUBUN_NAME TYPE C LENGTH 6,         " #####

  ZDDATE LIKE ZEDT08_101-ZDDATE,        " ####

  ZDATE(10),                            " ####

  ZFLAG LIKE ZEDT08_101-ZFLAG,          " ####

  END OF GS_DELIVER_RESULT.



" ---------------------------------------------------------------------

" GT_ORDER, GT_DELIVER, GT_ORDER_RESULT, GT_DELIVER_RESULT ### ### ##

" ---------------------------------------------------------------------

DATA : GT_ORDER LIKE TABLE OF GS_ORDER.

DATA : GT_DELIVER LIKE TABLE OF GS_DELIVER.

DATA : GT_ORDER_RESULT LIKE TABLE OF GS_ORDER_RESULT.

DATA : GT_DELIVER_RESULT LIKE TABLE OF GS_DELIVER_RESULT.



" ---------------------------------------------------------------------

" ## ##

" ---------------------------------------------------------------------

RANGES : R_SALE_FG FOR ZEDT00_100-ZSALE_FG.

RANGES : R_FLAG FOR ZEDT00_101-ZFLAG.



" ---------------------------------------------------------------------

" X CHAR## CONSTANTS# ##

" ---------------------------------------------------------------------

CONSTANTS : C_X TYPE C VALUE 'X'.



" ---------------------------------------------------------------------

" BLOCK B1 #### ##

" ---------------------------------------------------------------------

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZORDNO FOR ZEDT08_100-ZORDNO.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT08_100-ZIDCODE NO INTERVALS NO-EXTENSION.

  SELECT-OPTIONS : S_ZMATNR FOR ZEDT08_100-ZMATNR.

  SELECT-OPTIONS : S_ZJDATE FOR ZEDT08_100-ZJDATE MODIF ID M1.

  SELECT-OPTIONS : S_ZDDATE FOR ZEDT08_101-ZDDATE MODIF ID M2.

SELECTION-SCREEN END OF BLOCK B1.



" ---------------------------------------------------------------------

" BLOCK B2 #### ##

" ---------------------------------------------------------------------

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.

  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.

SELECTION-SCREEN END OF BLOCK B2.



" ---------------------------------------------------------------------

" BLOCK B3 #### ##

" ---------------------------------------------------------------------

SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X'.

SELECTION-SCREEN END OF BLOCK B3.



" ---------------------------------------------------------------------

" #### ## ##

" ### ### ## ## ## ###

" ---------------------------------------------------------------------

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    " #### ## ##

    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = C_X.

        SCREEN-ACTIVE = 1.

      ELSE.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'.

      " #### ## ##

      IF P_R2 = C_X.

        SCREEN-ACTIVE = 1.

      ELSE.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.



" ---------------------------------------------------------------------

" ### ##

" ### ### ~ ## ## # ##

" ---------------------------------------------------------------------

INITIALIZATION.

  DATA : LV_START_DATE TYPE C LENGTH 10.  " ## ##

  DATA : LV_END_DATE TYPE C LENGTH 10.    " ### ##

  DATA : LV_YEAR TYPE C LENGTH 4.         " ## ##

  DATA : LV_MONTH TYPE C LENGTH 2.        " ## #

  DATA : LV_FIRST_DAY TYPE C LENGTH 2.    " ## 1#

  DATA : LV_LAST_DAY TYPE C LENGTH 2.     " ## ### #

  DATA : LV_DOT TYPE C LENGTH 1.          " .



  LV_YEAR = SY-DATUM(4).  " ## ##

  LV_MONTH = SY-DATUM+4(2).  " ## #

  LV_FIRST_DAY = '01'.

  LV_DOT = '.'.



  " ## ### ## ##

  CASE LV_MONTH.

    WHEN '01' OR '03' OR '05' OR '07' OR '08' OR '10' OR '12'.

      LV_LAST_DAY = '31'.

    WHEN '04' OR '06' OR '09' OR '11'.

      LV_LAST_DAY = '30'.

    WHEN '02'.

      " ## ##

      IF ( LV_YEAR MOD 4 = 0 AND LV_YEAR MOD 100 <> 0 ) OR ( LV_YEAR MOD 400 = 0 ).

        LV_LAST_DAY = 29.

      ELSE.

        LV_LAST_DAY = 28.

      ENDIF.

  ENDCASE.



  " ###/### ## ## ## ### ## ##

  CONCATENATE LV_YEAR LV_MONTH LV_LAST_DAY INTO LV_END_DATE.

  CONCATENATE LV_YEAR LV_MONTH LV_FIRST_DAY INTO LV_START_DATE.



  " #### ###

  S_ZJDATE-LOW = LV_START_DATE.

  S_ZJDATE-HIGH = LV_END_DATE.

  S_ZJDATE-SIGN = 'I'.

  S_ZJDATE-OPTION = 'BT'.



  APPEND S_ZJDATE.

  CLEAR S_ZJDATE.



  " #### ###

  S_ZDDATE-LOW = LV_START_DATE.

  S_ZDDATE-HIGH = LV_END_DATE.

  S_ZDDATE-SIGN = 'I'.

  S_ZDDATE-OPTION = 'BT'.



  APPEND S_ZDDATE.

  CLEAR S_ZDDATE.



" ---------------------------------------------------------------------

" SELECTION ## # ##

" ---------------------------------------------------------------------

START-OF-SELECTION.

  " SELECT# ### GT_ORDER, GT_DELIVER #### ### ##

  PERFORM GET_DATA.

  " RESULT #### GT_ORDER, GT_DELIVER #### ### ### # ## ### ##

  PERFORM RESULT_DATA.

  " ## ### ##

  PERFORM WRITE_DATA.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .



  IF P_R1 = C_X.

    " #### ##

    " ###### ## ##

    IF P_CH1 = C_X.

      SELECT * FROM ZEDT08_100

        INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

        WHERE ZORDNO IN S_ZORDNO

        AND ZIDCODE IN S_ZCODE

        AND ZMATNR IN S_ZMATNR

        AND ZJDATE IN S_ZJDATE

        AND ZSALE_FG IN R_SALE_FG.

     ELSE.

       " ####### ## ## ##

       SELECT * FROM ZEDT08_100

         INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

         WHERE ZORDNO IN S_ZORDNO

         AND ZIDCODE IN S_ZCODE

         AND ZMATNR IN S_ZMATNR

         AND ZJDATE IN S_ZJDATE

         AND ZSALE_FG NE '2'.

     ENDIF.

   ELSEIF P_R2 = C_X.

     " #### ##

     " ###### ## ##

     IF P_CH1 = C_X.

      SELECT * FROM ZEDT08_101

        INTO CORRESPONDING FIELDS OF TABLE GT_DELIVER

        WHERE ZORDNO IN S_ZORDNO

        AND ZIDCODE IN S_ZCODE

        AND ZMATNR IN S_ZMATNR

        AND ZDDATE IN S_ZDDATE

        AND ZFLAG IN R_FLAG.

     ELSE.

       " ####### ## ## ##

       SELECT * FROM ZEDT08_101

         INTO CORRESPONDING FIELDS OF TABLE GT_DELIVER

         WHERE ZORDNO IN S_ZORDNO

         AND ZIDCODE IN S_ZCODE

         AND ZMATNR IN S_ZMATNR

         AND ZDDATE IN S_ZDDATE

         AND ZFLAG NE C_X.

     ENDIF.

   ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  RESULT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM RESULT_DATA .



  " #### ### ##

  IF P_R1 = C_X.

    LOOP AT GT_ORDER INTO GS_ORDER.

      " GS_ORDER_RESULT ###

      CLEAR GS_ORDER_RESULT.

      " ## GS_ORDER #### GS_ORDER_RESULT# MOVE-CORRESPONDING

      MOVE-CORRESPONDING GS_ORDER TO GS_ORDER_RESULT.



      " #### ### ## RESULT #### ZMAT_NAME ##

      CASE GS_ORDER-ZMTART.

        WHEN '001'.

          GS_ORDER_RESULT-ZMAT_NAME = '##'.

        WHEN '002'.

          GS_ORDER_RESULT-ZMAT_NAME = '##'.

        WHEN '003'.

          GS_ORDER_RESULT-ZMAT_NAME = '##'.

        WHEN '004'.

          GS_ORDER_RESULT-ZMAT_NAME = '##'.

        WHEN '005'.

          GS_ORDER_RESULT-ZMAT_NAME = '##'.

        WHEN '006'.

          GS_ORDER_RESULT-ZMAT_NAME = '###'.

      ENDCASE.



      " ##### ## 1### ##, 2### ## ##

      IF GS_ORDER-ZSALE_FG = '1'.

        GS_ORDER_RESULT-ZSALE_NAME = '##'.

      ELSEIF GS_ORDER-ZSALE_FG = '2'.

        GS_ORDER_RESULT-ZSALE_NAME = '##'.

      ENDIF.



      " ####### ## ## ### ## NAME ##

      IF P_CH1 = C_X.

        IF GS_ORDER-ZRET_FG = '1'.

          GS_ORDER_RESULT-ZRET_NAME = '####'.

        ELSEIF GS_ORDER-ZRET_FG = '2'.

          GS_ORDER_RESULT-ZRET_NAME = '####'.

        ELSEIF GS_ORDER-ZRET_FG = '3'.

          GS_ORDER_RESULT-ZRET_NAME = '####'.

        ENDIF.

      ENDIF.



      " ## ### ##KRW# ##

      GS_ORDER_RESULT-AMT1 = GS_ORDER-ZNSAMT * 100.

      GS_ORDER_RESULT-AMT2 = GS_ORDER-ZSLAMT * 100.

      GS_ORDER_RESULT-AMT3 = GS_ORDER-ZDCAMT * 100.



      " #### ##

      IF GS_ORDER-ZRDATE IS INITIAL.

      ELSE.

        CONCATENATE GS_ORDER-ZRDATE+0(4) GS_ORDER-ZRDATE+4(2) GS_ORDER-ZRDATE+6(2) INTO GS_ORDER_RESULT-ZDATE SEPARATED BY '.'.

      ENDIF.



      " GT_ORDER_RESULT# APPEND

      APPEND GS_ORDER_RESULT TO GT_ORDER_RESULT.

      CLEAR : GS_ORDER, GS_ORDER_RESULT.



    ENDLOOP.

  ELSEIF P_R2 = C_X. " #### ### ##

    LOOP AT GT_DELIVER INTO GS_DELIVER.

      " GS_DELIVER_RESULT ###

      CLEAR GS_DELIVER_RESULT.

      " ## GS_DELIVER #### GS_DELIVER_RESULT# MOVE-CORRESPONDING

      MOVE-CORRESPONDING GS_DELIVER TO GS_DELIVER_RESULT.



      " #### ### ## ZMAT_NAME ##

      CASE GS_DELIVER-ZMTART.

        WHEN '1'.

          GS_DELIVER_RESULT-ZMAT_NAME = '##'.

        WHEN '2'.

          GS_DELIVER_RESULT-ZMAT_NAME = '##'.

        WHEN '3'.

          GS_DELIVER_RESULT-ZMAT_NAME = '##'.

        WHEN '4'.

          GS_DELIVER_RESULT-ZMAT_NAME = '##'.

        WHEN '5'.

          GS_DELIVER_RESULT-ZMAT_NAME = '##'.

        WHEN '6'.

          GS_DELIVER_RESULT-ZMAT_NAME = '###'.

      ENDCASE.



      " #### ### ## ZDGUBUN_NAME ##

      CASE GS_DELIVER-ZDGUBUN.

        WHEN '1'.

          GS_DELIVER_RESULT-ZDGUBUN_NAME = '###'.

        WHEN '2'.

          GS_DELIVER_RESULT-ZDGUBUN_NAME = '###'.

        WHEN '3'.

          GS_DELIVER_RESULT-ZDGUBUN_NAME = '###'.

        WHEN '4'.

          GS_DELIVER_RESULT-ZDGUBUN_NAME = '###'.

        WHEN '5'.

          GS_DELIVER_RESULT-ZDGUBUN_NAME = '###'.

        WHEN '6'.

          GS_DELIVER_RESULT-ZDGUBUN_NAME = '###'.

        WHEN '7'.

          GS_DELIVER_RESULT-ZDGUBUN_NAME = '###'.

      ENDCASE.



      " ##### ## ZDFLAG_NAME ##

      IF GS_DELIVER-ZDFLAG = '1'.

        GS_DELIVER_RESULT-ZDFLAG_NAME = '####'.

      ELSEIF GS_DELIVER-ZDFLAG = '2'.

        GS_DELIVER_RESULT-ZDFLAG_NAME = '####'.

      ENDIF.



      " ## ### ##KRW# ##

      GS_DELIVER_RESULT-AMT2 = GS_DELIVER-ZSLAMT * 100.



      " #### ##

      IF GS_DELIVER-ZRDATE IS INITIAL.

      ELSE.

        CONCATENATE GS_DELIVER-ZRDATE+0(4) GS_DELIVER-ZRDATE+4(2) GS_DELIVER-ZRDATE+6(2) INTO GS_DELIVER_RESULT-ZDATE SEPARATED BY '.'.

      ENDIF.



      " GT_DELIVER_RESULT# APPEND

      APPEND GS_DELIVER_RESULT TO GT_DELIVER_RESULT.

      CLEAR : GS_DELIVER, GS_DELIVER_RESULT.



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

  " ### ## ## ### ##

  " #### ### ##

  IF P_R1 = C_X.

    LOOP AT GT_ORDER_RESULT INTO GS_ORDER_RESULT.

      AT FIRST.

        " ####### ##

        IF P_CH1 = C_X.

          WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |   ####  |  ####   | ## |  ####  |  ####  |  ####  | '.

          WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE.

          " ####### ## ##

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |   ####  |  ####   | ## |  ####  | '.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDAT.



      " ####### ##

      IF P_CH1 = C_X.

        WRITE :/ '|',GS_ORDER_RESULT-ZORDNO,'|',GS_ORDER_RESULT-ZIDCODE,'|',GS_ORDER_RESULT-ZMATNR,'|',GS_ORDER_RESULT-ZMATNAME,'|',GS_ORDER_RESULT-ZMAT_NAME,'|'

        ,GS_ORDER_RESULT-ZVOLUM,'|',GS_ORDER_RESULT-VRKME,'|',GS_ORDER_RESULT-AMT1,'|',GS_ORDER_RESULT-AMT2,'|'

        ,GS_ORDER_RESULT-AMT3,'|',GS_ORDER_RESULT-ZSALE_NAME,'|',GS_ORDER_RESULT-ZJDATE,'|',GS_ORDER_RESULT-ZRET_NAME,'|',GS_ORDER_RESULT-ZDATE,'|'.

        WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.

        " ####### ## ##

        WRITE :/ '|',GS_ORDER_RESULT-ZORDNO,'|',GS_ORDER_RESULT-ZIDCODE,'|',GS_ORDER_RESULT-ZMATNR,'|',GS_ORDER_RESULT-ZMATNAME,'|',GS_ORDER_RESULT-ZMAT_NAME,'|'

        ,GS_ORDER_RESULT-ZVOLUM,'|',GS_ORDER_RESULT-VRKME,'|',GS_ORDER_RESULT-AMT1,'|',GS_ORDER_RESULT-AMT2,'|'

        ,GS_ORDER_RESULT-AMT3,'|',GS_ORDER_RESULT-ZSALE_NAME,'|',GS_ORDER_RESULT-ZJDATE,'|'.

        WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDLOOP.

  ELSEIF P_R2 = C_X.

    " #### ### ##

    LOOP AT GT_DELIVER_RESULT INTO GS_DELIVER_RESULT.

      AT FIRST.

        IF P_CH1 = 'X'.

          " ####### ##

          WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   | #### |  ##  |  ####  |  ####  |'.

          WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE.

          " ####### ## ##

          WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   | #### |  ##  |  ####  | '.

          WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDAT.



      " ####### ##

      IF P_CH1 = C_X.

        WRITE :/ '|',GS_DELIVER_RESULT-ZORDNO,'|',GS_DELIVER_RESULT-ZIDCODE,'|',GS_DELIVER_RESULT-ZMATNR,'|',GS_DELIVER_RESULT-ZMATNAME,'|',GS_DELIVER_RESULT-ZMAT_NAME,'|'

        ,GS_DELIVER_RESULT-ZVOLUM,'|',GS_DELIVER_RESULT-VRKME,'|',GS_DELIVER_RESULT-AMT2,'|',GS_DELIVER_RESULT-ZDFLAG_NAME,'|'

        ,GS_DELIVER_RESULT-ZDGUBUN_NAME,'|',GS_DELIVER_RESULT-ZDDATE,'|',GS_DELIVER_RESULT-ZDATE,'|'.

        WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.

        " ####### ## ##

        WRITE :/ '|',GS_DELIVER_RESULT-ZORDNO,'|',GS_DELIVER_RESULT-ZIDCODE,'|',GS_DELIVER_RESULT-ZMATNR,'|',GS_DELIVER_RESULT-ZMATNAME,'|',GS_DELIVER_RESULT-ZMAT_NAME,'|'

        ,GS_DELIVER_RESULT-ZVOLUM,'|',GS_DELIVER_RESULT-VRKME,'|',GS_DELIVER_RESULT-AMT2,'|',GS_DELIVER_RESULT-ZDFLAG_NAME,'|'

        ,GS_DELIVER_RESULT-ZDGUBUN_NAME,'|',GS_DELIVER_RESULT-ZDDATE,'|'.

        WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDLOOP.

  ENDIF.



ENDFORM.