
"&---------------------------------------------------------------------*

"& Report ZEDR022_PRACTICE003

"&---------------------------------------------------------------------*

"&

"&---------------------------------------------------------------------*

REPORT ZEDR022_PRACTICE003.






*===============================================================*

* ###/## ###

*===============================================================*




TABLES : ZEDT022_100."####

TABLES : ZEDT022_101."####






* ## ## ##




CONSTANTS :

  C_X        TYPE CHAR1 VALUE 'X',

  C_SPACE    TYPE CHAR1 VALUE ' ',

  C_EQ       TYPE CHAR2 VALUE 'EQ',

  C_BT       TYPE CHAR2 VALUE 'BT',

  C_RATE_KRW TYPE I VALUE 100. "## ## ##






* RANGE ## : #### ##




RANGES : R_ZFLAG FOR ZEDT022_101-ZFLAG.






* #### ### ######




  DATA : BEGIN OF GS_ORDER_PRINT, "#####

    ZORDNO LIKE ZEDT022_100-ZORDNO, "####

    ZIDCODE LIKE ZEDT022_100-ZIDCODE, "##ID

    ZMATNR LIKE ZEDT022_100-ZMATNR, "####

    ZMATNAME LIKE ZEDT022_100-ZMATNAME, "###

    ZMAT_NAME TYPE C LENGTH 8, "#####

    ZVOLUM LIKE ZEDT022_100-ZVOLUM, "##

    VRKME LIKE ZEDT022_100-VRKME, "##

    ZNSAMT TYPE I, "####

    ZSLAMT TYPE I, "####

    ZDCAMT TYPE I, "####

    ZSALE_NAME TYPE C LENGTH 4, " ##

    ZJDATE LIKE ZEDT022_100-ZJDATE, "####

    ZRET_NAME TYPE C LENGTH 10, "####

    ZRDATE LIKE ZEDT022_100-ZRDATE, "####

  END OF GS_ORDER_PRINT.

  DATA : GT_ORDER_PRINT LIKE TABLE OF GS_ORDER_PRINT.






* #### ### ######




  DATA : BEGIN OF GS_DELIVERY_PRINT,

    ZORDNO LIKE ZEDT022_100-ZORDNO, "####

    ZIDCODE LIKE ZEDT022_100-ZIDCODE, "##ID

    ZMATNR LIKE ZEDT022_100-ZMATNR, "####

    ZMATNAME LIKE ZEDT022_100-ZMATNAME, "###

    ZMAT_NAME TYPE C LENGTH 8, "#####

    ZVOLUM LIKE ZEDT022_100-ZVOLUM, "##

    VRKME LIKE ZEDT022_100-VRKME, "##

    ZSLAMT TYPE I, "####

    ZDFLAG_NAME TYPE C LENGTH 8, "####

    ZDGUBUN_NAME TYPE C LENGTH 6, "####

    ZDDATE LIKE ZEDT022_101-ZDDATE, "####

    ZRDATE LIKE ZEDT022_101-ZRDATE, "####

    ZFLAG LIKE ZEDT022_101-ZFLAG, "ZFLAG# X ##### ##### ##

  END OF GS_DELIVERY_PRINT.

  DATA : GT_DELIVERY_PRINT LIKE TABLE OF GS_DELIVERY_PRINT.






* ### ###### (####, ####)




DATA : GS_ORDER LIKE ZEDT022_100.

DATA : GT_ORDER LIKE TABLE OF GS_ORDER.



DATA : GS_DELIVERY LIKE ZEDT022_101.

DATA : GT_DELIVERY LIKE TABLE OF GS_DELIVERY.








*===============================================================*

* ### ##

*===============================================================*




SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

 SELECT-OPTIONS : S_ZORDNO FOR ZEDT022_100-ZORDNO. "####

 SELECT-OPTIONS : S_ZID FOR ZEDT022_100-ZIDCODE NO INTERVALS NO-EXTENSION. "##ID

 SELECT-OPTIONS : S_ZMATNR FOR ZEDT022_100-ZMATNR. "####

 SELECT-OPTIONS : S_ZJDATE FOR ZEDT022_100-ZJDATE MODIF ID M1. "####

 SELECT-OPTIONS : S_ZDDATE FOR ZEDT022_101-ZDDATE MODIF ID M2. "####

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

 PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. "####

 PARAMETERS : P_R2 RADIOBUTTON GROUP R1. "####

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS : Z_CHECK AS CHECKBOX DEFAULT C_X. "######

SELECTION-SCREEN END OF BLOCK B3.








*===============================================================*

* initialization

*===============================================================*




