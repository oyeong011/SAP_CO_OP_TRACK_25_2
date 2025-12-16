
*&---------------------------------------------------------------------*

*& Report ZEDR04_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_PRACTICE003.



TABLES : ZEDT04_100, ZEDT04_101.



CONSTANTS : C_RATE TYPE I VALUE 100.  " ## ## ## ##

RANGES R_ZID FOR ZEDT04_100-ZIDCODE.  " ### ##ID# ## RANGES ##

DATA GV_DATE TYPE D.                  " ## ## ## ##



DATA GS_ORD TYPE ZEDT04_100.      " ## ##

DATA GT_ORD LIKE TABLE OF GS_ORD.



DATA : BEGIN OF GS_WRITE_ORD,     " ## ## ###

  ZORDNO TYPE ZEDT04_100-ZORDNO,      " ####

  ZIDCODE TYPE ZEDT04_100-ZIDCODE,    " ID

  ZMATNR TYPE ZEDT04_100-ZMATNR,      " ####

  ZMATNAME TYPE ZEDT04_100-ZMATNAME,  " ###

  ZMTART_NAME TYPE C LENGTH 8,        " #### (##)

  ZVOLUM TYPE ZEDT04_100-ZVOLUM,      " ##

  VRKME TYPE ZEDT04_100-VRKME,        " ##

  ZNSAMT TYPE I,                      " #### (KRW)

  ZSLAMT TYPE I,                      " #### (KRW)

  ZDCAMT TYPE I,                      " #### (KRW)

  ZSALE_FG_NAME TYPE C LENGTH 6,      " ## (## OR ##)

  ZJDATE TYPE ZEDT04_100-ZJDATE,      " ####

  ZRET_FG_NAME TYPE C LENGTH 10,      " #### (##)

  ZRDATE TYPE ZEDT04_100-ZRDATE,      " ####

  END OF GS_WRITE_ORD.

DATA GT_WRITE_ORD LIKE TABLE OF GS_WRITE_ORD.



DATA GS_DEL TYPE ZEDT04_101.      " ## ##

DATA GT_DEL LIKE TABLE OF GS_DEL.



DATA : BEGIN OF GS_WRITE_DEL,     " ## ## ###

  ZORDNO TYPE ZEDT04_101-ZORDNO,      " ####

  ZIDCODE TYPE ZEDT04_101-ZIDCODE,    " ID

  ZMATNR TYPE ZEDT04_101-ZMATNR,      " ####

  ZMATNAME TYPE ZEDT04_101-ZMATNAME,  " ###

  ZMTART_NAME TYPE C LENGTH 8,        " #### (##)

  ZVOLUM TYPE ZEDT04_101-ZVOLUM,      " ##

  VRKME TYPE ZEDT04_101-VRKME,        " ##

  ZSLAMT TYPE I,                      " #### (KRW)

  ZDFLAG_NAME TYPE C LENGTH 10,       " #### (##)

  ZDGUBUN_NAME TYPE C LENGTH 8,       " ## (##)

  ZDDATE TYPE ZEDT04_101-ZDDATE,      " ####

  ZRDATE TYPE ZEDT04_101-ZRDATE,      " ####

  ZFLAG TYPE ZEDT04_101-ZFLAG,        " ####

  END OF GS_WRITE_DEL.

DATA GT_WRITE_DEL LIKE TABLE OF GS_WRITE_DEL.







SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS S_ZORDNO FOR ZEDT04_100-ZORDNO.  " ####

  PARAMETERS P_ZID TYPE ZEDT04_100-ZIDCODE.       " ##ID

  SELECT-OPTIONS S_ZMATNR FOR ZEDT04_100-ZMATNR.  " ####

  SELECT-OPTIONS S_ZJDATE FOR ZEDT04_100-ZJDATE MODIF ID M1.  " ####

  SELECT-OPTIONS S_ZDDATE FOR ZEDT04_101-ZDDATE MODIF ID M2.  " ####

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS P_RDJ RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. " ####

  PARAMETERS P_RDD RADIOBUTTON GROUP R1.                              " ####

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS P_ZFLAG AS CHECKBOX DEFAULT 'X'. " ######

