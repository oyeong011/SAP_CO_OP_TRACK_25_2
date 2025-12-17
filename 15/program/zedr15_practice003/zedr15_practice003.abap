
*&---------------------------------------------------------------------*

*& Report ZEDR15_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR15_PRACTICE003.






*---------------------### # ## ##---------------------

*####, #### ### ####




TABLES : ZEDT15_100.

TABLES : ZEDT15_101.






*## ### ##(X)# ## ## ##




CONSTANTS : C_X VALUE 'X'.

CONSTANTS : C_A VALUE ''.






*## ## ##




RANGES : R_ZFG FOR ZEDT15_101-ZFLAG.








*### # ### ###### ##




DATA : BEGIN OF GS_ORDER. "####

  include structure
ZEDT15_100
.

  DATA : END OF GS_ORDER.



DATA : BEGIN OF GS_ORDEROUT, "#### ###

  ZORDNO LIKE ZEDT15_100-ZORDNO, "####

  ZIDCODE LIKE ZEDT15_100-ZIDCODE, "##ID

  ZMATNR LIKE ZEDT15_100-ZMATNR, "####

  ZMATNAME LIKE ZEDT15_100-ZMATNAME, "###

  ZMAT_NAME TYPE C LENGTH 8, "##### (ZMTART# #### MODIFY)

  ZVOLUM LIKE ZEDT15_100-ZVOLUM, "##

  VRKME LIKE ZEDT15_100-VRKME, "##

  ZNSAMT TYPE I, "####

  ZSLAMT TYPE I, "####

  ZDCAMT TYPE I, "####

  ZSALE_NAME TYPE C LENGTH 4, " ## (#### / ZSALE_FG# #### MODIFY)

  ZJDATE LIKE ZEDT15_100-ZJDATE, "####

  ZRET_NAME TYPE C LENGTH 10, "#### (ZRET_FG# #### MODIFY)

  ZRDATE LIKE ZEDT15_100-ZRDATE, "####

  END OF GS_ORDEROUT.



DATA : BEGIN OF GS_DELIVER.

  include structure
ZEDT15_101
.

  DATA : END OF GS_DELIVER.



DATA : BEGIN OF GS_DELIVEROUT, "###

  ZORDNO LIKE ZEDT15_101-ZORDNO, "####

  ZIDCODE LIKE ZEDT15_101-ZIDCODE, "##ID

  ZMATNR LIKE ZEDT15_101-ZMATNR, "####

  ZMATNAME LIKE ZEDT15_101-ZMATNAME, "###

  ZMAT_NAME TYPE C LENGTH 8, "##### (ZMTART# #### MODIFY)

  ZVOLUM LIKE ZEDT15_101-ZVOLUM, "##

  VRKME LIKE ZEDT15_101-VRKME, "##

  ZSLAMT TYPE I, "####

  ZDFLAG_NAME TYPE C LENGTH 8, "#### (ZDFLAG# #### MODIFY)

  ZDGUBUN_NAME TYPE C LENGTH 6, "#### (ZDGUBUN# #### MODIFY)

  ZDDATE LIKE ZEDT15_101-ZDDATE, "####

  ZRDATE LIKE ZEDT15_101-ZRDATE, "####

  ZFLAG LIKE ZEDT00_101-ZFLAG, "FLAG

  END OF GS_DELIVEROUT.



DATA : GT_ORDER LIKE TABLE OF GS_ORDER.

DATA : GT_DELIVER LIKE TABLE OF GS_DELIVER.

DATA : GT_ORDEROUT LIKE TABLE OF GS_ORDEROUT.

DATA : GT_DELIVEROUT LIKE TABLE OF GS_DELIVEROUT.






*---------------------SELECTION SCREEN ##---------------------




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZORDNO FOR ZEDT15_100-ZORDNO. "####

  SELECT-OPTIONS : S_ZID FOR ZEDT15_100-ZIDCODE NO INTERVALS NO-EXTENSION. "##ID

  SELECT-OPTIONS : S_ZMATNR FOR ZEDT15_100-ZMATNR. "####

  SELECT-OPTIONS : S_ZJDATE FOR ZEDT15_100-ZJDATE MODIF ID M1. "####

  SELECT-OPTIONS : S_ZDDATE FOR ZEDT15_101-ZDDATE MODIF ID M2. "####

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. "####

  PARAMETERS : P_R2 RADIOBUTTON GROUP R1. "####

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X'. "#### ##

