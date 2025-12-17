
*&---------------------------------------------------------------------*

*& Report ZEDR10_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR10_PRACTICE003.



" ## #### ##

CONSTANTS C_CURR TYPE WAERS VALUE 'KRW'.    "####

CONSTANTS C_CURR_DIV TYPE P VALUE 100.      "100 ## ##

" ## # # ### ##

CONSTANTS C_ORDER_LINER1 TYPE I VALUE 187.

CONSTANTS C_ORDER_LINER2 TYPE I VALUE 161.

CONSTANTS C_DELIV_LINER1 TYPE I VALUE 156.

CONSTANTS C_DELIV_LINER2 TYPE I VALUE 143.



" STRUCTURE ## # INTERNAL TABLE ## --------------------------------



" ## ## # ## ## ## STRUCT

DATA: BEGIN OF GS_COMBINED,




*    mandt    TYPE mandt,        "Client




        ZORDNO       TYPE ZORDNO10,     "####

        ZIDCODE      TYPE ZIDCODE10,    "##ID

        ZMATNR       TYPE ZMATNR10,     "####

        ZMTART       TYPE ZMTART10,     "####

        ZMATNAME     TYPE ZMATNAME10,   "###

        ZVOLUM       TYPE ZVOLUM10,     "##

        VOLUM        TYPE VOLUM,        "Volume

        VRKME        TYPE VRKME,        "Sales Unit

        ZSLAMT       TYPE ZSLAMT10,     "####

        ZRDATE       TYPE ZDDATE10,     "####



        "============ Fields from ZEDT10_100 ============

        ZNSAMT       TYPE ZSLAMT10,     "####

        ZDCAMT       TYPE ZDCAMT10,     "####

        ZDC_FG       TYPE ZDC_FG10,     "####

        ZSALE_FG     TYPE ZSALE_FG10,   "####

        ZRET_FG      TYPE ZRET_FG10,    "####

        ZJDATE       TYPE ZJDATE10,     "####





        "============ Fields from ZEDT10_101 ============

        ZDFLAG       TYPE ZDFLAG10,     "####

        ZDGUBUN      TYPE ZDGUBUN10,    "####

        ZDDATE       TYPE ZDDATE10,     "####

        ZFLAG        TYPE ZFLAG10,      "####



        "=== ## ###

        C_ZMTART(10) TYPE C, "####

        C_ZDC(6)     TYPE C, "####

        C_ZSALE(5)   TYPE C, "####

        C_ZRET(10)   TYPE C, "####

        C_ZDFLAG(8)  TYPE C, "####

        C_ZDGUBUN(8) TYPE C, "####

        C_ZRDATE(10) TYPE C, "####



        C_ZSLAMT(13) TYPE C,

        C_ZNSAMT(13) TYPE C,

        C_ZDCAMT(13) TYPE C

        .

DATA: END OF GS_COMBINED,

GT_COMBINED LIKE TABLE OF GS_COMBINED.



" ## ## STRUCT # TABLE

DATA: BEGIN OF GS_ORDER.

    include structure
ZEDT10_100
.

DATA: END OF GS_ORDER,

GT_ORDER LIKE TABLE OF GS_ORDER.



" ## ## STRUCTURE # TABLE

DATA: BEGIN OF GS_DELIVERY.

    include structure
ZEDT10_101
.

DATA: END OF GS_DELIVERY,

GT_DELIVERY LIKE TABLE OF GS_DELIVERY.



" #. STRUCTURE ## # INTERNAL TABLE ## --------------------------------



" SELECT-OPTION # PARAMETER ## ----------------------------



" ## ## BLOCK

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

SELECT-OPTIONS:

      S_ORDNO   FOR GS_ORDER-ZORDNO     ,                          " ####

      S_ZIDCO   FOR GS_ORDER-ZIDCODE    NO INTERVALS NO-EXTENSION, " ## ID

      S_MATNR   FOR GS_ORDER-ZMATNR     ,                          " ####

      S_JDATE   FOR GS_ORDER-ZJDATE     MODIF ID S1,               " ####

      S_DDATE   FOR GS_DELIVERY-ZDDATE  MODIF ID S2.



SELECTION-SCREEN END OF BLOCK B1.



" RADIO BUTTON BLOCK ## #### ## #### ##.

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

PARAMETERS:

  P_R_ORD RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1,

  P_R_DEL RADIOBUTTON GROUP R1.

