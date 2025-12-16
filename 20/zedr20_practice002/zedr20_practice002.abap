
*&---------------------------------------------------------------------*

*& Report ZEDR20_PRACTICE002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_PRACTICE002.



DATA: GS_ZEDT001 TYPE ZEDT20_001.   " ZEDT20_001# #### ## ##### ##

DATA: GT_ZEDT001 LIKE TABLE OF GS_ZEDT001.    " ZEDT20_001# #### ## ###### ##



DATA: GS_ZEDT002 TYPE ZEDT20_002.   " ZEDT20_002# #### ## ##### ##

DATA: GT_ZEDT002 LIKE TABLE OF GS_ZEDT002.    " ZEDT20_002# #### ## ###### ##



DATA: GS_ZEDT004 TYPE ZEDT20_004.   " ZEDT20_004# #### ## ##### ##

DATA: GT_ZEDT004 LIKE TABLE OF GS_ZEDT004.    " ZEDT20_004# #### ## ###### ##



DATA: BEGIN OF GS_MASTER,   " ### #### ### ##### ##

  ZCODE TYPE ZEDT20_001-ZCODE,    " ZCODE ##

  ZKNAME(10),   " ZKNAME ##

  ZTARGET(10),    " ZTARGET ## (## ##)

  ZTEL TYPE ZEDT20_001-ZTEL,    " ZTEL ##

  ZBRIEF(10),   " ZBRIEF ## (##)

  END OF GS_MASTER.   " ##### ## ##

DATA: GT_MASTER LIKE TABLE OF GS_MASTER.    " ### #### ### ###### ##



DATA: BEGIN OF GS_SUM,    " #### #### # #### ### ##### ##

  ZGENDER,    " ZGEDNDER ##

  ZSUM TYPE I VALUE 0,    " ZSUM ## # 0## ###

  END OF GS_SUM.    " ##### ## ##

DATA: GT_SUM LIKE TABLE OF GS_SUM.    " #### #### # #### ### ###### ##



" ### #### #### ## ### ## ##

GS_SUM-ZGENDER = 'M'.

APPEND GS_SUM TO GT_SUM.    " #### append



" ### #### #### ## ### ## ##

GS_SUM-ZGENDER = 'F'.

APPEND GS_SUM TO GT_SUM.    " #### append



" ### ### #### ## ## KRW ## ##

CONSTANTS: C_KRW TYPE I VALUE 100.



" ZEDT20_001# #### GT_ZEDT001# ###

SELECT * FROM ZEDT20_001

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT001.



" ZEDT20_002# #### GT_ZEDT002# ###

SELECT * FROM ZEDT20_002

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT002.



" ZEDT20_004# #### GT_ZEDT004# ###

SELECT * FROM ZEDT20_004

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT004.



" ### ## ## ### #### ## ##

SORT GT_ZEDT004 BY ZCODE ASCENDING ZGRADE DESCENDING.



" ZCODE# #### ### # ## ### #### ### ## => ### ### ##

DELETE ADJACENT DUPLICATES FROM GT_ZEDT004 COMPARING ZCODE.



CLEAR: GS_MASTER, GS_ZEDT001, GS_ZEDT002, GS_ZEDT004.   " ##### ###



LOOP AT GT_ZEDT002 INTO GS_ZEDT002.   " LOOP## ##

  CLEAR: GS_ZEDT004, GS_ZEDT001, GS_MASTER.   " ##### ###



  " ### ### ### ##### ##### GT_ZEDT004# ### ### #### ###

  READ TABLE GT_ZEDT004 WITH KEY ZCODE = GS_ZEDT002-ZCODE INTO GS_ZEDT004.

  IF SY-SUBRC NE 0.   " #### ### ###

    CONTINUE.         " ## #### ## ##

  ENDIF.    " IF## ##



  READ TABLE GT_ZEDT001 WITH KEY ZCODE = GS_ZEDT002-ZCODE INTO GS_ZEDT001.



  GS_MASTER-ZKNAME = GS_ZEDT001-ZKNAME.   " GS_MASTER# #### ##

  GS_MASTER-ZCODE = GS_ZEDT002-ZCODE.   " GS_MASTER# ZCODE ##



  " ### D## F# ### ##### ##

  IF ( GS_ZEDT004-ZGRADE = 'D' ) OR ( GS_ZEDT004-ZGRADE = 'F' ).

    GS_MASTER-ZBRIEF = '####'.    " ##### ZBRIEF# ##

    GS_MASTER-ZTEL = GS_ZEDT001-ZTEL.   " GS_MASTER# ZTEL ##

  ENDIF.    " IF# ##



  IF GS_ZEDT002-ZMAJOR NE GS_ZEDT004-ZMAJOR.    " ZMAJOR## ####

    GS_MASTER-ZTARGET = '####'.   " ##### ###

  ENDIF.    " IF# ##.



  " ###### ### append#

  APPEND GS_MASTER TO GT_MASTER.



  GS_SUM-ZGENDER = GS_ZEDT001-ZGENDER.    " GS_SUM# ZGENDER# ## ### ### ###

  GS_SUM-ZSUM = GS_ZEDT004-ZSUM * C_KRW.    " GS_SUM# ZSUM# ## ### #### C_KRW# ### ###

  COLLECT GS_SUM INTO GT_SUM.   " # ### ###### COLLECT# ###

ENDLOOP.    " LOOP# ##.



LOOP AT GT_MASTER INTO GS_MASTER.   " #### #### LOOP# ##

  AT FIRST.   " ## ### #### #####

    WRITE :/ '-------------------------------------------------------------------------------'.

    WRITE :/ '|   ####   |    ##    |   ####   |       ####      |    ##    |'.

    WRITE :/ '-------------------------------------------------------------------------------'.

  ENDAT.    " AT## ##

  " ### ##

  WRITE :/ '|  ', GS_MASTER-ZCODE, '|',GS_MASTER-ZKNAME,'|  ',  GS_MASTER-ZTARGET  ,'|  ' ,GS_MASTER-ZTEL,' |', GS_MASTER-ZBRIEF, '|'.

  WRITE :/ '-------------------------------------------------------------------------------'.





  AT LAST.    " ### ### ### #### ### ### #####

    READ TABLE GT_SUM WITH KEY ZGENDER = 'M' INTO GS_SUM.   " ### #### #### ###

    WRITE :/ '###### :', GS_SUM-ZSUM.   " ### ### ##

    READ TABLE GT_SUM WITH KEY ZGENDER = 'F' INTO GS_SUM.   " ### #### #### ###

    WRITE :/ '###### :', GS_SUM-ZSUM.   " ### ### ##

  ENDAT.    " AT## ##

ENDLOOP.    " Loop# ##