
*&---------------------------------------------------------------------*

*& Report ZEDR25_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR25_PRACTICE003.



TABLES : ZEDT25_100, ZEDT25_101.



CONSTANTS : C_X TYPE CHAR1 VALUE 'X'.



" ## ## ###

DATA: BEGIN OF GS_ORDER.

  include structure
ZEDT25_100
.

DATA: END OF GS_ORDER.

DATA : GT_ORDER LIKE TABLE OF GS_ORDER.



"###(##)

DATA : BEGIN OF GS_ORDRE,

  ZORDNO LIKE ZEDT25_100-ZORDNO,

  ZIDCODE LIKE ZEDT25_100-ZIDCODE,

  ZMATNR LIKE ZEDT25_100-ZMATNR, "####

  ZMATNAME LIKE ZEDT25_100-ZMATNAME,

  ZMAT_NAME TYPE C LENGTH 8,

  ZVOLUM LIKE ZEDT25_100-ZVOLUM,

  VRKME LIKE ZEDT25_100-VRKME,

  SALEAMT1 TYPE I, "####

  SALESALEAMT2 TYPE I, "####

  SALEAMT3 TYPE I, "####

  ZSALE_NAME TYPE C LENGTH 4,

  ZJDATE     LIKE ZEDT25_100-ZJDATE,

  ZRET_NAME  TYPE C LENGTH 10,

  ZDATE(10), "####

  END OF GS_ORDRE.

DATA : GT_ORDRE LIKE TABLE OF GS_ORDRE.



"#### ###

DATA: BEGIN OF GS_DELIVERY.

  include structure
ZEDT25_101
.

DATA: END OF GS_DELIVERY.

DATA : GT_DELIVERY LIKE TABLE OF GS_DELIVERY.



" ###(##)

DATA : BEGIN OF GS_DELRE,

  ZORDNO LIKE ZEDT25_101-ZORDNO,

  ZIDCODE LIKE ZEDT25_101-ZIDCODE,

  ZMATNR LIKE ZEDT25_101-ZMATNR,

  ZMATNAME LIKE ZEDT25_101-ZMATNAME,

  ZMAT_NAME TYPE C LENGTH 8,

  ZVOLUM LIKE ZEDT25_101-ZVOLUM,

  VRKME LIKE ZEDT25_101-VRKME,

  SALEAMT2 TYPE I,

  ZDFLAG_NAME TYPE C LENGTH 8,

  ZDGUBUN_NAME TYPE C LENGTH 6,

  ZDDATE LIKE ZEDT25_101-ZDDATE,

  ZDATE(10),

  ZFLAG LIKE ZEDT25_101-ZFLAG, "FLAG

  END OF GS_DELRE.

DATA : GT_DELRE LIKE TABLE OF GS_DELRE.



RANGES : R_FG FOR ZEDT25_100-ZSALE_FG.

RANGES : R_ZG FOR ZEDT25_101-ZFLAG.



"### ##

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZORDNO FOR ZEDT25_100-ZORDNO.

  SELECT-OPTIONS : S_ZID FOR ZEDT25_100-ZIDCODE NO INTERVALS NO-EXTENSION. "### # ###

  SELECT-OPTIONS : S_ZMATNR FOR ZEDT25_100-ZMATNR.

  SELECT-OPTIONS : S_ZJDATE FOR ZEDT25_100-ZJDATE MODIF ID M1.

  SELECT-OPTIONS : S_ZDDATE FOR ZEDT25_101-ZDDATE MODIF ID M2.

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.

  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X'.

  SELECTION-SCREEN END OF BLOCK B3.



INITIALIZATION.

  "## ##, ## ## ###

" https://zcoding1.tistory.com/4

  DATA: lv_last_day TYPE d.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      day_in            = sy-datum

    IMPORTING

      last_day_of_month = lv_last_day.



  S_ZJDATE-LOW  = sy-datum(6) && '01'.

  S_ZJDATE-HIGH = lv_last_day.

  S_ZJDATE-SIGN = 'I'.

  S_ZJDATE-OPTION = 'BT'.

  APPEND S_ZJDATE.



  S_ZDDATE-LOW  = sy-datum(6) && '01'.

  S_ZDDATE-HIGH = lv_last_day.

  S_ZDDATE-SIGN = 'I'.

  S_ZDDATE-OPTION = 'BT'.

  APPEND S_ZDDATE.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

  " ####

    IF screen-group1 = 'M1'.

      IF p_r1 = C_X.

        screen-active = 1.

      ELSE.

        screen-active = 0.

      ENDIF.

      MODIFY SCREEN.

    ENDIF.



    " ####

    IF screen-group1 = 'M2'.

      IF p_r2 = C_X.

        screen-active = 1.

      ELSE.

        screen-active = 0.

      ENDIF.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.



