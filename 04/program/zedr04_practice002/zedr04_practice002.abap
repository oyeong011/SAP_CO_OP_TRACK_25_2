
*&---------------------------------------------------------------------*

*& Report ZEDR04_PRACTICE002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_PRACTICE002.





"####

DATA GS_ZEDT001 TYPE ZEDT04_001.

DATA GS_ZEDT002 TYPE ZEDT04_002.

DATA GS_ZEDT004 TYPE ZEDT04_004.



"### ###

DATA GT_ZEDT001 LIKE TABLE OF ZEDT04_001. " ##, #### ##

DATA GT_ZEDT002 LIKE TABLE OF ZEDT04_002. " ## # ## ##

DATA GT_ZEDT004 LIKE TABLE OF ZEDT04_004. " ## -> ## ### ##, D# F ### #### / ## ##  / ### ##



" ####(###)

DATA : BEGIN OF GS_RESULT,

  ZCODE TYPE ZEDT04_001-ZCODE,

  ZKNAME TYPE ZEDT04_001-ZKNAME,

  ZTEL TYPE ZEDT04_001-ZTEL,

  ZMAJOR_CHANGE TYPE C LENGTH 10,   " ####

  ZBRIEF TYPE C LENGTH 10,          " ## ## ##

  END OF GS_RESULT.

DATA GT_RESULT LIKE TABLE OF GS_RESULT. " ####(###)



" # ## ### ##(###)

DATA : BEGIN OF GS_SUM,

  ZGENDER TYPE ZEDT04_001-ZGENDER,

  ZSUM TYPE I,  " ###(##)

  END OF GS_SUM.

DATA GT_SUM LIKE TABLE OF GS_SUM.



CLEAR : GT_ZEDT001, GT_ZEDT002, GT_ZEDT004, GT_RESULT, GT_SUM.



" ### ####

SELECT * FROM ZEDT04_001 INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT001.

SELECT * FROM ZEDT04_002 INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT002.

SELECT * FROM ZEDT04_004 INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT004.



" ##

SORT GT_ZEDT001 BY ZCODE.

SORT GT_ZEDT002 BY ZCODE.

SORT GT_ZEDT004 BY ZCODE ZGRADE DESCENDING.



DELETE ADJACENT DUPLICATES FROM GT_ZEDT004 COMPARING ZCODE. " ZCODE # ## ## ## ### ### ## ##



CLEAR : GS_ZEDT001, GS_ZEDT002, GS_ZEDT004, GS_RESULT, GS_SUM.

LOOP AT GT_ZEDT001 INTO GS_ZEDT001.

  " INDEX #### GT_ZEDT002 ##

  READ TABLE GT_ZEDT002 INTO GS_ZEDT002 INDEX SY-TABIX.



  " GT_ZEDT004 ##

  MOVE-CORRESPONDING GS_ZEDT001 TO GS_ZEDT004.

  READ TABLE GT_ZEDT004 WITH KEY ZCODE = GS_ZEDT001-ZCODE INTO GS_ZEDT004." COMPARING ZCODE.

  IF SY-SUBRC <> 0. " ## ### ### ###.

    CONTINUE.

  ENDIF.



  " ### ## ## ####

  GS_RESULT-ZCODE = GS_ZEDT001-ZCODE.

  GS_RESULT-ZKNAME = GS_ZEDT001-ZKNAME.



  IF ( GS_ZEDT004-ZGRADE = 'F' )  OR ( GS_ZEDT004-ZGRADE = 'D' ).  " #### ## ##

    GS_RESULT-ZBRIEF = '####'.

    GS_RESULT-ZTEL = GS_ZEDT001-ZTEL.

  ENDIF.



  IF GS_ZEDT002-ZMAJOR <> GS_ZEDT004-ZMAJOR.  " ## ## ##

    GS_RESULT-ZMAJOR_CHANGE = '####'.

  ENDIF.



  APPEND GS_RESULT TO GT_RESULT.



  " # ## ### ## ####

  GS_SUM-ZGENDER = GS_ZEDT001-ZGENDER.

  GS_SUM-ZSUM = GS_ZEDT004-ZSUM * 100.

  COLLECT GS_SUM INTO GT_SUM.



  CLEAR : GS_ZEDT001, GS_RESULT.

ENDLOOP.



" ## ##

CLEAR : GS_RESULT.

LOOP AT GT_RESULT INTO GS_RESULT.

  AT FIRST.

    WRITE / '----------------------------------------------------------------------------------'.

    WRITE : / '|  ####  |         ##         |  ####  |     ####     |    ##    |'.

    WRITE / '----------------------------------------------------------------------------------'.

  ENDAT.



  WRITE : / '|', GS_RESULT-ZCODE, '|', GS_RESULT-ZKNAME, '|', GS_RESULT-ZMAJOR_CHANGE, '|', GS_RESULT-ZTEL, '|', GS_RESULT-ZBRIEF, '|'.

  WRITE / '----------------------------------------------------------------------------------'.

ENDLOOP.



CLEAR GS_SUM.

READ TABLE GT_SUM WITH KEY ZGENDER = 'M' INTO GS_SUM.

WRITE : / '### ### : ', GS_SUM-ZSUM.



CLEAR GS_SUM.

READ TABLE GT_SUM WITH KEY ZGENDER = 'F' INTO GS_SUM.

WRITE : / '### ### : ', GS_SUM-ZSUM.