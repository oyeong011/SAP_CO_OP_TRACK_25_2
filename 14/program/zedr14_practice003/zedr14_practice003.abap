
*&---------------------------------------------------------------------*

*& Report ZEDR14_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR14_PRACTICE003 LINE-SIZE 200.



"####### ##

TABLES : ZEDT14_100, ZEDT14_101.



CONSTANTS : BEGIN OF BOOL,    "CONSTANTS ##

  TRUE(1) VALUE '1',

  FALSE(1) VALUE '0',

  END OF BOOL.

CONSTANTS FIRST_DATE(2) VALUE '01'.



"### ITAB

DATA : BEGIN OF GS_PRINT100.

  include structure
ZEDT14_100
.

DATA : END OF GS_PRINT100.

DATA : GT_PRINT100 LIKE TABLE OF GS_PRINT100.



DATA : BEGIN OF GS_PRINT101.

  include structure
ZEDT14_101
.

DATA : END OF GS_PRINT101.

DATA : GT_PRINT101 LIKE TABLE OF GS_PRINT101.



"### ITAB

DATA : BEGIN OF GS_FINAL100, "###### ## ###

    ZORDNO LIKE ZEDT14_100-ZORDNO,  "####

    ZIDCODE LIKE ZEDT14_100-ZIDCODE,  "##ID

    ZMATNR LIKE ZEDT14_100-ZMATNR,  "####

    ZMATNAME LIKE ZEDT14_100-ZMATNAME,  "###

    ZMTART LIKE ZEDT14_100-ZMTART,  "####

    ZVOLUM LIKE ZEDT14_100-ZVOLUM,  "##

    VRKME LIKE ZEDT14_100-VRKME,  "##

    ZNSAMT LIKE ZEDT14_100-ZNSAMT,  "####

    ZSLAMT LIKE ZEDT14_100-ZSLAMT,  "####

    ZDCAMT LIKE ZEDT14_100-ZDCAMT,  "####

    ZSALE_FG LIKE ZEDT14_100-ZSALE_FG,  "####

    ZJDATE LIKE ZEDT14_100-ZJDATE,  "####

    ZRET_FG LIKE ZEDT14_100-ZRET_FG,  "####

    ZRDATE LIKE ZEDT14_100-ZRDATE,  "####

    ZMTART_TEXT TYPE C LENGTH 10,   "#### ##

    ZSALE_TEXT TYPE C LENGTH 10,    "## ##

    ZRET_TEXT TYPE C LENGTH 10,   "#### ##

  END OF GS_FINAL100.

DATA : GT_FINAL100 LIKE TABLE OF GS_FINAL100.



DATA : BEGIN OF GS_FINAL101, "###### ## ###

    ZORDNO LIKE ZEDT14_101-ZORDNO,  "####

    ZIDCODE LIKE ZEDT14_101-ZIDCODE,  "##ID

    ZMATNR LIKE ZEDT14_101-ZMATNR,  "####

    ZMATNAME LIKE ZEDT14_101-ZMATNAME,  "###

    ZMTART LIKE ZEDT14_101-ZMTART,  "####

    ZVOLUM LIKE ZEDT14_101-ZVOLUM,  "##

    VRKME LIKE ZEDT14_101-VRKME,  "##

    ZSLAMT LIKE ZEDT14_101-ZSLAMT,  "####

    ZDFLAG LIKE ZEDT14_101-ZDFLAG,  "####

    ZDGUBUN LIKE ZEDT14_101-ZDGUBUN,  "####

    ZDDATE LIKE ZEDT14_101-ZDDATE,  "####

    ZRDATE LIKE ZEDT14_101-ZRDATE,  "####

    ZFLAG LIKE ZEDT14_101-ZFLAG,   "####

    ZMTART_TEXT TYPE C LENGTH 10,  "#### ##

    ZDFLAG_TEXT TYPE C LENGTH 10,  "#### ##

    ZDGUBUN_TEXT TYPE C LENGTH 10,  "## ##

  END OF GS_FINAL101.

DATA : GT_FINAL101 LIKE TABLE OF GS_FINAL101.



