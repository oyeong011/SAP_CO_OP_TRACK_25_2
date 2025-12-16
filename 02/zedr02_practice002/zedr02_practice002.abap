
*&---------------------------------------------------------------------*

*& Report ZEDR02_PRACTICE002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_PRACTICE002.



DATA: GT_ZEDT001 TYPE TABLE OF ZEDT02_001.

DATA: GT_ZEDT002 TYPE TABLE OF ZEDT02_002.

DATA: GT_ZEDT004 TYPE TABLE OF ZEDT02_004.



"### ### ### ##

DATA: BEGIN OF GS_STUDENT,

  ZCODE TYPE ZEDT02_001-ZCODE, "####

  ZKNAME TYPE ZEDT02_001-ZKNAME, "##

  ZPRCON TYPE C LENGTH 10, "####

  ZTEL TYPE ZEDT02_001-ZTEL, "####

  ZPROB TYPE C LENGTH 10, "##

END OF GS_STUDENT.

DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.



SELECT * FROM ZEDT02_001 INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT001.

SELECT * FROM ZEDT02_002 INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT002.

SELECT * FROM ZEDT02_004 INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT004.

DATA: GS_ZEDT001 TYPE ZEDT02_001.

DATA: GS_ZEDT002 TYPE ZEDT02_002.

DATA: GS_ZEDT004 TYPE ZEDT02_004.



"### ### ### ### ##

DATA: BEGIN OF GS_GENDER,

  ZGNAME TYPE C LENGTH 1, "###: M, F

  ZSUM TYPE ZEDT02_004-ZSUM, "### ##

END OF GS_GENDER.

DATA: GT_GENDER LIKE TABLE OF GS_GENDER.



DATA: GV_IDX TYPE I VALUE 1. "ZEDT02_001# ZEDT02_002# ### ###



"## ## ### ## ## ##

SORT GT_ZEDT004 BY ZCODE ZPERNR ZSCHOOL ZSEM ZGRADE DESCENDING.



"## ## ## ## ### ## ##

DELETE ADJACENT DUPLICATES FROM GT_ZEDT004 COMPARING ZCODE ZSEM.



"APPEND LOOP

LOOP AT GT_ZEDT004 INTO GS_ZEDT004.

  CLEAR GS_STUDENT.

    DO. "001## 004# ### ### ## ### ## ##

      READ TABLE GT_ZEDT001 INTO GS_ZEDT001

        INDEX GV_IDX.



      "001# 004# ## ### ## ### ### ##

      IF GS_ZEDT001-ZCODE = GS_ZEDT004-ZCODE.

        EXIT.



      ENDIF.

      GV_IDX = GV_IDX + 1.

    ENDDO.



    "### D# F# ####

    IF GS_ZEDT004-ZGRADE = 'D' OR GS_ZEDT004-ZGRADE = 'F'.

      GS_STUDENT-ZTEL = GS_ZEDT001-ZTEL. "#### #### ##

      GS_STUDENT-ZPROB = '####'.

    ENDIF.



    "## ##### ##

    GS_GENDER-ZGNAME = GS_ZEDT001-ZGENDER.

    GS_GENDER-ZSUM = GS_ZEDT004-ZSUM.

    COLLECT GS_GENDER INTO GT_GENDER.



    "001# 002##### ### ### ### ##

    GS_ZEDT002-ZMAJOR = GS_ZEDT004-ZMAJOR.

    READ TABLE GT_ZEDT002 INTO GS_ZEDT002 INDEX GV_IDX COMPARING ZMAJOR.

    IF SY-SUBRC = 2.

      GS_STUDENT-ZPRCON = '####'.

    ENDIF.



    "### #### ## ## ##

    GS_STUDENT-ZCODE = GS_ZEDT001-ZCODE.

    GS_STUDENT-ZKNAME = GS_ZEDT001-ZKNAME.

    APPEND GS_STUDENT TO GT_STUDENT.

    GV_IDX = GV_IDX + 1.

ENDLOOP.



"WRITE LOOP

LOOP AT GT_STUDENT INTO GS_STUDENT.

  "# ### ##

  AT FIRST.

    WRITE: / '----------------------------------------------------------------------------------',

           / '|  ####  |         ##         |  ####  |     ####     |    ##    |',

           / '----------------------------------------------------------------------------------'.

  ENDAT.



  WRITE: / '|', GS_STUDENT-ZCODE, '|', GS_STUDENT-ZKNAME, '|', GS_STUDENT-ZPRCON, '|', GS_STUDENT-ZTEL, '|', GS_STUDENT-ZPROB, '|'.

  WRITE: / '----------------------------------------------------------------------------------'.



  "#### ##

  AT LAST.

    READ TABLE GT_GENDER INTO GS_GENDER INDEX 1. "1## ### ##

    GS_GENDER-ZSUM = GS_GENDER-ZSUM * 100.

    IF GS_GENDER-ZGNAME = 'M'.

      WRITE: / '###### :', GS_GENDER-ZSUM DECIMALS 0.

    ELSE.

      WRITE: / '###### :', GS_GENDER-ZSUM DECIMALS 0.

    ENDIF.

    READ TABLE GT_GENDER INTO GS_GENDER INDEX 2. "2## ### ##

    GS_GENDER-ZSUM = GS_GENDER-ZSUM * 100.

    IF GS_GENDER-ZGNAME = 'M'.

      WRITE: / '###### :', GS_GENDER-ZSUM DECIMALS 0.

    ELSE.

      WRITE: / '###### :', GS_GENDER-ZSUM DECIMALS 0.

    ENDIF.

  ENDAT.

ENDLOOP.