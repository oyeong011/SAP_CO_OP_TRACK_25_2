
REPORT ZEDR21_PRACTICE003.



"------------------------------------------------------------

" 1. ### ###

"------------------------------------------------------------

TABLES : ZEDT21_100, ZEDT21_101.   " ## ###, ## ### ##



"------------------------------------------------------------

" ## ## (## ## #### ##, MODIF ID 3## ##)

"------------------------------------------------------------

CONSTANTS :

  "=== ## Flag ===

  FLAG_ON   TYPE CHAR1 VALUE 'X',   " ###(####, ##### ON)

  FLAG_OFF  TYPE CHAR1 VALUE '0',   " ###/False



  "=== ## ## (##/##/## ##) ===

  STATE_1   TYPE CHAR1 VALUE '1',   " ##

  STATE_2   TYPE CHAR1 VALUE '2',   " ##

  STATE_3   TYPE CHAR1 VALUE '3',   " ## ##

  STATE_4   TYPE CHAR1 VALUE '4',

  STATE_5   TYPE CHAR1 VALUE '5',

  STATE_6   TYPE CHAR1 VALUE '6',

  STATE_7   TYPE CHAR1 VALUE '7',



  "=== ## ## ## (## ## #) ===

  DAY_01    TYPE CHAR2 VALUE '01',  " 1#

  DAY_02    TYPE CHAR2 VALUE '02',

  DAY_03    TYPE CHAR2 VALUE '03',

  DAY_04    TYPE CHAR2 VALUE '04',

  DAY_05    TYPE CHAR2 VALUE '05',

  DAY_06    TYPE CHAR2 VALUE '06',

  DAY_07    TYPE CHAR2 VALUE '07',

  DAY_08    TYPE CHAR2 VALUE '08',

  DAY_09    TYPE CHAR2 VALUE '09',

  DAY_10    TYPE CHAR2 VALUE '10',

  DAY_11    TYPE CHAR2 VALUE '11',

  DAY_12    TYPE CHAR2 VALUE '12',

  DAY_28    TYPE CHAR2 VALUE '28',  " 2# (## ## X)

  DAY_30    TYPE CHAR2 VALUE '30',

  DAY_31    TYPE CHAR2 VALUE '31',



  "=== Selection-Screen Group ID (3##) ===

  GROUP_ORDER TYPE CHAR3 VALUE 'ORD',   " #### ##

  GROUP_DELIV TYPE CHAR3 VALUE 'DLV',   " #### ##



  "=== ## ## ## (001~006) ===

  TYPE_FOOD    TYPE CHAR3 VALUE '001', " ##

  TYPE_GOODS   TYPE CHAR3 VALUE '002', " ##

  TYPE_PRODUCT TYPE CHAR3 VALUE '003', " ##

  TYPE_CLOTH   TYPE CHAR3 VALUE '004', " ##

  TYPE_BOOK    TYPE CHAR3 VALUE '005', " ##

  TYPE_SERVICE TYPE CHAR3 VALUE '006'. " ###



"------------------------------------------------------------

" ## ## ##

"------------------------------------------------------------

RANGES : R_FG FOR ZEDT21_100-ZSALE_FG,

         R_ZG FOR ZEDT21_101-ZFLAG21.



"------------------------------------------------------------

" #### ITAB ##

"------------------------------------------------------------

DATA : BEGIN OF GS_ORDER,

  ZORDNO    LIKE ZEDT21_100-ZORDNO,

  ZIDCODE   LIKE ZEDT21_100-ZIDCODE,

  ZMATNR    LIKE ZEDT21_100-ZMATNR,

  ZMTART    LIKE ZEDT21_100-ZMTART,

  ZMATNAME  LIKE ZEDT21_100-ZMATNAME,

  ZVOLUM    LIKE ZEDT21_100-ZVOLUM,

  VRKME       LIKE ZEDT21_100-VRKME,

  ZNSAMT    LIKE ZEDT21_100-ZNSAMT,

  ZSLAMT    LIKE ZEDT21_100-ZSLAMT,

  ZDCAMT    LIKE ZEDT21_100-ZDCAMT,

  ZSALE_FG LIKE ZEDT21_100-ZSALE_FG,

  ZRET_FG   LIKE ZEDT21_100-ZRET_FG,

  ZJDATE    LIKE ZEDT21_100-ZJDATE,

  ZRDATE    LIKE ZEDT21_100-ZRDATE,

END OF GS_ORDER.

DATA : GT_ORDER LIKE TABLE OF GS_ORDER.



