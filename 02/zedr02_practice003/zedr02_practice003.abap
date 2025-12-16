
*&---------------------------------------------------------------------*

*& Report ZEDR02_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_PRACTICE003.



"### ####

TABLES : ZEDT02_101, ZEDT02_100.



"#### ### ### ##

DATA: BEGIN OF GS_ORDER.

  include structure
ZEDT02_100
.

DATA : END OF GS_ORDER.

DATA : GT_ORDER LIKE TABLE OF GS_ORDER.



"#### ### ### ##

DATA: BEGIN OF GS_SHIP.

  include structure
ZEDT02_101
.

DATA : END OF GS_SHIP.

DATA : GT_SHIP LIKE TABLE OF GS_SHIP.



"### ### ### ##

DATA: BEGIN OF GS_OUTPUT,

  ZORDNO LIKE ZEDT02_100-ZORDNO, "####

  ZIDCODE LIKE ZEDT02_100-ZIDCODE, "##ID

  ZMATNR LIKE ZEDT02_100-ZMATNR, "####

  ZMTART TYPE C LENGTH 10, "####

  ZMATNAME LIKE ZEDT02_100-ZMATNAME, "###

  ZVOLUM LIKE ZEDT02_100-ZVOLUM, "##

  VOLUM LIKE ZEDT02_100-VOLUM, "Volume

  VRKME LIKE ZEDT02_100-VRKME, "Sales Unit

  ZNSAMT LIKE ZEDT02_100-ZNSAMT, "####

  ZSLAMT LIKE ZEDT02_100-ZSLAMT, "####

  ZDCAMT LIKE ZEDT02_100-ZDCAMT, "####

  ZSALE_FG TYPE C LENGTH 10, "##(####)

  ZRET_FG TYPE C LENGTH 10, "####

  ZJDATE LIKE ZEDT02_100-ZJDATE, "####

  ZRDATE TYPE C LENGTH 10, "####

  ZDFLAG TYPE C LENGTH 10, "####

  ZDGUBUN TYPE C LENGTH 10, "####

  ZDDATE LIKE ZEDT02_101-ZDDATE, "####

END OF GS_OUTPUT.

DATA: GT_OUTPUT LIKE TABLE OF GS_OUTPUT.



DATA: GV_SDATE TYPE D, GV_EDATE TYPE D. "#### ### ### ###, ##

RANGES : GR_REFUND FOR ZEDT02_100-ZRDATE. "#### ## ### ### RANGE ##

CONSTANTS: C_RATE TYPE I VALUE '100'. "### ### ## ##



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZORDNO FOR ZEDT02_100-ZORDNO. "####

  SELECT-OPTIONS : S_ZCODE FOR ZEDT02_100-ZIDCODE NO-EXTENSION NO INTERVALS. "##ID

  SELECT-OPTIONS : S_ZMATNR FOR ZEDT02_100-ZMATNR. "####

  SELECT-OPTIONS : S_ZJDATE FOR ZEDT02_100-ZJDATE MODIF ID M1. "####

  SELECT-OPTIONS : S_ZDDATE FOR ZEDT02_101-ZDDATE MODIF ID M2. "####

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_ORDER RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. "####

  PARAMETERS : P_SHIP RADIOBUTTON GROUP R1. "####

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS : P_RE AS CHECKBOX DEFAULT 'X'. "#### ##

SELECTION-SCREEN END OF BLOCK B3.



"##### ## default ##

INITIALIZATION.

GV_SDATE = SY-DATUM.

GV_EDATE = SY-DATUM.

GV_SDATE+6(2) = '01'. "# ## #### ##

"# ## ##### ##

CASE GV_SDATE+4(2).

  WHEN '01' OR '03' OR '05' OR '07' OR '08' OR '10' OR '12'.

    GV_EDATE+6(2) = '31'.

  WHEN '04' OR '06' OR '09' OR '11'.

    GV_EDATE+6(2) = '30'.

  WHEN '02'.

    IF ( GV_SDATE(4) MOD 4 = 0  AND GV_SDATE(4) MOD 100 <> 0 ) OR ( GV_SDATE(4) MOD 400 = 0 ).

      GV_EDATE+6(2) = '29'.

    ELSE.

      GV_EDATE+6(2) = '28'.

    ENDIF.

  ENDCASE.

S_ZJDATE-LOW = GV_SDATE.

S_ZJDATE-HIGH = GV_EDATE.

APPEND S_ZJDATE.

S_ZDDATE-LOW = GV_SDATE.

S_ZDDATE-HIGH = GV_EDATE.

