
*&---------------------------------------------------------------------*

*& Report ZEDR13_PRACTICE002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR13_PRACTICE002.



DATA : BEGIN OF GS_RESULT,                       "### ###"

  ZCODE TYPE ZEDT13_001-ZCODE,                   "####"

  ZKNAME TYPE ZEDT13_001-ZKNAME,                 "##"

  ZMOVED TYPE C LENGTH 10,                       "####"

  ZTEL TYPE ZEDT13_001-ZTEL,                     "####"

  ZFAIL TYPE C LENGTH 10,                        "##"

  END OF GS_RESULT.

DATA : GT_RESULT LIKE TABLE OF GS_RESULT.



DATA : BEGIN OF GS_SUM,                          "## # ### ### ### ##"

  ZGENDER TYPE ZEDT13_001-ZGENDER,

  ZSUM TYPE ZEDT13_004-ZSUM,

  END OF GS_SUM.

DATA : GT_SUM LIKE TABLE OF GS_SUM.



DATA : GS_ZEDT001 TYPE ZEDT13_001,               "# ### ## WORK AREA # ITAB ##"

       GT_ZEDT001 TYPE TABLE OF ZEDT13_001,

       GS_ZEDT002 TYPE ZEDT13_002,

       GT_ZEDT002 TYPE TABLE OF ZEDT13_002,

       GS_ZEDT004 TYPE ZEDT13_004,

       GT_ZEDT004 TYPE TABLE OF ZEDT13_004.



SELECT * FROM ZEDT13_001                          "# ITAB# ### ####"

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT001.

SELECT * FROM ZEDT13_002

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT002.

SELECT * FROM ZEDT13_004

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT004.



SORT GT_ZEDT004 BY ZCODE ZGRADE DESCENDING.       "SORT # ZCODE# ### ## ## ## ### ## ## ##"

DELETE ADJACENT DUPLICATES FROM GT_ZEDT004 COMPARING ZCODE.



LOOP AT GT_ZEDT004 INTO GS_ZEDT004.

  CLEAR : GS_ZEDT001, GS_ZEDT002, GS_RESULT.



  MOVE-CORRESPONDING GS_ZEDT004 TO GS_ZEDT001.    "ZCODE# ### ##"

  MOVE-CORRESPONDING GS_ZEDT004 TO GS_ZEDT002.    "ZCODE# ### ##"

  MOVE-CORRESPONDING GS_ZEDT004 TO GS_RESULT.     "ZCODE# ### ##"



  READ TABLE GT_ZEDT002 WITH KEY ZCODE = GS_ZEDT004-ZCODE     "GS_ZEDT002# ZCODE#### #####"

  INTO GS_ZEDT002 COMPARING ZMAJOR.                           "## ZMAJOR# ## ## SY-SUBRC = 2# #### #



  IF SY-SUBRC = '2'. "MAJOR ## ### ## ##"

    GS_RESULT-ZMOVED = '####'.

  ENDIF.



  READ TABLE GT_ZEDT001 WITH KEY ZCODE = GS_ZEDT004-ZCODE INTO GS_ZEDT001. "### GS_ZEDT001# # ##"

  IF SY-SUBRC = '0'.

    MOVE-CORRESPONDING GS_ZEDT001 TO GS_RESULT.               "GS_ZEDT001## ## ## #### ZKNAME## ZTEL# ###"

  ENDIF.



  IF GS_ZEDT004-ZGRADE = 'D' OR GS_ZEDT004-ZGRADE = 'F'.      "GS_ZEDT004# ## ## ### D or F# ##"

    GS_RESULT-ZFAIL = '####'.                                "## #### ### ## ## ##"

  ELSEIF GS_ZEDT004-ZGRADE = ' '.

    CONTINUE.                                                 "#### ### ###"

  ELSE.

    CLEAR : GS_RESULT-ZTEL.                                   "###### #### #### ##"

  ENDIF.



  GS_SUM-ZGENDER = GS_ZEDT001-ZGENDER. "GS_SUM# #### ####"

  GS_SUM-ZSUM = GS_ZEDT004-ZSUM.



  APPEND GS_RESULT TO GT_RESULT.     "## ### ##"

  COLLECT GS_SUM INTO GT_SUM.        "## ## M or F# ## ZSUM# ###"



ENDLOOP.



DATA : GV_SUM TYPE P.  "CURR ### ### ## P### ## *100# ## ### #### ## ### ##### #### ### ## #### ## ##"

LOOP AT GT_RESULT INTO GS_RESULT.

  AT FIRST.

    WRITE :/ '-------------------------------------------------------------------------------------'.

    WRITE :/ '|  ####  |         ##         |   ####    |     ####     |    ##    |'.

    WRITE :/ '-------------------------------------------------------------------------------------'.

  ENDAT.



  WRITE :/ '|', GS_RESULT-ZCODE, '|', GS_RESULT-ZKNAME,'|',GS_RESULT-ZMOVED,'   |', GS_RESULT-ZTEL, '|',GS_RESULT-ZFAIL,'|'.

  WRITE :/ '-------------------------------------------------------------------------------------'.



  AT LAST.

    READ TABLE GT_SUM WITH KEY ZGENDER = 'M' INTO GS_SUM.

    IF SY-SUBRC = 0.

      GV_SUM = GS_SUM-ZSUM * 100.

      WRITE :/ '###### : ', GV_SUM.

    ENDIF.

    READ TABLE GT_SUM WITH KEY ZGENDER = 'F' INTO GS_SUM.

    IF SY-SUBRC = 0.

      GV_SUM = GS_SUM-ZSUM * 100.

      WRITE :/ '###### : ', GV_SUM.

    ENDIF.

  ENDAT.

ENDLOOP.