
*&---------------------------------------------------------------------*

*& Report ZEDR11_PRACTICE001

*&---------------------------------------------------------------------*




REPORT ZEDR11_PRACTICE001.



"=============================================================

" 1. DATA ##

"=============================================================

DATA: GS_GRADE LIKE ZEDT11_004,            " ## ### # # (ZCODE, ZFLAG, ZSUM, ZAMOUNT #)

      GT_GRADE LIKE TABLE OF ZEDT11_004.   " ## ### (#### ##)



" ## ## (A~D)

DATA: GV_A LIKE ZEDT11_004-ZCODE,          " ####

      GV_B,                                 " ## ## ###

      GV_C,                                 " ## ## ###

      GV_D,                                 " ### A ## ###

      GV_SUM  TYPE i,                       " ## ##(##)

      GV_SUM2 TYPE i.                       " ### ####(##)



" ### ## ##(### ###)

DATA: LV_AMOUNT_INT TYPE i.



"=============================================================

" 2. GET DATA

"=============================================================

SELECT * FROM ZEDT11_004

  INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.



SORT GT_GRADE BY ZCODE ZPERNR ZEXAM.



CLEAR: GS_GRADE, GV_A, GV_B, GV_C, GV_D, GV_SUM, GV_SUM2.



"=============================================================

" 3. MODIFY DATA

"   - ZCODE #### # ## 'A' ## ## # ZFLAG

"   - ZFLAG='X'## ##(A) 20%, ###(B) 10% ##

"   - ## ### ZAMOUNT# ##, ##(GV_SUM) ##

"=============================================================

LOOP AT GT_GRADE INTO GS_GRADE.



  AT NEW ZCODE.

    GV_A = GS_GRADE-ZCODE.                 " ## #### ##

    GV_B = 'X'.                            " ## ##

    GV_D = 'X'.                            " ## ### A## ##

  ENDAT.



  " ### A ##

  IF GV_B <> 'X'.

    IF GS_GRADE-ZGRADE <> 'A'.

      CLEAR GV_D.                          " #### A# ### ##

    ENDIF.

  ELSE.

    IF GS_GRADE-ZGRADE <> 'A'.

      CLEAR GV_D.

    ENDIF.

  ENDIF.



  AT END OF ZCODE.

    GV_C = 'X'.                            " ## ##

  ENDAT.



  IF GV_C = 'X'.



    " ## ####(####100 # 100.00 # 10000) - ### ##

    GV_SUM2 = CONV i( GS_GRADE-ZSUM * 100 ).



    " ####(### A)## ## ## - ## #### ##

    IF GV_D = 'X'.

      GS_GRADE-ZFLAG = 'X'.

      IF GS_GRADE-ZSCHOOL = 'A'.          " ##(A) # 20% ##

        GV_SUM2 = GV_SUM2 * 80 / 100.

      ELSEIF GS_GRADE-ZSCHOOL = 'B'.      " ###(B) # 10% ##

        GV_SUM2 = GV_SUM2 * 90 / 100.

      ENDIF.

    ELSE.

      CLEAR GS_GRADE-ZFLAG.               " ## ##

    ENDIF.



    " ## ## ##(### ##)

    GS_GRADE-ZAMOUNT = GV_SUM2.



    " ## ##(## ##)

    GV_SUM = GV_SUM + GV_SUM2.



    " ### ### ##

    MODIFY GT_GRADE FROM GS_GRADE INDEX SY-TABIX.



    " ## ### ###

    CLEAR: GS_GRADE, GV_D, GV_B, GV_C, GV_SUM2.

  ELSE.

    CLEAR: GV_B, GV_C.

  ENDIF.



ENDLOOP.



"=============================================================

" 4. ## ## # ## (##### 1#)

"=============================================================

SORT GT_GRADE DESCENDING BY ZCODE ZAMOUNT.

DELETE ADJACENT DUPLICATES FROM GT_GRADE COMPARING ZCODE.

SORT GT_GRADE BY ZCODE.



"=============================================================

" 5. WRITE DATA (###/AT FIRST/AT LAST/##)



"=============================================================

LOOP AT GT_GRADE INTO GS_GRADE.



  AT FIRST.

    WRITE: / '--------------------------------------------------------------------------'.

    WRITE: / '|   ####   |          ###          |####|       ####      |'.

    WRITE: / '--------------------------------------------------------------------------'.

  ENDAT.



  " ### ### ## ## ### ## # ##

  LV_AMOUNT_INT = GS_GRADE-ZAMOUNT.



  WRITE: / '|  ', GS_GRADE-ZCODE,

         '|    ', GS_GRADE-ZMNAME,

         '|',     GS_GRADE-ZFLAG, '     |  ',

                  LV_AMOUNT_INT, '      |'.

  WRITE: / '--------------------------------------------------------------------------'.



  AT LAST.

    WRITE: / '|', '               ', '#      #', '                     ', '|',

            '  ', GV_SUM, '    ', '|'.

    WRITE: / '--------------------------------------------------------------------------'.

  ENDAT.



ENDLOOP.