SELECTION-SCREEN END OF BLOCK B2.



" ## ## CHECKBOX BLOCK

SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

PARAMETERS:

      P_C_RET AS CHECKBOX DEFAULT 'X'.

SELECTION-SCREEN END OF BLOCK B3.



" #. SELECT-OPTION # PARAMETER ## ----------------------------



" SCREEN ###



INITIALIZATION.

  " ### ## ###

  " https://zcoding1.tistory.com/4 - ## ####

  DATA: GV_LDAT TYPE SY-DATUM.

  " ## ###.

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN            = SY-DATUM

    IMPORTING

      LAST_DAY_OF_MONTH = GV_LDAT.



  " ## ##

  S_DDATE-HIGH = GV_LDAT.

  S_JDATE-HIGH = GV_LDAT.



  " ## ##

  S_DDATE-LOW = |{ SY-DATUM(6) }01 |.

  S_JDATE-LOW = |{ SY-DATUM(6) }01 |.



  APPEND S_DDATE.

  APPEND S_JDATE.



  " SCREEN ##. ------------------



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    " RADIO BOX ACTION ##

    IF P_R_ORD = 'X'.

      IF SCREEN-GROUP1 = 'S1'. " ####

        SCREEN-ACTIVE = '1'.  " ###

      ELSEIF SCREEN-GROUP1 = 'S2'. " ####

        SCREEN-ACTIVE = '0'.  " ####

      ENDIF.

    ELSEIF P_R_DEL = 'X'.

      IF SCREEN-GROUP1 = 'S1'. " ####

        SCREEN-ACTIVE = '0'.  " ####

      ELSEIF SCREEN-GROUP1 = 'S2'. " ####

        SCREEN-ACTIVE = '1'.  " ###

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

  " #. SCREEN ##. ------------------



  " #### ##.



START-OF-SELECTION.

  " RANGE ##

  DATA : GR_RET_FG TYPE RANGE OF ZEDT10_101-ZFLAG,

         GS_RET_FG LIKE LINE OF GR_RET_FG.

  " ## ## RANGE ##

  GS_RET_FG-SIGN = 'I'.

  GS_RET_FG-LOW = ''.

  " #### RANGE ## ##

  IF P_C_RET = 'X'.

    " 'X'# '1','2','3'# ## INITIAL ### # ## ##.

    GS_RET_FG-OPTION = 'GE'.

  ELSE.

    GS_RET_FG-OPTION = 'EQ'.

  ENDIF.

  APPEND GS_RET_FG TO GR_RET_FG.



  " ## ## ##

  IF P_R_ORD = 'X'.

    SELECT *

      INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

      FROM ZEDT10_100

      WHERE ZORDNO  IN S_ORDNO

      AND   ZIDCODE IN S_ZIDCO

      AND   ZMATNR  IN S_MATNR

      AND   ZJDATE  IN S_JDATE

      AND   ZRET_FG IN GR_RET_FG

      .



    MOVE-CORRESPONDING GT_ORDER[] TO GT_COMBINED[].



    PERFORM MODI_TABLE_4_PRINT.



    PERFORM PRINT_ORDER_TABLE.



    " ## ## ##

  ELSEIF P_R_DEL = 'X'.

    SELECT *

      INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY

      FROM ZEDT10_101

      WHERE ZORDNO IN S_ORDNO

      AND   ZIDCODE IN S_ZIDCO

      AND ZMATNR IN S_MATNR

      AND ZDDATE IN S_DDATE

      AND ZFLAG  IN GR_RET_FG

    .

    MOVE-CORRESPONDING GT_DELIVERY[] TO GT_COMBINED[].



    PERFORM MODI_TABLE_4_PRINT.



    PERFORM PRINT_DELIVERY_TABLE .

  ENDIF.






*&---------------------------------------------------------------------*

*&      Form  MODI_TABLE_4_PRINT

*&---------------------------------------------------------------------*

*       ### ## ## ### ##.

*----------------------------------------------------------------------*

*      <--P_GT_COMBINED  text

*----------------------------------------------------------------------*