SELECTION-SCREEN END OF BLOCK B3.






*---------------------Report event ##---------------------

*### YYYY.MM.DD# #### # -> (T-CODE :SU3)# default## date format(DATFM) ##



*## ### # ## ## # ###




INITIALIZATION.

  PERFORM DATE_INIT. "####/#### default ##






*### layout### ##




AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_CONTROL. "### ### ## ####/#### #####






*#### ### ##




START-OF-SELECTION.

  PERFORM RANGES_CONTROL. "#### ### ## RANGE CONTROL

  PERFORM SELECT_DATA. "### ##

  PERFORM MODIFY_DATA. "### ## (select option# ## ### ##)

  PERFORM WRITE_DATA. "### ##










*&---------------------------------------------------------------------*

*&      Form  DATE_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DATE_INIT .

  DATA : LV_MONTHLAST TYPE SY-DATUM. "### ## ## ######

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS' "## # ### ### ### ####

    EXPORTING "#### ##

      DAY_IN = SY-DATUM

    IMPORTING "### ## ##

      LAST_DAY_OF_MONTH = LV_MONTHLAST.



   "####

   S_ZJDATE-LOW = SY-DATUM(6) && '01'.

   S_ZJDATE-HIGH = LV_MONTHLAST.

   S_ZJDATE-SIGN = 'I'.

   S_ZJDATE-OPTION = 'BT'.

   APPEND S_ZJDATE.



   "####

   S_ZDDATE-LOW = SY-DATUM(6) && '01'.

   S_ZDDATE-HIGH = LV_MONTHLAST.

   S_ZDDATE-SIGN = 'I'.

   S_ZDDATE-OPTION = 'BT'.

   APPEND S_ZDDATE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SCREEN_CONTROL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SCREEN_CONTROL .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = C_X.

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R2 = C_X.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'.

      IF P_R1 = C_X.

        SCREEN-ACTIVE = '0'.

      ELSEIF P_R2 = C_X.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  RANGES_CONTROL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM RANGES_CONTROL .

  R_ZFG-SIGN = 'I'.

  R_ZFG-OPTION = 'EQ'.

  R_ZFG-LOW = ''.

  APPEND R_ZFG.



  IF P_CH1 = C_X.

    R_ZFG-LOW = C_X.

  ENDIF.

  APPEND R_ZFG.



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



 IF P_R1 = C_X.

  " #### ## # ##

      SELECT T1~*

        FROM ZEDT15_100 AS T1

        LEFT OUTER JOIN ZEDT15_101 AS T2

        ON T1~ZORDNO = T2~ZORDNO

        INTO CORRESPONDING FIELDS OF TABLE @GT_ORDER

        WHERE T1~ZIDCODE IN @S_ZID "##### #### #### # ## ##.

        AND T1~ZORDNO IN @S_ZORDNO

        AND T1~ZMATNR IN @S_ZMATNR

        AND T1~ZJDATE IN @S_ZJDATE

        AND T2~ZFLAG IN @R_ZFG .



  ELSEIF P_R2 = C_X.

  " #### ## # ##

      SELECT *

        FROM ZEDT15_101

        INTO CORRESPONDING FIELDS OF TABLE GT_DELIVER

        WHERE ZIDCODE IN S_ZID

        AND ZORDNO IN S_ZORDNO

        AND ZMATNR IN S_ZMATNR

        AND ZDDATE IN S_ZDDATE

        AND ZFLAG IN R_ZFG.



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