"### ## ##

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZORDNO FOR ZEDT14_100-ZORDNO.

  PARAMETERS : P_ZID LIKE ZEDT14_100-ZIDCODE.

  SELECT-OPTIONS : S_ZMATNR FOR ZEDT14_100-ZMATNR.

  SELECT-OPTIONS : S_ZJDATE FOR ZEDT14_100-ZJDATE MODIF ID M1.

  SELECT-OPTIONS : S_ZDDATE FOR ZEDT14_101-ZDDATE MODIF ID M2.

SELECTION-SCREEN END OF BLOCK B1.

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.

  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.

SELECTION-SCREEN END OF BLOCK B2.

SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X' MODIF ID M3.

SELECTION-SCREEN END OF BLOCK B3.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = BOOL-TRUE.

      ELSEIF P_R2 = 'X'.

        SCREEN-ACTIVE = BOOL-FALSE.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

    IF SCREEN-GROUP1 = 'M2'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = BOOL-FALSE.

      ELSEIF P_R2 = 'X'.

        SCREEN-ACTIVE = BOOL-TRUE.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



INITIALIZATION.   "INITIALIZATION ##

S_ZJDATE-LOW = SY-DATUM.

S_ZJDATE-LOW+6(2) = FIRST_DATE.

S_ZDDATE-LOW = SY-DATUM.

S_ZDDATE-LOW+6(2) = FIRST_DATE.



CALL FUNCTION 'SLS_MISC_GET_LAST_DAY_OF_MONTH'   "#### ## ##

  EXPORTING

    DAY_IN = SY-DATUM

  IMPORTING

    LAST_DAY_OF_MONTH = S_ZJDATE-HIGH.

    S_ZDDATE-HIGH = S_ZJDATE-HIGH.



APPEND S_ZJDATE.

APPEND S_ZDDATE.



"######

START-OF-SELECTION.   "START-OF-SELECTION ##

  PERFORM GET_DATA.   "### ##

  PERFORM MODIFY_DATA.    "### ##

