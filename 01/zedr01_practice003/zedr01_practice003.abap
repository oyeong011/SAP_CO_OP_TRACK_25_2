
*&---------------------------------------------------------------------*

*& Report ZEDR01_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR01_PRACTICE003.



TABLES : ZEDT01_100 , ZEDT01_101.



CONSTANTS : C_RATE_KRW   TYPE I VALUE 100.  " #### ## ## ##



DATA : BEGIN OF GS_ORDER.             " ### #### ###

  include structure
ZEDT01_100
.

  DATA : END OF GS_ORDER.

DATA : GT_ORDER LIKE TABLE OF GS_ORDER.



DATA : BEGIN OF GS_DELIVERY.          " ### #### ###

  include structure
ZEDT01_101
.

  DATA : END OF GS_DELIVERY.

DATA : GT_DELIVERY LIKE TABLE OF GS_DELIVERY.



DATA : BEGIN OF GS_WRITE_ORDER,

  ZORDNO LIKE ZEDT01_100-ZORDNO,      "####

  ZIDCODE LIKE ZEDT01_100-ZIDCODE,    "##ID

  ZMATNR LIKE ZEDT01_100-ZMATNR,      "####

  ZMTART TYPE C LENGTH 16,            "####

  ZMATART_NAME LIKE ZEDT01_100-ZMATNAME,"###

  ZVOLUM LIKE ZEDT01_100-ZVOLUM,      "##

  VRKME LIKE ZEDT01_100-VRKME,        "##

  ZNSAMT TYPE P DECIMALS 2 LENGTH 6,  "####

  ZSLAMT TYPE P DECIMALS 2 LENGTH 6,  "####

  ZDCAMT TYPE P DECIMALS 2 LENGTH 6,  "####

  SALES_TYPE TYPE C LENGTH 16,        "##

  ZJDATE TYPE C LENGTH 12,            "####

  ZRET_FG TYPE C LENGTH 12,           "####

  ZRDATE TYPE C LENGTH 12,            "####

  END OF GS_WRITE_ORDER.

DATA : GT_WRITE_ORDER LIKE TABLE OF GS_WRITE_ORDER.



DATA : BEGIN OF GS_WRITE_DELIVERY,

  ZORDNO LIKE ZEDT01_101-ZORDNO,     "####

  ZIDCODE LIKE ZEDT01_101-ZIDCODE,   "##ID

  ZMATNR LIKE ZEDT01_101-ZMATNR,     "####

  ZMTART TYPE C LENGTH 16,           "####

  ZMTART_NAME LIKE ZEDT01_101-ZMATNAME,"###

  ZVOLUM LIKE ZEDT01_101-ZVOLUM,     "##

  VRKME LIKE ZEDT01_101-VRKME,       "##

  ZSLAMT TYPE P DECIMALS 2 LENGTH 6, "####

  ZDFLAG TYPE C LENGTH 14,           "####

  ZDGUBUN TYPE C LENGTH 12,   "##

  ZDDATE TYPE C LENGTH 12,           "####

  ZRDATE TYPE C LENGTH 12,           "####

  END OF GS_WRITE_DELIVERY.

DATA : GT_WRITE_DELIVERY LIKE TABLE OF GS_WRITE_DELIVERY.






*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.                " ### ##

  SELECT-OPTIONS : S_ZORDNO FOR ZEDT01_100-ZORDNO.            " ####

  PARAMETERS : S_ZCODE LIKE ZEDT01_100-ZIDCODE.               " ##ID

  SELECT-OPTIONS : S_ZMATNR FOR ZEDT01_100-ZMATNR.            " ####

  SELECT-OPTIONS : S_ZJDATE FOR ZEDT01_100-ZJDATE MODIF ID M1." #### ( M1 )

  SELECT-OPTIONS : S_ZDDATE FOR ZEDT01_101-ZDDATE MODIF ID M2." #### ( M2 )

SELECTION-SCREEN END OF BLOCK B1.



INITIALIZATION.



PERFORM DATE_CALCULATOR CHANGING S_ZJDATE-LOW    " #### ### : ## ### 1# ## ##

                                 S_ZJDATE-HIGH.



PERFORM DATE_CALCULATOR CHANGING S_ZDDATE-LOW    " #### ### : ## ### 1# ## ##

                                 S_ZDDATE-HIGH.