DATA : BEGIN OF GS_0100, "### ####

  ZORDNO   LIKE ZEDT21_100-ZORDNO,

  ZIDCODE  LIKE ZEDT21_100-ZIDCODE,

  ZMATNR   LIKE ZEDT21_100-ZMATNR,

  ZMATNAME LIKE ZEDT21_100-ZMATNAME,

  ZMAT_NAME  TYPE C LENGTH 8,

  ZVOLUM   LIKE ZEDT21_100-ZVOLUM,

  VRKME      LIKE ZEDT21_100-VRKME,

  AMT1 TYPE I,

  AMT2 TYPE I,

  AMT3 TYPE I,

  ZSALE_NAME TYPE C LENGTH 4,

  ZJDATE   LIKE ZEDT21_100-ZJDATE,

  ZRET_NAME  TYPE C LENGTH 10,

  ZDATE(10),

END OF GS_0100.

DATA : GT_0100 LIKE TABLE OF GS_0100.



" #### ITAB

DATA : BEGIN OF GS_DELIVERY,

  ZORDNO21   LIKE ZEDT21_101-ZORDNO21,

  ZIDCODE21  LIKE ZEDT21_101-ZIDCODE21,

  ZMATNR21   LIKE ZEDT21_101-ZMATNR21,

  ZMTART21   LIKE ZEDT21_101-ZMTART21,

  ZMATNAME21 LIKE ZEDT21_101-ZMATNAME21,

  ZVOLUM21   LIKE ZEDT21_101-ZVOLUM21,

  VRKME      LIKE ZEDT21_101-VRKME,

  ZSLAMT21   LIKE ZEDT21_101-ZSLAMT21,

  ZDFLAG21   LIKE ZEDT21_101-ZDFLAG21,

  ZDGUBUN21  LIKE ZEDT21_101-ZDGUBUN21,

  ZDDATE21   LIKE ZEDT21_101-ZDDATE21,

  ZRDATE21   LIKE ZEDT21_101-ZRDATE21,

  ZFLAG21    LIKE ZEDT21_101-ZFLAG21,

END OF GS_DELIVERY.

DATA : GT_DELIVERY LIKE TABLE OF GS_DELIVERY.



DATA : BEGIN OF GS_0200, "### ####

  ZORDNO21   LIKE ZEDT21_101-ZORDNO21,

  ZIDCODE21  LIKE ZEDT21_101-ZIDCODE21,

  ZMATNR21   LIKE ZEDT21_101-ZMATNR21,

  ZMATNAME21 LIKE ZEDT21_101-ZMATNAME21,

  ZMAT_NAME  TYPE C LENGTH 8,

  ZVOLUM21   LIKE ZEDT21_101-ZVOLUM21,

  VRKME      LIKE ZEDT21_101-VRKME,

  AMT2 TYPE I,

  ZDFLAG_NAME TYPE C LENGTH 8,

  ZDGUBUN_NAME TYPE C LENGTH 6,

  ZDDATE21   LIKE ZEDT21_101-ZDDATE21,

  ZDATE(10),

  ZFLAG21    LIKE ZEDT21_101-ZFLAG21,

END OF GS_0200.

DATA : GT_0200 LIKE TABLE OF GS_0200.



"------------------------------------------------------------

" Selection-Screen

"------------------------------------------------------------

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

 SELECT-OPTIONS : S_ZORDNO FOR ZEDT21_100-ZORDNO,

                  S_ZID    FOR ZEDT21_100-ZIDCODE NO INTERVALS NO-EXTENSION,

                  S_ZMATNR FOR ZEDT21_100-ZMATNR,

                  S_ZJDATE FOR ZEDT21_100-ZJDATE MODIF ID ORD,

                  S_ZDDATE FOR ZEDT21_101-ZDDATE21 MODIF ID DLV.

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

 PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1,

              P_R2 RADIOBUTTON GROUP R1.

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

 PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X'.

SELECTION-SCREEN END OF BLOCK B3.



"------------------------------------------------------------

" ### ##

"------------------------------------------------------------

INITIALIZATION.

  PERFORM ZJDATE_INIT_.

  PERFORM ZDDATE_INIT_.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_SETTING.



START-OF-SELECTION.

  PERFORM CHECKBOX_INIT.

  PERFORM SELECT_DATA.

  PERFORM MODIFY_DATA.

  PERFORM WRITE_DATA.






*---------------------------------------------------------------------*

*   #### ###

*---------------------------------------------------------------------*




