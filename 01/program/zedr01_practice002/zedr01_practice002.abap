
*&---------------------------------------------------------------------*

*& Read Table ## 2025-09-17

*&---------------------------------------------------------------------*

*0. ## #### ## ####

*1. ##### ## ###### ##

*2. DATA# ### #, ## ### #### #### #### (### COPY###)

*3. COLLECT 1# ## ##

*4. READ~COMPAIRNG 1### ##

*5. EXIT, CONTINUE, STOP, CHECK ## 1# ## ##

*6. MODIFY# ## ## ##

*7. LOOP# MODIFY#, WRITE### #### # 2## ##

*8. ### ### ## ## ### ##### #### ##

*9. ##(ZEDT00_004) # D## F# 1# ##### ### ######

* (# ###### #### ##, ##, ### ###### ## ## ### # ### ## ##### ##)

*10. ###### ### #### ### ## # ## #### ###

*11. ####(ZEDT00_002)# ## ## # ### #####(ZEDT00_004)# ## ### ### ####### ##

*12. ### ###(ZEDT00_004-ZSUM) ##, ### ###(ZEDT00_004-ZSUM)  ## ##

* (# ###### #### ##, ##, ### ###### ## ## ###  # ### ###### # ##### ## ZSUM## ####)

*13. ### #### ####, # ## ##

*&-------------------------------------------------------------------------------------------------------------*




REPORT ZEDR01_PRACTICE002.






*&-------------------------------------------------------------------------------------------------------------*

* ### STRUCTURE , TABLE ##




DATA : GS_ZEDT001 LIKE ZEDT00_001,

       GS_ZEDT002 LIKE ZEDT00_002,

       GS_ZEDT004 LIKE ZEDT00_004,

       GT_ZEDT001 LIKE TABLE OF ZEDT00_001,

       GT_ZEDT002 LIKE TABLE OF ZEDT00_002,

       GT_ZEDT004 LIKE TABLE OF ZEDT00_004.




* ### STRUCETURE , TABLE ##




DATA : BEGIN OF GS_WRITE_STUDENT_INFO,

  ZPERNR LIKE ZEDT00_001-ZPERNR,                        " #### "

  ZCODE LIKE ZEDT00_001-ZCODE,                          " #### "

  ZKNAME LIKE ZEDT00_001-ZKNAME,                        " #### "

  ZENAME LIKE ZEDT00_001-ZENAME,                        " #### "

  ZGENDER LIKE ZEDT00_001-ZGENDER,                      " #### "

  ZTEL LIKE ZEDT00_001-ZTEL,                            " ### "

  ZMGUBUN LIKE ZEDT00_002-ZMGUBUN,                      " #### "

  ZMNAME_PAST LIKE ZEDT00_002-ZMNAME,                   " ## #### "

  ZSUM LIKE ZEDT00_002-ZSUM,                            " ## "

  ZWAERS LIKE ZEDT00_002-ZWAERS,                        " ### "

  ZMNAME_OUT LIKE ZEDT00_004-ZMNAME,                    " ## #### "

  ZSCHOOL LIKE ZEDT00_004-ZSCHOOL,                      " ## "

  ZEXAM LIKE ZEDT00_004-ZEXAM,                          " #### "

  ZGRADE LIKE ZEDT00_004-ZGRADE,                        " #### "

  ZMAJOR_TRANS_FLAG TYPE C LENGTH 10,                   " ## ## "

  ZWARN_FLAG TYPE C LENGTH 10,                          " ## ## "

  END OF GS_WRITE_STUDENT_INFO.

DATA : GT_WRITE_STUDENT_INFO LIKE TABLE OF GS_WRITE_STUDENT_INFO.






* ### STRUCETURE , TABLE ##




DATA : BEGIN OF GS_WRITE_TOTALSUM,

  ZGENDER LIKE ZEDT00_001-ZGENDER,                      " ## "

  ZSUM    TYPE P DECIMALS 2,                            " ## "

  END OF GS_WRITE_TOTALSUM.

DATA : GT_WRITE_TOTALSUM LIKE TABLE OF GS_WRITE_TOTALSUM.




*&-------------------------------------------------------------------------------------------------------------*




" ### ## "

SELECT * FROM ZEDT00_001

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT001.



SELECT * FROM ZEDT00_002

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT002.



SELECT * FROM ZEDT00_004

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT004.




*&-------------------------------------------------------------------------------------------------------------*

* ### ZEDT004# #### ZEDT001 , ZEDT002 , ZEDT003 #### #### GT_WRITE_STUDENT_INFO# ##

* READ ~ COMPARING# #### ## ## ##

* CONTIUNE# #### ### ## SKIP

*&-------------------------------------------------------------------------------------------------------------*






LOOP AT GT_ZEDT004 INTO GS_ZEDT004.



  CLEAR : GS_WRITE_STUDENT_INFO,GS_ZEDT001,GS_ZEDT002.                                      " ### ## CLEAR "

  MOVE-CORRESPONDING GS_ZEDT004 TO GS_ZEDT002.                                              " COMPARING# ## GS_ZEDT004# ### GS_ZEDT002# ## "



  READ TABLE GT_ZEDT001 INTO GS_ZEDT001 WITH KEY ZCODE = GS_ZEDT004-ZCODE.                  " ##### #### GS_ZEDT001# ## ### "

  READ TABLE GT_ZEDT002 INTO GS_ZEDT002 WITH KEY ZCODE = GS_ZEDT004-ZCODE COMPARING ZMAJOR. " ##### #### GS_ZEDT004# ## ### # ZMAJOR ## "



  GS_WRITE_STUDENT_INFO-ZMNAME_PAST = GS_ZEDT002-ZMNAME.                                    " ##### ## / ## ## ## "

  GS_WRITE_STUDENT_INFO-ZMNAME_OUT = GS_ZEDT004-ZMNAME.



  MOVE-CORRESPONDING GS_ZEDT004 TO GS_WRITE_STUDENT_INFO.    " GS_WRITE_STUDENT_INFO# ## ## ##, ZSUM# #### ## #### ## "

  MOVE-CORRESPONDING GS_ZEDT002 TO GS_WRITE_STUDENT_INFO.

  MOVE-CORRESPONDING GS_ZEDT001 TO GS_WRITE_STUDENT_INFO.



  GS_WRITE_STUDENT_INFO-ZSUM = GS_ZEDT004-ZSUM.              " GS_ZEDT004-ZSUM# ### #### "



  IF ( GS_ZEDT002-ZMAJOR = ' ' OR GS_ZEDT004-ZMAJOR = ' ' ). " #### "

    WRITE : / '### ### - MAJOR FIELD ERROR.'.

    CONTINUE.

  ELSE.                                                      " #### ZMAJOR ## "

    IF SY-SUBRC = 0 .                                        " ZMAJOR# #### "

      GS_WRITE_STUDENT_INFO-ZMAJOR_TRANS_FLAG = ' '.

    ELSEIF SY-SUBRC = 4.                                     " ZMAJOR ## ## "

      WRITE : / '#### #### ####. - ZMAJOR NOT EXIST.'.

      CONTINUE.

    ELSE.

      GS_WRITE_STUDENT_INFO-ZMAJOR_TRANS_FLAG = '####'.           " ZMAJOR# #### "

    ENDIF.

  ENDIF.



  IF GS_WRITE_STUDENT_INFO-ZGRADE = ' '.                                  " ZGRADE ## ## "

    WRITE : / '### ### - GRADE FIELD ERROR.'.

    CONTINUE.

  ELSE.

    IF GS_WRITE_STUDENT_INFO-ZGRADE = 'D' OR GS_WRITE_STUDENT_INFO-ZGRADE = 'F'. " ZGRADE #### "

      GS_WRITE_STUDENT_INFO-ZWARN_FLAG = '####'.                           " D ## F ##### #### "

    ENDIF.

  ENDIF.



  APPEND GS_WRITE_STUDENT_INFO TO GT_WRITE_STUDENT_INFO.                " ### ## #### ## "



ENDLOOP.




*&-------------------------------------------------------------------------------------------------------------*






SORT GT_WRITE_STUDENT_INFO BY ZCODE ASCENDING ZGRADE DESCENDING.       " ### TABLE ### ## ## ### ## "

DELETE ADJACENT DUPLICATES FROM GT_WRITE_STUDENT_INFO COMPARING ZCODE. " #### "






*&-------------------------------------------------------------------------------------------------------------*






CONSTANTS : C_RATE_KRW          TYPE I VALUE 100.               " #### ## ## ## "

DATA : LV_WRITE_TOTALSUM_MALE   TYPE P DECIMALS 2.              " ### ## ## "

DATA : LV_WRITE_TOTALSUM_FEMALE TYPE P DECIMALS 2.              " ### ## ## "

DATA : LV_TEL_SHOW         TYPE ZEDT00_001-ZTEL.                " ### ## "



LOOP AT GT_WRITE_STUDENT_INFO INTO GS_WRITE_STUDENT_INFO.

  AT FIRST.                                   " HEADER "

    WRITE : SY-ULINE(72).

    WRITE : / SY-VLINE ,TEXT-000 CENTERED,    " #### "

           15 SY-VLINE ,TEXT-001 CENTERED,    " ## "

           27 SY-VLINE ,TEXT-002 CENTERED,    " #### "

           40 SY-VLINE ,TEXT-003 CENTERED,    " ### "

           60 SY-VLINE ,TEXT-004 CENTERED,    " #### "

           72 SY-VLINE.

    WRITE : / SY-ULINE(72).

  ENDAT.

                                                              " BODY "

  GS_WRITE_TOTALSUM-ZGENDER = GS_WRITE_STUDENT_INFO-ZGENDER.  " ## ### "

  GS_WRITE_TOTALSUM-ZSUM = GS_WRITE_STUDENT_INFO-ZSUM.        " ## ### "

  COLLECT GS_WRITE_TOTALSUM INTO GT_WRITE_TOTALSUM.           " ### ## ## ## "



  CLEAR: LV_TEL_SHOW.                                         " ### CLEAR "

  IF GS_WRITE_STUDENT_INFO-ZWARN_FLAG = '####'.              " #### ## ## "

    LV_TEL_SHOW = GS_WRITE_STUDENT_INFO-ZTEL.                 " ##### ## ### ##

  ENDIF.



  WRITE : / SY-VLINE ,GS_WRITE_STUDENT_INFO-ZCODE UNDER TEXT-000,                " #### "

         15 SY-VLINE , GS_WRITE_STUDENT_INFO-ZKNAME UNDER TEXT-001,              " ## "

         27 SY-VLINE , GS_WRITE_STUDENT_INFO-ZMAJOR_TRANS_FLAG UNDER TEXT-002,   " #### "

         40 SY-VLINE , LV_TEL_SHOW UNDER TEXT-003,                               " ### ## "

         60 SY-VLINE , GS_WRITE_STUDENT_INFO-ZWARN_FLAG UNDER TEXT-004,          " #### "

         72 SY-VLINE.

  WRITE : / SY-ULINE(72).



  AT LAST.

    READ TABLE GT_WRITE_TOTALSUM INTO GS_WRITE_TOTALSUM WITH KEY ZGENDER = 'M'. " ### FIELD# TABLE ## "

    LV_WRITE_TOTALSUM_MALE = GS_WRITE_TOTALSUM-ZSUM * C_RATE_KRW.               " ## ### # #### "

    READ TABLE GT_WRITE_TOTALSUM INTO GS_WRITE_TOTALSUM WITH KEY ZGENDER = 'F'. " ### FIELD# TABLE ## "

    LV_WRITE_TOTALSUM_FEMALE = GS_WRITE_TOTALSUM-ZSUM * C_RATE_KRW.             " ## ### # ####"



    WRITE : / '### ### :', LV_WRITE_TOTALSUM_MALE DECIMALS 0.                  " ## ##

    WRITE : / '### ### :', LV_WRITE_TOTALSUM_FEMALE DECIMALS 0.

  ENDAT.

ENDLOOP.