APPEND S_ZJDATE.                                 " #### ### ##

APPEND S_ZDDATE.                                 " #### ### ##




*&---------------------------------------------------------------------*




START-OF-SELECTION.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.                         " ### ## ##

  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. " #### ### ## ( R1 )

  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.                              " #### ### ## ( R1 )

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.                         " ## ## ##

  PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X'.                          " #### ## ##

SELECTION-SCREEN END OF BLOCK B3.



AT SELECTION-SCREEN OUTPUT.                                           " ### ##

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M2'.                                          " M2## ## (####)

      IF P_R1 = 'X'.                                                  " #### ON

        SCREEN-ACTIVE = '0'.                                          " #### OFF

      ELSEIF P_R2 = 'X'.                                              " #### ON

        SCREEN-ACTIVE = '1'.                                          " #### ON

      ENDIF.

    ENDIF.



    IF SCREEN-GROUP1 = 'M1'.                                          " M1## ## (#### )

      IF P_R1 = 'X'.                                                  " #### ON

        SCREEN-ACTIVE = '1'.                                          " #### OFF

      ELSEIF P_R2 = 'X'.                                              " #### OFF

        SCREEN-ACTIVE = '0'.                                          " #### ON

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.



END-OF-SELECTION.




*&---------------------------------------------------------------------*








IF P_R1 = 'X'.                                                       " ## ## ON

  PERFORM GET_ORDER_DATA.                                            " #### ### ## ### ####

  PERFORM APPEND_ORDER_DATA.                                         " ### ### ### #### ##

  PERFORM WRITE_ORDER_DATA.                                          " ##

ENDIF.



IF P_R2 = 'X'.                                                       " ## ## ON

  PERFORM GET_DELIVERY_DATA.                                         " #### ### ## ### ####

  PERFORM APPEND_DELIVERY_DATA.                                      " ### ### ### #### ##

  PERFORM WRITE_DELIVERY_DATA.                                       " ##

ENDIF.






*&---------------------------------------------------------------------*

*&      Form  DATE_CALCULATOR

*&---------------------------------------------------------------------*

*       ## ## SUBROUTINE

*       ####(SY-DATUM) #### 1## ##### ## ### ##

*       2## ## #### ### ##

*----------------------------------------------------------------------*

*      <--P_S_ZJDATE_LOW  ### 1#

*      <--P_S_ZJDATE_HIGH  ### ##

*----------------------------------------------------------------------*




FORM DATE_CALCULATOR CHANGING P_DATE_LOW TYPE DATS

                               P_DATE_HIGH TYPE DATS.

  DATA: LV_YEAR  TYPE I,             " ## ##

        LV_MONTH TYPE I,             " ## #

        LV_DAY   TYPE C LENGTH 2.    " ## #



  RANGES : LR_30MON FOR LV_MONTH.

  RANGES : LR_31MON FOR LV_MONTH.



  APPEND VALUE #( SIGN = 'I' OPTION = 'EQ' LOW = 4 ) TO LR_30MON.

  APPEND VALUE #( SIGN = 'I' OPTION = 'EQ' LOW = 6 ) TO LR_30MON.

  APPEND VALUE #( SIGN = 'I' OPTION = 'EQ' LOW = 9 ) TO LR_30MON.

  APPEND VALUE #( SIGN = 'I' OPTION = 'EQ' LOW = 10 ) TO LR_30MON.



  APPEND VALUE #( SIGN = 'I' OPTION = 'EQ' LOW = 1 ) TO LR_31MON.

  APPEND VALUE #( SIGN = 'I' OPTION = 'EQ' LOW = 3 ) TO LR_31MON.

  APPEND VALUE #( SIGN = 'I' OPTION = 'EQ' LOW = 5 ) TO LR_31MON.

  APPEND VALUE #( SIGN = 'I' OPTION = 'EQ' LOW = 7 ) TO LR_31MON.

  APPEND VALUE #( SIGN = 'I' OPTION = 'EQ' LOW = 8 ) TO LR_31MON.

  APPEND VALUE #( SIGN = 'I' OPTION = 'EQ' LOW = 10 ) TO LR_31MON.

  APPEND VALUE #( SIGN = 'I' OPTION = 'EQ' LOW = 12 ) TO LR_31MON.



  P_DATE_LOW = SY-DATUM(6) && '01'.



  LV_YEAR  = SY-DATUM+0(4).

  LV_MONTH = SY-DATUM+4(2).



  IF LV_MONTH IN LR_30MON.

    LV_DAY = '30'.

  ELSEIF LV_MONTH IN LR_31MON.

    LV_DAY = '31'.

  ELSE.

    IF ( LV_YEAR MOD 4 = 0 AND LV_YEAR MOD 100 <> 0 ) OR ( LV_YEAR MOD 400 = 0 ).

      LV_DAY = '29'. " ##

    ELSE.

      LV_DAY = '28'.

    ENDIF.

  ENDIF.



  P_DATE_HIGH = SY-DATUM(6) && LV_DAY.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FORMAT_DATE