APPEND S_ZDDATE.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    "#### ##### ### ##### ##

    IF SCREEN-GROUP1 = 'M1'.

      IF P_ORDER = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSEIF P_SHIP = 'X'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    "#### ##### ### ##### ##

    IF SCREEN-GROUP1 = 'M2'.

      IF P_ORDER = 'X'.

        SCREEN-ACTIVE = '0'.

      ELSEIF P_SHIP = 'X'.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



START-OF-SELECTION.

  PERFORM GET_DATA. "##### ### ## #### ### #### ##

  PERFORM APPEND_DATA. "### #### ### #### ##

  PERFORM WRITE_DATA. "### ##






*END-OF-SELECTION.

*  PERFORM WRITE_DATA.

*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  GR_REFUND-SIGN = 'I'.

  GR_REFUND-LOW = '00000000'.

  IF P_RE IS INITIAL. "###### ##### #### ## ## ##

    GR_REFUND-OPTION = 'EQ'. "##### ### ### ##### #

  ELSE. "###### ##### ### ##

    GR_REFUND-OPTION = 'GE'. "##### ### ## ### ##### #

  ENDIF.

  APPEND GR_REFUND.



  IF P_ORDER = 'X'. "####

    SELECT * FROM ZEDT02_100

      INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

      WHERE ZIDCODE IN S_ZCODE "####

      AND ZORDNO IN S_ZORDNO "##ID

      AND ZMATNR IN S_ZMATNR "####

      AND ZJDATE IN S_ZJDATE "####

      AND ZRDATE IN GR_REFUND. "RANGE ## ##->##### ### ### ######



  ELSEIF P_SHIP = 'X'. "####

    SELECT * FROM ZEDT02_101

      INTO CORRESPONDING FIELDS OF TABLE GT_SHIP

      WHERE ZIDCODE IN S_ZCODE "####

      AND ZORDNO IN S_ZORDNO "##ID

      AND ZMATNR IN S_ZMATNR "####

      AND ZDDATE IN S_ZDDATE "####

      AND ZRDATE IN GR_REFUND. "RANGE ## ##->##### ### ### ######

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

  LOOP AT GT_OUTPUT INTO GS_OUTPUT.

   IF P_ORDER = 'X'.

     IF P_RE IS INITIAL.

       "#### / #### ###

       AT FIRST.

         WRITE: / '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

         WRITE: / '|  ####  |     ID     |  ####  |        ###        |  ####  |## |## |     ####      |     ####      |     ####      |    ##    |  ####  |'.

         WRITE: / '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

       ENDAT.

       WRITE: / '|', GS_OUTPUT-ZORDNO, '|', GS_OUTPUT-ZIDCODE, '|', GS_OUTPUT-ZMATNR, '|',

         GS_OUTPUT-ZMATNAME, '|', GS_OUTPUT-ZMTART, '|', GS_OUTPUT-ZVOLUM, '|', GS_OUTPUT-VRKME, '|',

         GS_OUTPUT-ZNSAMT DECIMALS 0, '|', GS_OUTPUT-ZSLAMT DECIMALS 0, '|', GS_OUTPUT-ZDCAMT DECIMALS 0, '|',

         GS_OUTPUT-ZSALE_FG, '|', GS_OUTPUT-ZJDATE, '|'.

       WRITE: / '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

     ELSE.

       "####/#### ##

       AT FIRST.

         WRITE: / '--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

         WRITE: / '|  ####  |     ID     |  ####  |        ###        |  ####  |## |## |     ####      |     ####      |     ####      |    ##    |  ####  |  ####  |  ####  |'.

         WRITE: / '--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

       ENDAT.

       WRITE: / '|', GS_OUTPUT-ZORDNO, '|', GS_OUTPUT-ZIDCODE, '|', GS_OUTPUT-ZMATNR, '|',

         GS_OUTPUT-ZMATNAME, '|', GS_OUTPUT-ZMTART, '|', GS_OUTPUT-ZVOLUM, '|', GS_OUTPUT-VRKME, '|',

         GS_OUTPUT-ZNSAMT DECIMALS 0, '|', GS_OUTPUT-ZSLAMT DECIMALS 0, '|', GS_OUTPUT-ZDCAMT DECIMALS 0, '|',

         GS_OUTPUT-ZSALE_FG, '|', GS_OUTPUT-ZJDATE, '|', GS_OUTPUT-ZRET_FG, '|', GS_OUTPUT-ZRDATE, '|'.

       WRITE: / '--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

     ENDIF.

   ELSEIF P_SHIP = 'X'.

     IF P_RE IS INITIAL.

       "#### / #### ###

       AT FIRST.

         WRITE: / '---------------------------------------------------------------------------------------------------------------------------------------------------'.

         WRITE: / '|  ####  |     ID     |  ####  |        ###        |  ####  |## |## |     ####      |  ####  |    ##    |  ####  |'.

         WRITE: / '---------------------------------------------------------------------------------------------------------------------------------------------------'.

       ENDAT.

       WRITE: / '|', GS_OUTPUT-ZORDNO, '|', GS_OUTPUT-ZIDCODE, '|', GS_OUTPUT-ZMATNR, '|',

         GS_OUTPUT-ZMATNAME, '|', GS_OUTPUT-ZMTART, '|', GS_OUTPUT-ZVOLUM, '|', GS_OUTPUT-VRKME, '|',

         GS_OUTPUT-ZSLAMT DECIMALS 0, '|', GS_OUTPUT-ZDFLAG, '|', GS_OUTPUT-ZDGUBUN, '|',

         GS_OUTPUT-ZDDATE, '|'.

       WRITE: / '---------------------------------------------------------------------------------------------------------------------------------------------------'.

     ELSE.

       "####/#### ##

       AT FIRST.

         WRITE: / '----------------------------------------------------------------------------------------------------------------------------------------------------------------'.

         WRITE: / '|  ####  |     ID     |  ####  |        ###        |  ####  |## |## |     ####      |  ####  |    ##    |  ####  |  ####  |'.

         WRITE: / '----------------------------------------------------------------------------------------------------------------------------------------------------------------'.

       ENDAT.

       WRITE: / '|', GS_OUTPUT-ZORDNO, '|', GS_OUTPUT-ZIDCODE, '|', GS_OUTPUT-ZMATNR, '|',

         GS_OUTPUT-ZMATNAME, '|', GS_OUTPUT-ZMTART, '|', GS_OUTPUT-ZVOLUM, '|', GS_OUTPUT-VRKME, '|',

         GS_OUTPUT-ZSLAMT DECIMALS 0, '|', GS_OUTPUT-ZDFLAG, '|', GS_OUTPUT-ZDGUBUN, '|',

         GS_OUTPUT-ZDDATE, '|', GS_OUTPUT-ZRDATE, '|'.

       WRITE: / '----------------------------------------------------------------------------------------------------------------------------------------------------------------'.

     ENDIF.

   ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  APPEND_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM APPEND_DATA .

  IF P_ORDER = 'X'. "####

    LOOP AT GT_ORDER INTO GS_ORDER.

      GS_OUTPUT-ZORDNO = GS_ORDER-ZORDNO. "####

      "SHIFT GS_OUTPUT-ZORDNO LEFT DELETING LEADING '0'. "## 0 ###



      GS_OUTPUT-ZIDCODE = GS_ORDER-ZIDCODE. "##ID



      GS_OUTPUT-ZMATNR = GS_ORDER-ZMATNR. "####

      "SHIFT GS_OUTPUT-ZMATNR LEFT DELETING LEADING '0'. "## 0 ###



      GS_OUTPUT-ZMATNAME = GS_ORDER-ZMATNAME. "###



      CASE GS_ORDER-ZMTART. "####

        WHEN '001'.

          GS_OUTPUT-ZMTART = '##'.

        WHEN '002'.

          GS_OUTPUT-ZMTART = '##'.

        WHEN '003'.

          GS_OUTPUT-ZMTART = '##'.

        WHEN '004'.

          GS_OUTPUT-ZMTART = '##'.

        WHEN '005'.

          GS_OUTPUT-ZMTART = '##'.

        WHEN '006'.

          GS_OUTPUT-ZMTART = '###'.

        ENDCASE.



      GS_OUTPUT-ZVOLUM = GS_ORDER-ZVOLUM. "##

      GS_OUTPUT-VRKME = GS_ORDER-VRKME. "Sales Unit

      GS_OUTPUT-ZNSAMT = GS_ORDER-ZNSAMT * C_RATE. "####

      GS_OUTPUT-ZSLAMT = GS_ORDER-ZSLAMT * C_RATE. "####

      GS_OUTPUT-ZDCAMT = GS_ORDER-ZDCAMT * C_RATE. "####



      CASE GS_ORDER-ZSALE_FG. "##(####)

        WHEN '1'.

          GS_OUTPUT-ZSALE_FG = '##'.

        WHEN '2'.

          GS_OUTPUT-ZSALE_FG = '##'.

      ENDCASE.



      GS_OUTPUT-ZJDATE = GS_ORDER-ZJDATE. "####



      IF P_RE IS NOT INITIAL. "######

        CASE GS_ORDER-ZRET_FG. "####

          WHEN '1'.

            GS_OUTPUT-ZRET_FG = '####'.

          WHEN '2'.

            GS_OUTPUT-ZRET_FG = '####'.

          WHEN '3'.

            GS_OUTPUT-ZRET_FG = '####'.

        ENDCASE.



        "####

        IF GS_ORDER-ZRDATE = '00000000'.

          GS_OUTPUT-ZRDATE = ''. "#### ### ## ##

        ELSE.

          WRITE: GS_ORDER-ZRDATE TO GS_OUTPUT-ZRDATE USING EDIT MASK '____.__.__'. "#### ### YYYY.MM.DD #### ##

        ENDIF.

      ENDIF.



      APPEND GS_OUTPUT TO GT_OUTPUT.

      CLEAR: GS_OUTPUT, GS_ORDER.

    ENDLOOP.



  ELSEIF P_SHIP = 'X'. "####

    LOOP AT GT_SHIP INTO GS_SHIP.

      GS_OUTPUT-ZORDNO = GS_SHIP-ZORDNO. "####

      "SHIFT GS_OUTPUT-ZORDNO LEFT DELETING LEADING '0'. "## 0 ###



      GS_OUTPUT-ZIDCODE = GS_SHIP-ZIDCODE. "##ID



      GS_OUTPUT-ZMATNR = GS_SHIP-ZMATNR. "####

      "SHIFT GS_OUTPUT-ZMATNR LEFT DELETING LEADING '0'. "## 0 ###



      GS_OUTPUT-ZMATNAME = GS_SHIP-ZMATNAME. "###



      CASE GS_SHIP-ZMTART. "####

        WHEN '001'.

          GS_OUTPUT-ZMTART = '##'.

        WHEN '002'.

          GS_OUTPUT-ZMTART = '##'.

        WHEN '003'.

          GS_OUTPUT-ZMTART = '##'.

        WHEN '004'.

          GS_OUTPUT-ZMTART = '##'.

        WHEN '005'.

          GS_OUTPUT-ZMTART = '##'.

        WHEN '006'.

          GS_OUTPUT-ZMTART = '###'.

        ENDCASE.



      GS_OUTPUT-ZVOLUM = GS_SHIP-ZVOLUM. "##

      GS_OUTPUT-VRKME = GS_SHIP-VRKME. "Sales Unit

      GS_OUTPUT-ZSLAMT = GS_SHIP-ZSLAMT * C_RATE. "####



      CASE GS_SHIP-ZDFLAG. "####

        WHEN '1'.

          GS_OUTPUT-ZDFLAG = '####'.

        WHEN '2'.

          GS_OUTPUT-ZDFLAG = '###'.

        WHEN '3'.

          GS_OUTPUT-ZDFLAG = '####'.

      ENDCASE.

      IF GS_SHIP-ZFLAG = 'X'. "#### ### #### # ##

        GS_OUTPUT-ZDFLAG = ''.

      ENDIF.



      CASE GS_SHIP-ZDGUBUN. "####

        WHEN '1'.

          GS_OUTPUT-ZDGUBUN = '###'.

        WHEN '2'.

          GS_OUTPUT-ZDGUBUN = '###'.

        WHEN '3'.

          GS_OUTPUT-ZDGUBUN = '###'.

        WHEN '4'.

          GS_OUTPUT-ZDGUBUN = '###'.

        WHEN '5'.

          GS_OUTPUT-ZDGUBUN = '###'.

        WHEN '6'.

          GS_OUTPUT-ZDGUBUN = '###'.

        WHEN '7'.

          GS_OUTPUT-ZDGUBUN = '###'.

      ENDCASE.



      GS_OUTPUT-ZDDATE = GS_SHIP-ZDDATE. "####



      IF P_RE IS NOT INITIAL. "#### ##

        IF GS_SHIP-ZRDATE = '00000000'.

          GS_OUTPUT-ZRDATE = ''. "#### ### ## ##

        ELSE.

          WRITE: GS_SHIP-ZRDATE TO GS_OUTPUT-ZRDATE USING EDIT MASK '____.__.__'. "#### ### YYYY.MM.DD #### ##

        ENDIF.

      ENDIF.



      APPEND GS_OUTPUT TO GT_OUTPUT.

      CLEAR: GS_OUTPUT, GS_SHIP.

    ENDLOOP.

  ENDIF.

ENDFORM.