INITIALIZATION."### ## ##~## #### ##

  DATA : LV_FIRST_DATE TYPE SY-DATUM,"## # 1#

         LV_LAST_DATE TYPE SY-DATUM."### ##



  LV_FIRST_DATE+0(4) = SY-DATUM+0(4)."####

  LV_FIRST_DATE+4(2) = SY-DATUM+4(2)."###

  LV_FIRST_DATE+6(2) = '01'."1# ##



  CALL FUNCTION 'LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN = SY-DATUM

    IMPORTING

      LAST_DAY_OF_MONTH = LV_LAST_DATE.



  S_ZJDATE-SIGN = 'I'."#### ## ##

  S_ZJDATE-OPTION = C_BT.

  S_ZJDATE-LOW = LV_FIRST_DATE.

  S_ZJDATE-HIGH = LV_LAST_DATE.

  APPEND S_ZJDATE.



  S_ZDDATE-SIGN = 'I'."#### ## ##

  S_ZDDATE-OPTION = C_BT.

  S_ZDDATE-LOW = LV_FIRST_DATE.

  S_ZDDATE-HIGH = LV_LAST_DATE.

  APPEND S_ZDDATE.








*===============================================================*

* AT SELECTION-SCREEN OUTPUT

*===============================================================*




AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF P_R1 = C_X. "#### ## #

      IF SCREEN-GROUP1 = 'M1'. SCREEN-ACTIVE = '1'. "#### ###

      ELSEIF SCREEN-GROUP1 = 'M2'. SCREEN-ACTIVE = '0'. "#### ####

      ENDIF.

    ELSE. "#### ## #

      IF SCREEN-GROUP1 = 'M1'. SCREEN-ACTIVE = '0'. "#### ####

      ELSEIF SCREEN-GROUP1 = 'M2'. SCREEN-ACTIVE = '1'. "#### ###

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.






*===============================================================*

* START-OF-SELECTION :

*===============================================================*




START-OF-SELECTION.

  PERFORM SET_FLAG_RANGE.

  PERFORM GET_DATA.

  PERFORM PROCESS_DATA.

  PERFORM WRITE_DATA.








*&---------------------------------------------------------------------*

*&      Form  SET_FLAG_RANGE

*&---------------------------------------------------------------------*




FORM SET_FLAG_RANGE .

  CLEAR : R_ZFLAG.



  R_ZFLAG-SIGN = 'I'.

  R_ZFLAG-OPTION = C_EQ.



  IF Z_CHECK = C_X."## #####

    R_ZFLAG-LOW = C_X.     APPEND R_ZFLAG."## ### ##

    R_ZFLAG-LOW = C_SPACE. APPEND R_ZFLAG."## ### ##

  ELSE.

    R_ZFLAG-LOW = C_SPACE. APPEND R_ZFLAG."## ##

  ENDIF.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .

  CLEAR : GT_ORDER, GT_DELIVERY.



  IF P_R1 = C_X."####

    SELECT A~*

      INTO CORRESPONDING FIELDS OF TABLE @GT_ORDER

      FROM ZEDT022_100 AS A

      LEFT OUTER JOIN ZEDT022_101 AS B

      ON A~ZORDNO = B~ZORDNO

      WHERE A~ZORDNO IN @S_ZORDNO

        AND A~ZIDCODE IN @S_ZID

        AND A~ZMATNR IN @S_ZMATNR

        AND A~ZJDATE IN @S_ZJDATE

        AND B~ZFLAG IN @R_ZFLAG.

  ELSE."####

    SELECT *

      INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY

      FROM ZEDT022_101

      WHERE ZORDNO IN S_ZORDNO

        AND ZIDCODE IN S_ZID

        AND ZMATNR IN S_ZMATNR

        AND ZDDATE IN S_ZDDATE

        AND ZFLAG IN R_ZFLAG.

  ENDIF.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  PROCESS_DATA

*&---------------------------------------------------------------------*




