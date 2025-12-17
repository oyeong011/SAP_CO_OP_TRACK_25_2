
*&---------------------------------------------------------------------*

*& Report ZEDR06_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_PRACTICE003.

TABLES : ZEDT06_100, ZEDT06_101.




*&---------------------------------------------------------------------*




" ## #### ##

CONSTANTS C_DOT TYPE C VALUE '.'.      " ## ## ## ##

CONSTANTS C_X TYPE C VALUE 'X'.        " X# ## ## ##




*&---------------------------------------------------------------------*




" ### ### # ### ##

" #### ###

DATA : BEGIN OF GS_ORDER,

  ZORDNO LIKE ZEDT06_100-ZORDNO,      " ####

  ZIDCODE LIKE ZEDT06_100-ZIDCODE,    " ##ID

  ZMATNR LIKE ZEDT06_100-ZMATNR,      " ####

  ZMTART LIKE ZEDT06_100-ZMTART,      " ####

  ZMATNAME LIKE ZEDT06_100-ZMATNAME,  " ###

  ZVOLUM LIKE ZEDT06_100-ZVOLUM,      " ##

  VOLUM LIKE ZEDT06_100-VOLUM,        " VOLUME

  VRKME LIKE ZEDT06_100-VRKME,        " SALES UNIT

  ZNSAMT LIKE ZEDT06_100-ZNSAMT,      " ####

  ZSLAMT LIKE ZEDT06_100-ZSLAMT,      " ####

  ZDCAMT LIKE ZEDT06_100-ZDCAMT,      " ####

  ZDC_FG LIKE ZEDT06_100-ZDC_FG,      " ####

  ZSALE_FG LIKE ZEDT06_100-ZSALE_FG,  " ####

  ZRET_FG LIKE ZEDT06_100-ZRET_FG,    " ####

  ZJDATE LIKE ZEDT06_100-ZJDATE,      " ####

  ZRDATE LIKE ZEDT06_100-ZRDATE,      " ####

  END OF GS_ORDER.

DATA : GT_ORDER LIKE TABLE OF GS_ORDER.



" #### ###

DATA : BEGIN OF GS_DELIVER,

  ZORDNO LIKE ZEDT06_101-ZORDNO,      " ####

  ZIDCODE LIKE ZEDT06_101-ZIDCODE,    " ##ID

  ZMATNR LIKE ZEDT06_101-ZMATNR,      " ####

  ZMTART LIKE ZEDT06_101-ZMTART,      " ####

  ZMATNAME LIKE ZEDT06_101-ZMATNAME,  " ###

  ZVOLUM LIKE ZEDT06_101-ZVOLUM,      " ##

  VOLUM LIKE ZEDT06_101-VOLUM,        " VOLUME

  VRKME LIKE ZEDT06_101-VRKME,        " SALES UNIT

  ZSLAMT LIKE ZEDT06_101-ZSLAMT,      " ####

  ZDFLAG LIKE ZEDT06_101-ZDFLAG,      " ####

  ZDGUBUN LIKE ZEDT06_101-ZDGUBUN,    " ####

  ZDDATE LIKE ZEDT06_101-ZDDATE,      " ####

  ZRDATE LIKE ZEDT06_101-ZRDATE,      " ####

  ZFLAG LIKE ZEDT06_101-ZFLAG,        " ####

  END OF GS_DELIVER.

DATA : GT_DELIVER LIKE TABLE OF GS_DELIVER.



" ## ### ###

DATA : BEGIN OF GS_ORDER_RESULT,

  ZORDNO LIKE ZEDT06_100-ZORDNO,      " ####

  ZIDCODE LIKE ZEDT06_100-ZIDCODE,    " ##ID

  ZMATNR LIKE ZEDT06_100-ZMATNR,      " ####

  ZMATNAME LIKE ZEDT06_100-ZMATNAME,  " ###

  ZMAT_NAME TYPE C LENGTH 10,         " ##### -> CASE

  ZVOLUM LIKE ZEDT06_100-ZVOLUM,      " ##

  VRKME LIKE ZEDT06_100-VRKME,        " ##

  ZNSAMT TYPE I,                      " ####

  ZSLAMT TYPE I,                      " ####

  ZDCAMT TYPE I,                      " ####

  ZSALE_FG TYPE C LENGTH 4,           " #### -> CASE

  ZJDATE LIKE ZEDT06_100-ZJDATE,      " ####

  ZRET_NAME TYPE C LENGTH 10,         " #### -> CASE + ## ## #

  ZRDATE(10),                         " #### ->        ## ## #

  END OF GS_ORDER_RESULT.

