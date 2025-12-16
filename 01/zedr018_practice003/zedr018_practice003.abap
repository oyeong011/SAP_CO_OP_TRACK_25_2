
*&---------------------------------------------------------------------*

*& Report ZEDR018_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR018_PRACTICE003.



TABLES : ZEDT018_100, ZEDT018_101.



CONSTANTS : C_DMIN TYPE DATE VALUE '19000101',

            C_DMAX TYPE DATE VALUE '99991231',

            C_NMIN TYPE C LENGTH 10 VALUE '0000000000',

            C_NMAX TYPE C LENGTH 10 VALUE '9999999999',

            C_ID   TYPE C LENGTH 10 VALUE 'SSU-**'.



RANGES : GR_ZID FOR ZEDT018_100-ZIDCODE,

  GR_ZORDNO FOR ZEDT018_100-ZORDNO,

  GR_ZMATNR FOR ZEDT018_100-ZMATNR,

  GR_ZJDATE FOR ZEDT018_100-ZJDATE,

  GR_ZDDATE FOR ZEDT018_101-ZDDATE.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

SELECT-OPTIONS : S_ZORDNO FOR ZEDT018_100-ZORDNO.

PARAMETERS : P_ZID LIKE ZEDT018_100-ZIDCODE.

SELECT-OPTIONS : S_ZMATNR FOR ZEDT018_100-ZMATNR.

SELECT-OPTIONS : S_ZJDATE FOR ZEDT018_100-ZJDATE MODIF ID M1.

SELECT-OPTIONS : S_ZDDATE FOR ZEDT018_101-ZDDATE MODIF ID M2.

SELECTION-SCREEN END OF BLOCK B1.





SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

SELECTION-SCREEN BEGIN OF LINE.

PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.

SELECTION-SCREEN COMMENT (10) FOR FIELD P_R1. " ### ## ## #(###) ##

SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.

PARAMETERS : P_R2 RADIOBUTTON GROUP R1. "## ## ### ### ## ##### #.

SELECTION-SCREEN COMMENT (10) FOR FIELD P_R2. " ## #(###) ##

SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

PARAMETERS : Z_CHECK AS CHECKBOX DEFAULT 'X'.

SELECTION-SCREEN END OF BLOCK B3.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R2 = 'X'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    IF SCREEN-GROUP1 = 'M2'.

      IF P_R2 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R1 = 'X'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



FORM MAKE_RANGES.



  " --- ##ID ---

  CLEAR GR_ZID.

  IF P_ZID IS INITIAL.

    GR_ZID-SIGN = 'I'.

    GR_ZID-OPTION = 'CP'.

    GR_ZID-LOW  = C_ID.

  ELSE.

    GR_ZID-SIGN = 'I'.

    GR_ZID-OPTION = 'EQ'.

    GR_ZID-LOW  = P_ZID.

  ENDIF.

  APPEND GR_ZID.



  " --- #### ---

  CLEAR GR_ZORDNO.

  GR_ZORDNO-SIGN   = 'I'.

  GR_ZORDNO-OPTION = 'BT'.

  IF S_ZORDNO[] IS INITIAL.

    GR_ZORDNO-LOW    = C_NMIN.

    GR_ZORDNO-HIGH   = C_NMAX.

  ELSE.

    GR_ZORDNO-LOW    = S_ZORDNO-LOW.

    GR_ZORDNO-HIGH   = S_ZORDNO-HIGH.

  ENDIF.

  APPEND GR_ZORDNO.



  " --- #### ---

  CLEAR GR_ZMATNR.

  GR_ZMATNR-SIGN   = 'I'.

  GR_ZMATNR-OPTION = 'BT'.

  IF S_ZMATNR[] IS INITIAL.

    GR_ZMATNR-LOW    = C_NMIN.

    GR_ZMATNR-HIGH   = C_NMAX.

  ELSE.

    GR_ZMATNR-LOW    = S_ZMATNR-LOW.

    GR_ZMATNR-HIGH   = S_ZMATNR-HIGH.

  ENDIF.

  APPEND GR_ZMATNR.



  " --- #### ---

  CLEAR GR_ZJDATE.

  GR_ZJDATE-SIGN   = 'I'.

  GR_ZJDATE-OPTION = 'BT'.

  IF S_ZJDATE[] IS INITIAL.

    GR_ZJDATE-LOW    = C_DMIN.

    GR_ZJDATE-HIGH   = C_DMAX.

  ELSE.

    GR_ZJDATE-LOW    = S_ZJDATE-LOW.

    GR_ZJDATE-HIGH   = S_ZJDATE-HIGH.

  ENDIF.

  APPEND GR_ZJDATE.



  " --- #### ---

  CLEAR GR_ZDDATE.

  GR_ZDDATE-SIGN   = 'I'.

  GR_ZDDATE-OPTION = 'BT'.

  IF S_ZDDATE[] IS INITIAL.

    GR_ZDDATE-LOW    = C_DMIN.

    GR_ZDDATE-HIGH   = C_DMAX.

  ELSE.

    GR_ZDDATE-LOW    = S_ZDDATE-LOW.

    GR_ZDDATE-HIGH   = S_ZDDATE-HIGH.

  ENDIF.

  APPEND GR_ZDDATE.