FORM ZJDATE_INIT_ .

  S_ZJDATE-LOW = SY-DATUM(6) && DAY_01.

  IF SY-DATUM+4(2) = DAY_01 OR SY-DATUM+4(2) = DAY_03 OR SY-DATUM+4(2) = DAY_05

   OR SY-DATUM+4(2) = DAY_07 OR SY-DATUM+4(2) = DAY_08 OR SY-DATUM+4(2) = DAY_10

   OR SY-DATUM+4(2) = DAY_12.

    S_ZJDATE-HIGH = SY-DATUM(6) && DAY_31.

  ELSEIF SY-DATUM+4(2) = DAY_02.

    S_ZJDATE-HIGH = SY-DATUM(6) && DAY_28.

  ELSE.

    S_ZJDATE-HIGH = SY-DATUM(6) && DAY_30.

  ENDIF.

  S_ZJDATE-SIGN = 'I'.

  S_ZJDATE-OPTION = 'BT'.

  APPEND S_ZJDATE.

ENDFORM.






*---------------------------------------------------------------------*

*   #### ###

*---------------------------------------------------------------------*




FORM ZDDATE_INIT_ .

  S_ZDDATE-LOW = SY-DATUM(6) && DAY_01.

  IF SY-DATUM+4(2) = DAY_01 OR SY-DATUM+4(2) = DAY_03 OR SY-DATUM+4(2) = DAY_05

   OR SY-DATUM+4(2) = DAY_07 OR SY-DATUM+4(2) = DAY_08 OR SY-DATUM+4(2) = DAY_10

   OR SY-DATUM+4(2) = DAY_12.

    S_ZDDATE-HIGH = SY-DATUM(6) && DAY_31.

  ELSEIF SY-DATUM+4(2) = DAY_02.

    S_ZDDATE-HIGH = SY-DATUM(6) && DAY_28.

  ELSE.

    S_ZDDATE-HIGH = SY-DATUM(6) && DAY_30.

  ENDIF.

  S_ZDDATE-SIGN = 'I'.

  S_ZDDATE-OPTION = 'BT'.

  APPEND S_ZDDATE.

ENDFORM.






*---------------------------------------------------------------------*

*   ## ##

*---------------------------------------------------------------------*




FORM SCREEN_SETTING .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = GROUP_DELIV.

      IF P_R1 = FLAG_ON.

        SCREEN-ACTIVE = FLAG_OFF.

      ELSE.

        SCREEN-ACTIVE = STATE_1.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = GROUP_ORDER.

      IF P_R1 = FLAG_ON.

        SCREEN-ACTIVE = STATE_1.

      ELSE.

        SCREEN-ACTIVE = FLAG_OFF.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.






*---------------------------------------------------------------------*

*   #### Range ##

*---------------------------------------------------------------------*




FORM CHECKBOX_INIT .



  IF P_R1 = FLAG_ON.

    R_FG-SIGN = 'I'. R_FG-OPTION = 'EQ'.

    R_FG-LOW = STATE_1. APPEND R_FG.

    IF P_CH1 = FLAG_ON. R_FG-LOW = STATE_2. APPEND R_FG. ENDIF.

  ELSE.

    R_ZG-SIGN = 'I'. R_ZG-OPTION = 'EQ'.

    R_ZG-LOW = space. APPEND R_ZG.

    IF P_CH1 = FLAG_ON. R_ZG-LOW = FLAG_ON. APPEND R_ZG. ENDIF.

  ENDIF.



ENDFORM.








*---------------------------------------------------------------------*

*   ### SELECT

*---------------------------------------------------------------------*




FORM SELECT_DATA .

  IF P_R1 = FLAG_ON.

    SELECT * FROM ZEDT21_100

      INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

      WHERE ZORDNO  IN S_ZORDNO

        AND ZIDCODE IN S_ZID

        AND ZMATNR  IN S_ZMATNR

        AND ZJDATE

        IN S_ZJDATE

        AND ZSALE_FG IN R_FG.

  ELSE.

    SELECT * FROM ZEDT21_101

      INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY

      WHERE ZORDNO21   IN S_ZORDNO

        AND ZIDCODE21 IN S_ZID

        AND ZMATNR21  IN S_ZMATNR

        AND ZDDATE21  IN S_ZDDATE

        AND ZFLAG21   IN R_ZG.

  ENDIF.

ENDFORM.






*---------------------------------------------------------------------*

*   ### ##

*---------------------------------------------------------------------*




