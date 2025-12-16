
*&---------------------------------------------------------------------*

*& Report ZEDR20_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_PRACTICE003.



" ### TABLE ##

TABLES: ZEDT20_100, ZEDT20_101.



" ### #### ## ## KRW ##

CONSTANTS: C_KRW TYPE I VALUE 100.



" ##### ###### ### ## ## ##

DATA: GV_START TYPE SY-DATUM,

      GV_END TYPE SY-DATUM,

      GV_DATE TYPE SY-DATUM.



DATA: BEGIN OF GS_ORDER.    " ###### ## ##### ##

  DATA: ZORDNO LIKE ZEDT20_100-ZORDNO,    " ####

        ZIDCODE LIKE ZEDT20_100-ZIDCODE,    " ID

        ZMATNR LIKE ZEDT20_100-ZMATNR,    " ####

        ZMATNAME LIKE ZEDT20_100-ZMATNAME,    " ###

        ZVOLUM LIKE ZEDT20_100-ZVOLUM,    " ##

        VRKME LIKE ZEDT20_100-VRKME,    " ##

        ZNSAMT TYPE I,    " ####

        ZSLAMT TYPE I,    " ####

        ZDCAMT TYPE I,    " ####

        ZJDATE LIKE ZEDT20_100-ZJDATE,    " ####

        ZDATE(10).    " ####

  DATA: ZKMTART TYPE C LENGTH 8,    " ####

        ZKDC_FG TYPE C LENGTH 8,    " ####

        ZKSALE_FG TYPE C LENGTH 5,    " ##

        ZKRET_FG TYPE C LENGTH 10.    " ####

  DATA: END OF GS_ORDER.

DATA: GT_ORDER LIKE TABLE OF GS_ORDER.    " ###### ## ### ##



DATA: BEGIN OF GS_DELIVERY.   " ###### ## ##### ##

  DATA: ZORDNO LIKE ZEDT20_101-ZORDNO,    " ####

        ZIDCODE LIKE ZEDT20_101-ZIDCODE,    " ID

        ZMATNR LIKE ZEDT20_101-ZMATNR,    " ####

        ZMATNAME LIKE ZEDT20_101-ZMATNAME,    " ###

        ZVOLUM LIKE ZEDT20_101-ZVOLUM,    " ##

        VRKME LIKE ZEDT20_101-VRKME,    " ##

        ZSLAMT TYPE I,    " ####

        ZDDATE LIKE ZEDT20_101-ZDDATE,    " ####

        ZDATE(10).    " ####

  DATA: ZKMTART TYPE C LENGTH 8,    " ####

        ZKDFLAG TYPE C LENGTH 8,    " ####

        ZKDGUBUN TYPE C LENGTH 8.   " ##

  DATA: END OF GS_DELIVERY.

DATA: GT_DELIVERY LIKE TABLE OF GS_DELIVERY.    " ###### ## ### ##



DATA: BEGIN OF GS_MASTER.   " #### ### ### MASTER ##### ##

  include structure
ZEDT20_100
.    " #### ### ## ###. #### ##### #### ## #####

  DATA: ZDFLAG LIKE ZEDT20_101-ZDFLAG,    " ####

        ZDGUBUN LIKE ZEDT20_101-ZDGUBUN,    " ####

        ZDDATE LIKE ZEDT20_101-ZDDATE.    " ####

  DATA: END OF GS_MASTER.

DATA: GT_MASTER LIKE TABLE OF GS_MASTER.    " MASTER ### ##





" ### ### ##

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS: S_ZORDNO FOR ZEDT20_100-ZORDNO.   " ####

  PARAMETERS: P_ZID LIKE ZEDT20_100-ZIDCODE.   " ## ID

  SELECT-OPTIONS: S_ZMATNR FOR ZEDT20_100-ZMATNR.   " ####

  SELECT-OPTIONS: S_ZJDATE FOR ZEDT20_100-ZJDATE MODIF ID M1.   " ####

  SELECT-OPTIONS: S_ZDDATE FOR ZEDT20_101-ZDDATE MODIF ID M2.   " ####

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS: P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.   " ####

  PARAMETERS: P_R2 RADIOBUTTON GROUP R1.    " ####

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS: P_C1 AS CHECKBOX DEFAULT 'X' USER-COMMAND UC1.    " ######

