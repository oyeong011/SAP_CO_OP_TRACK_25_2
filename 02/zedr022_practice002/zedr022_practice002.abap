
*&---------------------------------------------------------------------*

*& Report ZEDR022_PRACTICE002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR022_PRACTICE002.






* #### ## ### ### ##




TYPES : BEGIN OF TY_ZEDT001,

  ZCODE TYPE C LENGTH 10, "####

  ZPERNR TYPE C LENGTH 10, "####

  ZKNAME TYPE C LENGTH 20, "####

  ZENAME TYPE C LENGTH 20, "####

  ZGENDER TYPE C LENGTH 1, "##

  ZTEL TYPE C LENGTH 20, "####

END OF TY_ZEDT001.



DATA : GT_ZEDT001 TYPE TABLE OF TY_ZEDT001,

      GS_ZEDT001 TYPE TY_ZEDT001.



TYPES : BEGIN OF TY_ZEDT002,

  ZCODE TYPE C LENGTH 10, "####

  ZPERNR TYPE C LENGTH 10, "####

  ZMAJOR TYPE C LENGTH 5, "##

  ZMNAME TYPE C LENGTH 30, "###

  ZMGUBUN TYPE C LENGTH 1, "####

  ZUM TYPE P DECIMALS 2, "###

  ZWAERS TYPE C LENGTH 3, "##

END OF TY_ZEDT002.



DATA : GT_ZEDT002 TYPE TABLE OF TY_ZEDT002,

      GS_ZEDT002 TYPE TY_ZEDT002.



TYPES : BEGIN OF TY_ZEDT004,

  ZCODE TYPE C LENGTH 10, "####

  ZPERNR TYPE C LENGTH 10, "####

  ZSCHOOL TYPE C LENGTH 1, "####

  ZSEM TYPE C LENGTH 1, "####

  ZEXAM TYPE C LENGTH 1, "####

  ZMAJOR TYPE C LENGTH 5, "##

  ZMNAME TYPE C LENGTH 30, "###

  ZSUM TYPE P DECIMALS 2, "### ## ##

  ZWAERS TYPE C LENGTH 3, "##

  ZGRADE TYPE C LENGTH 1, "##

END OF TY_ZEDT004.



DATA : GT_ZEDT004 TYPE TABLE OF TY_ZEDT004,

      GS_ZEDT004 TYPE TY_ZEDT004.



TYPES : BEGIN OF TY_SUM,

  ZGENDER TYPE C LENGTH 1, "##

  TOTAL TYPE P DECIMALS 2, "# ###

END OF TY_SUM.



DATA : GT_SUM TYPE TABLE OF TY_SUM,

      GS_SUM TYPE TY_SUM.






* ### ####




SELECT * FROM ZEDT00_001

  INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT001.

SELECT * FROM ZEDT00_002

  INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT002.

SELECT * FROM ZEDT00_004

  INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT004.






* ## ##




DATA : GV_LOWEST_GRADE TYPE C LENGTH 1, "### ## ## # ## ## ##

       GV_LOWEST_SUM TYPE P DECIMALS 2, "#### ## # ## ###

       GV_WARN_FLAG TYPE C LENGTH 10, "#### ##

       LV_TRANSFER TYPE C LENGTH 10. "## ##



"ZEDT00_004# 'D'or'F'# #### ### #### ##

"# ## #### # ### ##, ##, ### ## ## ## ## ## ### # ### ## ##

LOOP AT GT_ZEDT004 INTO GS_ZEDT004.

  IF GS_ZEDT004-ZGRADE = 'D' or GS_ZEDT004-ZGRADE = 'F'.

    GS_ZEDT004-ZSCHOOL = 'W'. "###### ### ZSCHOOL# 'W'

    MODIFY GT_ZEDT004 FROM GS_ZEDT004. "## ### ##

   ENDIF.

ENDLOOP.



LOOP AT GT_ZEDT001 INTO GS_ZEDT001.



"### # ## ## ## ### ##### #### ##

 READ TABLE GT_ZEDT004 WITH KEY ZCODE = GS_ZEDT001-ZCODE

 TRANSPORTING NO FIELDS. "TRANSPORTING NO FIELDS : ## #### ##, ### ## #### ###

                         "SY-SUBRC = 0, ### SY-SUBRC # 0 ##