ENDFORM.



"data

"### ### ###

DATA : BEGIN OF GS_PRINT,

         ZORDNO       LIKE ZEDT018_100-ZORDNO,

         ZIDCODE      LIKE ZEDT018_100-ZIDCODE,

         ZMATNR       LIKE ZEDT018_100-ZMATNR,

         ZMTART       LIKE ZEDT018_100-ZMTART,

         ZMATNAME     LIKE ZEDT018_100-ZMATNAME,

         ZVOLUM       LIKE ZEDT018_100-ZVOLUM,

         VRKME        LIKE ZEDT018_100-VRKME,

         ZNSAMT       LIKE ZEDT018_100-ZNSAMT,

         ZSLAMT       LIKE ZEDT018_100-ZSLAMT,

         ZDCAMT       LIKE ZEDT018_100-ZDCAMT,

         ZDC_FG       LIKE ZEDT018_100-ZDC_FG,

         ZSALE_FG     LIKE ZEDT018_100-ZSALE_FG,

         ZRET_FG      LIKE ZEDT018_100-ZRET_FG,

         ZJDATE       LIKE ZEDT018_100-ZJDATE,

         ZRDATE       LIKE ZEDT018_100-ZRDATE,

         ZDFLAG       LIKE ZEDT018_101-ZDFLAG,

         ZDGUBUN      LIKE ZEDT018_101-ZDGUBUN,

         ZDDATE       LIKE ZEDT018_101-ZDDATE,

         ZFLAG        LIKE ZEDT018_101-ZFLAG,



         "## ###

         C_ZMTART(10) TYPE C, "####

         C_ZDC(6)     TYPE C, "####

         C_ZSALE(5)   TYPE C, "####

         C_ZRET(10)   TYPE C, "####

         C_ZDFLAG(8)  TYPE C, "####

         C_ZDGUBUN(8) TYPE C, "####

         C_ZRDATE(10) TYPE C, "####



         I_ZSLAMT     TYPE I,

         I_ZNSAMT     TYPE I,

         I_ZDCAMT     TYPE I,





       END OF GS_PRINT.

DATA : GT_PRINT LIKE TABLE OF GS_PRINT.

DATA: PV_ZRET TYPE C. "#### ####



INITIALIZATION. "## range ## ## ##.

  RANGES : LR_DATE FOR SY-DATUM. "range ## -> month

  DATA : LV_FIRST TYPE D.

  DATA : LV_LAST TYPE D.



  LV_FIRST = SY-DATUM.

  LV_FIRST+6(2) = '01'.



  CALL FUNCTION 'LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN            = LV_FIRST

    IMPORTING

      LAST_DAY_OF_MONTH = LV_LAST.



  CLEAR LR_DATE.

  LR_DATE-SIGN = 'I'.

  LR_DATE-OPTION = 'BT'.

  LR_DATE-LOW = LV_FIRST.

  LR_DATE-HIGH = LV_LAST.



  CLEAR S_ZJDATE. APPEND LR_DATE TO S_ZJDATE.

  CLEAR S_ZDDATE. APPEND LR_DATE TO S_ZDDATE.



START-OF-SELECTION.

  PERFORM MAKE_RANGES.

  IF Z_CHECK = 'X'.

    PV_ZRET = 'X'.

    PERFORM GET_DATA_CH.

  ELSE.

    CLEAR PV_ZRET.

    PERFORM GET_DATA.

  ENDIF.



  PERFORM MODIFY_TABLE_FOR_PRINT.



END-OF-SELECTION. "## ## ### #### ## ### ##.

  IF P_R1 = 'X'.

    PERFORM WRITE_DATA_OR.

  ELSE.

    PERFORM WRITE_DATA_DV.

  ENDIF.



  " ## ## ## -> table 101## zflag #### ## ## .



  "form