SELECTION-SCREEN END OF BLOCK B3.



AT SELECTION-SCREEN OUTPUT.   " #### #### ### ##### ##

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R2 = 'X'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.



    IF SCREEN-GROUP1 = 'M2'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '0'.

      ELSEIF P_R2 = 'X'.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



INITIALIZATION.   " ### ### ####

  GV_DATE = SY-DATUM.   " ### ## ###



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'   " ### ## # ## ## ###### ....

    EXPORTING

      DAY_IN = GV_DATE

    IMPORTING

      LAST_DAY_OF_MONTH = GV_END.   " #### ####

  CONCATENATE GV_DATE+0(6) '01' INTO GV_START.    " #### ### #



  " ### ### ### ##

  S_ZJDATE-LOW = GV_START.

  S_ZJDATE-HIGH = GV_END.

  APPEND S_ZJDATE.



  S_ZDDATE-LOW = GV_START.

  S_ZDDATE-HIGH = GV_END.

  APPEND S_ZDDATE.



START-OF-SELECTION.   " ## ##

  RANGES R_ZID FOR P_ZID.

  IF P_ZID IS NOT INITIAL.

    R_ZID-OPTION = 'EQ'.

    R_ZID-SIGN = 'I'.

    R_ZID-LOW = P_ZID.

    APPEND R_ZID.

  ENDIF.

  IF P_R1 = 'X'.    " ##### ### ### ###

    PERFORM GET_DATA_BY_ZJDATE USING S_ZJDATE[]

                              S_ZORDNO[]

                              S_ZMATNR[]

                              R_ZID[].

  ELSEIF P_R2 = 'X'.    " ##### ### ### ###

    PERFORM GET_DATA_BY_ZDDATE USING S_ZDDATE[]

                              S_ZORDNO[]

                              S_ZMATNR[]

                              R_ZID[].

  ENDIF.



IF GT_MASTER IS INITIAL.

  MESSAGE '#### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

  LEAVE LIST-PROCESSING.

ENDIF.



LOOP AT GT_MASTER INTO GS_MASTER.

  DATA: LV_ZMTART(5).   " ###### ### ## ##

  " ## ### ##

  PERFORM PROCESS_PUBLIC_DATA CHANGING GS_MASTER

                                     LV_ZMTART.

  IF P_R1 = 'X'.    " ####

    MOVE LV_ZMTART TO GS_ORDER-ZKMTART.   " #### ##

    MOVE-CORRESPONDING GS_MASTER TO GS_ORDER.   " ### ### # ##

    " #### ### ##

    PERFORM PROCESS_ORDER_DATA USING GS_MASTER

                                CHANGING GS_ORDER.

    APPEND GS_ORDER TO GT_ORDER.    " #### ### #### APPEND

  ELSEIF P_R2 = 'X'.    " ####

    MOVE LV_ZMTART TO GS_DELIVERY-ZKMTART.    " #### ##

    MOVE-CORRESPONDING GS_MASTER TO GS_DELIVERY.    " ### ### # ##

    " #### ### ##

    PERFORM PROCESS_DELIVERY_DATA USING GS_MASTER

                                  CHANGING GS_DELIVERY.

  ENDIF.



    " ###

    IF P_R1 = 'X'.

      IF P_C1 = 'X'.

        " #### ## ####

        PERFORM WRITE_ORDER_RED USING SY-TABIX

                                      GS_ORDER.

      ELSE.

        CHECK GS_MASTER-ZRET_FG =''.

        " #### ### ####

        PERFORM WRITE_ORDER USING SY-TABIX

                                  GS_ORDER.

      ENDIF.

    ELSE.

      IF P_C1 = 'X'.

        " #### ## ####

        PERFORM WRITE_DELIVERY_RED USING SY-TABIX

                                         GS_DELIVERY.

      ELSE.

        CHECK GS_DELIVERY-ZDATE =''.

        " #### ### ####

        PERFORM WRITE_DELIVERY USING SY-TABIX

                                     GS_DELIVERY.

      ENDIF.

    ENDIF.

