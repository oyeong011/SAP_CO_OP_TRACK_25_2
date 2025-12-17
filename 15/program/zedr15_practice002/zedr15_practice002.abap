
*&---------------------------------------------------------------------*

*& Report ZEDR15_PRACTICE002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR15_PRACTICE002.



"### ##

DATA : GS_ZEDT001 TYPE ZEDT00_001.

DATA : GS_ZEDT002 TYPE ZEDT00_002.

DATA : GS_ZEDT004 TYPE ZEDT00_004.



"## ##

DATA : GV_CHMAJOR LENGTH 10 TYPE C, "####

      GV_WARN LENGTH 10 TYPE C, "####

      GV_TEL TYPE ZEDT00_001-ZTEL. "#### ### ####



DATA : BEGIN OF GS_SUM, "##

  ZGENDER TYPE ZEDT00_001-ZGENDER, "##

  ZSUM TYPE ZEDT00_004-ZSUM, "###

  END OF GS_SUM.





"###### ##

DATA : GT_ZEDT001 LIKE TABLE OF GS_ZEDT001.

DATA : GT_ZEDT002 LIKE TABLE OF GS_ZEDT002.

DATA : GT_ZEDT004 LIKE TABLE OF GS_ZEDT004.

DATA : GT_SUM LIKE TABLE OF GS_SUM.



"### ####

SELECT * FROM ZEDT00_001 INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT001.



SELECT * FROM ZEDT00_002 INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT002.



SELECT * FROM ZEDT00_004 INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT004.



"### ## # GT_ZDET004# #### ## ### ##

SORT GT_ZEDT001 BY ZCODE.

SORT GT_ZEDT002 BY ZCODE.

SORT GT_ZEDT004 BY ZCODE ZGRADE DESCENDING.

DELETE ADJACENT DUPLICATES FROM GT_ZEDT004 COMPARING ZCODE.





CLEAR : GS_ZEDT001, GS_ZEDT002, GS_ZEDT004.



LOOP AT GT_ZEDT004 INTO GS_ZEDT004.



  AT FIRST.

    WRITE :/ '-------------------------------------------------------------------------------------'.

    WRITE :/ '|  ####  |         ##         |   ####    |     ####     |    ##    |'.

    WRITE :/ '-------------------------------------------------------------------------------------'.

  ENDAT.



  CHECK GS_ZEDT004-ZGRADE NE ''. "#### ### ##### ##



  "#### ##

  MOVE-CORRESPONDING GS_ZEDT004 TO GS_ZEDT002.

  READ TABLE GT_ZEDT002 WITH KEY ZCODE = GS_ZEDT004-ZCODE INTO GS_ZEDT002 COMPARING ZMAJOR. "### #### ###



  IF SY-SUBRC = 2. "### GS_RESULT# #### ##

    GV_CHMAJOR = '####'.

  ELSE.

    GV_CHMAJOR = ''.

  ENDIF.



  "#### ##

  MOVE-CORRESPONDING GS_ZEDT004 TO GS_ZEDT001.

  READ TABLE GT_ZEDT001 WITH KEY ZCODE = GS_ZEDT004-ZCODE INTO GS_ZEDT001. "### ####



  IF GS_ZEDT004-ZGRADE = 'F' OR GS_ZEDT004-ZGRADE = 'D'.

    GV_WARN = '####'.

    GV_TEL = GS_ZEDT001-ZTEL.

  ELSE.

    GV_WARN = ''.

    GV_TEL = ''.

  ENDIF.



  "## ##

  MOVE-CORRESPONDING GS_ZEDT001 TO GS_SUM.

  MOVE-CORRESPONDING GS_ZEDT004 TO GS_SUM.

  COLLECT GS_SUM INTO GT_SUM.



  WRITE :/ '|', GS_ZEDT004-ZCODE, '|', GS_ZEDT001-ZKNAME,'|',GV_CHMAJOR,'   |', GV_TEL, '|',GV_WARN,'|'.

  WRITE :/ '-------------------------------------------------------------------------------------'.



  CLEAR : GV_CHMAJOR, GV_WARN, GV_TEL. "## ### ## ## CLEAR

ENDLOOP.





"## ##

LOOP AT GT_SUM INTO GS_SUM.

  GS_SUM-ZSUM = GS_SUM-ZSUM * 100.

  IF GS_SUM-ZGENDER = 'M'.

    WRITE : / '###### : ',  GS_SUM-ZSUM .

  ELSE.

    WRITE : / '###### : ',  GS_SUM-ZSUM .

  ENDIF.

ENDLOOP.