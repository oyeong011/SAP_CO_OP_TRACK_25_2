
*&---------------------------------------------------------------------*

*& Report ZEDR03_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_PRACTICE003.

TABLES : ZEDT03_100.

TABLES : ZEDT03_101.



"## ### ###

DATA : BEGIN OF GS_ORDER.

  include structure
ZEDT03_100
.

DATA : END OF GS_ORDER.

DATA : GT_ORDER LIKE TABLE OF GS_ORDER.



"## ### ###

DATA : BEGIN OF GS_DELIVER.

  include structure
ZEDT03_101
.

DATA : END OF GS_DELIVER.

DATA : GT_DELIVER LIKE TABLE OF GS_DELIVER.



"## ## ###

DATA : GV_YEAR(4) TYPE C.

DATA : GV_MONTH(2) TYPE C.

DATA : GV_NEXTFIRSTDAY TYPE D.

DATA : GV_LASTDAY TYPE D.



"## KRW ## ## ##

CONSTANTS : KOR TYPE I VALUE '100'.



"## ###

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZORDO FOR ZEDT03_100-ZORDNO. "####

  SELECT-OPTIONS : S_ZID FOR ZEDT03_100-ZIDCODE NO INTERVALS NO-EXTENSION. "##ID

  SELECT-OPTIONS : S_ZMATNR FOR ZEDT03_100-ZMATNR. "####

  SELECT-OPTIONS : S_ZJDATE FOR ZEDT03_100-ZJDATE MODIF ID M1. "####*

  SELECT-OPTIONS : S_ZDDATE FOR ZEDT03_101-ZDDATE MODIF ID M2. "####*

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS : P_ORDER RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.

  PARAMETERS : P_DEV RADIOBUTTON GROUP R1.

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS : P_ZINCL AS CHECKBOX DEFAULT 'X'.

SELECTION-SCREEN END OF BLOCK B3.





"###

INITIALIZATION.

GV_YEAR = SY-DATUM(4).

GV_MONTH = SY-DATUM+4(2).



"### 1# -1# ### # ##

IF GV_MONTH = '12'.

  GV_MONTH = '01'.

  GV_YEAR = GV_YEAR + 1.

ELSE.

  GV_MONTH = GV_MONTH + 1.

ENDIF.

GV_NEXTFIRSTDAY = |{ GV_YEAR }{ GV_MONTH }01|.

GV_LASTDAY = GV_NEXTFIRSTDAY - 1.



S_ZJDATE-LOW = |{ sy-datum(4) }0101|.

S_ZJDATE-HIGH = GV_LASTDAY .

APPEND S_ZJDATE.

S_ZDDATE-LOW = |{ sy-datum(4) }0101|.

S_ZDDATE-HIGH = GV_LASTDAY .

APPEND S_ZDDATE.



CLEAR : GT_ORDER.

CLEAR : GT_DELIVER.



"## / ## ## ## ## ##

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF P_ORDER = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE  = '0'.

      ENDIF.

      MODIFY SCREEN.

    ENDIF.



    IF SCREEN-GROUP1 = 'M2'.

      IF P_DEV = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.



START-OF-SELECTION.

  "## ### ### ##

  IF S_ZJDATE[] IS INITIAL.

  ELSE.

    PERFORM GET_ORDER.

  ENDIF.

  "## ### ### ##

  IF S_ZDDATE[] IS INITIAL.

  ELSE.

    PERFORM GET_DELIVER.

  ENDIF.



"SELECTION# ## # ## ## ##

END-OF-SELECTION.

  PERFORM WRITE_DATA.



"ORDER ## #### ###

FORM GET_ORDER.

    SELECT *

      FROM ZEDT03_100

      INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

      WHERE ZORDNO IN S_ZORDO

      AND ZIDCODE IN S_ZID

      AND ZMATNR IN S_ZMATNR

      AND ZJDATE IN S_ZJDATE.

ENDFORM.



"DELIVER ## #### ###