DATA : GT_ORDER_RESULT LIKE TABLE OF GS_ORDER_RESULT.



" ## ### ###

DATA : BEGIN OF GS_DELIVER_RESULT,

  ZORDNO LIKE ZEDT06_101-ZORDNO,      " ####

  ZIDCODE LIKE ZEDT06_101-ZIDCODE,    " ##ID

  ZMATNR LIKE ZEDT06_101-ZMATNR,      " ####

  ZMATNAME LIKE ZEDT06_101-ZMATNAME,  " ###

  ZMAT_NAME TYPE C LENGTH 8,          " #####  -> CASE

  ZVOLUM LIKE ZEDT06_101-ZVOLUM,      " ##

  VRKME LIKE ZEDT06_101-VRKME,        " ##

  ZSLAMT TYPE I,                      " ####

  ZDFLAG TYPE C LENGTH 8,             " ####    -> CASE

  ZDGUBUN TYPE C LENGTH 8,            " #####  -> CASE

  ZDDATE LIKE ZEDT06_101-ZDDATE,      " ####

  ZRDATE(10),                         " ####    -> ## ## #

  END OF GS_DELIVER_RESULT.

DATA : GT_DELIVER_RESULT LIKE TABLE OF GS_DELIVER_RESULT.




*&---------------------------------------------------------------------*




" SELECTION-SCREEN## ## ##

" ### ## ## ## (####, ##ID, ####, ##/## ##)

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS S_ZORDNO FOR ZEDT06_100-ZORDNO.

  PARAMETERS P_ZID LIKE ZEDT06_100-ZIDCODE.

  SELECT-OPTIONS S_ZMATNR FOR ZEDT06_100-ZMATNR.

  SELECT-OPTIONS S_ZJDATE FOR ZEDT06_100-ZJDATE MODIF ID M1.

  SELECT-OPTIONS S_ZDDATE FOR ZEDT06_101-ZDDATE MODIF ID M2.

SELECTION-SCREEN END OF BLOCK B1.

" ##/## ## RADIOBUTTON

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS P_R1 RADIOBUTTON GROUP G1 USER-COMMAND UC1.

  PARAMETERS P_R2 RADIOBUTTON GROUP G1.

SELECTION-SCREEN END OF BLOCK B2.

" ## ## ## CHECKBOX

SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS P_CH1 AS CHECKBOX.

SELECTION-SCREEN END OF BLOCK B3.




*&---------------------------------------------------------------------*




" ## ## ##

RANGES : R_ORDER_ZJDATE FOR ZEDT06_100-ZJDATE.       " #### RANGE ##

RANGES : R_DELIVER_ZDDATE FOR ZEDT06_101-ZDDATE.     " #### RANGE ##




*&---------------------------------------------------------------------*




" ## ## ##.

" 1. ## ##.

INITIALIZATION.

  P_R1 = C_X.

  P_CH1 = C_X.

  PERFORM DEFAULT_DATE_SETTING.      " ## ## # ##.



" 2. ### ##

AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_SETTING.            " ### ##



" 3. ### ##

START-OF-SELECTION.

  PERFORM GET_DATA.                  " ### ##



" 4. ### ####

END-OF-SELECTION.

  IF P_R1 = C_X.

    PERFORM MAKE_RESULT_ORDER_DATA.  " ## ### ### #### ##

    PERFORM WRITE_ORDER_DATA.        " ## ### ##

  ELSE.

    PERFORM MAKE_RESULT_DELIVER_DATA." ## ### ### #### ##

    PERFORM WRITE_DELIVER_DATA.      " ## ### ##

  ENDIF.




*&---------------------------------------------------------------------*