START-OF-SELECTION.

  PERFORM CHECKBOX_INIT."## ## ##

  PERFORM SELECT_DATA. "##

  PERFORM MODIFY_DATA. "##

  PERFORM WRITE_DATA. "##








*&---------------------------------------------------------------------*

*&      Form  CHECKBOX_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECKBOX_INIT .

   CLEAR R_FG.

  CLEAR R_ZG.



  IF P_R1 = C_X. " ##

    R_FG-SIGN   = 'I'.

    R_FG-OPTION = 'EQ'.

    R_FG-LOW    = '1'.

    APPEND R_FG.



    IF P_CH1 = C_X.

      R_FG-LOW = '2'.

      APPEND R_FG.

    ENDIF.



  ELSEIF P_R2 = C_X. " ##

    R_ZG-SIGN   = 'I'.

    R_ZG-OPTION = 'EQ'.

    R_ZG-LOW    = ' '.

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

   IF P_R1 = C_X. " ##

    SELECT * FROM ZEDT25_100

      INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

      WHERE ZORDNO   IN S_ZORDNO

        AND ZIDCODE  IN S_ZID

        AND ZMATNR   IN S_ZMATNR

        AND ZJDATE   IN S_ZJDATE

        AND ZSALE_FG IN R_FG. "####

  ELSEIF P_R2 = C_X. " ##

    SELECT * FROM ZEDT25_101

      INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY

      WHERE ZORDNO   IN S_ZORDNO

        AND ZIDCODE  IN S_ZID

        AND ZMATNR   IN S_ZMATNR

        AND ZDDATE   IN S_ZDDATE

        AND ZFLAG    IN R_ZG. " ####

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

  IF P_R1 = C_X.

    LOOP AT GT_ORDER INTO GS_ORDER.

      CLEAR GS_ORDRE.

      MOVE-CORRESPONDING GS_ORDER TO GS_ORDRE.



      " #####

      CASE GS_ORDER-ZSALE_FG.

        WHEN '1'. GS_ORDRE-ZSALE_NAME = '##'.

        WHEN '2'. GS_ORDRE-ZSALE_NAME = '##'.

      ENDCASE.



      " #####

      CASE GS_ORDER-ZMTART.

        WHEN '001'. GS_ORDRE-ZMAT_NAME = '##'.

        WHEN '002'. GS_ORDRE-ZMAT_NAME = '##'.

        WHEN '003'. GS_ORDRE-ZMAT_NAME = '##'.

        WHEN '004'. GS_ORDRE-ZMAT_NAME = '##'.

        WHEN '005'. GS_ORDRE-ZMAT_NAME = '##'.

        WHEN '006'. GS_ORDRE-ZMAT_NAME = '###'.

      ENDCASE.



      " ####

      IF P_CH1 = C_X.

        CASE GS_ORDER-ZRET_FG.

          WHEN '1'. GS_ORDRE-ZRET_NAME = '####'.

          WHEN '2'. GS_ORDRE-ZRET_NAME = '####'.

          WHEN '3'. GS_ORDRE-ZRET_NAME = '####'.

        ENDCASE.

      ENDIF.



      " ## ##(# ###)

      GS_ORDRE-SALEAMT1 = GS_ORDER-ZNSAMT * 100.

      GS_ORDRE-SALESALEAMT2 = GS_ORDER-ZSLAMT * 100.

      GS_ORDRE-SALEAMT3 = GS_ORDER-ZDCAMT * 100.



      " #### ##




*      IF GS_ORDER-ZRDATE IS NOT INITIAL.

*        WRITE GS_ORDER-ZRDATE TO GS_ORDRE-ZDATE

*          USING EDIT MASK '____.__.__'.

*      ENDIF.






      IF GS_ORDER-ZRDATE IS INITIAL.

      ELSE.

        CONCATENATE GS_ORDER-ZRDATE+0(4) '.' GS_ORDER-ZRDATE+4(2) '.' GS_ORDER-ZRDATE+6(2)

        INTO GS_ORDRE-ZDATE.

      ENDIF.



      APPEND GS_ORDRE TO GT_ORDRE.

      CLEAR : GS_ORDER, GS_ORDRE.



    ENDLOOP.



  ELSEIF P_R2 = C_X.

    LOOP AT GT_DELIVERY INTO GS_DELIVERY.

      CLEAR GS_DELRE.

       MOVE-CORRESPONDING GS_DELIVERY TO GS_DELRE.



      " #####

      CASE GS_DELIVERY-ZMTART.

        WHEN '001'. GS_DELRE-ZMAT_NAME = '##'.

        WHEN '002'. GS_DELRE-ZMAT_NAME = '##'.

        WHEN '003'. GS_DELRE-ZMAT_NAME = '##'.

        WHEN '004'. GS_DELRE-ZMAT_NAME = '##'.

        WHEN '005'. GS_DELRE-ZMAT_NAME = '##'.

        WHEN '006'. GS_DELRE-ZMAT_NAME = '###'.

      ENDCASE.



      " ####

      CASE GS_DELIVERY-ZDFLAG.

        WHEN '1'. GS_DELRE-ZDFLAG_NAME = '####'.

        WHEN '2'. GS_DELRE-ZDFLAG_NAME = '####'.

      ENDCASE.



      " ####

      CASE GS_DELIVERY-ZDGUBUN.

        WHEN '1'. GS_DELRE-ZDGUBUN_NAME = '###'.

        WHEN '2'. GS_DELRE-ZDGUBUN_NAME = '###'.

        WHEN '3'. GS_DELRE-ZDGUBUN_NAME = '###'.

        WHEN '4'. GS_DELRE-ZDGUBUN_NAME = '###'.

        WHEN '5'. GS_DELRE-ZDGUBUN_NAME = '###'.

        WHEN '6'. GS_DELRE-ZDGUBUN_NAME = '###'.

        WHEN '7'. GS_DELRE-ZDGUBUN_NAME = '###'.

      ENDCASE.



      GS_DELRE-SALEAMT2 = GS_DELIVERY-ZSLAMT * 100.






