
*&---------------------------------------------------------------------*

*& Report ZEDR08_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR08_PRACTICE001.



" #### ## ### ##

DATA : BEGIN OF GS_GRADE,

  MANDT LIKE ZEDT08_004-MANDT,

  ZCODE LIKE ZEDT08_004-ZCODE,

  ZPERNR LIKE ZEDT08_004-ZPERNR,

  ZSCHOOL LIKE ZEDT08_004-ZSCHOOL,

  ZSEM LIKE ZEDT08_004-ZSEM,

  ZEXAM LIKE ZEDT08_004-ZEXAM,

  ZMAJOR LIKE ZEDT08_004-ZMAJOR,

  ZMNAME LIKE ZEDT08_004-ZMNAME,

  ZSUM LIKE ZEDT08_004-ZSUM,

  ZWAERS LIKE ZEDT08_004-ZWAERS,

  ZGRADE LIKE ZEDT08_004-ZGRADE,

  ZFLAG LIKE ZEDT08_004-ZFLAG,

  ZAMOUNT LIKE ZEDT08_004-ZAMOUNT,

END OF GS_GRADE.



" #### ## ###### ##

DATA : GT_GRADE LIKE TABLE OF GS_GRADE.



" GT_GRADE #### #### #### ##

SELECT * FROM ZEDT00_004 INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.



" ZCODE ZPERNR #### ##

SORT GT_GRADE BY ZCODE ZPERNR.



" ## ### ###

DATA : GV_GRADE TYPE I VALUE 1.



" ## ### #### ## ## ##

DATA : GV_ZAMOUNT TYPE P.

DATA : GV_ZSCHOOL TYPE C.



" ## ### ## ##

DATA : GV_GRADE-ZAMOUNT TYPE P VALUE '0'.

" # ### ## ##

DATA : GV_SUM-ZAMOUNT TYPE P VALUE '0'.

" ### ## ### ## ##

DATA : GV_GRADE-ZMNAME TYPE C LENGTH 20.



" ## LOOP

LOOP AT GT_GRADE INTO GS_GRADE.

  AT FIRST.

    WRITE :/ ' TITLE : LOOP## (AT##)'.

    WRITE :/ ' --------------------------------------------------------------------------- '.

    WRITE :/ ' |   ####   |         ###         | #### |             #### |'.

    WRITE :/ ' --------------------------------------------------------------------------- '.

  ENDAT.



  GV_GRADE-ZMNAME = GS_GRADE-ZMNAME.



  " ## ## ##### ##### ## ##

  GV_ZAMOUNT = GS_GRADE-ZSUM.

  GV_ZSCHOOL = GS_GRADE-ZSCHOOL.



  " ## ### ## ### ## ### ###

  AT NEW ZPERNR.

    GV_GRADE = 1.

  ENDAT.



  " ### A# ### ### ##

  IF GV_GRADE = '1'.

    IF GS_GRADE-ZGRADE <> 'A'.

      GV_GRADE = '2'.

    ENDIF.

  ENDIF.



  " ## ### #

  AT END OF ZPERNR.

    " ### ## 1### ## ##

    IF GV_GRADE = '1'.

      GS_GRADE-ZFLAG = 'X'.



      " ### ## ### ##

      IF GV_ZSCHOOL = 'A'.

        GS_GRADE-ZAMOUNT = GV_ZAMOUNT * '0.8'.

      ELSEIF GV_ZSCHOOL = 'B'.

        GS_GRADE-ZAMOUNT = GV_ZAMOUNT * '0.9'.

      ELSE.

        GS_GRADE-ZAMOUNT = GV_ZAMOUNT.

      ENDIF.

    ELSE.

      " ##### ### ###

      GS_GRADE-ZFLAG = ' '.

      GS_GRADE-ZAMOUNT = GV_ZAMOUNT.

    ENDIF.



    GV_GRADE-ZAMOUNT = GS_GRADE-ZAMOUNT * 100.



    " # ### ## ## ##

    GV_SUM-ZAMOUNT = GV_SUM-ZAMOUNT + GV_GRADE-ZAMOUNT.



    " INTERNAL TABLE# ### # ##

    MODIFY GT_GRADE FROM GS_GRADE TRANSPORTING ZFLAG ZAMOUNT WHERE ZCODE = GS_GRADE-ZCODE.



    WRITE :/ ' | ', GS_GRADE-ZCODE, ' | ', GV_GRADE-ZMNAME, ' |    ', GS_GRADE-ZFLAG, '   |   ', GV_GRADE-ZAMOUNT, ' | '.

    WRITE :/ ' --------------------------------------------------------------------------- '.

  ENDAT.



  AT LAST.

    WRITE :/ ' |                     #  #                       |   ', GV_SUM-ZAMOUNT, ' | '.

    WRITE :/ ' --------------------------------------------------------------------------- '.

  ENDAT.

ENDLOOP.