*&      Form  DEFAULT_DATE_SETTING

*&---------------------------------------------------------------------*

*       ## : ## ## # ##

*----------------------------------------------------------------------*




FORM DEFAULT_DATE_SETTING.

  DATA : LV_TODAY TYPE SY-DATUM,                           " ## ### ##

         LV_CUR_MONTH_FIRST_DATE TYPE C LENGTH 2,          " ## ## ### ##

         LV_CUR_MONTH_LAST_DATE TYPE C LENGTH 2,           " ## ## ### ##

         LV_CUR_MONTH TYPE C LENGTH 2,                     " ## #

         LV_CUR_YEAR TYPE C LENGTH 4,                      " ## ##

         LV_LEAP_YEAR_FLAG TYPE C.                         " ## ## ###

   DATA : LV_LOW_DAY TYPE C LENGTH 20.                     " ## ## ### ##

   DATA : LV_HIGH_DAY TYPE C LENGTH 20.                    " ## ## ### ##



  " ## ### ## # ####

  LV_CUR_YEAR = SY-DATUM(4).

  LV_CUR_MONTH = SY-DATUM+4(2).

  LV_CUR_MONTH_FIRST_DATE = '01'.



  " ## ### ## ## ##

  CASE LV_CUR_MONTH.

    WHEN 1 OR 3 OR 5 OR 7 OR 8 OR 10 OR 12.

      LV_CUR_MONTH_LAST_DATE = '31'.

    WHEN 4 OR 6 OR 9 OR 11.

      LV_CUR_MONTH_LAST_DATE = '30'.

    WHEN 2.

      " ## ##

      IF ( LV_CUR_YEAR MOD 400 = 0 ) OR ( LV_CUR_YEAR MOD 100 <> 0 AND LV_CUR_YEAR MOD 4 = 0 ).

        LV_LEAP_YEAR_FLAG = 'X'.

      ENDIF.



      " ### ## ##

      IF LV_LEAP_YEAR_FLAG = 'X'.

        LV_CUR_MONTH_LAST_DATE = '29'.

      ELSE.

        LV_CUR_MONTH_LAST_DATE = '28'.

      ENDIF.

    ENDCASE.



    " ## ## ### ## ###

    CONCATENATE  LV_CUR_YEAR LV_CUR_MONTH LV_CUR_MONTH_FIRST_DATE INTO LV_LOW_DAY.

    " ## ## ### ## ###

    CONCATENATE  LV_CUR_YEAR LV_CUR_MONTH LV_CUR_MONTH_LAST_DATE INTO LV_HIGH_DAY.



    " #### ## ##

    CLEAR : S_ZJDATE.

    R_ORDER_ZJDATE-SIGN = 'I'.

    R_ORDER_ZJDATE-option = 'BT'.

    R_ORDER_ZJDATE-LOW    = LV_LOW_DAY.

    R_ORDER_ZJDATE-HIGH   = LV_HIGH_DAY.

    APPEND R_ORDER_ZJDATE TO S_ZJDATE.



    " #### ## ##

    CLEAR : R_DELIVER_ZDDATE.

    R_DELIVER_ZDDATE-SIGN = 'I'.

    R_DELIVER_ZDDATE-option = 'BT'.

    R_DELIVER_ZDDATE-LOW    = LV_LOW_DAY.

    R_DELIVER_ZDDATE-HIGH   = LV_HIGH_DAY.

    APPEND R_DELIVER_ZDDATE TO S_ZDDATE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SCREEN_SETTING

*&---------------------------------------------------------------------*

*       ## : ### ### ## ##/#### ##

*----------------------------------------------------------------------*




FORM SCREEN_SETTING.

  LOOP AT SCREEN.

    " #### ##

    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = C_X.

        SCREEN-ACTIVE = 1.

      ELSE.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.

    " #### ##

    IF SCREEN-GROUP1 = 'M2'.

      IF P_R2 = C_X.

        SCREEN-ACTIVE = 1.

      ELSE.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       ## : ##/## ### ##

*----------------------------------------------------------------------*




" #### PERFORM