*&---------------------------------------------------------------------*

*       #### #### ### ##### ### .# ### ##

*        YYMMDD -> YY . MM . DD

*----------------------------------------------------------------------*

*      <--P_DATE

*----------------------------------------------------------------------*




FORM FORMAT_DATE  CHANGING P_DATE.



  CONCATENATE P_DATE+0(4) '.' P_DATE+4(2) '.' P_DATE+6(2)

         INTO P_DATE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CONVERT_PRICE_CURRENCY

*&---------------------------------------------------------------------*

*     ##### ## # #### #### * ## (100) #### ##

*       <--CONVERT_PRICE = PRICE * CURR

*----------------------------------------------------------------------*




FORM CONVERT_PRICE_CURRENCY  USING    P_PRICE

                                      P_CURR_RATE

                             CHANGING P_CONV_PRICE.



  P_CONV_PRICE = P_PRICE * P_CURR_RATE.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_ORDER_DATA

*&---------------------------------------------------------------------*

*       ### ## #### ###(ZEDT01_100) ##

*----------------------------------------------------------------------*

*  <--  GT_ORDER

*----------------------------------------------------------------------*




FORM GET_ORDER_DATA.



  SELECT * FROM ZEDT01_100

    INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

    WHERE ZJDATE IN S_ZJDATE

    AND ZORDNO IN S_ZORDNO

    AND ZMATNR IN S_ZMATNR.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  APPEND_ORDER_DATA

*&---------------------------------------------------------------------*

*       ### #### LOOP# #### ### ### ### ## ##

*       ### #### ### ##

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM APPEND_ORDER_DATA .

  LOOP AT GT_ORDER INTO GS_ORDER.

    CLEAR : GS_WRITE_ORDER.



    MOVE-CORRESPONDING GS_ORDER TO GS_WRITE_ORDER.  " ## ### ## #### ### COPY

                                                    " ## ### ## ### ## ##

    CASE GS_ORDER-ZMTART.

      WHEN '001'.

        GS_WRITE_ORDER-ZMTART = '##'.

      WHEN '002'.

        GS_WRITE_ORDER-ZMTART = '##'.

      WHEN '003'.

        GS_WRITE_ORDER-ZMTART = '##'.

      WHEN '004'.

        GS_WRITE_ORDER-ZMTART = '##'.

      WHEN '005'.

        GS_WRITE_ORDER-ZMTART = '##'.

      WHEN '006'.

        GS_WRITE_ORDER-ZMTART = '###'.

    ENDCASE.



   CASE GS_ORDER-ZSALE_FG.

     WHEN '1'.

       GS_WRITE_ORDER-SALES_TYPE = '##'.

     WHEN '2'.

       GS_WRITE_ORDER-SALES_TYPE = '##'.

   ENDCASE.



   CASE GS_ORDER-ZRET_FG.

     WHEN ' '.

       GS_WRITE_ORDER-ZRET_FG = ' '.

       GS_WRITE_ORDER-ZRDATE = ' '.

     WHEN '1'.

       GS_WRITE_ORDER-ZRET_FG = '####'.

     WHEN '2'.

       GS_WRITE_ORDER-ZRET_FG = '####'.

     WHEN '3'.

       GS_WRITE_ORDER-ZRET_FG = '####'.

    ENDCASE.

                                                  " YYMMDD -> YY.MM.DD# ###

    PERFORM FORMAT_DATE CHANGING GS_WRITE_ORDER-ZJDATE.

    IF GS_ORDER-ZRET_FG <> ' '.                   " ### ## # ## ##### ###

      PERFORM FORMAT_DATE CHANGING GS_WRITE_ORDER-ZRDATE.

    ENDIF.

                                                  " ## ## #### ### ##

    PERFORM CONVERT_PRICE_CURRENCY USING GS_ORDER-ZNSAMT C_RATE_KRW

                                   CHANGING GS_WRITE_ORDER-ZNSAMT.

    PERFORM CONVERT_PRICE_CURRENCY USING GS_ORDER-ZSLAMT C_RATE_KRW

                                   CHANGING GS_WRITE_ORDER-ZSLAMT.

    PERFORM CONVERT_PRICE_CURRENCY USING GS_ORDER-ZDCAMT C_RATE_KRW

                                   CHANGING GS_WRITE_ORDER-ZDCAMT.

    APPEND GS_WRITE_ORDER TO GT_WRITE_ORDER.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  WRITE_ORDER_DATA

