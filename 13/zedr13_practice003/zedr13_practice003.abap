
*&---------------------------------------------------------------------*

*& Report ZEDR13_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR13_PRACTICE003.



TABLES : ZEDT13_100, ZEDT13_101. "SELECTION OPTION ##### ## ##"



CONSTANTS : KRW_RATE TYPE I VALUE 100.  "### ## ##"



DATA : GS_ORDER TYPE ZEDT13_100.        "### ## ### ##"

DATA : GT_ORDER LIKE TABLE OF GS_ORDER.



DATA : BEGIN OF GS_WORDER,              "### ## ### ##"

  ZORDNO TYPE ZEDT13_100-ZORDNO,        "####"

  ZIDCODE TYPE ZEDT13_100-ZIDCODE,      "##ID"

  ZMATNR LIKE ZEDT13_100-ZMATNR,        "####"

  ZMATNAME LIKE ZEDT13_100-ZMATNAME,    "###"

  ZMTART TYPE C LENGTH 8,               "####"

  ZVOLUM LIKE ZEDT13_100-ZVOLUM,        "##"

  VRKME LIKE ZEDT13_100-VRKME,          "##"

  ZNSAMT TYPE I,                        "####"

  ZSLAMT TYPE I,                        "####"

  ZDCAMT TYPE I,                     	  "####"

  ZSALE_FG TYPE C LENGTH 4,             "#### -> ##"

  ZJDATE TYPE C LENGTH 10,              "####"

  ZRET_FG TYPE C LENGTH 10,             "####"

  ZRDATE TYPE C LENGTH 10,              "####"

 END OF GS_WORDER.

 DATA : GT_WORDER LIKE TABLE OF GS_WORDER.



DATA : GS_DELIVERY TYPE ZEDT13_101.     "### ## ### ##"

DATA : GT_DELIVERY LIKE TABLE OF GS_DELIVERY.



DATA : BEGIN OF GS_WDELIVERY,           "### ## ### ##"

  ZORDNO LIKE ZEDT13_101-ZORDNO,        "####"

  ZIDCODE LIKE ZEDT13_101-ZIDCODE,      "##ID"

  ZMATNR LIKE ZEDT13_101-ZMATNR,        "####"

  ZMATNAME LIKE ZEDT13_101-ZMATNAME,    "###"

  ZMTART TYPE C LENGTH 8,               "####"

  ZVOLUM LIKE ZEDT13_101-ZVOLUM,        "##"

  VRKME LIKE ZEDT13_101-VRKME,          "##"

  ZSLAMT TYPE I,                        "####"

  ZDFLAG TYPE C LENGTH 8,               "####"

  ZDGUBUN TYPE C LENGTH 6,              "#### -> ##"

  ZDDATE TYPE C LENGTH 10,              "####"

  ZRDATE TYPE C LENGTH 10,              "####"

  END OF GS_WDELIVERY.

DATA : GT_WDELIVERY LIKE TABLE OF GS_WDELIVERY.



RANGES : R_FG FOR ZEDT13_100-ZSALE_FG.  "## ### ## ## ### ##### ### ##"

RANGES : R_CH FOR ZEDT13_101-ZFLAG.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  "## #### ### ## #### ### #### 2## ### ##"

  SELECT-OPTIONS : S_ZORDNO FOR ZEDT13_100-ZORDNO.                              "####"

  SELECT-OPTIONS : S_IDCODE FOR ZEDT13_100-ZIDCODE NO INTERVALS NO-EXTENSION.   "##ID"

  SELECT-OPTIONS : S_MATART FOR ZEDT13_100-ZMTART.                              "####"

  SELECT-OPTIONS : S_ZJDATE FOR ZEDT13_100-ZJDATE MODIF ID M1.                  "####"

  SELECT-OPTIONS : S_DDATE FOR ZEDT13_101-ZDDATE MODIF ID M2.                   "####"

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  "#### ## USER EVENT ####"

  PARAMETERS P1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.              "####"

  PARAMETERS P2 RADIOBUTTON GROUP R1.                                           "####"

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS P3 AS CHECKBOX DEFAULT 'X'.                                        "######"

SELECTION-SCREEN END OF BLOCK B3.



INITIALIZATION.

PERFORM DATE_SETTING CHANGING S_ZJDATE-LOW    "### ### ## ### ##"

                              S_ZJDATE-HIGH.

PERFORM DATE_SETTING CHANGING S_DDATE-LOW

                              S_DDATE-HIGH.

APPEND S_ZJDATE.

APPEND S_DDATE.

AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_CHANGING.     "##### ## -> ### ##"



START-OF-SELECTION.

PERFORM CHECK_FG.              "##### ## -> ## ### ##"

PERFORM GET_DATA.

PERFORM MODIFY_DATA.