END-OF-SELECTION.

  PERFORM WRITE_DATA.   "### ##




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_DATA.



  RANGES : LR_ZID FOR ZEDT14_100-ZIDCODE,   "RANGES ## -> #### ##

           LR_ZSALEFG FOR ZEDT14_100-ZSALE_FG,

           LR_ZFLAG FOR ZEDT14_101-ZFLAG.



  IF P_ZID IS NOT INITIAL.    "P_ZID# #### ## #

    LR_ZID-SIGN = 'I'.

    LR_ZID-OPTION = 'EQ'.

    LR_ZID-LOW = P_ZID.

    APPEND LR_ZID.

  ENDIF.



  IF P_R1 = 'X'.  "####

    IF P_CH1 IS INITIAL.  "#### ## X

      LR_ZSALEFG-SIGN = 'I'.

      LR_ZSALEFG-OPTION = 'NE'.

      LR_ZSALEFG-LOW = '2'.

      APPEND LR_ZSALEFG.

    ENDIF.



    SELECT * FROM ZEDT14_100

      INTO CORRESPONDING FIELDS OF TABLE GT_PRINT100

      WHERE ZORDNO IN S_ZORDNO

        AND ZIDCODE IN LR_ZID

        AND ZMATNR IN S_ZMATNR

        AND ZJDATE IN S_ZJDATE

        AND ZSALE_FG IN LR_ZSALEFG.



  ELSEIF P_R2 = 'X'.  "####

    IF P_CH1 IS INITIAL.  "#### ## X

      LR_ZFLAG-SIGN = 'I'.

      LR_ZFLAG-OPTION = 'NE'.

      LR_ZFLAG-LOW = 'X'.

      APPEND LR_ZFLAG.

    ENDIF.



    SELECT * FROM ZEDT14_101

      INTO CORRESPONDING FIELDS OF TABLE GT_PRINT101

      WHERE ZORDNO IN S_ZORDNO

        AND ZIDCODE IN LR_ZID

        AND ZMATNR IN S_ZMATNR

        AND ZDDATE IN S_ZDDATE

        AND ZFLAG IN LR_ZFLAG.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM MODIFY_DATA.



  IF P_R1 = 'X'.

    LOOP AT GT_PRINT100 INTO GS_PRINT100.

      MOVE-CORRESPONDING GS_PRINT100 TO GS_FINAL100.



      CASE GS_FINAL100-ZMTART.    "#### ### ##

        WHEN '001'. GS_FINAL100-ZMTART_TEXT = '##'.

        WHEN '002'. GS_FINAL100-ZMTART_TEXT = '##'.

        WHEN '003'. GS_FINAL100-ZMTART_TEXT = '##'.

        WHEN '004'. GS_FINAL100-ZMTART_TEXT = '##'.

        WHEN '005'. GS_FINAL100-ZMTART_TEXT = '##'.

        WHEN '006'. GS_FINAL100-ZMTART_TEXT = '###'.

      ENDCASE.



      CASE GS_FINAL100-ZSALE_FG.    "## ### ##

        WHEN '1'. GS_FINAL100-ZSALE_TEXT = '##'.

        WHEN '2'. GS_FINAL100-ZSALE_TEXT = '##'.

      ENDCASE.



      CASE GS_FINAL100-ZRET_FG.   "#### ### ##

        WHEN '1'. GS_FINAL100-ZRET_TEXT = '####'.

        WHEN '2'. GS_FINAL100-ZRET_TEXT = '####'.

        WHEN '3'. GS_FINAL100-ZRET_TEXT = '####'.

        WHEN OTHERS. CLEAR GS_FINAL100-ZRET_TEXT.

      ENDCASE.



      APPEND GS_FINAL100 TO GT_FINAL100.

    ENDLOOP.



  ELSEIF P_R2 = 'X'.

    LOOP AT GT_PRINT101 INTO GS_PRINT101.

      MOVE-CORRESPONDING GS_PRINT101 TO GS_FINAL101.



      CASE GS_FINAL101-ZMTART.    "## ## ### ##

        WHEN '001'. GS_FINAL101-ZMTART_TEXT = '##'.

        WHEN '002'. GS_FINAL101-ZMTART_TEXT = '##'.

        WHEN '003'. GS_FINAL101-ZMTART_TEXT = '##'.

        WHEN '004'. GS_FINAL101-ZMTART_TEXT = '##'.

        WHEN '005'. GS_FINAL101-ZMTART_TEXT = '##'.

        WHEN '006'. GS_FINAL101-ZMTART_TEXT = '###'.

      ENDCASE.



      CASE GS_FINAL101-ZDFLAG.

        WHEN '1'. GS_FINAL101-ZDFLAG_TEXT = '####'.

        WHEN '2'. GS_FINAL101-ZDFLAG_TEXT = '###'.

        WHEN '3'. GS_FINAL101-ZDFLAG_TEXT = '####'.

      ENDCASE.



      CASE GS_FINAL101-ZDGUBUN.

        WHEN '1'. GS_FINAL101-ZDGUBUN_TEXT = '###'.

        WHEN '2'. GS_FINAL101-ZDGUBUN_TEXT = '###'.

        WHEN '3'. GS_FINAL101-ZDGUBUN_TEXT = '###'.

        WHEN '4'. GS_FINAL101-ZDGUBUN_TEXT = '###'.

        WHEN '5'. GS_FINAL101-ZDGUBUN_TEXT = '###'.

        WHEN '6'. GS_FINAL101-ZDGUBUN_TEXT = '###'.

        WHEN '7'. GS_FINAL101-ZDGUBUN_TEXT = '###'.

      ENDCASE.



      APPEND GS_FINAL101 TO GT_FINAL101.

    ENDLOOP.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM WRITE_DATA.



  DATA LV_DATE TYPE C LENGTH 10.  "#### ## ## ##



  IF P_R1 = 'X'.  "####

    IF GT_PRINT100 IS INITIAL.  "GT_PRINT100# #### ### ##

      MESSAGE '### ## ### ####.' TYPE 'S'.

      RETURN.

    ENDIF.



    IF P_CH1 = 'X'.   "######

      ULINE AT /01(155).  "## ##

      WRITE: /01 '|', 02(09) '####'      CENTERED,

                 11 '|', 12(08) 'ID'     CENTERED,

                 20 '|', 21(10) '####'   CENTERED,

                 31 '|', 32(15) '###'    CENTERED,

                 47 '|', 48(10) '####'   CENTERED,

                 58 '|', 59(05) '##'     CENTERED,

                 64 '|', 65(05) '##'     CENTERED,

                 70 '|', 71(12) '####'   CENTERED,

                 83 '|', 84(12) '####'   CENTERED,

                 96 '|', 97(12) '####'   CENTERED,

                109 '|', 110(08) '##'    CENTERED,

                118 '|', 119(12) '####'  CENTERED,

                131 '|', 132(10) '####'  CENTERED,

                142 '|', 143(12) '####'  CENTERED,

                155 '|'.

      ULINE AT /01(155).



      LOOP AT GT_FINAL100 INTO GS_FINAL100.  "### ##

        IF GS_FINAL100-ZRDATE IS INITIAL.  "#### ## ##

          CLEAR LV_DATE.

        ELSE.

          WRITE GS_FINAL100-ZRDATE TO LV_DATE.

        ENDIF.



        WRITE: /01 '|', 02(09) GS_FINAL100-ZORDNO,

                 11 '|', 12(08) GS_FINAL100-ZIDCODE,

                 20 '|', 21(10) GS_FINAL100-ZMATNR,

                 31 '|', 32(15) GS_FINAL100-ZMATNAME,

                 47 '|', 48(10) GS_FINAL100-ZMTART_TEXT,

                 58 '|', 59(05) GS_FINAL100-ZVOLUM,

                 64 '|', 65(05) GS_FINAL100-VRKME,

                 70 '|', 71(12) GS_FINAL100-ZNSAMT CURRENCY 'KRW' RIGHT-JUSTIFIED,

                 83 '|', 84(12) GS_FINAL100-ZSLAMT CURRENCY 'KRW' RIGHT-JUSTIFIED,

                 96 '|', 97(12) GS_FINAL100-ZDCAMT CURRENCY 'KRW' RIGHT-JUSTIFIED,

                109 '|', 110(08) GS_FINAL100-ZSALE_TEXT,

                118 '|', 119(12) GS_FINAL100-ZJDATE,

                131 '|', 132(10) GS_FINAL100-ZRET_TEXT,

                142 '|', 143(12) LV_DATE,

                155 '|'.

        ULINE AT /01(155).

      ENDLOOP.

    ELSE.    "###### X

      ULINE AT /01(131).  "## ##

      WRITE: /01 '|', 02(09) '####'      CENTERED,

                 11 '|', 12(08) 'ID'      CENTERED,

                 20 '|', 21(10) '####'   CENTERED,

                 31 '|', 32(15) '###'    CENTERED,

                 47 '|', 48(10) '####'   CENTERED,

                 58 '|', 59(05) '##'     CENTERED,

                 64 '|', 65(05) '##'     CENTERED,

                 70 '|', 71(12) '####'   CENTERED,

                 83 '|', 84(12) '####'   CENTERED,

                 96 '|', 97(12) '####'   CENTERED,

                109 '|', 110(08) '##'    CENTERED,

                118 '|', 119(12) '####'  CENTERED,

                131 '|'.

      ULINE AT /01(131).



      LOOP AT GT_FINAL100 INTO GS_FINAL100.  "### ##

        WRITE: /01 '|', 02(09) GS_FINAL100-ZORDNO,

                 11 '|', 12(08) GS_FINAL100-ZIDCODE,

                 20 '|', 21(10) GS_FINAL100-ZMATNR,

                 31 '|', 32(15) GS_FINAL100-ZMATNAME,

                 47 '|', 48(10) GS_FINAL100-ZMTART_TEXT,

                 58 '|', 59(05) GS_FINAL100-ZVOLUM,

                 64 '|', 65(05) GS_FINAL100-VRKME,

                 70 '|', 71(12) GS_FINAL100-ZNSAMT CURRENCY 'KRW' RIGHT-JUSTIFIED,

                 83 '|', 84(12) GS_FINAL100-ZSLAMT CURRENCY 'KRW' RIGHT-JUSTIFIED,

                 96 '|', 97(12) GS_FINAL100-ZDCAMT CURRENCY 'KRW' RIGHT-JUSTIFIED,

                109 '|', 110(08) GS_FINAL100-ZSALE_TEXT,

                118 '|', 119(12) GS_FINAL100-ZJDATE,

                131 '|'.

        ULINE AT /01(131).

      ENDLOOP.

    ENDIF.



  ELSEIF P_R2 = 'X'.  "####

    IF GT_FINAL101 IS INITIAL.   "GT_PRINT101# #### ### ##

      MESSAGE '### ## ### ####.' TYPE 'S'.

      RETURN.

    ENDIF.



    IF P_CH1 = 'X'.   "######

      ULINE AT /01(131).  "## ##

        WRITE: /01 '|', 02(09) '####'      CENTERED,

                   11 '|', 12(08) 'ID'     CENTERED,

                   20 '|', 21(10) '####'   CENTERED,

                   31 '|', 32(15) '###'    CENTERED,

                   47 '|', 48(10) '####'   CENTERED,

                   58 '|', 59(05) '##'     CENTERED,

                   64 '|', 65(05) '##'     CENTERED,

                   70 '|', 71(12) '####'   CENTERED,

                   83 '|', 84(12) '####'   CENTERED,

                   96 '|', 97(08) '##'     CENTERED,

                  105 '|', 106(12) '####'  CENTERED,

                  118 '|', 119(12) '####'  CENTERED,

                  131 '|'.

        ULINE AT /01(131).



      LOOP AT GT_FINAL101 INTO GS_FINAL101.  "### ##

        IF GS_FINAL101-ZRDATE IS INITIAL.  "#### ## ##

          CLEAR LV_DATE.

        ELSE.

          WRITE GS_FINAL101-ZRDATE TO LV_DATE.

        ENDIF.



        WRITE: /01 '|', 02(09) GS_FINAL101-ZORDNO,

                   11 '|', 12(08) GS_FINAL101-ZIDCODE,

                   20 '|', 21(10) GS_FINAL101-ZMATNR,

                   31 '|', 32(15) GS_FINAL101-ZMATNAME,

                   47 '|', 48(10) GS_FINAL101-ZMTART_TEXT,

                   58 '|', 59(05) GS_FINAL101-ZVOLUM,

                   64 '|', 65(05) GS_FINAL101-VRKME,

                   70 '|', 71(12) GS_FINAL101-ZSLAMT CURRENCY 'KRW' RIGHT-JUSTIFIED,

                   83 '|', 84(12) GS_FINAL101-ZDFLAG_TEXT,

                   96 '|', 97(08) GS_FINAL101-ZDGUBUN_TEXT,

                  105 '|', 106(12) GS_FINAL101-ZDDATE,

                  118 '|', 119(12) LV_DATE,

                  131 '|'.

        ULINE AT /01(131).

      ENDLOOP.

    ELSE.   "###### X

      ULINE AT /01(118).  "## ##

        WRITE: /01 '|', 02(09) '####'      CENTERED,

                   11 '|', 12(08) 'ID'     CENTERED,

                   20 '|', 21(10) '####'   CENTERED,

                   31 '|', 32(15) '###'    CENTERED,

                   47 '|', 48(10) '####'   CENTERED,

                   58 '|', 59(05) '##'     CENTERED,

                   64 '|', 65(05) '##'     CENTERED,

                   70 '|', 71(12) '####'   CENTERED,

                   83 '|', 84(12) '####'   CENTERED,

                   96 '|', 97(08) '##'     CENTERED,

                  105 '|', 106(12) '####'  CENTERED,

                  118 '|'.

        ULINE AT /01(118).



      LOOP AT GT_FINAL101 INTO GS_FINAL101.  "### ##

        WRITE: /01 '|', 02(09) GS_FINAL101-ZORDNO,

                   11 '|', 12(08) GS_FINAL101-ZIDCODE,

                   20 '|', 21(10) GS_FINAL101-ZMATNR,

                   31 '|', 32(15) GS_FINAL101-ZMATNAME,

                   47 '|', 48(10) GS_FINAL101-ZMTART_TEXT,

                   58 '|', 59(05) GS_FINAL101-ZVOLUM,

                   64 '|', 65(05) GS_FINAL101-VRKME,

                   70 '|', 71(12) GS_FINAL101-ZSLAMT CURRENCY 'KRW' RIGHT-JUSTIFIED,

                   83 '|', 84(12) GS_FINAL101-ZDFLAG_TEXT,

                   96 '|', 97(08) GS_FINAL101-ZDGUBUN_TEXT,

                  105 '|', 106(12) GS_FINAL101-ZDDATE,

                  118 '|'.

        ULINE AT /01(118).

      ENDLOOP.

    ENDIF.

  ENDIF.



ENDFORM.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ## ### ####.