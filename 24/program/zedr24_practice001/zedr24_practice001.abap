
*&---------------------------------------------------------------------*

*& Report ZEDR24_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR24_PRACTICE001.



INCLUDE <LINE>.



"0. Declare Constant

CONSTANTS : C_RATE TYPE I VALUE '100'. "# ### ##"



"1. Declare Var

"1-1. Structure or Table

DATA : GT_GRADE TYPE TABLE OF ZEDT24_004,

       GS_GRADE TYPE ZEDT24_004,

       GS_GRADE_TMP TYPE ZEDT24_004.

"1-2. Var

DATA : GV_TOTAL_SUM TYPE I VALUE 0,

       GV_FLAG TYPE I VALUE 0,

       GV_MONEY TYPE I VALUE 0.



"2. Get Data

SELECT * FROM ZEDT24_004 INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.

SORT GT_GRADE BY ZCODE ZMNAME. "AT ### #### ## ### ##### ### ##



"3. Modify Data

LOOP AT GT_GRADE INTO GS_GRADE.

  GS_GRADE_TMP = GS_GRADE. "AT#### * ### ## ##

  AT FIRST.

    GV_TOTAL_SUM = 0. "## ## ## ###

  ENDAT.



  AT NEW ZCODE.

    GV_FLAG = 1.   "### ### ###, ### ### ###

  ENDAT.



  IF GS_GRADE-ZGRADE <> 'A' AND GV_FLAG = 1. "GV_FLAG = 0##, ## # ## ##

    GV_FLAG = 0.   "### ### ##

  ENDIF.



  AT END OF ZCODE.   "# ### #### ### ### #A

    GS_GRADE = GS_GRADE_TMP. "### ## ### ## ###

    "GS_GRADE-ZFLAG = ''.

    GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM.



    IF GV_FLAG = 1. "### ### # ##

      GS_GRADE-ZFLAG = 'X'.

      IF GS_GRADE-ZSCHOOL = 'A'. "### ##

        GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM * 80 / 100.

      ELSEIF GS_GRADE-ZSCHOOL = 'B'. "#### ## -> Domain# # ### ## ### #### ## else if ##

        GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM * 90 / 100.

      ENDIF.

    ENDIF.



    GV_TOTAL_SUM = GV_TOTAL_SUM + GS_GRADE-ZAMOUNT. "## ## ##

    MODIFY GT_GRADE FROM GS_GRADE TRANSPORTING ZAMOUNT ZFLAG.

    CLEAR GS_GRADE.

  ENDAT.



  AT LAST.

    DELETE GT_GRADE WHERE ZAMOUNT = 0. "## ## ##

  ENDAT.

ENDLOOP.



"4. Printing Data

ULINE AT /1(63).

WRITE :/ SY-VLINE, (10)'## ##', SY-VLINE, (20)'##', SY-VLINE, (10)'####', SY-VLINE, (10)'####', SY-VLINE. "# ## ##"

ULINE AT /1(63).

"# ## ##

LOOP AT GT_GRADE INTO GS_GRADE.

  IF GS_GRADE-ZAMOUNT > 0.

    GV_MONEY = GS_GRADE-ZAMOUNT * C_RATE.

    WRITE :/ sy-vline, (10)GS_GRADE-ZCODE, sy-vline, (20)GS_GRADE-ZMNAME, sy-vline, (10)GS_GRADE-ZFLAG, sy-vline, (10)GV_MONEY, sy-vline.

    ULINE AT /1(63).

    CLEAR GV_MONEY.

  ENDIF.

  CLEAR GS_GRADE.

ENDLOOP.

GV_TOTAL_SUM = GV_TOTAL_SUM * C_RATE.

WRITE :/ SY-VLINE.

WRITE AT 20(29)'#   #'.

WRITE : SY-VLINE, (10)GV_TOTAL_SUM, sy-vline.

ULINE AT /1(63).