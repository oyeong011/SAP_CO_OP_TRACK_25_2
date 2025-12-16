
*&---------------------------------------------------------------------*

*& Report ZEDR10_PRACTICE002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR10_PRACTICE002.



" ### ## ------

DATA: BEGIN OF GS_RESULT,

  ZCODE     TYPE ZEDT10_001-ZCODE,    " ## ##

  ZKNAME    TYPE ZEDT10_001-ZKNAME,   " ## ##

  ZCHMAJOR  TYPE ABAP_BOOL,           " ## FLAG

  ZTEL      TYPE ZEDT10_001-ZTEL,     " ####

  ZWARNING  TYPE ABAP_BOOL,           " #### FLAG

  ZGENDER   TYPE ZEDT10_001-ZGENDER,  " ## ##

  ZSUM      TYPE ZEDT10_004-ZSUM,     " ## ##

END OF GS_RESULT.



DATA: BEGIN OF GS_SCHOLAR,

  ZGENDER   TYPE ZEDT10_001-ZGENDER,

  ZSUM  TYPE ZEDT10_004-ZSUM,

END OF GS_SCHOLAR.



DATA: GS_ZEDT001 TYPE ZEDT10_001,

      GS_ZEDT002 TYPE ZEDT10_002,

      GS_ZEDT004 TYPE ZEDT10_004.



" #. ### ## ------



" ### ## -------------------



DATA: GT_ZEDT001 TYPE SORTED TABLE OF ZEDT10_001 WITH UNIQUE KEY ZCODE,

      GT_ZEDT002 TYPE SORTED TABLE OF ZEDT10_002 WITH UNIQUE KEY ZCODE,

      GT_ZEDT004 TYPE TABLE OF ZEDT10_004 WITH NON-UNIQUE KEY ZCODE.




*      GT_TEMP004 TYPE TABLE OF ZEDT10_004 WITH NON-UNIQUE KEY ZCODE.      " T004 ### ### #






DATA: GT_RESULT LIKE TABLE OF GS_RESULT,

      GT_SCHOLAR LIKE TABLE OF GS_SCHOLAR.



" #. ### ## -------------------





" # #### -------------------------------------

SELECT * FROM ZEDT10_001

  INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT001.



SELECT * FROM ZEDT10_002

  INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT002.



SELECT * FROM ZEDT10_004

  INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT004.






*MOVE-CORRESPONDING GT_ZEDT001[] TO GT_RESULT[].




" #. # #### -------------------------------------






*### ### ## ## ### ##### ##

*GT_ZEDT004## D # F # #### ## ####

*#### #### ZTEL# ### ##

*GT_ZEDT002# ## ### GT_ZEDT004# ### ### ## FLAG TRUE






" #### # ### CLEAR

CLEAR: GS_RESULT, GS_SCHOLAR, GS_ZEDT001, GS_ZEDT002, GS_ZEDT004.



" TABLE #### ### ## ## SORT

SORT GT_ZEDT004 ASCENDING BY ZCODE ZGRADE.



" ### #### ## ZEDT004# #### ####.

LOOP AT GT_ZEDT004 INTO GS_ZEDT004.

  AT NEW ZCODE.

    " ### ZCODE# #### CLEAR

    CLEAR: GS_RESULT, GS_SCHOLAR, GS_ZEDT001, GS_ZEDT002.



    " ### GS_RESULT # ##.

    READ TABLE GT_ZEDT001

      INTO GS_ZEDT001

      WITH KEY ZCODE = GS_ZEDT004-ZCODE

      COMPARING ZCODE.



    READ TABLE GT_ZEDT002

      INTO GS_ZEDT002

      WITH KEY ZCODE = GS_ZEDT001-ZCODE

      TRANSPORTING ZMNAME ZMAJOR.



    MOVE-CORRESPONDING GS_ZEDT002 TO GS_RESULT.

    MOVE-CORRESPONDING GS_ZEDT001 TO GS_RESULT.



    GS_RESULT-ZCHMAJOR = ABAP_FALSE.

    GS_RESULT-ZWARNING = ABAP_FALSE.



  ENDAT.



  IF GS_ZEDT004-ZMAJOR <> GS_ZEDT002-ZMAJOR.

    GS_RESULT-ZCHMAJOR = ABAP_TRUE.

  ENDIF.



  IF GS_ZEDT004-ZGRADE = 'D' OR GS_ZEDT004-ZGRADE = 'F'.

    GS_RESULT-ZWARNING = ABAP_TRUE.

  ENDIF.



  GS_RESULT-ZSUM = GS_ZEDT004-ZSUM.



  AT END OF ZCODE.

    " ### ## # ####

    GS_SCHOLAR-ZGENDER = GS_RESULT-ZGENDER.

    GS_SCHOLAR-ZSUM = GS_RESULT-ZSUM.

    COLLECT GS_SCHOLAR INTO GT_SCHOLAR.



    " ### ### ### ##

    APPEND GS_RESULT TO GT_RESULT.

  ENDAT.

ENDLOOP.



" ## ### ##

LOOP AT GT_RESULT INTO GS_RESULT.

  AT FIRST.

    WRITE :/ '-------------------------------------------------------------------------------------'.

    WRITE :/ '|  ####  |         ##         |   ####    |     ####     |    ##    |'.

    WRITE :/ '-------------------------------------------------------------------------------------'.

  ENDAT.



  WRITE :/ '|', GS_RESULT-ZCODE, '|', GS_RESULT-ZKNAME,'          |'.

  IF GS_RESULT-ZCHMAJOR = ABAP_TRUE.

    WRITE: '      X       |'.

  ELSE.

    WRITE: '              |'.

  ENDIF.

  IF GS_RESULT-ZWARNING = ABAP_TRUE.

    WRITE: GS_RESULT-ZTEL, '|'.

    WRITE: '####   |'.

  ELSE.

    WRITE: '                ', '|'.

    WRITE: '           |'.

  ENDIF.

  WRITE :/ '-------------------------------------------------------------------------------------'.

ENDLOOP.



" ## ### ##.

DO.

  CLEAR GS_SCHOLAR.

  READ TABLE GT_SCHOLAR INTO GS_SCHOLAR INDEX SY-INDEX.

  IF SY-SUBRC = 0.

    IF GS_SCHOLAR-ZGENDER = 'M'.

      WRITE :/ '###### : '.

    ELSEIF GS_SCHOLAR-ZGENDER = 'F'.

      WRITE :/ '###### : '.

    ELSE.

      WRITE:/ '#### ## ### #####.'.

      EXIT.

    ENDIF.

    DATA: GV_SUM TYPE I.

    GV_SUM = GS_SCHOLAR-ZSUM * 100.

    WRITE: GV_SUM.

  ELSE.

    " 2## #### ## #.

    STOP.

  ENDIF.

ENDDO.