END-OF-SELECTION.

PERFORM WRITE_DATA.




*&---------------------------------------------------------------------*

*&      Form  DATE_SETTING

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--S_DATE_LOW  text

*      <--S_DATE_HIGH  text

*----------------------------------------------------------------------*




FORM DATE_SETTING CHANGING S_DATE_LOW TYPE D

                            S_DATE_HIGH TYPE D.

  DATA : LV_MONTH TYPE I.

  DATA : LV_YEAR TYPE I.

  S_DATE_LOW = SY-DATUM(6) && '01'. "## ### 01# ##"

  LV_YEAR = SY-DATUM+0(4).

  LV_MONTH = SY-DATUM+4(2).



  CASE LV_MONTH. "### ### # ###"

    WHEN '01'.

      S_DATE_HIGH = SY-DATUM(6) && '31'.

    WHEN '02'.

      IF ( LV_YEAR MOD 4 = 0 AND LV_YEAR MOD 100 <> 0 ) OR LV_YEAR MOD 400 = 0.

        S_DATE_HIGH = SY-DATUM(6) && '29'. "##"

      ELSE.

        S_DATE_HIGH = SY-DATUM(6) && '28'. "##"

      ENDIF.

    WHEN '03'.

      S_DATE_HIGH = SY-DATUM(6) && '31'.

    WHEN '04'.

      S_DATE_HIGH = SY-DATUM(6) && '30'.

    WHEN '05'.

      S_DATE_HIGH = SY-DATUM(6) && '31'.

    WHEN '06'.

      S_DATE_HIGH = SY-DATUM(6) && '30'.

    WHEN '07'.

      S_DATE_HIGH = SY-DATUM(6) && '31'.

    WHEN '08'.

      S_DATE_HIGH = SY-DATUM(6) && '31'.

    WHEN '09'.

      S_DATE_HIGH = SY-DATUM(6) && '30'.

    WHEN '10'.

      S_DATE_HIGH = SY-DATUM(6) && '31'.

    WHEN '11'.

      S_DATE_HIGH = SY-DATUM(6) && '30'.

    WHEN '12'.

      S_DATE_HIGH = SY-DATUM(6) && '31'.

   ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SCREEN_CHANGING

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SCREEN_CHANGING .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'. "## ##"

      IF P1 = 'X'.  "## ### ## ## ### ## SELECT-OPTION ###"

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'. "## ##"

      IF P2 = 'X'.   "## ### ## ## ### ## SELECT-OPTION ###"

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_FG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_FG.

  IF P1 = 'X'. "## ## ##"

    R_FG-SIGN = 'I'. "## ##"

    R_FG-OPTION = 'EQ'. "LOW# ## #### ## ##"

    R_FG-LOW = '1'. "## ## ##"

    APPEND R_FG.

    IF P3 = 'X'.

      R_FG-LOW = '2'. "## # ### ## ## ##"

      APPEND R_FG.

    ENDIF.

  ELSEIF P2 = 'X'. "## ## ##"

    R_CH-SIGN = 'I'. "## ##"

    R_CH-OPTION = 'EQ'. "LOW# ## #### ## ##"

    R_CH-LOW = ' '. "## ## ##### # ##"

    APPEND R_CH.

    IF P3 = 'X'.

      R_CH-LOW = 'X'. "## ## ## ## ## ## # ##"

      APPEND R_CH.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA.

  IF P1 = 'X'. "## ##"

    SELECT * FROM ZEDT13_100

    INTO CORRESPONDING FIELDS OF TABLE GT_ORDER "GT_ORDER #### ## ####"

    WHERE ZORDNO IN S_ZORDNO

    AND ZIDCODE IN S_IDCODE

    AND ZMATNR IN S_MATART

    AND ZJDATE IN S_ZJDATE

    AND ZSALE_FG IN R_FG. "### ## ### ####"

  ELSEIF P2 = 'X'. "## ##"

    SELECT * FROM ZEDT13_101

    INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY "GT_DELIVERY #### ## ####"

    WHERE ZORDNO IN S_ZORDNO

    AND ZIDCODE IN S_IDCODE

    AND ZMATNR IN S_MATART

    AND ZDDATE IN S_DDATE

    AND ZFLAG IN R_CH. "### ## ### ####"

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

  IF P1 = 'X'.  "## ##"

    CLEAR GS_ORDER.

    LOOP AT GT_ORDER INTO GS_ORDER.

      MOVE-CORRESPONDING GS_ORDER TO GS_WORDER.



      SHIFT GS_WORDER-ZORDNO LEFT DELETING LEADING '0'. "0000000001 -> 1"

      SHIFT GS_WORDER-ZMATNR LEFT DELETING LEADING '0'.



      PERFORM DATE_ZOM CHANGING GS_WORDER-ZJDATE. "## ## ## . ##"

      PERFORM DATE_ZOM CHANGING GS_WORDER-ZRDATE.



      CASE GS_ORDER-ZMTART. "## ## ### ##"

      WHEN '001'.

        GS_WORDER-ZMTART = '##'.

      WHEN '002'.

        GS_WORDER-ZMTART = '##'.

      WHEN '003'.

        GS_WORDER-ZMTART = '##'.

      WHEN '004'.

        GS_WORDER-ZMTART = '##'.

      WHEN '005'.

        GS_WORDER-ZMTART = '##'.

      WHEN '006'.

         GS_WORDER-ZMTART = '###'.

      ENDCASE.



      CASE GS_ORDER-ZSALE_FG. "## ## ### ##"

      WHEN '1'.

        GS_WORDER-ZSALE_FG = '##'.

        CLEAR : GS_WORDER-ZRDATE. "### ## ##### ##"

      WHEN '2'.

        GS_WORDER-ZSALE_FG = '##'.

      ENDCASE.



      CASE GS_ORDER-ZRET_FG.

      WHEN '1'.

        GS_WORDER-ZRET_FG = '####'.

      WHEN '2'.

        GS_WORDER-ZRET_FG = '####'.

      WHEN '3'.

        GS_WORDER-ZRET_FG = '####'.

      ENDCASE.



      GS_WORDER-ZNSAMT = GS_WORDER-ZNSAMT * KRW_RATE. "### ##"

      GS_WORDER-ZSLAMT = GS_WORDER-ZSLAMT * KRW_RATE.

      GS_WORDER-ZDCAMT = GS_WORDER-ZDCAMT * KRW_RATE.



      APPEND GS_WORDER TO GT_WORDER.

      CLEAR : GS_ORDER, GS_WORDER.

    ENDLOOP.

  ELSEIF P2 = 'X'.  "## ##"

    CLEAR GS_DELIVERY.

    LOOP AT GT_DELIVERY INTO GS_DELIVERY.

      MOVE-CORRESPONDING GS_DELIVERY TO GS_WDELIVERY.



      SHIFT GS_WDELIVERY-ZORDNO LEFT DELETING LEADING '0'. "0000000001 -> 1"

      SHIFT GS_WDELIVERY-ZMATNR LEFT DELETING LEADING '0'.



      PERFORM DATE_ZOM CHANGING GS_WDELIVERY-ZDDATE. "## ## ## . ##"

      PERFORM DATE_ZOM CHANGING GS_WDELIVERY-ZRDATE.



      CASE GS_DELIVERY-ZDFLAG. "## ## ### ##"

        WHEN '1'.

          GS_WDELIVERY-ZDFLAG = '####'.

        WHEN '2'.

          GS_WDELIVERY-ZDFLAG = '###'.

        WHEN '3'.

          GS_WDELIVERY-ZDFLAG = '####'.

      ENDCASE.



      CASE GS_DELIVERY-ZDGUBUN. "## ## ### ##"

        WHEN '1'.

          GS_WDELIVERY-ZDGUBUN = '###'.

        WHEN '2'.

          GS_WDELIVERY-ZDGUBUN = '###'.

        WHEN '3'.

          GS_WDELIVERY-ZDGUBUN = '###'.

        WHEN '4'.

          GS_WDELIVERY-ZDGUBUN = '###'.

        WHEN '5'.

          GS_WDELIVERY-ZDGUBUN = '###'.

        WHEN '6'.

          GS_WDELIVERY-ZDGUBUN = '###'.

        WHEN '7'.

          GS_WDELIVERY-ZDGUBUN = '###'.

      ENDCASE.



      CASE GS_DELIVERY-ZMTART. "## ## ### ##"

      WHEN '001'.

        GS_WDELIVERY-ZMTART = '##'.

      WHEN '002'.

        GS_WDELIVERY-ZMTART = '##'.

      WHEN '003'.

        GS_WDELIVERY-ZMTART = '##'.

      WHEN '004'.

        GS_WDELIVERY-ZMTART = '##'.

      WHEN '005'.

        GS_WDELIVERY-ZMTART = '##'.

      WHEN '006'.

        GS_WDELIVERY-ZMTART = '###'.

      ENDCASE.



      IF GS_DELIVERY-ZFLAG = 'X'. "## ### GS_DELIVERY## #### # #### ## ## ##"

        CLEAR : GS_WDELIVERY-ZDFLAG. "## ### ## ## ## #### ##"

      ELSE.

        CLEAR : GS_WDELIVERY-ZRDATE. "### ## ## #### ##"

      ENDIF.



      GS_WDELIVERY-ZSLAMT = GS_DELIVERY-ZSLAMT * KRW_RATE. "### ##"



      APPEND GS_WDELIVERY TO GT_WDELIVERY.

      CLEAR : GS_ORDER, GS_WORDER.

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

  IF P1 = 'X'.       "## ##"

    LOOP AT GT_WORDER INTO GS_WORDER.

      AT FIRST.

        IF P3 = 'X'. "######"

          WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |   ####  |  ####   | ## |  ####  |  ####  |  ####  | '.

          WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |   ####  |  ####   | ## |  ####  | '.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDAT.

      IF P3 = 'X'.   "######"

        WRITE :/ SY-VLINE, GS_WORDER-ZORDNO,

                 SY-VLINE, GS_WORDER-ZIDCODE,

                 SY-VLINE, GS_WORDER-ZMATNR,

                 SY-VLINE, GS_WORDER-ZMATNAME,

                 SY-VLINE, GS_WORDER-ZMTART,

                 SY-VLINE, GS_WORDER-ZVOLUM,

                 SY-VLINE, GS_WORDER-VRKME,

                 SY-VLINE, GS_WORDER-ZNSAMT,

                 SY-VLINE, GS_WORDER-ZSLAMT,

                 SY-VLINE, GS_WORDER-ZDCAMT,

                 SY-VLINE, GS_WORDER-ZSALE_FG,

                 SY-VLINE, GS_WORDER-ZJDATE,

                 SY-VLINE, GS_WORDER-ZRET_FG,

                 SY-VLINE, GS_WORDER-ZRDATE,

                 SY-VLINE.

        WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.

        WRITE :/  SY-VLINE, GS_WORDER-ZORDNO,

                 SY-VLINE, GS_WORDER-ZIDCODE,

                 SY-VLINE, GS_WORDER-ZMATNR,

                 SY-VLINE, GS_WORDER-ZMATNAME,

                 SY-VLINE, GS_WORDER-ZMTART,

                 SY-VLINE, GS_WORDER-ZVOLUM,

                 SY-VLINE, GS_WORDER-VRKME,

                 SY-VLINE, GS_WORDER-ZNSAMT,

                 SY-VLINE, GS_WORDER-ZSLAMT,

                 SY-VLINE, GS_WORDER-ZDCAMT,

                 SY-VLINE, GS_WORDER-ZSALE_FG,

                 SY-VLINE, GS_WORDER-ZJDATE,

                 SY-VLINE.

        WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDLOOP.

  ELSEIF P2 = 'X'.   "## ##"

    LOOP AT GT_WDELIVERY INTO GS_WDELIVERY.

      AT FIRST.

        IF P3 = 'X'. "######"

         WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   | #### |  ##  |  ####  |  ####  |'.

          WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE.

          WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   | #### |  ##  |  ####  | '.

          WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDAT.

      IF P3 = 'X'.   "######"

        WRITE :/ SY-VLINE, GS_WDELIVERY-ZORDNO,

                 SY-VLINE, GS_WDELIVERY-ZIDCODE,

                 SY-VLINE, GS_WDELIVERY-ZMATNR,

                 SY-VLINE, GS_WDELIVERY-ZMATNAME,

                 SY-VLINE, GS_WDELIVERY-ZMTART,

                 SY-VLINE, GS_WDELIVERY-ZVOLUM,

                 SY-VLINE, GS_WDELIVERY-VRKME,

                 SY-VLINE, GS_WDELIVERY-ZSLAMT,

                 SY-VLINE, GS_WDELIVERY-ZDFLAG,

                 SY-VLINE, GS_WDELIVERY-ZDGUBUN,

                 SY-VLINE, GS_WDELIVERY-ZDDATE,

                 SY-VLINE, GS_WDELIVERY-ZRDATE,

                 SY-VLINE.

       WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE.

        WRITE :/ SY-VLINE, GS_WDELIVERY-ZORDNO,

                 SY-VLINE, GS_WDELIVERY-ZIDCODE,

                 SY-VLINE, GS_WDELIVERY-ZMATNR,

                 SY-VLINE, GS_WDELIVERY-ZMATNAME,

                 SY-VLINE, GS_WDELIVERY-ZMTART,

                 SY-VLINE, GS_WDELIVERY-ZVOLUM,

                 SY-VLINE, GS_WDELIVERY-VRKME,

                 SY-VLINE, GS_WDELIVERY-ZSLAMT,

                 SY-VLINE, GS_WDELIVERY-ZDFLAG,

                 SY-VLINE, GS_WDELIVERY-ZDGUBUN,

                 SY-VLINE, GS_WDELIVERY-ZDDATE,

                 SY-VLINE.

        WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDLOOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DATE_ZOM

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DATE_ZOM CHANGING DATE.

  DATE = DATE+0(4) && '.' && DATE+4(2) && '.' && DATE+6(2). "## ### .# ## ##"

ENDFORM.