ENDLOOP.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_BY_ZJDATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_S_ZJDATE[]  text

*      <--P_GT_ORD  text

*----------------------------------------------------------------------*




FORM GET_DATA_BY_ZJDATE  USING    P_ZJDATE LIKE S_ZJDATE[]

                                  P_ZORDNO LIKE S_ZORDNO[]

                                  P_ZMATNR LIKE S_ZMATNR[]

                                  P_ZID LIKE R_ZID[].

  " ##### #### ## ## ### #### ###

  SELECT *

    FROM ZEDT20_100

    INTO CORRESPONDING FIELDS OF TABLE GT_MASTER

    WHERE ZJDATE IN P_ZJDATE

    AND ZORDNO IN P_ZORDNO

    AND ZMATNR IN P_ZMATNR

    AND ZIDCODE IN P_ZID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_BY_ZDDATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_S_ZDDATE[]  text

*      <--P_GT_DEL  text

*----------------------------------------------------------------------*




FORM GET_DATA_BY_ZDDATE  USING    P_ZDDATE LIKE S_ZDDATE[]

                                  P_ZORDNO LIKE S_ZORDNO[]

                                  P_ZMATNR LIKE S_ZMATNR[]

                                  P_ZID LIKE R_ZID[].

  " ##### #### ## ## ### #### ###

  SELECT *

    FROM ZEDT20_101

    INTO CORRESPONDING FIELDS OF TABLE GT_MASTER

    WHERE ZDDATE IN P_ZDDATE

    AND ZORDNO IN P_ZORDNO

    AND ZMATNR IN P_ZMATNR

    AND ZIDCODE IN P_ZID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_ORDER_RED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_SY_TABIX  text

*      -->P_GS_MASTER  text

*----------------------------------------------------------------------*




FORM WRITE_ORDER_RED  USING    P_TABIX LIKE SY-TABIX

                               PS_ORDER LIKE GS_ORDER.

  IF P_TABIX = 1.   " ### #### ## ### ##

    WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

    WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |  ####   |  ####   | ##  |  ####  |  ####  |  ####  |'.

    WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

  ENDIF.

  " # ##

  WRITE:/ '|', PS_ORDER-ZORDNO, '|', PS_ORDER-ZIDCODE, '|', PS_ORDER-ZMATNR, '|', PS_ORDER-ZMATNAME, '|', PS_ORDER-ZKMTART, '|',PS_ORDER-ZVOLUM, '|',PS_ORDER-VRKME, '|',PS_ORDER-ZNSAMT,

  '|', PS_ORDER-ZSLAMT, '|',PS_ORDER-ZDCAMT, '|',PS_ORDER-ZKSALE_FG, '|',PS_ORDER-ZJDATE, '|',PS_ORDER-ZKRET_FG, '|',PS_ORDER-ZDATE, '|'.

  WRITE:/ '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_ORDER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_SY_TABIX  text

*      -->P_GS_MASTER  text

*----------------------------------------------------------------------*




FORM WRITE_ORDER  USING    P_TABIX LIKE SY-TABIX

                           PS_ORDER LIKE GS_ORDER.

  IF P_TABIX = 1.   " ### #### ## ### ##

    WRITE :/ '-----------------------------------------------------------------------------------------------------------------------------------------------------'.

    WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |  ####   |  ####   | ##  |  ####  |'.

    WRITE :/ '-----------------------------------------------------------------------------------------------------------------------------------------------------'.

 ENDIF.

 " # ##

  WRITE:/ '|', PS_ORDER-ZORDNO, '|', PS_ORDER-ZIDCODE, '|', PS_ORDER-ZMATNR, '|', PS_ORDER-ZMATNAME, '|', PS_ORDER-ZKMTART, '|',PS_ORDER-ZVOLUM, '|',PS_ORDER-VRKME, '|',PS_ORDER-ZNSAMT,'|', PS_ORDER-ZSLAMT, '|',PS_ORDER-ZDCAMT, '|',PS_ORDER-ZKSALE_FG,