SELECTION-SCREEN END OF BLOCK B3.







INITIALIZATION.

  CONCATENATE SY-DATUM(6) '01' INTO GV_DATE.  " ### ## # ##

  S_ZJDATE-LOW = GV_DATE.

  S_ZDDATE-LOW = GV_DATE.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS' " ### ## ### ##

  EXPORTING

    DAY_IN            = GV_DATE

  IMPORTING

    LAST_DAY_OF_MONTH = GV_DATE.

  S_ZJDATE-HIGH = GV_DATE.

  S_ZDDATE-HIGH = GV_DATE.



  APPEND S_ZJDATE.

  APPEND S_ZDDATE.







AT SELECTION-SCREEN OUTPUT. " ### ### ## ##### #### # ## ##

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.      " ####

      IF P_RDJ = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'.  " ####

      IF P_RDD = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.







START-OF-SELECTION.

  " ## ID# RANGES ###

  IF P_ZID IS NOT INITIAL.

    R_ZID-SIGN = 'I'.

    R_ZID-OPTION = 'EQ'.

    R_ZID-LOW = P_ZID.

    APPEND R_ZID.

  ENDIF.



  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.

  PERFORM WRITE_DATA.

END-OF-SELECTION.














*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA.  " DB ### ####

  IF P_RDJ = 'X'.   " ## ## ##

    SELECT * FROM ZEDT04_100

      INTO CORRESPONDING FIELDS OF TABLE GT_ORD

      WHERE ZORDNO IN S_ZORDNO

      AND ZIDCODE IN R_ZID

      AND ZMATNR IN S_ZMATNR

      AND ZJDATE IN S_ZJDATE.

  ELSE.             " ## ## ##

    SELECT * FROM ZEDT04_101

      INTO CORRESPONDING FIELDS OF TABLE GT_DEL

      WHERE ZORDNO IN S_ZORDNO

      AND ZIDCODE IN R_ZID

      AND ZMATNR IN S_ZMATNR

      AND ZDDATE IN S_ZDDATE.

  ENDIF.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*