*&---------------------------------------------------------------------*

*       ### #### ### ##

*       #### #### P_CH1# ## ##### ### ##

*&---------------------------------------------------------------------*




FORM WRITE_ORDER_DATA .

    LOOP AT GT_WRITE_ORDER INTO GS_WRITE_ORDER.

    AT FIRST.                                   " HEADER "

      IF P_CH1 = 'X'.

        WRITE : / SY-ULINE(180).

      ELSE.

        WRITE : / SY-ULINE(150).

      ENDIF.



      WRITE : / SY-VLINE ,TEXT-000 CENTERED,    " ####

             15 SY-VLINE ,TEXT-001 CENTERED,    " ID

             27 SY-VLINE ,TEXT-002 CENTERED,    " ####

             40 SY-VLINE ,TEXT-003 CENTERED,    " ###

             60 SY-VLINE ,TEXT-004 ,            " ####

             70 SY-VLINE ,TEXT-005 ,            " ##

             78 SY-VLINE ,TEXT-006 ,            " ##

             85 SY-VLINE ,TEXT-007 CENTERED,    " ####

             100 SY-VLINE ,TEXT-008 CENTERED,   " ####

             115 SY-VLINE ,TEXT-009 CENTERED,   " ####

             130 SY-VLINE ,TEXT-010 ,           " ##

             138 SY-VLINE ,TEXT-011 CENTERED.   " ####



      IF P_CH1 = 'X'.

        WRITE : 150 SY-VLINE ,TEXT-012 CENTERED,  " ####

                165 SY-VLINE ,TEXT-013 CENTERED,  " ####

                180 SY-VLINE.

        WRITE : / SY-ULINE(180).

      ELSE.

        WRITE : 150 SY-VLINE.

        WRITE : / SY-ULINE(150).

      ENDIF.

    ENDAT.

                                               " BODY "

    WRITE : / SY-VLINE  ,GS_WRITE_ORDER-ZORDNO CENTERED UNDER TEXT-000,   " #### "

           15 SY-VLINE  ,GS_WRITE_ORDER-ZIDCODE CENTERED UNDER TEXT-001,  " ID "

           27 SY-VLINE  ,GS_WRITE_ORDER-ZMATNR  UNDER TEXT-002,           " ####

           40 SY-VLINE  ,GS_WRITE_ORDER-ZMATART_NAME UNDER TEXT-003,          " ###

           60 SY-VLINE  ,GS_WRITE_ORDER-ZMTART UNDER TEXT-004,            " ####

           70 SY-VLINE  ,GS_WRITE_ORDER-ZVOLUM UNDER TEXT-005,            " ##

           78 SY-VLINE  ,GS_WRITE_ORDER-VRKME  UNDER TEXT-006,            " ##

           85 SY-VLINE  ,GS_WRITE_ORDER-ZNSAMT DECIMALS 0 UNDER TEXT-007, " ####

           100 SY-VLINE ,GS_WRITE_ORDER-ZSLAMT DECIMALS 0 UNDER TEXT-008, " ####

           115 SY-VLINE ,GS_WRITE_ORDER-ZDCAMT DECIMALS 0 UNDER TEXT-009, " ####

           130 SY-VLINE ,GS_WRITE_ORDER-SALES_TYPE UNDER TEXT-010,        " ##

           138 SY-VLINE ,GS_WRITE_ORDER-ZJDATE  UNDER TEXT-011.           " ####

    IF P_CH1 = 'X'.

      WRITE : 150 SY-VLINE ,GS_WRITE_ORDER-ZRET_FG UNDER TEXT-012 .       " ####

      IF GS_ORDER-ZRET_FG <> ' '.

        WRITE : 165 SY-VLINE,GS_WRITE_ORDER-ZRDATE UNDER TEXT-013 ,       " ####

                180 SY-VLINE.

      ELSE.

        WRITE : 165 SY-VLINE,

                180 SY-VLINE.

      ENDIF.



      WRITE : / SY-ULINE(180).

    ELSE.

      WRITE : 150 SY-VLINE.

      WRITE : / SY-ULINE(150).

    ENDIF.



  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DELIVERY_DATA