FORM MODI_TABLE_4_PRINT.

  LOOP AT GT_COMBINED INTO GS_COMBINED.

    " ## 0 ## ##

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'

      EXPORTING

        input  = GS_COMBINED-ZORDNO

      IMPORTING

        output = GS_COMBINED-ZORDNO.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'

      EXPORTING

        input  = GS_COMBINED-ZMATNR

      IMPORTING

        output = GS_COMBINED-ZMATNR.

    " ## ### ### ##

    GS_COMBINED-ZNSAMT = GS_COMBINED-ZNSAMT / C_CURR_DIV.

    GS_COMBINED-ZSLAMT = GS_COMBINED-ZSLAMT / C_CURR_DIV.

    GS_COMBINED-ZDCAMT = GS_COMBINED-ZDCAMT / C_CURR_DIV.



    WRITE GS_COMBINED-ZNSAMT TO GS_COMBINED-C_ZNSAMT CURRENCY C_CURR.

    WRITE GS_COMBINED-ZSLAMT TO GS_COMBINED-C_ZSLAMT CURRENCY C_CURR.

    WRITE GS_COMBINED-ZDCAMT TO GS_COMBINED-C_ZDCAMT CURRENCY C_CURR.

    " #. ## ### ### ##



    " ## ## ##.

    IF GS_COMBINED-ZRDATE IS NOT INITIAL.

      WRITE GS_COMBINED-ZRDATE TO GS_COMBINED-C_ZRDATE.

    ENDIF.

    " #. ## ## ##.



    " ## FLAG #### ##

    CASE GS_COMBINED-ZDC_FG. " #### ##

      WHEN '1'.

        GS_COMBINED-C_ZDC = '#####'.

      WHEN '2'.

        GS_COMBINED-C_ZDC = '######'.

      WHEN '3'.

        GS_COMBINED-C_ZDC = '####'.

      WHEN '4'.

        GS_COMBINED-C_ZDC = '####'.

    ENDCASE.



    CASE GS_COMBINED-ZDFLAG. " #### FLAG ##

      WHEN '1'.

        GS_COMBINED-C_ZDFLAG = '####'.

      WHEN '2'.

        GS_COMBINED-C_ZDFLAG = '###'.

      WHEN '3'.

        GS_COMBINED-C_ZDFLAG = '####'.

    ENDCASE.



    CASE GS_COMBINED-ZDGUBUN. " ######

      WHEN '1'.

        GS_COMBINED-C_ZDGUBUN = '###'.

      WHEN '2'.

        GS_COMBINED-C_ZDGUBUN = '###'.

      WHEN '3'.

        GS_COMBINED-C_ZDGUBUN = '###'.

      WHEN '4'.

        GS_COMBINED-C_ZDGUBUN = '###'.

      WHEN '5'.

        GS_COMBINED-C_ZDGUBUN = '###'.

      WHEN '6'.

        GS_COMBINED-C_ZDGUBUN = '###'.

      WHEN '7'.

        GS_COMBINED-C_ZDGUBUN = '###'.

    ENDCASE.



    CASE GS_COMBINED-ZMTART. " ####

      WHEN '001'.

        GS_COMBINED-C_ZMTART = '##'.

      WHEN '002'.

        GS_COMBINED-C_ZMTART = '##'.

      WHEN '003'.

        GS_COMBINED-C_ZMTART = '##'.

      WHEN '004'.

        GS_COMBINED-C_ZMTART = '##'.

      WHEN '005'.

        GS_COMBINED-C_ZMTART = '##'.

      WHEN '006'.

        GS_COMBINED-C_ZMTART = '###'.

    ENDCASE.



    CASE GS_COMBINED-ZRET_FG.

      WHEN '1'.

        GS_COMBINED-C_ZRET = '####'.

      WHEN '2'.

        GS_COMBINED-C_ZRET = '####'.

      WHEN '3'.

        GS_COMBINED-C_ZRET = '####'.

    ENDCASE.



    CASE GS_COMBINED-ZSALE_FG. " ####

      WHEN '1'.

        GS_COMBINED-C_ZSALE = '##'.

      WHEN '2'.

        GS_COMBINED-C_ZSALE = '##'.

    ENDCASE.

    " #. ## FLAG #### ##



    " MODIFY# ##

    MODIFY GT_COMBINED FROM GS_COMBINED INDEX SY-TABIX.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  PRINT_ORDER_TABLE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM PRINT_ORDER_TABLE .




*  IF P_C_RET <> 'X'.

*    " ## ## #### INTERNAL TABLE## ##.