FORM GET_DATA. "### # ## ##, ## ##

  CLEAR GT_PRINT.

  IF P_R1 = 'X'. "####

    SELECT * FROM ZEDT018_100

      INTO CORRESPONDING FIELDS OF TABLE GT_PRINT

      WHERE ZORDNO IN GR_ZORDNO

      AND ZIDCODE IN GR_ZID

      AND ZMATNR IN GR_ZMATNR

      AND ZJDATE IN GR_ZJDATE

      AND ZRET_FG NOT IN ( 1,2,3 ).

  ELSE. "####

    SELECT * FROM ZEDT018_101

      INTO CORRESPONDING FIELDS OF TABLE GT_PRINT

      WHERE ZORDNO IN GR_ZORDNO

      AND ZIDCODE IN GR_ZID

      AND ZMATNR IN GR_ZMATNR

      AND ZDDATE IN GR_ZDDATE

      AND ZFLAG NE 'X'.

  ENDIF.

ENDFORM.

FORM GET_DATA_CH. "## ##

  CLEAR GT_PRINT.

  IF P_R1 = 'X'. "####

    SELECT * FROM ZEDT018_100

      INTO CORRESPONDING FIELDS OF TABLE GT_PRINT

      WHERE ZORDNO IN GR_ZORDNO

      AND ZIDCODE IN GR_ZID

      AND ZMATNR IN GR_ZMATNR

      AND ZJDATE IN GR_ZJDATE

      .

  ELSE. "####

    SELECT * FROM ZEDT018_101

      INTO CORRESPONDING FIELDS OF TABLE GT_PRINT

      WHERE ZORDNO IN GR_ZORDNO

      AND ZIDCODE IN GR_ZID

      AND ZMATNR IN GR_ZMATNR

      AND ZDDATE IN GR_ZDDATE.

  ENDIF.

ENDFORM.



" ### ## ### ##

FORM MODIFY_TABLE_FOR_PRINT.

  LOOP AT GT_PRINT INTO GS_PRINT.

    GS_PRINT-I_ZNSAMT = GS_PRINT-ZNSAMT * 100.

    GS_PRINT-I_ZSLAMT = GS_PRINT-ZSLAMT * 100.

    GS_PRINT-I_ZDCAMT = GS_PRINT-ZDCAMT * 100.



    "## ##

    CASE GS_PRINT-ZMTART.

      WHEN '001'.

        GS_PRINT-C_ZMTART = '##'.

      WHEN '002'.

        GS_PRINT-C_ZMTART = '##'.

      WHEN '003'.

        GS_PRINT-C_ZMTART = '##'.

      WHEN '004'.

        GS_PRINT-C_ZMTART = '##'.

      WHEN '005'.

        GS_PRINT-C_ZMTART = '##'.

      WHEN '006'.

        GS_PRINT-C_ZMTART = '###'.

    ENDCASE.



    "## ##

    CASE GS_PRINT-ZDC_FG.

      WHEN '1'.

        GS_PRINT-C_ZDC = '#####'.

      WHEN '2'.

        GS_PRINT-C_ZDC = '######'.

      WHEN '3'.

        GS_PRINT-C_ZDC = '####'.

      WHEN '4'.

        GS_PRINT-C_ZDC = '####'.

    ENDCASE.



    "## ##

    CASE GS_PRINT-ZSALE_FG.

      WHEN '1'.

        GS_PRINT-C_ZSALE = '##'.

      WHEN '2'.

        GS_PRINT-C_ZSALE = '##'.

    ENDCASE.



    "## ##

    CASE GS_PRINT-ZRET_FG.

      WHEN '1'.

        GS_PRINT-C_ZRET = '####'.

      WHEN '2'.

        GS_PRINT-C_ZRET = '####'.

      WHEN '3'.

        GS_PRINT-C_ZRET = '####'.

    ENDCASE.





    " ####

    CASE GS_PRINT-ZDFLAG.

      WHEN '1'.

        GS_PRINT-C_ZDFLAG = '####'.

      WHEN '2'.

        GS_PRINT-C_ZDFLAG = '###'.

    ENDCASE.



    " ## ##

    CASE GS_PRINT-ZDGUBUN.

      WHEN '1'.

        GS_PRINT-C_ZDGUBUN = '###'.

      WHEN '2'.

        GS_PRINT-C_ZDGUBUN = '###'.

      WHEN '3'.

        GS_PRINT-C_ZDGUBUN = '###'.

      WHEN '4'.

        GS_PRINT-C_ZDGUBUN = '###'.

      WHEN '5'.

        GS_PRINT-C_ZDGUBUN = '###'.

      WHEN '6'.

        GS_PRINT-C_ZDGUBUN = '###'.

      WHEN '7'.

        GS_PRINT-C_ZDGUBUN = '###'.

    ENDCASE.



    " ## ##

    IF GS_PRINT-ZRDATE IS NOT INITIAL.

      WRITE GS_PRINT-ZRDATE TO GS_PRINT-C_ZRDATE.

    ENDIF.



    MODIFY GT_PRINT FROM GS_PRINT INDEX SY-TABIX.

  ENDLOOP.