IF P_R1 = C_X.



  LOOP AT GT_ORDER INTO GS_ORDER.

    CLEAR : GS_ORDEROUT.

    MOVE-CORRESPONDING GS_ORDER TO GS_ORDEROUT.



    "#####

    CASE GS_ORDER-ZMTART.

      WHEN '001'.

        GS_ORDEROUT-ZMAT_NAME = '##'.

      WHEN '002'.

        GS_ORDEROUT-ZMAT_NAME = '##'.

      WHEN '003'.

        GS_ORDEROUT-ZMAT_NAME = '##'.

      WHEN '004'.

        GS_ORDEROUT-ZMAT_NAME = '##'.

      WHEN '005'.

        GS_ORDEROUT-ZMAT_NAME = '##'.

      WHEN '006'.

        GS_ORDEROUT-ZMAT_NAME = '###'.

      ENDCASE.



    "####, ####, ####

    GS_ORDEROUT-ZNSAMT = GS_ORDER-ZNSAMT * 100.

    GS_ORDEROUT-ZSLAMT = GS_ORDER-ZSLAMT * 100.

    GS_ORDEROUT-ZDCAMT = GS_ORDER-ZDCAMT * 100.



    "##

    CASE GS_ORDER-ZSALE_FG.

      WHEN '1'.

        GS_ORDEROUT-ZSALE_NAME = '##'.

      WHEN '2'.

        GS_ORDEROUT-ZSALE_NAME = '##'.

      ENDCASE.



    "####

    CASE GS_ORDER-ZRET_FG.

      WHEN '1'.

        GS_ORDEROUT-ZRET_NAME = '####'.

      WHEN '2'.

        GS_ORDEROUT-ZRET_NAME = '####'.

      WHEN '3'.

        GS_ORDEROUT-ZRET_NAME = '####'.

      WHEN ''.

        GS_ORDEROUT-ZRET_NAME = ''.

      ENDCASE.



    IF GS_ORDER-ZRDATE IS INITIAL.

      GS_ORDEROUT-ZRDATE = C_A.

    ENDIF.





    APPEND GS_ORDEROUT TO GT_ORDEROUT.

  ENDLOOP.