'|',PS_ORDER-ZJDATE, '|'.

  WRITE:/ '-----------------------------------------------------------------------------------------------------------------------------------------------------'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_DELIVERY_RED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_SY_TABIX  text

*      -->P_GS_MASTER  text

*----------------------------------------------------------------------*




FORM WRITE_DELIVERY_RED  USING    P_TABIX LIKE SY-TABIX

                                  PS_DELIVERY LIKE GS_DELIVERY.

  IF P_TABIX = 1.   " ### #### ## ### ##

    WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

    WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   | #### |   ##   |  ####  |  ####  |'.

    WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

 ENDIF.

 " # ##

  WRITE:/ '|', PS_DELIVERY-ZORDNO, '|', PS_DELIVERY-ZIDCODE, '|', PS_DELIVERY-ZMATNR, '|', PS_DELIVERY-ZMATNAME, '|', PS_DELIVERY-ZKMTART, '|',PS_DELIVERY-ZVOLUM, '|',PS_DELIVERY-VRKME,'|', PS_DELIVERY-ZSLAMT, '|',PS_DELIVERY-ZKDFLAG, '|',

PS_DELIVERY-ZKDGUBUN, '|',PS_DELIVERY-ZDDATE, '|', PS_DELIVERY-ZDATE, '|'.

  WRITE:/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_DELIVERY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_SY_TABIX  text

*      -->P_GS_MASTER  text

*----------------------------------------------------------------------*




FORM WRITE_DELIVERY  USING    P_TABIX LIKE SY-TABIX

                              PS_DELIVERY LIKE GS_DELIVERY.

  IF P_TABIX = 1.   " ### #### ## ### ##

    WRITE :/ '---------------------------------------------------------------------------------------------------------------------------------------'.

    WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   | #### |   ##   |  ####  |'.

    WRITE :/ '---------------------------------------------------------------------------------------------------------------------------------------'.

  ENDIF.

  " # ##

  WRITE:/ '|', PS_DELIVERY-ZORDNO, '|', PS_DELIVERY-ZIDCODE, '|', PS_DELIVERY-ZMATNR, '|', PS_DELIVERY-ZMATNAME, '|', PS_DELIVERY-ZKMTART, '|',PS_DELIVERY-ZVOLUM, '|',PS_DELIVERY-VRKME,

  '|', PS_DELIVERY-ZSLAMT, '|',PS_DELIVERY-ZKDFLAG, '|',PS_DELIVERY-ZKDGUBUN, '|',PS_DELIVERY-ZDDATE, '|'.

  WRITE:/ '---------------------------------------------------------------------------------------------------------------------------------------'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  PROCESS_ORDER_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_MASTER  text

*      <--P_GS_ORDER  text

*----------------------------------------------------------------------*