ENDFORM.





" ####### ##

FORM WRITE_DATA_OR.

  IF PV_ZRET = 'X'.

    WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

  ELSE.

    WRITE :/ '-----------------------------------------------------------------------------------------------------------------------------------------------------------------'.

  ENDIF.

  WRITE:

/ '|', (10) '####',

  '|', (10) 'ID',

  '|', (10) '####',

  '|', (20) '###',

  '|', (10) '####',

  '|', (5) '##',

  '|', (5) '##',

  '|', (13) '####',

  '|', (13) '####',

  '|', (13) '####',

  '|', (5) '##',

  '|', (10) '####'.



  IF PV_ZRET = 'X'.

    WRITE : '|', (10) '####', '|', (10) '####', '|'.

    WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

  ELSE.

    WRITE : '|'.

    WRITE :/ '-----------------------------------------------------------------------------------------------------------------------------------------------------------------'.

  ENDIF.

  LOOP AT GT_PRINT INTO GS_PRINT.

    WRITE:

      / '|', GS_PRINT-ZORDNO,

        '|', GS_PRINT-ZIDCODE,

        '|', GS_PRINT-ZMATNR,

        '|', GS_PRINT-ZMATNAME,

        '|', GS_PRINT-C_ZMTART,

        '|', (5) GS_PRINT-ZVOLUM,

        '|', (5) GS_PRINT-VRKME,

        '|', (13) GS_PRINT-I_ZNSAMT,

        '|', (13)GS_PRINT-I_ZSLAMT,

        '|', (13)GS_PRINT-I_ZDCAMT,

        '|', GS_PRINT-C_ZSALE,

        '|', GS_PRINT-ZJDATE.

    "#### #### ##

    IF PV_ZRET = 'X'.

      WRITE:

                '|', GS_PRINT-C_ZRET,

                '|', GS_PRINT-C_ZRDATE,

                '|'.

      WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

    ELSE.

      WRITE: '|'.

      WRITE :/ '-----------------------------------------------------------------------------------------------------------------------------------------------------------------'.

    ENDIF.

  ENDLOOP.

ENDFORM.



" ####### ##

FORM WRITE_DATA_DV.

  IF PV_ZRET = 'X'.

    WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------------------'.

  ELSE.

    WRITE :/ '---------------------------------------------------------------------------------------------------------------------------------------------------'.

  ENDIF.

  WRITE:

/ '|', (10) '####',

  '|', (10) 'ID',

  '|', (10) '####',

  '|', (20) '###',

  '|', (10) '####',

  '|', (5) '##',

  '|', (5) '##',

  '|', (13) '####',

  '|', (10) '####',

  '|', (10) '##',

  '|', (10) '####'.



  IF PV_ZRET = 'X'.

    WRITE : '|', (10) '####', '|'.

    WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------------------'.

  ELSE.

    WRITE : '|'.

    WRITE :/ '---------------------------------------------------------------------------------------------------------------------------------------------------'.

  ENDIF.

  LOOP AT GT_PRINT INTO GS_PRINT.

    WRITE:

      / '|', GS_PRINT-ZORDNO,

        '|', GS_PRINT-ZIDCODE,

        '|', GS_PRINT-ZMATNR,

        '|', GS_PRINT-ZMATNAME,

        '|', GS_PRINT-C_ZMTART,

        '|', (5) GS_PRINT-ZVOLUM,

        '|', (5) GS_PRINT-VRKME,

        '|', (13) GS_PRINT-I_ZSLAMT,

        '|', (10) GS_PRINT-C_ZDFLAG,

        '|', (10) GS_PRINT-C_ZDGUBUN,

        '|', GS_PRINT-ZDDATE.

    "#### #### ##

    IF PV_ZRET = 'X'.

      WRITE:

                '|', GS_PRINT-C_ZRDATE,

                '|'.

      WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------------------'.

    ELSE.

      WRITE: '|'.

      WRITE :/ '---------------------------------------------------------------------------------------------------------------------------------------------------'.

    ENDIF.



  ENDLOOP.

ENDFORM.