*    DELETE GT_COMBINED WHERE ZRET_FG IS NOT INITIAL.

*  ENDIF.






  " HEADER STRING ##

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

  '|', (10) '####'. "124 + 12



  " ## ## #### ##

  IF P_C_RET = 'X'.

    WRITE:

    '|', (10) '####',

    '|', (10) '####',

    '|'. " 20 +3

    PERFORM PRINT_DASH USING C_ORDER_LINER1.

  ELSE.

    WRITE: '|'.

    PERFORM PRINT_DASH USING C_ORDER_LINER2.

  ENDIF.

  " #. HEADER STRING ##

  " # # ##

  LOOP AT GT_COMBINED INTO GS_COMBINED.

    WRITE:

      / '|', GS_COMBINED-ZORDNO ,

        '|', GS_COMBINED-ZIDCODE,

        '|', GS_COMBINED-ZMATNR,

        '|', GS_COMBINED-ZMATNAME,

        '|', GS_COMBINED-C_ZMTART,

        '| ', GS_COMBINED-ZVOLUM,

        ' | ', GS_COMBINED-VRKME,

        ' |', GS_COMBINED-C_ZNSAMT,

        '|', GS_COMBINED-C_ZSLAMT,

        '|', GS_COMBINED-C_ZDCAMT,

        '|', GS_COMBINED-C_ZSALE,

        '|', GS_COMBINED-ZJDATE.

    "#### #### ##

    IF P_C_RET = 'X'.

      WRITE:

                '|', GS_COMBINED-C_ZRET,

                '|', GS_COMBINED-C_ZRDATE,

                '|'.

      PERFORM PRINT_DASH USING C_ORDER_LINER1.

    ELSE.

      WRITE: '|'.

      PERFORM PRINT_DASH USING C_ORDER_LINER2.

    ENDIF.



  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  PRINT_ORDER_TABLE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM PRINT_DELIVERY_TABLE .

  IF P_C_RET <> 'X'.

    " ## ## #### INTERNAL TABLE## ##.

    DELETE GT_COMBINED WHERE ZFLAG = 'X'.

  ENDIF.



  " HEADER STRING ##

  WRITE:

/ '|', (10) '####',

  '|', (10) 'ID',

  '|', (10) '####',

  '|', (20) '###',

  '|', (10) '####',

  '|', (5) '##',

  '|', (5) '##',

  '|', (13) '####',

  '|', (8) '####',

  '|', (8) '##',

  '|', (10) '####'. " 122



  " ## ## #### ##

  IF P_C_RET = 'X'.

    WRITE:

    '|', (10) '####', " 12

    '|'.

    PERFORM PRINT_DASH USING C_DELIV_LINER1..

  ELSE.

    WRITE: '|'.

    PERFORM PRINT_DASH USING C_DELIV_LINER2.

  ENDIF.

  " #. HEADER STRING ##

  " # # ##

  LOOP AT GT_COMBINED INTO GS_COMBINED.

    WRITE:

      / '|', GS_COMBINED-ZORDNO,

        '|', GS_COMBINED-ZIDCODE,

        '|', GS_COMBINED-ZMATNR,

        '|', GS_COMBINED-ZMATNAME,

        '|', GS_COMBINED-C_ZMTART,

        '| ', GS_COMBINED-ZVOLUM,

        ' | ', GS_COMBINED-VRKME,

        ' |', GS_COMBINED-C_ZSLAMT,

        '|', GS_COMBINED-C_ZDFLAG,

        '|', GS_COMBINED-C_ZDGUBUN,

        '|', GS_COMBINED-ZDDATE.

    "#### #### ##

    IF P_C_RET = 'X'.

      WRITE:

                '|', GS_COMBINED-C_ZRDATE,

                '|'.

      PERFORM PRINT_DASH USING C_DELIV_LINER1.

    ELSE.

      WRITE: '|'.

      PERFORM PRINT_DASH USING C_DELIV_LINER2.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  PRINT_DASH

*&---------------------------------------------------------------------*

*       DASH ### #### FORM

*----------------------------------------------------------------------*

*      -->P_C_DELIV_LINER1  text

*----------------------------------------------------------------------*




FORM PRINT_DASH  USING    P_LINER.

  NEW-LINE.

  DO P_LINER TIMES.

    WRITE: '-' NO-GAP.

  ENDDO.

ENDFORM.