FORM PROCESS_ORDER_DATA  USING    PS_MASTER LIKE GS_MASTER

                         CHANGING PS_ORDER LIKE GS_ORDER.

  IF PS_MASTER-ZRDATE IS NOT INITIAL.   " ##### ## ## ## ### #### ##

    CONCATENATE PS_MASTER-ZRDATE+0(4) '.' PS_MASTER-ZRDATE+4(2) '.' PS_MASTER-ZRDATE+6(2) INTO PS_ORDER-ZDATE.

  ELSE.   " ## ## ## ##

    PS_ORDER-ZDATE = ''.

  ENDIF.

  " ## ## ##

  CASE PS_MASTER-ZDC_FG.

    WHEN 1.

      PS_ORDER-ZKDC_FG = '#####'.

    WHEN 2.

      PS_ORDER-ZKDC_FG = '######'.

    WHEN 3.

      PS_ORDER-ZKDC_FG = '####'.

    WHEN 4.

      PS_ORDER-ZKDC_FG = '####'.

    ENDCASE.

  " ## ## ##

  CASE PS_MASTER-ZSALE_FG.

    WHEN 1.

      PS_ORDER-ZKSALE_FG = '##'.

    WHEN 2.

      PS_ORDER-ZKSALE_FG = '##'.

    ENDCASE.

  " ## ## ##

  CASE PS_MASTER-ZRET_FG.

    WHEN 1.

      PS_ORDER-ZKRET_FG = '####'.

    WHEN 2.

      PS_ORDER-ZKRET_FG = '####'.

    WHEN 3.

      PS_ORDER-ZKRET_FG = '####'.

    WHEN OTHERS.

      PS_ORDER-ZKRET_FG = ''.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  PROCESS_DELIVERY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_MASTER  text

*      <--P_GS_ORDER  text

*----------------------------------------------------------------------*




FORM PROCESS_DELIVERY_DATA  USING    PS_MASTER LIKE GS_MASTER

                            CHANGING PS_DELIVERY LIKE GS_DELIVERY.

  IF PS_MASTER-ZRDATE IS NOT INITIAL.   " ##### ## ## ## ### #### ##

    CONCATENATE PS_MASTER-ZRDATE+0(4) '.' PS_MASTER-ZRDATE+4(2) '.' PS_MASTER-ZRDATE+6(2) INTO PS_DELIVERY-ZDATE.

  ELSE.   " ## ### ## ##

    PS_DELIVERY-ZDATE = ''.

  ENDIF.

  " #### ##

  CASE PS_MASTER-ZDFLAG.

    WHEN 1.

      PS_DELIVERY-ZKDFLAG = '####'.

    WHEN 2.

      PS_DELIVERY-ZKDFLAG = '###'.

    WHEN 3.

      PS_DELIVERY-ZKDFLAG = '####'.

    ENDCASE.

  " #### ##

  CASE PS_MASTER-ZDGUBUN.

    WHEN 1.

      PS_DELIVERY-ZKDGUBUN = '###'.

    WHEN 2.

      PS_DELIVERY-ZKDGUBUN = '###'.

    WHEN 3.

      PS_DELIVERY-ZKDGUBUN = '###'.

    WHEN 4.

      PS_DELIVERY-ZKDGUBUN = '###'.

    WHEN 5.

      PS_DELIVERY-ZKDGUBUN = '###'.

    WHEN 6.

      PS_DELIVERY-ZKDGUBUN = '###'.

    WHEN 7.

      PS_DELIVERY-ZKDGUBUN = '###'.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  PROCESS_PUBLIC_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_GS_MASTER  text

*      <--P_LC_ZMTART  text

*----------------------------------------------------------------------*




FORM PROCESS_PUBLIC_DATA  CHANGING PS_MASTER LIKE GS_MASTER

                                   P_ZMTART.

  " ### #### ## KRW# ##

  PS_MASTER-ZSLAMT = PS_MASTER-ZSLAMT * C_KRW.

  PS_MASTER-ZNSAMT = PS_MASTER-ZNSAMT * C_KRW.

  PS_MASTER-ZDCAMT = PS_MASTER-ZDCAMT * C_KRW.

  " #### ##

  CASE GS_MASTER-ZMTART.

      WHEN 1.

        P_ZMTART = '##'.

      WHEN 2.

        P_ZMTART = '##'.

      WHEN 3.

        P_ZMTART = '##'.

      WHEN 4.

        P_ZMTART = '##'.

      WHEN 5.

        P_ZMTART = '##'.

      WHEN 6.

        P_ZMTART = '###'.

      ENDCASE.

ENDFORM.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### #### ####.