*      IF GS_DELIVERY-ZRDATE IS NOT INITIAL.

*        WRITE GS_DELIVERY-ZRDATE TO GS_DELRE-ZDATE

*          USING EDIT MASK '____.__.__'.

*      ENDIF.

*

*      APPEND GS_DELRE TO GT_DELRE.






      IF GS_DELIVERY-ZRDATE IS INITIAL.

      ELSE.

        CONCATENATE GS_DELIVERY-ZRDATE+0(4) '.' GS_DELIVERY-ZRDATE+4(2) '.' GS_DELIVERY-ZRDATE+6(2)

        INTO GS_DELRE-ZDATE.

      ENDIF.



      APPEND GS_DELRE TO GT_DELRE.

      CLEAR : GS_DELIVERY , GS_DELRE.

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

   IF P_R1 = C_X.

    LOOP AT GT_ORDRE INTO GS_ORDRE.

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

        WRITE :/ '|', GS_ORDRE-ZORDNO, '|', GS_ORDRE-ZIDCODE, '|', GS_ORDRE-ZMATNR, '|', GS_ORDRE-ZMATNAME, '|', GS_ORDRE-ZMAT_NAME, '|',

                   GS_ORDRE-ZVOLUM, '|', GS_ORDRE-VRKME, '|', GS_ORDRE-SALEAMT1, '|', GS_ORDRE-SALESALEAMT2, '|', GS_ORDRE-SALEAMT3, '|',

                   GS_ORDRE-ZSALE_NAME, '|', GS_ORDRE-ZJDATE, '|', GS_ORDRE-ZRET_NAME, '|', GS_ORDRE-ZDATE, '|'.

        WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.

        WRITE :/ '|', GS_ORDRE-ZORDNO, '|', GS_ORDRE-ZIDCODE, '|', GS_ORDRE-ZMATNAME, '|', GS_ORDRE-ZMATNAME, '|', GS_ORDRE-ZMAT_NAME, '|',

                   GS_ORDRE-ZVOLUM, '|', GS_ORDRE-VRKME, '|', GS_ORDRE-SALEAMT1, '|', GS_ORDRE-SALESALEAMT2, '|', GS_ORDRE-SALEAMT3, '|',

                   GS_ORDRE-ZSALE_NAME, '|', GS_ORDRE-ZJDATE, '|'.

        WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDLOOP.



  ELSEIF P_R2 = C_X.

    LOOP AT GT_DELRE INTO GS_DELRE.

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

        WRITE :/ '|', GS_DELRE-ZORDNO, '|', GS_DELRE-ZIDCODE, '|', GS_DELRE-ZMATNR, '|', GS_DELRE-ZMATNAME, '|', GS_DELRE-ZMAT_NAME, '|',

                   GS_DELRE-ZVOLUM, '|', GS_DELRE-VRKME, '|', GS_DELRE-SALEAMT2, '|', GS_DELRE-ZDFLAG_NAME, '|',

                   GS_DELRE-ZDGUBUN_NAME, '|', GS_DELRE-ZDDATE, '|', GS_DELRE-ZDATE, '|'.

        WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.

        WRITE :/ '|', GS_DELRE-ZORDNO, '|', GS_DELRE-ZIDCODE, '|', GS_DELRE-ZMATNR, '|', GS_DELRE-ZMATNAME, '|', GS_DELRE-ZMAT_NAME, '|',

                   GS_DELRE-ZVOLUM, '|', GS_DELRE-VRKME, '|', GS_DELRE-SALEAMT2, '|', GS_DELRE-ZDFLAG_NAME, '|',

                   GS_DELRE-ZDGUBUN_NAME, '|', GS_DELRE-ZDDATE, '|'.

        WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDLOOP.

  ENDIF.

ENDFORM.