FORM PROCESS_DATA .

  IF P_R1 = C_X."####

    LOOP AT GT_ORDER INTO GS_ORDER.

      MOVE-CORRESPONDING GS_ORDER TO GS_ORDER_PRINT.



      CASE GS_ORDER-ZMTART.

        WHEN '001'. GS_ORDER_PRINT-ZMAT_NAME = '##'.

        WHEN '002'. GS_ORDER_PRINT-ZMAT_NAME = '##'.

        WHEN '003'. GS_ORDER_PRINT-ZMAT_NAME = '##'.

        WHEN '004'. GS_ORDER_PRINT-ZMAT_NAME = '##'.

        WHEN '005'. GS_ORDER_PRINT-ZMAT_NAME = '##'.

        WHEN '006'. GS_ORDER_PRINT-ZMAT_NAME = '###'.

      ENDCASE.



      CASE GS_ORDER-ZSALE_FG.

        WHEN '1'. GS_ORDER_PRINT-ZSALE_NAME = '##'.

        WHEN '2'. GS_ORDER_PRINT-ZSALE_NAME = '##'.

      ENDCASE.



      CASE GS_ORDER-ZRET_FG.

        WHEN '1'. GS_ORDER_PRINT-ZRET_NAME = '####'.

        WHEN '2'. GS_ORDER_PRINT-ZRET_NAME = '####'.

        WHEN '3'. GS_ORDER_PRINT-ZRET_NAME = '####'.

        WHEN OTHERS. CLEAR GS_ORDER_PRINT-ZRET_NAME.

      ENDCASE.



      GS_ORDER_PRINT-ZNSAMT = GS_ORDER-ZNSAMT * C_RATE_KRW."####

      GS_ORDER_PRINT-ZSLAMT = GS_ORDER-ZSLAMT * C_RATE_KRW.

      GS_ORDER_PRINT-ZDCAMT = GS_ORDER-ZDCAMT * C_RATE_KRW.



      APPEND GS_ORDER_PRINT TO GT_ORDER_PRINT.

    ENDLOOP.



  ELSE."####

    LOOP AT GT_DELIVERY INTO GS_DELIVERY.

      MOVE-CORRESPONDING GS_DELIVERY TO GS_DELIVERY_PRINT.



      CASE GS_DELIVERY-ZMTART.

        WHEN '001'. GS_DELIVERY_PRINT-ZMAT_NAME = '##'.

        WHEN '002'. GS_DELIVERY_PRINT-ZMAT_NAME = '##'.

        WHEN '003'. GS_DELIVERY_PRINT-ZMAT_NAME = '##'.

        WHEN '004'. GS_DELIVERY_PRINT-ZMAT_NAME = '##'.

        WHEN '005'. GS_DELIVERY_PRINT-ZMAT_NAME = '##'.

        WHEN '006'. GS_DELIVERY_PRINT-ZMAT_NAME = '###'.

      ENDCASE.



      CASE GS_DELIVERY-ZDFLAG.

        WHEN '1'. GS_DELIVERY_PRINT-ZDFLAG_NAME = '####'.

        WHEN '2'. GS_DELIVERY_PRINT-ZDFLAG_NAME = '###'.

        "WHEN '3'. GS_DELIVERY_PRINT-ZDFLAG_NAME = '####'.

        WHEN '3'. CLEAR GS_DELIVERY_PRINT-ZDFLAG_NAME.  " ##### ## ##

        WHEN OTHERS. CLEAR GS_DELIVERY_PRINT-ZDFLAG_NAME.

      ENDCASE.



      CASE GS_DELIVERY-ZDGUBUN.

        WHEN '1'. GS_DELIVERY_PRINT-ZDGUBUN_NAME = '###'.

        WHEN '2'. GS_DELIVERY_PRINT-ZDGUBUN_NAME = '###'.

        WHEN '3'. GS_DELIVERY_PRINT-ZDGUBUN_NAME = '###'.

        WHEN '4'. GS_DELIVERY_PRINT-ZDGUBUN_NAME = '###'.

        WHEN '5'. GS_DELIVERY_PRINT-ZDGUBUN_NAME = '###'.

        WHEN '6'. GS_DELIVERY_PRINT-ZDGUBUN_NAME = '###'.

        WHEN '7'. GS_DELIVERY_PRINT-ZDGUBUN_NAME = '###'.

      ENDCASE.



      GS_DELIVERY_PRINT-ZSLAMT = GS_DELIVERY-ZSLAMT * C_RATE_KRW.

      APPEND GS_DELIVERY_PRINT TO GT_DELIVERY_PRINT.

    ENDLOOP.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  WRITE_DATA

*&---------------------------------------------------------------------*