ELSEIF P_R2 = C_X.

   LOOP AT GT_DELIVER INTO GS_DELIVER.

    CLEAR : GS_DELIVEROUT.

    MOVE-CORRESPONDING GS_DELIVER TO GS_DELIVEROUT.





    "#####

    CASE GS_DELIVER-ZMTART.

      WHEN '001'.

        GS_DELIVEROUT-ZMAT_NAME = '##'.

      WHEN '002'.

        GS_DELIVEROUT-ZMAT_NAME = '##'.

      WHEN '003'.

        GS_DELIVEROUT-ZMAT_NAME = '##'.

      WHEN '004'.

        GS_DELIVEROUT-ZMAT_NAME = '##'.

      WHEN '005'.

        GS_DELIVEROUT-ZMAT_NAME = '##'.

      WHEN '006'.

        GS_DELIVEROUT-ZMAT_NAME = '###'.

      ENDCASE.



    "####, ####, ####

    GS_DELIVEROUT-ZSLAMT = GS_DELIVER-ZSLAMT * 100.





    "####

    CASE GS_DELIVER-ZDFLAG.

      WHEN '1'.

        GS_DELIVEROUT-ZDFLAG_NAME = '####'.

      WHEN '2'.

        GS_DELIVEROUT-ZDFLAG_NAME = '###'.

      WHEN '3'.

        GS_DELIVEROUT-ZDFLAG_NAME = '####'.

      ENDCASE.





    "####

    CASE GS_DELIVER-ZDGUBUN.

      WHEN '1'.

        GS_DELIVEROUT-ZDGUBUN_NAME = '###'.

      WHEN '2'.

        GS_DELIVEROUT-ZDGUBUN_NAME = '###'.

      WHEN '3'.

        GS_DELIVEROUT-ZDGUBUN_NAME = '###'.

      WHEN '4'.

        GS_DELIVEROUT-ZDGUBUN_NAME = '###'.

      WHEN '5'.

        GS_DELIVEROUT-ZDGUBUN_NAME = '###'.

      WHEN '6'.

        GS_DELIVEROUT-ZDGUBUN_NAME = '###'.

      WHEN '7'.

       GS_DELIVEROUT-ZDGUBUN_NAME = '###'.

      ENDCASE.

    APPEND GS_DELIVEROUT TO GT_DELIVEROUT.

  ENDLOOP.



  IF GS_DELIVER-ZRDATE IS INITIAL.

    GS_DELIVEROUT-ZRDATE = C_A.

  ENDIF.



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

  LOOP AT GT_ORDEROUT INTO GS_ORDEROUT.

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

        WRITE :/ '|',GS_ORDEROUT-ZORDNO,

                 '|',GS_ORDEROUT-ZIDCODE,

                 '|',GS_ORDEROUT-ZMATNR,

                 '|',GS_ORDEROUT-ZMATNAME,

                 '|',GS_ORDEROUT-ZMAT_NAME,

                 '|',GS_ORDEROUT-ZVOLUM,

                 '|',GS_ORDEROUT-VRKME,

                 '|',GS_ORDEROUT-ZNSAMT,

                 '|',GS_ORDEROUT-ZSLAMT,

                 '|',GS_ORDEROUT-ZDCAMT,

                 '|',GS_ORDEROUT-ZSALE_NAME,

                 '|',GS_ORDEROUT-ZJDATE,

                 '|',GS_ORDEROUT-ZRET_NAME,

                 '|',GS_ORDEROUT-ZRDATE,

                 '|'.

        WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.



      ELSE.



          WRITE :/ '|',GS_ORDEROUT-ZORDNO,

                   '|',GS_ORDEROUT-ZIDCODE,

                   '|',GS_ORDEROUT-ZMATNR,

                   '|',GS_ORDEROUT-ZMATNAME,

                   '|',GS_ORDEROUT-ZMAT_NAME,

                   '|',GS_ORDEROUT-ZVOLUM,

                   '|',GS_ORDEROUT-VRKME,

                   '|',GS_ORDEROUT-ZNSAMT,

                   '|',GS_ORDEROUT-ZSLAMT,

                   '|',GS_ORDEROUT-ZDCAMT,

                   '|',GS_ORDEROUT-ZSALE_NAME,

                   '|',GS_ORDEROUT-ZJDATE,

                   '|'.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.







      ENDIF.

    ENDLOOP.

 ELSEIF P_R2 = C_X. "####

    LOOP AT GT_DELIVEROUT INTO GS_DELIVEROUT.

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

        WRITE :/ '|',GS_DELIVEROUT-ZORDNO,

                 '|',GS_DELIVEROUT-ZIDCODE,

                 '|',GS_DELIVEROUT-ZMATNR,

                 '|',GS_DELIVEROUT-ZMATNAME,

                 '|',GS_DELIVEROUT-ZMAT_NAME,

                 '|',GS_DELIVEROUT-ZVOLUM,

                 '|',GS_DELIVEROUT-VRKME,

                 '|',GS_DELIVEROUT-ZSLAMT,

                 '|',GS_DELIVEROUT-ZDFLAG_NAME,

                 '|',GS_DELIVEROUT-ZDGUBUN_NAME,

                 '|',GS_DELIVEROUT-ZDDATE,

                 '|',GS_DELIVEROUT-ZRDATE,

                 '|'.

        WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.



          WRITE :/ '|',GS_DELIVEROUT-ZORDNO,

               '|',GS_DELIVEROUT-ZIDCODE,

               '|',GS_DELIVEROUT-ZMATNR,

               '|',GS_DELIVEROUT-ZMATNAME,

               '|',GS_DELIVEROUT-ZMAT_NAME,

               '|' ,GS_DELIVEROUT-ZVOLUM,

               '|',GS_DELIVEROUT-VRKME,

               '|',GS_DELIVEROUT-ZSLAMT,

               '|',GS_DELIVEROUT-ZDFLAG_NAME,

               '|',GS_DELIVEROUT-ZDGUBUN_NAME,

               '|',GS_DELIVEROUT-ZDDATE,

               '|'.

           WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.







      ENDIF.

    ENDLOOP.

  ENDIF.

ENDFORM.