FORM MODIFY_DATA .





  LOOP AT GT_ORDER INTO GS_ORDER.

    CLEAR GS_0100. MOVE-CORRESPONDING GS_ORDER TO GS_0100.

    CASE GS_ORDER-ZSALE_FG.

      WHEN STATE_1. GS_0100-ZSALE_NAME = '##'.

      WHEN STATE_2. GS_0100-ZSALE_NAME = '##'.

    ENDCASE.

    CASE GS_ORDER-ZMTART.

      WHEN TYPE_FOOD.    GS_0100-ZMAT_NAME = '##'.

      WHEN TYPE_GOODS.   GS_0100-ZMAT_NAME = '##'.

      WHEN TYPE_PRODUCT. GS_0100-ZMAT_NAME = '##'.

      WHEN TYPE_CLOTH.   GS_0100-ZMAT_NAME = '##'.

      WHEN TYPE_BOOK.    GS_0100-ZMAT_NAME = '##'.

      WHEN TYPE_SERVICE. GS_0100-ZMAT_NAME = '###'.

    ENDCASE.

    IF P_CH1 = FLAG_ON.

      CASE GS_ORDER-ZRET_FG.

        WHEN STATE_1. GS_0100-ZRET_NAME = '####'.

        WHEN STATE_2. GS_0100-ZRET_NAME = '####'.

        WHEN STATE_3. GS_0100-ZRET_NAME = '####'.

      ENDCASE.

    ENDIF.

    GS_0100-AMT1 = GS_ORDER-ZNSAMT * 100.

    GS_0100-AMT2 = GS_ORDER-ZSLAMT * 100.

    GS_0100-AMT3 = GS_ORDER-ZDCAMT * 100.

    IF GS_ORDER-ZRDATE IS NOT INITIAL.

      CONCATENATE GS_ORDER-ZRDATE+0(4) '.'

                  GS_ORDER-ZRDATE+4(2) '.'

                  GS_ORDER-ZRDATE+6(2)

             INTO GS_0100-ZDATE.

    ENDIF.

    APPEND GS_0100 TO GT_0100.

  ENDLOOP.



  LOOP AT GT_DELIVERY INTO GS_DELIVERY.

    CLEAR GS_0200. MOVE-CORRESPONDING GS_DELIVERY TO GS_0200.

    CASE GS_DELIVERY-ZMTART21.

      WHEN TYPE_FOOD.    GS_0200-ZMAT_NAME = '##'.

      WHEN TYPE_GOODS.   GS_0200-ZMAT_NAME = '##'.

      WHEN TYPE_PRODUCT. GS_0200-ZMAT_NAME = '##'.

      WHEN TYPE_CLOTH.   GS_0200-ZMAT_NAME = '##'.

      WHEN TYPE_BOOK.    GS_0200-ZMAT_NAME = '##'.

      WHEN TYPE_SERVICE. GS_0200-ZMAT_NAME = '###'.

    ENDCASE.

    CASE GS_DELIVERY-ZDFLAG21.

      WHEN STATE_1. GS_0200-ZDFLAG_NAME = '####'.

      WHEN STATE_2. GS_0200-ZDFLAG_NAME = '###'.

      WHEN STATE_3. GS_0200-ZDFLAG_NAME = '####'.

    ENDCASE.

    CASE GS_DELIVERY-ZDGUBUN21.

      WHEN STATE_1. GS_0200-ZDGUBUN_NAME = '###'.

      WHEN STATE_2. GS_0200-ZDGUBUN_NAME = '###'.

      WHEN STATE_3. GS_0200-ZDGUBUN_NAME = '###'.

      WHEN STATE_4. GS_0200-ZDGUBUN_NAME = '###'.

      WHEN STATE_5. GS_0200-ZDGUBUN_NAME = '###'.

      WHEN STATE_6. GS_0200-ZDGUBUN_NAME = '###'.

      WHEN STATE_7. GS_0200-ZDGUBUN_NAME = '###'.

    ENDCASE.

    GS_0200-AMT2 = GS_DELIVERY-ZSLAMT21 * 100.

    IF GS_DELIVERY-ZRDATE21 IS NOT INITIAL.

      CONCATENATE GS_DELIVERY-ZRDATE21+0(4) '.'

                  GS_DELIVERY-ZRDATE21+4(2) '.'

                  GS_DELIVERY-ZRDATE21+6(2)

             INTO GS_0200-ZDATE.

    ENDIF.

    APPEND GS_0200 TO GT_0200.

  ENDLOOP.

ENDFORM.










*---------------------------------------------------------------------*

*   ## ##

*---------------------------------------------------------------------*