FORM WRITE_DATA .



 DATA : LV_ZRDATE_C TYPE C LENGTH 10."##### ##



 IF P_R1 = C_X."####

    LOOP AT GT_ORDER_PRINT INTO GS_ORDER_PRINT.

      AT FIRST.

        IF Z_CHECK = C_X.

          WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |   ####  |  ####   | ## |  ####  |  ####  |  ####  | '.

          WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |   ####  |  ####   | ## |  ####  | '.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDAT.



      IF GS_ORDER_PRINT-ZRDATE IS INITIAL OR GS_ORDER_PRINT-ZRDATE = '00000000'.

        CLEAR LV_ZRDATE_C.

      ELSE.

        LV_ZRDATE_C = GS_ORDER_PRINT-ZRDATE+0(4) && '.' && GS_ORDER_PRINT-ZRDATE+4(2) && '.' && GS_ORDER_PRINT-ZRDATE+6(2).

      ENDIF.



      IF Z_CHECK = C_X.

        WRITE :/ '|',GS_ORDER_PRINT-ZORDNO,'|',GS_ORDER_PRINT-ZIDCODE,'|',GS_ORDER_PRINT-ZMATNR,'|',GS_ORDER_PRINT-ZMATNAME,'|',GS_ORDER_PRINT-ZMAT_NAME,'|'

                 ,GS_ORDER_PRINT-ZVOLUM,'|',GS_ORDER_PRINT-VRKME,'|',GS_ORDER_PRINT-ZNSAMT,'|',GS_ORDER_PRINT-ZSLAMT,'|'

                 ,GS_ORDER_PRINT-ZDCAMT,'|',GS_ORDER_PRINT-ZSALE_NAME,'|',GS_ORDER_PRINT-ZJDATE,'|',GS_ORDER_PRINT-ZRET_NAME,'|',LV_ZRDATE_C,'|'.

        WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.

        WRITE :/ '|',GS_ORDER_PRINT-ZORDNO,'|',GS_ORDER_PRINT-ZIDCODE,'|',GS_ORDER_PRINT-ZMATNR,'|',GS_ORDER_PRINT-ZMATNAME,'|',GS_ORDER_PRINT-ZMAT_NAME,'|'

                 ,GS_ORDER_PRINT-ZVOLUM,'|',GS_ORDER_PRINT-VRKME,'|',GS_ORDER_PRINT-ZNSAMT,'|',GS_ORDER_PRINT-ZSLAMT,'|'

                 ,GS_ORDER_PRINT-ZDCAMT,'|',GS_ORDER_PRINT-ZSALE_NAME,'|',GS_ORDER_PRINT-ZJDATE,'|'.

        WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDLOOP.



  ELSEIF P_R2 = C_X.

    LOOP AT GT_DELIVERY_PRINT INTO GS_DELIVERY_PRINT.

      AT FIRST.

        IF Z_CHECK = C_X.

          WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   | #### |  ##  |  ####  |  ####  |'.

          WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE.

          WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   | #### |  ##  |  ####  | '.

          WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDAT.



      IF GS_DELIVERY_PRINT-ZRDATE IS INITIAL OR GS_DELIVERY_PRINT-ZRDATE = '00000000'.

        CLEAR LV_ZRDATE_C.

      ELSE.

        LV_ZRDATE_C = GS_DELIVERY_PRINT-ZRDATE+0(4) && '.' && GS_DELIVERY_PRINT-ZRDATE+4(2) && '.' && GS_DELIVERY_PRINT-ZRDATE+6(2).

      ENDIF.



      IF Z_CHECK = C_X.

        WRITE :/ '|',GS_DELIVERY_PRINT-ZORDNO,'|',GS_DELIVERY_PRINT-ZIDCODE,'|',GS_DELIVERY_PRINT-ZMATNR,'|',GS_DELIVERY_PRINT-ZMATNAME,'|',GS_DELIVERY_PRINT-ZMAT_NAME,'|'

                 ,GS_DELIVERY_PRINT-ZVOLUM,'|',GS_DELIVERY_PRINT-VRKME,'|',GS_DELIVERY_PRINT-ZSLAMT,'|',GS_DELIVERY_PRINT-ZDFLAG_NAME,'|'

                 ,GS_DELIVERY_PRINT-ZDGUBUN_NAME,'|',GS_DELIVERY_PRINT-ZDDATE,'|',LV_ZRDATE_C,'|'.

        WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.

        WRITE :/ '|',GS_DELIVERY_PRINT-ZORDNO,'|',GS_DELIVERY_PRINT-ZIDCODE,'|',GS_DELIVERY_PRINT-ZMATNR,'|',GS_DELIVERY_PRINT-ZMATNAME,'|',GS_DELIVERY_PRINT-ZMAT_NAME,'|'

          ,GS_DELIVERY_PRINT-ZVOLUM,'|',GS_DELIVERY_PRINT-VRKME,'|',GS_DELIVERY_PRINT-ZSLAMT,'|',GS_DELIVERY_PRINT-ZDFLAG_NAME,'|'

          ,GS_DELIVERY_PRINT-ZDGUBUN_NAME,'|',GS_DELIVERY_PRINT-ZDDATE,'|'.

        WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDLOOP.

  ENDIF.

ENDFORM.