FORM GET_DATA.

  " ##/## ## ## ## ##

  IF P_R1 = C_X.

    " ## ## ### ## SELECT

    IF P_ZID = ''.

      SELECT * FROM ZEDT06_100

        INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

        WHERE ZJDATE IN S_ZJDATE

        AND ZMATNR IN S_ZMATNR.

    ELSE.

      SELECT * FROM ZEDT06_100

        INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

        WHERE ZJDATE IN S_ZJDATE

        AND ZIDCODE = P_ZID

        AND ZMATNR IN S_ZMATNR.

    ENDIF.

  ELSE.

    " ## ## ### ## SELECT

    IF P_ZID = ''.

      SELECT * FROM ZEDT06_101

        INTO CORRESPONDING FIELDS OF TABLE GT_DELIVER

        WHERE ZDDATE IN S_ZDDATE

        AND ZMATNR IN S_ZMATNR.

    ELSE.

      SELECT * FROM ZEDT06_101

        INTO CORRESPONDING FIELDS OF TABLE GT_DELIVER

        WHERE ZDDATE IN S_ZDDATE

        AND ZIDCODE = P_ZID

        AND ZMATNR IN S_ZMATNR.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAKE_RESULT_ORDER_DATA

*&---------------------------------------------------------------------*

*       ## : ### ## ## ### ###

*----------------------------------------------------------------------*




FORM MAKE_RESULT_ORDER_DATA.

  CLEAR : GS_ORDER.

  LOOP AT GT_ORDER INTO GS_ORDER.



    " ## #### ## ## ### ##.

    IF P_CH1 <> C_X AND GS_ORDER-ZRET_FG <> ''.

      CONTINUE.

    ENDIF.



    CLEAR : GS_ORDER_RESULT.

    GS_ORDER_RESULT-ZORDNO = GS_ORDER-ZORDNO.

    GS_ORDER_RESULT-ZIDCODE = GS_ORDER-ZIDCODE.

    GS_ORDER_RESULT-ZMATNR = GS_ORDER-ZMATNR.

    GS_ORDER_RESULT-ZMATNAME = GS_ORDER-ZMATNAME.



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



    CASE GS_ORDER-ZSALE_FG.

      WHEN '1'.

        GS_ORDER_RESULT-ZSALE_FG = '##'.

      WHEN '2'.

        GS_ORDER_RESULT-ZSALE_FG = '##'.

    ENDCASE.



    CASE GS_ORDER-ZRET_FG.

      WHEN '1'.

        GS_ORDER_RESULT-ZRET_NAME = '####'.

      WHEN '2'.

        GS_ORDER_RESULT-ZRET_NAME = '####'.

      WHEN '3'.

        GS_ORDER_RESULT-ZRET_NAME = '####'.

    ENDCASE.



    GS_ORDER_RESULT-ZVOLUM = GS_ORDER-ZVOLUM.

    GS_ORDER_RESULT-VRKME = GS_ORDER-VRKME.

    GS_ORDER_RESULT-ZNSAMT = GS_ORDER-ZNSAMT * 100.

    GS_ORDER_RESULT-ZSLAMT = GS_ORDER-ZSLAMT * 100.

    GS_ORDER_RESULT-ZDCAMT = GS_ORDER-ZDCAMT * 100.

    GS_ORDER_RESULT-ZJDATE = GS_ORDER-ZJDATE.



    " ZRDATE(####) ###.

    IF GS_ORDER-ZRDATE IS INITIAL.

    ELSE.

      CONCATENATE GS_ORDER-ZRDATE+0(4) '.' GS_ORDER-ZRDATE+4(2) '.' GS_ORDER-ZRDATE+6(2)

      INTO GS_ORDER_RESULT-ZRDATE.

    ENDIF.





    APPEND GS_ORDER_RESULT TO GT_ORDER_RESULT.

    CLEAR : GS_ORDER, GS_ORDER_RESULT.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAKE_RESULT_DELIVER_DATA

*&---------------------------------------------------------------------*

*       ## : ### ## ## ### ###

*----------------------------------------------------------------------*