IF SY-SUBRC NE 0.

  CONTINUE. "## ##### ## ## ####, ## ## LOOP #### ####

 ENDIF.



"### ## ## & ### ##

 CLEAR: GV_LOWEST_GRADE, GV_LOWEST_SUM.

 READ TABLE GT_ZEDT004 INTO GS_ZEDT004

  WITH KEY ZCODE = GS_ZEDT001-ZCODE "ZCODE #### ## ### ##

  COMPARING ZGRADE. "ZGRADE# ### ##

  GV_LOWEST_GRADE = GS_ZEDT004-ZGRADE. "## ##

  GV_LOWEST_SUM = GS_ZEDT004-ZSUM. "##### # ###



"####(## ### ## ### ### ## ##)

CLEAR LV_TRANSFER.

READ TABLE GT_ZEDT002 INTO GS_ZEDT002 WITH KEY ZCODE = GS_ZEDT001-ZCODE.

IF SY-SUBRC = 0 AND GS_ZEDT002-ZMAJOR NE GS_ZEDT004-ZMAJOR.

  "## ### ##### ## ### ## ### ####

  LV_TRANSFER = '####'.

ENDIF.



"#### ## ##

GV_WARN_FLAG = ''. "#### ###

READ TABLE GT_ZEDT004 INTO GS_ZEDT004

  WITH KEY ZCODE = GS_ZEDT001-ZCODE

  ZSCHOOL = 'W'. "## ### ## ## 'W' #### ## ##

IF SY-SUBRC = 0.

  GV_WARN_FLAG = '####'.

ENDIF.



"### ##

CLEAR GS_SUM.

GS_SUM-ZGENDER = GS_ZEDT001-ZGENDER.

GS_SUM-TOTAL = GV_LOWEST_SUM.

COLLECT GS_SUM INTO GT_SUM. "COLLECT : ## ## ### ## ##



" AT FIRST  ## ##

  AT FIRST.

    WRITE: / '-------------------------------------------------------------------------------',

           / '|', (14) '####',

             '|', (9)  '##',

             '|', (10) '####',

             '|', (20) '####',

             '|', (10) '##', '|',

           / '-------------------------------------------------------------------------------'.

  ENDAT.



  " ### ##

  WRITE: / '|', (14) GS_ZEDT001-ZCODE,

           '|', (9)  GS_ZEDT001-ZKNAME,

           '|', (10) LV_TRANSFER.



  IF GV_WARN_FLAG = '####'.

    WRITE: '|', (20) GS_ZEDT001-ZTEL, "###### #### ###

           '|', (10) GV_WARN_FLAG, '|'.

  ELSE.

    WRITE: '|', (20) space, "## ## ### #### # ###

           '|', (10) GV_WARN_FLAG, '|'.

  ENDIF.



  WRITE: / '-------------------------------------------------------------------------------'.



"  AT LAST.

"    READ TABLE GT_SUM INTO GS_SUM

"    WITH KEY ZGENDER = 'M'.

"    IF sy-subrc = 0.

"      WRITE: / '###### :', GS_SUM-TOTAL CURRENCY 'KRW'.

"    ENDIF.



"    READ TABLE GT_SUM INTO GS_SUM

"    WITH KEY ZGENDER = 'F'.

"    IF sy-subrc = 0.

"      WRITE: / '###### :', GS_SUM-TOTAL CURRENCY 'KRW'.

"    ENDIF.

"  ENDAT.



ENDLOOP.





READ TABLE GT_SUM INTO GS_SUM WITH KEY ZGENDER = 'M'.

IF sy-subrc = 0.

  WRITE: / '###### :', GS_SUM-TOTAL CURRENCY 'KRW'.

ENDIF.



READ TABLE GT_SUM INTO GS_SUM WITH KEY ZGENDER = 'F'.

IF sy-subrc = 0.

  WRITE: / '###### :', GS_SUM-TOTAL CURRENCY 'KRW'.

ENDIF.