FORM MODIFY_DATA. " ### ### ###

  IF P_RDJ = 'X'.   " ## ##

    LOOP AT GT_ORD INTO GS_ORD.

      CLEAR GS_WRITE_ORD.

      MOVE-CORRESPONDING GS_ORD TO GS_WRITE_ORD.



      " ## ##

      GS_WRITE_ORD-ZNSAMT = GS_WRITE_ORD-ZNSAMT * C_RATE.

      GS_WRITE_ORD-ZSLAMT = GS_WRITE_ORD-ZSLAMT * C_RATE.

      GS_WRITE_ORD-ZDCAMT = GS_WRITE_ORD-ZDCAMT * C_RATE.



      CASE GS_ORD-ZMTART. " ####

        WHEN '001'.

          GS_WRITE_ORD-ZMTART_NAME = '##'.

        WHEN '002'.

          GS_WRITE_ORD-ZMTART_NAME = '##'.

        WHEN '003'.

          GS_WRITE_ORD-ZMTART_NAME = '##'.

        WHEN '004'.

          GS_WRITE_ORD-ZMTART_NAME = '##'.

        WHEN '005'.

          GS_WRITE_ORD-ZMTART_NAME = '##'.

        WHEN '006'.

          GS_WRITE_ORD-ZMTART_NAME = '###'.

      ENDCASE.



      CASE GS_ORD-ZSALE_FG. " ## (## OR ##)

        WHEN '1'.

          GS_WRITE_ORD-ZSALE_FG_NAME = '##'.

        WHEN '2'.

          GS_WRITE_ORD-ZSALE_FG_NAME = '##'.

      ENDCASE.



      CASE GS_ORD-ZRET_FG.  " ####

        WHEN '1'.

          GS_WRITE_ORD-ZRET_FG_NAME = '####'.

        WHEN '2'.

          GS_WRITE_ORD-ZRET_FG_NAME = '####'.

        WHEN '3'.

          GS_WRITE_ORD-ZRET_FG_NAME = '####'.

      ENDCASE.

      APPEND GS_WRITE_ORD TO GT_WRITE_ORD.

    ENDLOOP.



    IF P_ZFLAG = ''.  " ###### # ## # ## ## ### ##

      DELETE GT_WRITE_ORD WHERE ZSALE_FG_NAME = '##'.

    ENDIF.

  ELSE.             " ## ##

    LOOP AT GT_DEL INTO GS_DEL.

      CLEAR GS_WRITE_DEL.

      MOVE-CORRESPONDING GS_DEL TO GS_WRITE_DEL.



      " ## ##

      GS_WRITE_DEL-ZSLAMT = GS_WRITE_DEL-ZSLAMT * C_RATE.



      CASE GS_DEL-ZMTART. " ####

        WHEN '001'.

          GS_WRITE_DEL-ZMTART_NAME = '##'.

        WHEN '002'.

          GS_WRITE_DEL-ZMTART_NAME = '##'.

        WHEN '003'.

          GS_WRITE_DEL-ZMTART_NAME = '##'.

        WHEN '004'.

          GS_WRITE_DEL-ZMTART_NAME = '##'.

        WHEN '005'.

          GS_WRITE_DEL-ZMTART_NAME = '##'.

        WHEN '006'.

          GS_WRITE_DEL-ZMTART_NAME = '###'.

      ENDCASE.



      CASE GS_DEL-ZDFLAG. " ####

        WHEN '1'.

          GS_WRITE_DEL-ZDFLAG_NAME = '####'.

        WHEN '2'.

          GS_WRITE_DEL-ZDFLAG_NAME = '###'.

        WHEN '3'.

          IF GS_WRITE_DEL-ZFLAG <> 'X'.   " ## ## ## #### ##

            GS_WRITE_DEL-ZDFLAG_NAME = '####'.

          ENDIF.

      ENDCASE.



      CASE GS_DEL-ZDGUBUN.  " ##

        WHEN '1'.

          GS_WRITE_DEL-ZDGUBUN_NAME = '###'.

        WHEN '2'.

          GS_WRITE_DEL-ZDGUBUN_NAME = '###'.

        WHEN '3'.

          GS_WRITE_DEL-ZDGUBUN_NAME = '###'.

        WHEN '4'.

          GS_WRITE_DEL-ZDGUBUN_NAME = '###'.

        WHEN '5'.

          GS_WRITE_DEL-ZDGUBUN_NAME = '###'.

        WHEN '6'.

          GS_WRITE_DEL-ZDGUBUN_NAME = '###'.

        WHEN '7'.

          GS_WRITE_DEL-ZDGUBUN_NAME = '###'.

      ENDCASE.

      APPEND GS_WRITE_DEL TO GT_WRITE_DEL.

    ENDLOOP.

    IF P_ZFLAG = ''.  " ###### # ## # ## ## ### ##

      DELETE GT_WRITE_DEL WHERE ZFLAG = 'X'.

    ENDIF.

  ENDIF.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  WRITE_DATA

*&---------------------------------------------------------------------*




