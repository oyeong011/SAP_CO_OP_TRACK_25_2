
*&---------------------------------------------------------------------*

*& Report ZEDR19_029

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_029.



TYPES : BEGIN OF TY_RESULT,

        ZCODE TYPE ZEDT19_0001-ZCODE,

        ZNAME TYPE ZEDT19_0001-ZKNAME,

        LV_STOP TYPE C LENGTH 10,

        LV_MAJOR TYPE C LENGTH 10,

        LV_TEL TYPE C LENGTH 20,

        END OF TY_RESULT.



DATA : GT_RESULT TYPE SORTED TABLE OF TY_RESULT WITH UNIQUE KEY ZCODE,

       GS_RESULT TYPE TY_RESULT.



"### ## ##

DATA : LV_TEL TYPE C LENGTH 20,

       LV_FEMALE_SUM TYPE I,

       LV_MAJOR TYPE C LENGTH 20,

       LV_MALE_SUM TYPE I.



DATA : GT_ZEDT001 TYPE STANDARD TABLE OF ZEDT19_0001 WITH DEFAULT KEY,

       GT_ZEDT002 TYPE STANDARD TABLE OF ZEDT19_002 WITH DEFAULT KEY,

       GT_ZEDT004 TYPE STANDARD TABLE OF ZEDT19_004 WITH DEFAULT KEY.



DATA : GS_ZEDT001 TYPE ZEDT19_0001,

       GS_ZEDT002 TYPE ZEDT19_002,

       GS_ZEDT004 TYPE ZEDT19_004.



SELECT * FROM ZEDT19_0001 INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT001.

SELECT * FROM ZEDT19_002 INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT002.

SELECT * FROM ZEDT19_004 INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT004.



"##

SORT GT_ZEDT001 BY ZCODE.

SORT GT_ZEDT002 BY ZCODE.

SORT GT_ZEDT004 BY ZCODE ZGRADE DESCENDING.



LOOP AT GT_ZEDT001 INTO GS_ZEDT001.



  "#### ## ##

  READ TABLE GT_ZEDT004 WITH KEY ZCODE = GS_ZEDT001-ZCODE INTO GS_ZEDT004.

  CHECK SY-SUBRC = 0.





  "## ## ## (## SORT ## #### # ## ###)

  DATA(LV_STOP) = ' '.

  IF GS_ZEDT004-ZGRADE = 'D' OR

     GS_ZEDT004-ZGRADE = 'F'.

    LV_STOP = '####'.

    LV_TEL = GS_ZEDT001-ZTEL.

  ELSE.

    LV_TEL = ' '.

  ENDIF.



  "## ## ##

  CLEAR GS_ZEDT002.

  READ TABLE GT_ZEDT002 WITH KEY ZCODE = GS_ZEDT001-ZCODE

  INTO GS_ZEDT002.



  IF GS_ZEDT002-ZMNAME <> GS_ZEDT004-ZMNAME.

    LV_MAJOR = '####'.

  ELSE.

    LV_MAJOR = ' '.

  ENDIF.



  WRITE: / '## #:', gs_result-zcode, gs_result-zname, lv_stop, lv_major, lv_tel.



  CLEAR GS_RESULT.

  GS_RESULT-ZCODE = GS_ZEDT001-ZCODE.

  GS_RESULT-ZNAME = GS_ZEDT001-ZKNAME.

  GS_RESULT-LV_STOP = LV_STOP.

  GS_RESULT-LV_MAJOR = LV_MAJOR.

  GS_RESULT-LV_TEL = LV_TEL.

  "## #### ## #### ###

  MODIFY TABLE GT_RESULT FROM GS_RESULT.



  "### ### ##

  READ TABLE GT_ZEDT002 WITH KEY ZCODE = GS_ZEDT001-ZCODE INTO GS_ZEDT002.

  IF GS_ZEDT001-ZGENDER = 'F'.

    LV_FEMALE_SUM = LV_FEMALE_SUM + GS_ZEDT002-ZSUM.

  ELSE.

    LV_MALE_SUM = LV_MALE_SUM + GS_ZEDT002-ZSUM.

  ENDIF.



ENDLOOP.



LOOP AT GT_RESULT INTO GS_RESULT.

  AT FIRST.

    WRITE :/ '-------------------------------------------------------------------------------------'.

    WRITE :/ '|  ####  |         ##         |   ####    |     ####     |    ##    |'.

    WRITE :/ '-------------------------------------------------------------------------------------'.

  ENDAT.



  WRITE :/ '|', GS_RESULT-ZCODE, '|', GS_RESULT-ZNAME,'|',GS_RESULT-LV_MAJOR,'   |', GS_RESULT-LV_TEL, '|',GS_RESULT-LV_STOP,'|'.

  WRITE :/ '-------------------------------------------------------------------------------------'.

ENDLOOP.