FORM MAKE_RESULT_DELIVER_DATA.

  CLEAR : GS_DELIVER.

  LOOP AT GT_DELIVER INTO GS_DELIVER.



    " ## #### ## ## ### ##.

    IF P_CH1 <> C_X AND GS_DELIVER-ZFLAG <> ''.

      CONTINUE.

    ENDIF.



    CLEAR : GS_DELIVER_RESULT.

    GS_DELIVER_RESULT-ZORDNO = GS_DELIVER-ZORDNO.

    GS_DELIVER_RESULT-ZIDCODE = GS_DELIVER-ZIDCODE.

    GS_DELIVER_RESULT-ZMATNR = GS_DELIVER-ZMATNR.

    GS_DELIVER_RESULT-ZMATNAME = GS_DELIVER-ZMATNAME.



    CASE GS_DELIVER-ZMTART.

      WHEN '001'.

        GS_DELIVER_RESULT-ZMAT_NAME = '##'.

      WHEN '002'.

        GS_DELIVER_RESULT-ZMAT_NAME = '##'.

      WHEN '003'.

        GS_DELIVER_RESULT-ZMAT_NAME = '##'.

      WHEN '004'.

        GS_DELIVER_RESULT-ZMAT_NAME = '##'.

      WHEN '005'.

        GS_DELIVER_RESULT-ZMAT_NAME = '##'.

      WHEN '006'.

        GS_DELIVER_RESULT-ZMAT_NAME = '###'.

    ENDCASE.



    CASE GS_DELIVER-ZDFLAG.

      WHEN '1'.

        GS_DELIVER_RESULT-ZDFLAG = '####'.

      WHEN '2'.

        GS_DELIVER_RESULT-ZDFLAG = '###'.

      WHEN '3'.

        GS_DELIVER_RESULT-ZDFLAG = '####'.

    ENDCASE.



    CASE GS_DELIVER-ZDGUBUN.

      WHEN '1'.

        GS_DELIVER_RESULT-ZDGUBUN = '###'.

      WHEN '2'.

        GS_DELIVER_RESULT-ZDGUBUN = '###'.

      WHEN '3'.

        GS_DELIVER_RESULT-ZDGUBUN = '###'.

      WHEN '4'.

        GS_DELIVER_RESULT-ZDGUBUN = '###'.

      WHEN '5'.

        GS_DELIVER_RESULT-ZDGUBUN = '###'.

      WHEN '6'.

        GS_DELIVER_RESULT-ZDGUBUN = '###'.

      WHEN '7'.

        GS_DELIVER_RESULT-ZDGUBUN = '###'.

    ENDCASE.



    GS_DELIVER_RESULT-ZVOLUM = GS_DELIVER-ZVOLUM.

    GS_DELIVER_RESULT-VRKME = GS_DELIVER-VRKME.

    GS_DELIVER_RESULT-ZSLAMT = GS_DELIVER-ZSLAMT * 100.

    GS_DELIVER_RESULT-ZDDATE = GS_DELIVER-ZDDATE.



    " ZRDATE(####) ###.

    IF GS_DELIVER-ZRDATE IS INITIAL.

    ELSE.

      CONCATENATE GS_DELIVER-ZRDATE+0(4) '.' GS_DELIVER-ZRDATE+4(2) '.' GS_DELIVER-ZRDATE+6(2)

      INTO GS_DELIVER_RESULT-ZRDATE.

    ENDIF.



    APPEND GS_DELIVER_RESULT TO GT_DELIVER_RESULT.

    CLEAR : GS_DELIVER, GS_DELIVER_RESULT.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_ORDER_DATA

*&---------------------------------------------------------------------*

*       ## : ## ## ###

*----------------------------------------------------------------------*




