
*&---------------------------------------------------------------------*

*& Report ZEDR08_PRACTICE002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR08_PRACTICE002.



" GS_ZEDT001 ### ##

DATA : BEGIN OF GS_ZEDT001,

  MANDT LIKE ZEDT08_001-MANDT,

  ZCODE LIKE ZEDT08_001-ZCODE,

  ZPERNR LIKE ZEDT08_001-ZPERNR,

  ZKNAME LIKE ZEDT08_001-ZKNAME,

  ZENAME LIKE ZEDT08_001-ZENAME,

  ZGENDER LIKE ZEDT08_001-ZGENDER,

  ZTEL LIKE ZEDT08_001-ZTEL,

END OF GS_ZEDT001.



" GS_ZEDT002 ### ##

DATA : BEGIN OF GS_ZEDT002,

  MANDT LIKE ZEDT08_002-MANDT,

  ZCODE LIKE ZEDT08_002-ZCODE,

  ZPERNR LIKE ZEDT08_002-ZPERNR,

  ZMAJOR LIKE ZEDT08_002-ZMAJOR,

  ZMNAME LIKE ZEDT08_002-ZMNAME,

  ZMGUBUN LIKE ZEDT08_002-ZMGUBUN,

  ZSUMM LIKE ZEDT08_002-ZSUMM,

  ZWAERS LIKE ZEDT08_002-ZWAERS,

END OF GS_ZEDT002.



" GS_ZEDT004 ### ##

DATA : BEGIN OF GS_ZEDT004,

  MANDT LIKE ZEDT08_004-MANDT,

  ZCODE LIKE ZEDT08_004-ZCODE,

  ZPERNR LIKE ZEDT08_004-ZPERNR,

  ZSCHOOL LIKE ZEDT08_004-ZSCHOOL,

  ZSEM LIKE ZEDT08_004-ZSEM,

  ZEXAM LIKE ZEDT08_004-ZEXAM,

  ZMAJOR LIKE ZEDT08_004-ZMAJOR,

  ZMNAME LIKE ZEDT08_004-ZMNAME,

  ZSUM LIKE ZEDT08_004-ZSUM,

  ZWAERS LIKE ZEDT08_004-ZWAERS,

  ZGRADE LIKE ZEDT08_004-ZGRADE,

  ZFLAG LIKE ZEDT08_004-ZFLAG,

  ZAMOUNT LIKE ZEDT08_004-ZAMOUNT,

END OF GS_ZEDT004.



" #### ## ###### ##

DATA : GT_ZEDT001 LIKE TABLE OF GS_ZEDT001.

DATA : GT_ZEDT002 LIKE TABLE OF GS_ZEDT002.

DATA : GT_ZEDT004 LIKE TABLE OF GS_ZEDT004.



" DATA #### ##

SELECT * FROM ZEDT00_001 INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT001.

SELECT * FROM ZEDT00_002 INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT002.

SELECT * FROM ZEDT00_004 INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT004.



" GT_ZEDT004 ### ZCODE ZPERNR #### ##

SORT GT_ZEDT004 BY ZCODE ZPERNR.



" ## ## ## ###

DATA : GV_ZGRADE TYPE C LENGTH 1.

" ## ## ## ###

DATA : GV_ZTRANSFER TYPE C LENGTH 1.

" ## ## ## ##

DATA : GV_ZLOWGRADE TYPE C LENGTH 1.

" ## ### ## ### ##

DATA : GV_ZSUM TYPE P VALUE '0'.



" ### ### ### ##

DATA : BEGIN OF GS_SUM,

  ZGENDER TYPE C LENGTH 1,

  ZSUM TYPE P,

END OF GS_SUM.



" ### ### ### ##

DATA: GT_SUM LIKE TABLE OF GS_SUM.



" GT_ZEDT004 #### #### LOOP

