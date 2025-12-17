
*&---------------------------------------------------------------------*

*& Report ZEDR12_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_PRACTICE001.

DATA: GV_SUM TYPE I.

DATA: LV_P1 TYPE P DECIMALS 2.

DATA: LV_P2 TYPE P DECIMALS 2.

LV_P1 = '0.8'. "## ### #### ##

LV_P2 = '0.9'.





DATA: GS_GRADE TYPE ZEDT12_004. "#####.

DATA: GT_GRADE LIKE TABLE OF GS_GRADE. "########

DATA: BEGIN OF GS_ISSCHOLAR, "### ## ## ## ###

  ZCODE TYPE ZEDT12_004-ZCODE,

  CHECKA(1) TYPE C,

  END OF GS_ISSCHOLAR.

DATA: GT_ISSCHOLAR LIKE TABLE OF GS_ISSCHOLAR."### ## ## ## ###



DATA: BEGIN OF GS_OUT, "## ## ### # ### (###### #### ##.)

   ZCODE TYPE ZEDT12_004-ZCODE,

   ZMNAME TYPE ZEDT12_004-ZMNAME,

   ZFLAG TYPE ZEDT12_004-ZFLAG,

   ZWAERS TYPE ZEDT12_004-ZWAERS,

   ZAMOUNT TYPE I,

  END OF GS_OUT.

DATA: GT_OUT LIKE TABLE OF GS_OUT.

CLEAR: GS_OUT, GT_OUT.



SELECT * FROM ZEDT12_004 INTO CORRESPONDING FIELDS OF TABLE GT_GRADE. "2.DATA ###.

DELETE ADJACENT DUPLICATES FROM GT_GRADE.



SORT GT_GRADE BY ZCODE ZGRADE.



LOOP AT GT_GRADE INTO GS_GRADE.

  AT NEW ZCODE. "ZCODE# ### ##

   GS_ISSCHOLAR-CHECKA = 'X'.

  ENDAT.

  "### ##.

  IF GS_GRADE-ZGRADE = 'A'.

    GS_ISSCHOLAR-CHECKA = 'X'.

  ELSE.

    GS_ISSCHOLAR-CHECKA = ''.

  ENDIF.



  AT END OF ZCODE.

    GS_ISSCHOLAR-ZCODE = GS_GRADE-ZCODE.

    APPEND GS_ISSCHOLAR TO GT_ISSCHOLAR.

  ENDAT.

ENDLOOP.



LOOP AT GT_GRADE INTO GS_GRADE.



  READ TABLE GT_ISSCHOLAR INTO GS_ISSCHOLAR WITH KEY ZCODE = GS_GRADE-ZCODE.

    IF SY-SUBRC = 0 AND GS_ISSCHOLAR-CHECKA = 'X'. "### ## ##

       GS_GRADE-ZFLAG = 'X'.

        IF GS_GRADE-ZSCHOOL = 'A'. "###

          GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM * LV_P1 * 100.

        ELSEIF GS_GRADE-ZSCHOOL = 'B'. "####

          GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM * LV_P2 * 100.

        ENDIF.

    ELSE.

        GS_GRADE-ZFLAG = ''.

        GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM * 100.

    ENDIF.

      MODIFY GT_GRADE FROM GS_GRADE TRANSPORTING ZFLAG ZAMOUNT.



ENDLOOP.






*LOOP AT GT_GRADE INTO GS_GRADE.

*  AT END OF ZCODE.

*    GS_OUT-ZCODE = GS_GRADE-ZCODE.

*    ENDAT.

*    "MOVE-CORRESPONDING GS_GRADE TO GS_OUT.

*    GS_OUT-ZMNAME = GS_GRADE-ZMNAME.

*    GS_OUT-ZFLAG = GS_GRADE-ZFLAG.

*    GS_OUT-ZWAERS = GS_GRADE-ZWAERS.

*    GS_OUT-ZAMOUNT = GS_GRADE-ZAMOUNT.

*    APPEND GS_OUT TO GT_OUT.

*    CLEAR: GS_OUT.

*    "MODIFY GT_OUT FROM GS_OUT.

*ENDLOOP.






  MOVE-CORRESPONDING GT_GRADE[] TO GT_OUT[]. " GRADE## OUT#### BODY COPY

  DELETE ADJACENT DUPLICATES FROM GT_OUT COMPARING ZCODE.



" ### ##

LOOP AT GT_OUT INTO GS_OUT.

  GV_SUM = GV_SUM + GS_OUT-ZAMOUNT.

  AT FIRST. "## ### ## ### ### ##.

    WRITE :/ 'TITLE : LOOP## (AT##)'.

    WRITE :/ '--------------------------------------------------------------------------'.

    WRITE :/ '|   ####   |          ###          |####|       ####      |'.

    WRITE :/ '--------------------------------------------------------------------------'.

  ENDAT.



  WRITE :/ '|  ', GS_OUT-ZCODE, '|    ',GS_OUT-ZMNAME,'|',  GS_OUT-ZFLAG  ,'     | ' ,     GS_OUT-ZAMOUNT CURRENCY 'KRW','       |'.

  WRITE :/ '--------------------------------------------------------------------------'.



  AT LAST."## ### ## ### ### ##.

    WRITE :/ '|' ,'               ','#      #','                     ','|' ,'',  GV_SUM CURRENCY 'KRW'  ,'     ','|'  .

    WRITE :/ '--------------------------------------------------------------------------'.

  ENDAT.



ENDLOOP.