FORM WRITE_ORDER_DATA.

  CLEAR : GS_ORDER_RESULT.

  LOOP AT GT_ORDER_RESULT INTO GS_ORDER_RESULT.

      AT FIRST.

        IF P_CH1 = C_X.  " ## ##

          WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        |  ####  |## |## |  ####   |   ####  |  ####   | ## |  ####  |  ####  |  ####  | '.

          WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE.             " ## ###

          WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        |  ####  |## |## |  ####   |   ####  |  ####   | ## |  ####  | '.

          WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDAT.



      IF P_CH1 = C_X. " ## ##

        WRITE :/ '|',GS_ORDER_RESULT-ZORDNO,'|',GS_ORDER_RESULT-ZIDCODE,'|',GS_ORDER_RESULT-ZMATNR,'|',GS_ORDER_RESULT-ZMATNAME,'|',GS_ORDER_RESULT-ZMAT_NAME,'|',GS_ORDER_RESULT-ZVOLUM,'|',GS_ORDER_RESULT-VRKME,'|',GS_ORDER_RESULT-ZNSAMT,'|',

GS_ORDER_RESULT-ZSLAMT,'|',GS_ORDER_RESULT-ZDCAMT,'|',GS_ORDER_RESULT-ZSALE_FG,'|',GS_ORDER_RESULT-ZJDATE,'|',GS_ORDER_RESULT-ZRET_NAME,'|',GS_ORDER_RESULT-ZRDATE,'|'.

        WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.           " ## ###

        WRITE :/ '|',GS_ORDER_RESULT-ZORDNO,'|',GS_ORDER_RESULT-ZIDCODE,'|',GS_ORDER_RESULT-ZMATNR,'|',GS_ORDER_RESULT-ZMATNAME,'|',GS_ORDER_RESULT-ZMAT_NAME,'|'

        ,GS_ORDER_RESULT-ZVOLUM,'|',GS_ORDER_RESULT-VRKME,'|',GS_ORDER_RESULT-ZNSAMT,'|',GS_ORDER_RESULT-ZSLAMT,'|'

        ,GS_ORDER_RESULT-ZDCAMT,'|',GS_ORDER_RESULT-ZSALE_FG,'|',GS_ORDER_RESULT-ZJDATE,'|'.

        WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

      CLEAR : GS_ORDER_RESULT.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_DELIVER_DATA

*&---------------------------------------------------------------------*

*       ## : ## ## ###

*----------------------------------------------------------------------*




FORM WRITE_DELIVER_DATA.

  CLEAR : GS_DELIVER_RESULT.

  LOOP AT GT_DELIVER_RESULT INTO GS_DELIVER_RESULT.

      AT FIRST.

        IF P_CH1 = C_X. " ## ##

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   | #### |   ##   |  ####  |  ####  |'.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE.           " ## ###

          WRITE :/ '---------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   | #### |   ##   |  ####  | '.

          WRITE :/ '---------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDAT.



      IF P_CH1 = C_X.  " ## ##

        WRITE :/ '|',GS_DELIVER_RESULT-ZORDNO,'|',GS_DELIVER_RESULT-ZIDCODE,'|',GS_DELIVER_RESULT-ZMATNR,'|',GS_DELIVER_RESULT-ZMATNAME,'|',GS_DELIVER_RESULT-ZMAT_NAME,'|',GS_DELIVER_RESULT-ZVOLUM,'|',GS_DELIVER_RESULT-VRKME,'|',GS_DELIVER_RESULT-ZSLAMT,

'|',GS_DELIVER_RESULT-ZDFLAG,'|',GS_DELIVER_RESULT-ZDGUBUN,'|',GS_DELIVER_RESULT-ZDDATE,'|',GS_DELIVER_RESULT-ZRDATE,'|'.

        WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.             " ## ###

        WRITE :/ '|',GS_DELIVER_RESULT-ZORDNO,'|',GS_DELIVER_RESULT-ZIDCODE,'|',GS_DELIVER_RESULT-ZMATNR,'|',GS_DELIVER_RESULT-ZMATNAME,'|',GS_DELIVER_RESULT-ZMAT_NAME,'|'

        ,GS_DELIVER_RESULT-ZVOLUM,'|',GS_DELIVER_RESULT-VRKME,'|',GS_DELIVER_RESULT-ZSLAMT,'|',GS_DELIVER_RESULT-ZDFLAG,'|'

        ,GS_DELIVER_RESULT-ZDGUBUN,'|',GS_DELIVER_RESULT-ZDDATE,'|'.

        WRITE :/ '---------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

      CLEAR : GS_DELIVER_RESULT.

  ENDLOOP.



ENDFORM.