*&---------------------------------------------------------------------*

*       ### ## #### ###(ZEDT01_101) ##

*----------------------------------------------------------------------*

*  <--  GT_DELIVERY

*----------------------------------------------------------------------*




FORM GET_DELIVERY_DATA.



  SELECT * FROM ZEDT01_101

  INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY

  WHERE ZDDATE IN S_ZDDATE

  AND ZORDNO IN S_ZORDNO

  AND ZMATNR IN S_ZMATNR.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  APPEND_DELIVERY_DATA

*&---------------------------------------------------------------------*

*       ### #### LOOP# #### ### ### ### ## ##

*       ### #### ### ##

*----------------------------------------------------------------------*




FORM APPEND_DELIVERY_DATA .

  LOOP AT GT_DELIVERY INTO GS_DELIVERY.

    CLEAR : GS_WRITE_DELIVERY.

    MOVE-CORRESPONDING GS_DELIVERY TO GS_WRITE_DELIVERY.   " ## ### ## #### ### COPY

                                                           " ## ### ## ### ## ##

    CASE GS_DELIVERY-ZMTART.

      WHEN '001'.

        GS_WRITE_DELIVERY-ZMTART = '##'.

      WHEN '002'.

        GS_WRITE_DELIVERY-ZMTART = '##'.

      WHEN '003'.

        GS_WRITE_DELIVERY-ZMTART = '##'.

      WHEN '004'.

        GS_WRITE_DELIVERY-ZMTART = '##'.

      WHEN '005'.

        GS_WRITE_DELIVERY-ZMTART = '##'.

      WHEN '006'.

        GS_WRITE_DELIVERY-ZMTART = '###'.

    ENDCASE.



    IF GS_DELIVERY-ZFLAG = 'X'.

      GS_WRITE_DELIVERY-ZDFLAG = ' '.

    ELSE.

      GS_WRITE_DELIVERY-ZRDATE = ' '.



      CASE GS_DELIVERY-ZDFLAG.

        WHEN '1'.

          GS_WRITE_DELIVERY-ZDFLAG = '####'.

        WHEN '2'.

          GS_WRITE_DELIVERY-ZDFLAG = '###'.

        WHEN '3'.

          GS_WRITE_DELIVERY-ZDFLAG = '####'.

       ENDCASE.

    ENDIF.



    CASE GS_DELIVERY-ZDGUBUN.

      WHEN '1'.

        GS_WRITE_DELIVERY-ZDGUBUN = '###'.

      WHEN '2'.

        GS_WRITE_DELIVERY-ZDGUBUN = '###'.

      WHEN '3'.

        GS_WRITE_DELIVERY-ZDGUBUN = '###'.

      WHEN '4'.

        GS_WRITE_DELIVERY-ZDGUBUN = '###'.

      WHEN '5'.

        GS_WRITE_DELIVERY-ZDGUBUN = '###'.

      WHEN '6'.

        GS_WRITE_DELIVERY-ZDGUBUN = '###'.

      WHEN '7'.

        GS_WRITE_DELIVERY-ZDGUBUN = '###'.

    ENDCASE.

                                                " YYMMDD -> YY.MM.DD# ###

    PERFORM FORMAT_DATE CHANGING GS_WRITE_DELIVERY-ZDDATE.

                                                " ### ## # ## ##### ###

    IF GS_DELIVERY-ZFLAG = 'X'.

      PERFORM FORMAT_DATE CHANGING GS_WRITE_DELIVERY-ZRDATE.

    ENDIF.

                                                " ## ## #### ### ##

    PERFORM CONVERT_PRICE_CURRENCY USING GS_DELIVERY-ZSLAMT C_RATE_KRW

                                   CHANGING GS_WRITE_DELIVERY-ZSLAMT.



    APPEND GS_WRITE_DELIVERY TO GT_WRITE_DELIVERY.



  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  WRITE_DELIVERY_DATA