FORM WRITE_DATA. " ## ## ##

  IF P_RDJ = 'X'.   " ## ##

    IF P_ZFLAG = 'X'. " #### ##

      WRITE : / '--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

      WRITE : / '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |  ####   |  ####   |  ##  |  ####  |  ####  |  ####  |'.

      WRITE : / '--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

      LOOP AT GT_WRITE_ORD INTO GS_WRITE_ORD.

        WRITE : / '|', GS_WRITE_ORD-ZORDNO,       '|', GS_WRITE_ORD-ZIDCODE, '|', GS_WRITE_ORD-ZMATNR,        '|', GS_WRITE_ORD-ZMATNAME,

                  '|', GS_WRITE_ORD-ZMTART_NAME,  '|', GS_WRITE_ORD-ZVOLUM,  '|', GS_WRITE_ORD-VRKME,         '|', GS_WRITE_ORD-ZNSAMT,

                  '|', GS_WRITE_ORD-ZSLAMT,       '|', GS_WRITE_ORD-ZDCAMT,  '|', GS_WRITE_ORD-ZSALE_FG_NAME, '|', GS_WRITE_ORD-ZJDATE,

                  '|', GS_WRITE_ORD-ZRET_FG_NAME, '|'.

        IF GS_WRITE_ORD-ZRDATE IS NOT INITIAL.

          WRITE : GS_WRITE_ORD-ZRDATE, '|'.

        ELSE.

          WRITE : '           |'.

        ENDIF.

        WRITE : / '--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ENDLOOP.

    ELSE.             " #### ###

      WRITE : / '------------------------------------------------------------------------------------------------------------------------------------------------------'.

      WRITE : / '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |  ####   |  ####   |  ##  |  ####  |'.

      WRITE : / '------------------------------------------------------------------------------------------------------------------------------------------------------'.

      LOOP AT GT_WRITE_ORD INTO GS_WRITE_ORD.

        WRITE : / '|', GS_WRITE_ORD-ZORDNO,       '|', GS_WRITE_ORD-ZIDCODE, '|', GS_WRITE_ORD-ZMATNR,        '|', GS_WRITE_ORD-ZMATNAME,

                  '|', GS_WRITE_ORD-ZMTART_NAME,  '|', GS_WRITE_ORD-ZVOLUM,  '|', GS_WRITE_ORD-VRKME,         '|', GS_WRITE_ORD-ZNSAMT,

                  '|', GS_WRITE_ORD-ZSLAMT,       '|', GS_WRITE_ORD-ZDCAMT,  '|', GS_WRITE_ORD-ZSALE_FG_NAME, '|', GS_WRITE_ORD-ZJDATE, '|'.

        WRITE : / '------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ENDLOOP.

    ENDIF.

  ELSE.             " ## ##

    IF P_ZFLAG = 'X'. " #### ##

      WRITE : / '------------------------------------------------------------------------------------------------------------------------------------------------------'.

      WRITE : / '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |  ####  |   ##   |  ####  |  ####  |'.

      WRITE : / '------------------------------------------------------------------------------------------------------------------------------------------------------'.

      LOOP AT GT_WRITE_DEL INTO GS_WRITE_DEL.

        WRITE : / '|', GS_WRITE_DEL-ZORDNO,       '|', GS_WRITE_DEL-ZIDCODE,      '|', GS_WRITE_DEL-ZMATNR,        '|', GS_WRITE_DEL-ZMATNAME,

                  '|', GS_WRITE_DEL-ZMTART_NAME,  '|', GS_WRITE_DEL-ZVOLUM,       '|', GS_WRITE_DEL-VRKME,         '|', GS_WRITE_DEL-ZSLAMT,

                  '|', GS_WRITE_DEL-ZDFLAG_NAME,  '|', GS_WRITE_DEL-ZDGUBUN_NAME, '|', GS_WRITE_DEL-ZDDATE, '|'.

        IF GS_WRITE_DEL-ZRDATE IS NOT INITIAL.

          WRITE : GS_WRITE_DEL-ZRDATE, '|'.

        ELSE.

          WRITE : '           |'.

        ENDIF.

        WRITE : / '------------------------------------------------------------------------------------------------------------------------------------------------------'.

      ENDLOOP.

    ELSE.             " #### ###

      WRITE : / '-----------------------------------------------------------------------------------------------------------------------------------------'.

      WRITE : / '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |  ####  |   ##   |  ####  |'.

      WRITE : / '-----------------------------------------------------------------------------------------------------------------------------------------'.

      LOOP AT GT_WRITE_DEL INTO GS_WRITE_DEL.

        WRITE : / '|', GS_WRITE_DEL-ZORDNO,       '|', GS_WRITE_DEL-ZIDCODE,      '|', GS_WRITE_DEL-ZMATNR,        '|', GS_WRITE_DEL-ZMATNAME,

                  '|', GS_WRITE_DEL-ZMTART_NAME,  '|', GS_WRITE_DEL-ZVOLUM,       '|', GS_WRITE_DEL-VRKME,         '|', GS_WRITE_DEL-ZSLAMT,

                  '|', GS_WRITE_DEL-ZDFLAG_NAME,  '|', GS_WRITE_DEL-ZDGUBUN_NAME, '|', GS_WRITE_DEL-ZDDATE, '|'.

        WRITE : / '-----------------------------------------------------------------------------------------------------------------------------------------'.

      ENDLOOP.

    ENDIF.

  ENDIF.

ENDFORM.