FORM GET_DELIVER.

    SELECT *

      FROM ZEDT03_101

      INTO CORRESPONDING FIELDS OF TABLE GT_DELIVER

      WHERE ZORDNO IN S_ZORDO

      AND ZIDCODE IN S_ZID

      AND ZMATNR IN S_ZMATNR

      AND ZDDATE IN S_ZDDATE.

ENDFORM.



"## # ##### ###

DATA : GV_ZMTART TYPE C LENGTH 8. ""####

DATA : GV_ZNSAMT TYPE I. "####

DATA : GV_ZSLAMT TYPE I. "####

DATA : GV_ZDCAMT TYPE I. "####

DATA : GV_ZSALE TYPE C LENGTH 4. "## (##/##)

DATA : GV_ZRET TYPE C LENGTH 10. "####

DATA : GV_ZRDATE TYPE C LENGTH 10. "####

DATA : GV_ZDFLAG TYPE C LENGTH 8. "####

DATA : GV_ZDGUBUN TYPE C LENGTH 6. "####





"## FORM

FORM WRITE_DATA.

  IF P_ORDER = 'X'. "## ## ####

    LOOP AT GT_ORDER INTO GS_ORDER.

      AT FIRST.

        IF P_ZINCL = 'X'. "#### ##

          WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |   ####  |  ####   | ## |  ####  |  ####  |  ####  | '.

          WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE. "#### ## X

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

          WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |   ####  |  ####   | ## |  ####  | '.

          WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

         ENDIF.

      ENDAT.



      "## # ## ###

      "#### ##

      CASE GS_ORDER-ZMTART.

        WHEN '001'.

          GV_ZMTART = '##'.

        WHEN '002'.

          GV_ZMTART = '##'.

        WHEN '003'.

          GV_ZMTART = '##'.

        WHEN '004'.

          GV_ZMTART = '##'.

        WHEN '005'.

          GV_ZMTART = '##'.

        WHEN '006'.

          GV_ZMTART = '###'.

      ENDCASE.

      "#### ##

      GV_ZNSAMT = GS_ORDER-ZNSAMT * KOR.

      "#### ##

      GV_ZSLAMT = GS_ORDER-ZSLAMT * KOR.

      "#### ##

      GV_ZDCAMT = GS_ORDER-ZDCAMT * KOR.

      "## ##

      CASE GS_ORDER-ZSALE_FG.

        WHEN '1'.

          GV_ZSALE = '##'.

        WHEN '2'.

          GV_ZSALE = '##'.

      ENDCASE.

      "#### ##

      CASE GS_ORDER-ZRET_FG.

        WHEN '1'.

          GV_ZRET = '####'.

        WHEN '2'.

          GV_ZRET = '####'.

        WHEN '3'.

          GV_ZRET = '####'.

        WHEN ' '.

          GV_ZRET = ' '.

      ENDCASE.

      "#### ##

      CLEAR GV_ZRDATE.

      IF GS_ORDER-ZSALE_FG = '2'.

        CONCATENATE GS_ORDER-ZRDATE+0(4) '.' GS_ORDER-ZRDATE+4(2) '.' GS_ORDER-ZRDATE+6(2)

        INTO GV_ZRDATE.

       ENDIF.



      "## ####

      IF P_ZINCL = 'X'. "#### ##

       WRITE :/ '|',GS_ORDER-ZORDNO,'|',GS_ORDER-ZIDCODE,'|',GS_ORDER-ZMATNR,'|',GS_ORDER-ZMATNAME,'|',GV_ZMTART,'|'

       ,GS_ORDER-ZVOLUM,'|',GS_ORDER-VRKME,'|',GV_ZNSAMT,'|',GV_ZSLAMT,'|',GV_ZDCAMT,'|',GV_ZSALE,'|',GS_ORDER-ZJDATE,'|' , GV_ZRET,'|',GV_ZRDATE,'|'.

       WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE. "#### ## X

       IF GV_ZSALE = '##'.

        CONTINUE.

       ENDIF.

       WRITE :/ '|',GS_ORDER-ZORDNO,'|',GS_ORDER-ZIDCODE,'|',GS_ORDER-ZMATNR,'|',GS_ORDER-ZMATNAME,'|',GV_ZMTART,'|'

       ,GS_ORDER-ZVOLUM,'|',GS_ORDER-VRKME,'|',GV_ZNSAMT,'|',GV_ZSLAMT,'|',GV_ZDCAMT,'|',GV_ZSALE,'|',GS_ORDER-ZJDATE,'|'.

       WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.



      CLEAR : GS_ORDER.

    ENDLOOP.

   ELSE. "## ## ####

     LOOP AT GT_DELIVER INTO GS_DELIVER.

      AT FIRST.

        IF P_ZINCL = 'X'. "#### ##

            WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

            WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   | #### |  ##  |  ####  |  ####  |'.

            WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

        ELSE. "#### ## X

            WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

            WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   | #### |  ##  |  ####  | '.

            WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDAT.



      "#### ##

      CASE GS_DELIVER-ZMTART.

        WHEN '001'.

          GV_ZMTART = '##'.

        WHEN '002'.

          GV_ZMTART = '##'.

        WHEN '003'.

          GV_ZMTART = '##'.

        WHEN '004'.

          GV_ZMTART = '##'.

        WHEN '005'.

          GV_ZMTART = '##'.

        WHEN '006'.

          GV_ZMTART = '###'.

      ENDCASE.

     "#### ##

      GV_ZSLAMT = GS_DELIVER-ZSLAMT * KOR.

     "#### ##

      CASE GS_DELIVER-ZDFLAG.

          WHEN '1'.

            GV_ZDFLAG = '####'.

          WHEN '2'.

            GV_ZDFLAG = '###'.

          WHEN '3'.

            GV_ZDFLAG = '####'.

      ENDCASE.



      IF GS_DELIVER-ZRDATE IS NOT INITIAL.

        CLEAR : GV_ZDFLAG.

      ENDIF.

     "## ##

       CASE GS_DELIVER-ZDGUBUN.

        WHEN '1'.

          GV_ZDGUBUN = '###'.

        WHEN '2'.

          GV_ZDGUBUN = '###'.

        WHEN '3'.

          GV_ZDGUBUN = '###'.

        WHEN '4'.

          GV_ZDGUBUN = '###'.

        WHEN '5'.

          GV_ZDGUBUN = '###'.

        WHEN '6'.

          GV_ZDGUBUN = '###'.

        WHEN '7'.

          GV_ZDGUBUN = '###'.

      ENDCASE.



      "###### ##

      CLEAR GV_ZRDATE.

      IF GS_DELIVER-ZRDATE IS NOT INITIAL.

        CONCATENATE GS_DELIVER-ZRDATE+0(4) '.' GS_DELIVER-ZRDATE+4(2) '.' GS_DELIVER-ZRDATE+6(2)

        INTO GV_ZRDATE.

       ENDIF.



      "## ####

      IF P_ZINCL = 'X'. "#### ##

        WRITE :/ '|',GS_DELIVER-ZORDNO,'|',GS_DELIVER-ZIDCODE,'|',GS_DELIVER-ZMATNR,'|' , GS_DELIVER-ZMATNAME ,'|',GV_ZMTART,'|',GS_DELIVER-ZVOLUM,'|'

                ,GS_DELIVER-VRKME,'|', GV_ZSLAMT,'|', GV_ZDFLAG,'|',GV_ZDGUBUN,'|',GS_DELIVER-ZDDATE,'|', GV_ZRDATE, '|'.

      WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

      ELSE. "#### ## X

       IF GV_ZRDATE IS INITIAL.

        WRITE :/ '|',GS_DELIVER-ZORDNO,'|',GS_DELIVER-ZIDCODE,'|',GS_DELIVER-ZMATNR,'|' , GS_DELIVER-ZMATNAME ,'|',GV_ZMTART,'|',GS_DELIVER-ZVOLUM,'|'

                ,GS_DELIVER-VRKME,'|', GV_ZSLAMT,'|', GV_ZDFLAG,'|',GV_ZDGUBUN,'|',GS_DELIVER-ZDDATE,'|'.

        WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

        ENDIF.

      ENDIF.

     CLEAR : GS_DELIVER.

    ENDLOOP.

  ENDIF.

ENDFORM.