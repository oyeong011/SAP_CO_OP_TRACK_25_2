
*&---------------------------------------------------------------------*

*& Report ZEDR14_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR14_PRACTICE001.



"## 1#

"## ### ## ### ### ##

DATA : GT_GRADE TYPE TABLE OF ZEDT14_004,

       GS_GRADE TYPE ZEDT14_004.



SELECT * FROM ZEDT14_004 INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.



"ZFLAG ## ##

LOOP AT GT_GRADE INTO GS_GRADE.



  AT NEW ZCODE.     "AT NEW ##

    DATA(LV_FLAG) = 'X'.

  ENDAT.



  IF GS_GRADE-ZGRADE <> 'A'.

    LV_FLAG = ''.   "### ##

  ENDIF.



  AT END OF ZCODE.    "AT END ##

    GS_GRADE-ZFLAG = LV_FLAG.

  ENDAT.



  GS_GRADE-ZFLAG = LV_FLAG.



  MODIFY GT_GRADE FROM GS_GRADE TRANSPORTING ZFLAG

  WHERE ZCODE = GS_GRADE-ZCODE.



  CLEAR GS_GRADE.

ENDLOOP.



"ZAMOUNT ## ##

DATA LV_SUM TYPE ZEDT14_004-ZAMOUNT.    "# ##

LOOP AT GT_GRADE INTO GS_GRADE.



  DATA LV_AMOUNT TYPE ZEDT00_004-ZAMOUNT.



  IF GS_GRADE-ZSCHOOL = 'A' AND GS_GRADE-ZFLAG = 'X'.

    LV_AMOUNT = GS_GRADE-ZSUM * '0.8'.   "###

  ELSEIF GS_GRADE-ZSCHOOL = 'B' AND GS_GRADE-ZFLAG = 'X'.

    LV_AMOUNT = GS_GRADE-ZSUM * '0.9'.   "####

  ELSE.

    LV_AMOUNT = GS_GRADE-ZSUM.

  ENDIF.



  AT END OF ZCODE.

    LV_SUM = LV_SUM + LV_AMOUNT.    "## ##

  ENDAT.



  GS_GRADE-ZAMOUNT = LV_AMOUNT.



  MODIFY GT_GRADE FROM GS_GRADE INDEX SY-TABIX TRANSPORTING ZAMOUNT.



  CLEAR GS_GRADE.

ENDLOOP.



"## ##

SORT GT_GRADE BY ZCODE.     "##

DELETE ADJACENT DUPLICATES FROM GT_GRADE COMPARING ZCODE.   "## ##



LOOP AT GT_GRADE INTO GS_GRADE.

  "## ## ##

  AT FIRST.   "AT FIRST ##

    ULINE AT /01(50).

    WRITE : /01 '|', 02(10) '####' CENTERED,

             12 '|', 13(15) '###' CENTERED,

             28 '|', 29(10) '####' CENTERED,

             39 '|', 40(10) '####' CENTERED,

             50 '|'.

    ULINE AT /01(50).

  ENDAT.



  "## ## ##

  WRITE : /01 '|', 02(10) GS_GRADE-ZCODE CENTERED,

           12 '|', 13(15) GS_GRADE-ZMNAME,

           28 '|', 29(10) GS_GRADE-ZFLAG CENTERED,

           39 '|', 40(10) GS_GRADE-ZAMOUNT CENTERED CURRENCY 'KRW',

           50 '|'.

  ULINE AT /01(50).



  "## ##

  AT LAST.    "AT LAST ##

    WRITE: /01 '|', 02(37) '#    #' CENTERED,

            39 '|', 40(10) LV_SUM CENTERED CURRENCY 'KRW',

            50 '|'.

    ULINE AT /01(50).

  ENDAT.



ENDLOOP.