*&---------------------------------------------------------------------*

*       ## ### #### ### ##

*       #### #### P_CH1# ## ##### ### ##

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM WRITE_DELIVERY_DATA.

  LOOP AT GT_WRITE_DELIVERY INTO GS_WRITE_DELIVERY.

    AT FIRST.                                   " HEADER "

      IF P_CH1 = 'X'.

        WRITE : / SY-ULINE(150).

      ELSE.

        WRITE : / SY-ULINE(135).

      ENDIF.



      WRITE : / SY-VLINE ,TEXT-000 CENTERED,    " ####

             15 SY-VLINE ,TEXT-001 CENTERED,    " ID

             27 SY-VLINE ,TEXT-002 CENTERED,    " ####

             40 SY-VLINE ,TEXT-003 CENTERED,    " ###

             60 SY-VLINE ,TEXT-004 ,            " ####

             70 SY-VLINE ,TEXT-005 ,            " ##

             78 SY-VLINE ,TEXT-006 ,            " ##

             85 SY-VLINE ,TEXT-017 CENTERED,    " ####

             100 SY-VLINE ,TEXT-014 CENTERED,   " ####

             112 SY-VLINE ,TEXT-015 CENTERED,   " ##

             122 SY-VLINE ,TEXT-016 CENTERED.   " ####

      IF P_CH1 = 'X'.

        WRITE : 135 SY-VLINE ,TEXT-013 CENTERED,   " ####

                150 SY-VLINE.

        WRITE : / SY-ULINE(150).

      ELSE.

        WRITE : 135 SY-VLINE.

        WRITE : / SY-ULINE(135).

      ENDIF.

    ENDAT.

                                               " BODY "

    WRITE : / SY-VLINE  ,GS_WRITE_DELIVERY-ZORDNO CENTERED UNDER TEXT-000,            " #### "

           15 SY-VLINE  ,GS_WRITE_DELIVERY-ZIDCODE CENTERED UNDER TEXT-001,           " ID

           27 SY-VLINE  ,GS_WRITE_DELIVERY-ZMATNR UNDER TEXT-002,                     "####

           40 SY-VLINE  ,GS_WRITE_DELIVERY-ZMTART_NAME UNDER TEXT-003,                " ###

           60 SY-VLINE  ,GS_WRITE_DELIVERY-ZMTART UNDER TEXT-004,                     " ####

           70 SY-VLINE  ,GS_WRITE_DELIVERY-ZVOLUM UNDER TEXT-005,                     " ##

           78 SY-VLINE  ,GS_WRITE_DELIVERY-VRKME UNDER TEXT-006,                      " ##

           85 SY-VLINE  ,GS_WRITE_DELIVERY-ZSLAMT DECIMALS 0 UNDER TEXT-007,          " ####

           100 SY-VLINE ,GS_WRITE_DELIVERY-ZDFLAG DECIMALS 0 CENTERED UNDER TEXT-014, " ####

           112 SY-VLINE ,GS_WRITE_DELIVERY-ZDGUBUN DECIMALS 0 CENTERED UNDER TEXT-015," ##

           122 SY-VLINE ,GS_WRITE_DELIVERY-ZDDATE  UNDER TEXT-016.                    " ####

    IF P_CH1 = 'X'.

      IF GS_DELIVERY-ZFLAG = 'X'.

        WRITE : 135 SY-VLINE,GS_WRITE_DELIVERY-ZRDATE  UNDER TEXT-012,

                150 SY-VLINE.

        WRITE : / SY-ULINE(150).

      ELSE.

        WRITE : 135 SY-VLINE , 150 SY-VLINE.

        WRITE : / SY-ULINE(150).

      ENDIF.

    ELSE.

      WRITE : 135 SY-VLINE.

      WRITE : / SY-ULINE(135).

    ENDIF.

  ENDLOOP.



ENDFORM.