FORM WRITE_DATA .

  IF P_R1 = FLAG_ON. " ####

    LOOP AT GT_0100 INTO GS_0100.

      AT FIRST.

        IF P_CH1 = FLAG_ON.

          WRITE: / '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE: / '| ####   | ID         | ####   | ###               |   ##   | ##| ##| ####    | ####    |  ####   | ## | ####   | ####   | ####   |'.

          WRITE: / '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE.

          WRITE: / '----------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE: / '| ####   | ID         | ####   | ###               |   ##   | ##| ##| ####    | ####    |  ####   | ## | ####   |'.

          WRITE: / '----------------------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDAT.

      IF P_CH1 = FLAG_ON.



        WRITE: / '|', GS_0100-ZORDNO UNDER '####',

                 '|', GS_0100-ZIDCODE UNDER 'ID',

                 '|', GS_0100-ZMATNR  UNDER '####',

                 '|', GS_0100-ZMATNAME UNDER '###',

                 '|', GS_0100-ZMAT_NAME UNDER '##',

                 '|', GS_0100-ZVOLUM  UNDER '##',

                 '|', GS_0100-VRKME     UNDER '##',

                 '|', GS_0100-AMT1      UNDER '####',

                 '|', GS_0100-AMT2      UNDER '####',

                 '|', GS_0100-AMT3      UNDER '####',

                 '|', GS_0100-ZSALE_NAME UNDER '##',

                 '|', GS_0100-ZJDATE  UNDER '####',

                 '|', GS_0100-ZRET_NAME UNDER '####',

                 '|', GS_0100-ZDATE     UNDER '####','|'.

        WRITE: / '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.

        WRITE: / '|', GS_0100-ZORDNO UNDER '####',

                 '|', GS_0100-ZIDCODE UNDER 'ID',

                 '|', GS_0100-ZMATNR  UNDER '####',

                 '|', GS_0100-ZMATNAME UNDER '###',

                 '|', GS_0100-ZMAT_NAME UNDER '##',

                 '|', GS_0100-ZVOLUM  UNDER '##',

                 '|', GS_0100-VRKME     UNDER '##',

                 '|', GS_0100-AMT1      UNDER '####',

                 '|', GS_0100-AMT2      UNDER '####',

                 '|', GS_0100-AMT3      UNDER '####',

                 '|', GS_0100-ZSALE_NAME UNDER '##',

                 '|', GS_0100-ZJDATE  UNDER '####','|'.

        WRITE: / '----------------------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDLOOP.

  ELSEIF P_R2 = FLAG_ON. " ####

    LOOP AT GT_0200 INTO GS_0200.

      AT FIRST.

        IF P_CH1 = FLAG_ON.

          WRITE: / '--------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE: / '| ####   | ID         | ####   | ###               |   ##   | ##| ##| ####    | #### | ##   | ####   | ####   |'.

          WRITE: / '--------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE.

          WRITE: / '-------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE: / '| ####   | ID         | ####   | ###               |   ##   | ##| ##| ####    | #### | ##   | ####   |'.

          WRITE: / '-------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDAT.

      IF P_CH1 = FLAG_ON.

        WRITE: / '|', GS_0200-ZORDNO21 UNDER '####',

                 '|', GS_0200-ZIDCODE21 UNDER 'ID',

                 '|', GS_0200-ZMATNR21  UNDER '####',

                 '|', GS_0200-ZMATNAME21 UNDER '###',

                 '|', GS_0200-ZMAT_NAME UNDER '##',

                 '|', GS_0200-ZVOLUM21  UNDER '##',

                 '|', GS_0200-VRKME     UNDER '##',

                 '|', GS_0200-AMT2      UNDER '####',

                 '|', GS_0200-ZDFLAG_NAME UNDER '####',

                 '|', GS_0200-ZDGUBUN_NAME UNDER '##',

                 '|', GS_0200-ZDDATE21   UNDER '####',

                 '|', GS_0200-ZDATE      UNDER '####','|'.

        WRITE: / '--------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.

        WRITE: / '|', GS_0200-ZORDNO21 UNDER '####',

                 '|', GS_0200-ZIDCODE21 UNDER 'ID',

                 '|', GS_0200-ZMATNR21  UNDER '####',

                 '|', GS_0200-ZMATNAME21 UNDER '###',

                 '|', GS_0200-ZMAT_NAME UNDER '##',

                 '|', GS_0200-ZVOLUM21  UNDER '##',

                 '|', GS_0200-VRKME     UNDER '##',

                 '|', GS_0200-AMT2      UNDER '####',

                 '|', GS_0200-ZDFLAG_NAME UNDER '####',

                 '|', GS_0200-ZDGUBUN_NAME UNDER '##',

                 '|', GS_0200-ZDDATE21   UNDER '####','|'.

        WRITE: / '-------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDLOOP.

  ENDIF.

ENDFORM.