LOOP AT GT_ZEDT004 INTO GS_ZEDT004.



  " # LOOP# ## ##

  AT FIRST.

    WRITE :/ ' READ## '.

    WRITE :/ ' --------------------------------------------------------------------------------------- '.

    WRITE :/ ' |   ####   |          ##          |  ####  |      ####      |   ##    | '.

    WRITE :/ ' --------------------------------------------------------------------------------------- '.

  ENDAT.



  " #### GS_ZEDT001, GS_ZEDT002 ###

  CLEAR : GS_ZEDT001, GS_ZEDT002.



  " GS_ZEDT004# ZCODE# ## ## ## ##

  MOVE-CORRESPONDING GS_ZEDT004 TO GS_ZEDT001.

  READ TABLE GT_ZEDT001 INTO GS_ZEDT001 WITH KEY ZCODE = GS_ZEDT004-ZCODE COMPARING ZCODE.



  " GS_ZEDT001# ## ## ### ### CONTINUE

  IF SY-SUBRC <> 0.

    CONTINUE.

  ENDIF.



  " GS_ZEDT004# ZCODE# ## ## ## ##

  MOVE-CORRESPONDING GS_ZEDT004 TO GS_ZEDT002.

  READ TABLE GT_ZEDT002 INTO GS_ZEDT002 WITH KEY ZCODE = GS_ZEDT004-ZCODE COMPARING ZCODE.



  " GS_ZEDT001# ## ## ### ### CONTINUE

  IF SY-SUBRC <> 0.

    CONTINUE.

  ENDIF.



  " # ZCODE# ## ## ##, ## ## ##, ## ## ### ###

  AT NEW ZCODE.

    GV_ZTRANSFER = 'T'.

    GV_ZGRADE = 'T'.

    GV_ZLOWGRADE = 'A'.

  ENDAT.



  " ### ## ## ### ### ### ## # ###

  IF GS_ZEDT004-ZGRADE >= GV_ZLOWGRADE.

    GV_ZLOWGRADE = GS_ZEDT004-ZGRADE.

    GV_ZSUM = GS_ZEDT004-ZSUM.

  ENDIF.



  " ## ## ##

  IF GV_ZTRANSFER = 'T'.

    IF GS_ZEDT002-ZMAJOR <> GS_ZEDT004-ZMAJOR.

      GV_ZTRANSFER = 'F'.

    ENDIF.

  ENDIF.



  " ## ## ##

  IF GV_ZGRADE = 'T'.

    IF GS_ZEDT004-ZGRADE = 'D' OR GS_ZEDT004-ZGRADE = 'F'.

      GV_ZGRADE = 'F'.

    ENDIF.

  ENDIF.



  " ### ZCODE# ##

  AT END OF ZCODE.

    " GS_SUM# ## ## ## ##

    GS_SUM-ZGENDER = GS_ZEDT001-ZGENDER.

    GS_SUM-ZSUM    = GV_ZSUM * 100.



    " ## #(ZGENDER)# ## #### ZSUM ## ##

    COLLECT GS_SUM INTO GT_SUM.



    " ## ### ##

    IF GV_ZTRANSFER <> 'T'.

      " ## ## ### ## ##

      IF GV_ZGRADE = 'T'.

        WRITE :/ ' | ', GS_ZEDT001-ZCODE, ' | ', GS_ZEDT001-ZKNAME, ' | ', '####', ' | ', '                ', ' | ', '         | '.

      " ## ## ### ##

      ELSE.

        WRITE :/ ' | ', GS_ZEDT001-ZCODE, ' | ', GS_ZEDT001-ZKNAME, ' | ', '####', ' | ', GS_ZEDT001-ZTEL, ' | ', '#### | '.

      ENDIF.

    " ## ### ## ##

    ELSE.

      " ## ## ### ## ##

      IF GV_ZGRADE = 'T'.

        WRITE :/ ' | ', GS_ZEDT001-ZCODE, ' | ', GS_ZEDT001-ZKNAME, ' | ', '        ', ' | ', '                ', ' | ', '         | '.

      " ## ## ### ##

      ELSE.

         WRITE :/ ' | ', GS_ZEDT001-ZCODE, ' | ', GS_ZEDT001-ZKNAME, ' | ', '        ', ' | ', GS_ZEDT001-ZTEL, ' | ', '#### | '.

      ENDIF.

    ENDIF.



    WRITE :/ ' --------------------------------------------------------------------------------------- '.



    CLEAR : GV_ZSUM.

  ENDAT.



  " ### LOOP# ##

  AT LAST.

    WRITE :/ ' --------------------------------------------------------------------------------------- '.



    " GT_SUM #### ### ## ### ###, ### # ## ##

    LOOP AT GT_SUM INTO GS_SUM.

      IF GS_SUM-ZGENDER = 'M'.

        WRITE: / '###### :', GS_SUM-ZSUM.

      ELSEIF GS_SUM-ZGENDER = 'F'.

        WRITE: / '###### :', GS_SUM-ZSUM.

      ENDIF.

    ENDLOOP.



    EXIT.

  ENDAT.



ENDLOOP.