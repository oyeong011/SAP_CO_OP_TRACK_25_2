
*&---------------------------------------------------------------------*

*& Report ZEDR21_PRACTICE001

*&---------------------------------------------------------------------*




REPORT ZEDR21_PRACTICE001.                               " ### #### ##



"1. DATA ##

DATA:  GS_GRADE LIKE ZEDT21_004.                                  " #####(# ## ##) ##

DATA:  GT_GRADE LIKE TABLE OF ZEDT21_004.                          " DDIC ## ZEDT21_004# ## ### ##







"## ## ##

DATA: ZCODE       LIKE ZEDT21_004-ZCODE21.                " ## ### #### ##

DATA: GRADE       TYPE C LENGTH 10.                       " ## # ## ##('A' ## ## ###)

DATA: NEW         TYPE C LENGTH 10.                       " ## # ### ## ## ###('X'# # ##)

DATA: END         TYPE C LENGTH 10.                       " ## ### ### ## ###('X'# ###)

DATA: FLAG        TYPE C LENGTH 10.                       " ## # ## ### 'A'## ## ###

DATA: ZPAY_AMT TYPE I.

DATA: NO_SOSU TYPE I.

"## ## ##

DATA: TOTAL_PAY TYPE I.                                   " ##(## ##) ### ##



"2. GET DATA

SELECT * FROM ZEDT21_004                                  " DB ##### ## # ##

  INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.            " ### #### ## #### ##



"SORT

SORT GT_GRADE BY ZCODE21 ZPERNR21 ZEXAM21.                " AT NEW/AT END #### ## ##(###=ZCODE21)



CLEAR: GS_GRADE.                                          " ##### ###(### ### ##)

CLEAR: ZCODE, GRADE, END.                                 " ## ## ## ## ###



"3. MODIFY DATA

LOOP AT GT_GRADE INTO GS_GRADE.                           " ## #### # ## GS_GRADE# ###



  " ## ## ## ##

  AT NEW ZCODE21.

    ZCODE = GS_GRADE-ZCODE21.

    NEW = 'X'.

    CLEAR FLAG.                                           " ## ## # FLAG ###

  ENDAT.



  "# #### ## A #### ##

  IF NEW = 'X'.

    IF GS_GRADE-ZGRADE21 = 'A'.

      " ## ### ## ### 'A'# ##

      GRADE = 'A'.

      FLAG  = 'X'.                                        " # ### A# FLAG ##

    ENDIF.

  ELSE.

    "# ### ##: ## ### ## ## ### A## ## ### A## ##

    IF GRADE = 'A'.

      IF GS_GRADE-ZGRADE21 = 'A'.

        FLAG = 'X'.

      " #### 'A'# ### --> #### ### ##

      ELSE.

        CLEAR: GRADE, FLAG.

      ENDIF.

    ENDIF.

  ENDIF.



  " ## ### ### ###### ##, ### # ## END = 'X'

  AT END OF ZCODE21.

    END = 'X'.

  ENDAT.

  "## ### ### ##### ##

  IF END = 'X'.

    "##### 100# ### ##### 100 ###

    ZPAY_AMT = GS_GRADE-ZSUM21 * 100.



    "# ## ## # FLAG# 'X'## ## ### A ### ####

    IF FLAG = 'X'.

      GS_GRADE-ZFLAG21 = 'X'.

      "#### #### ## 20% ##

      IF GS_GRADE-ZSCHOOL21 = 'A'.

        ZPAY_AMT = ZPAY_AMT * 80 / 100.

       " #### ### ####### 10%# ##.

      ELSE.

        ZPAY_AMT = ZPAY_AMT * 90 / 100.

      ENDIF.

    ENDIF.



    "## ##

    TOTAL_PAY = TOTAL_PAY + ZPAY_AMT.            " ## ## ### ## ## ## ##

    GS_GRADE-ZAMOUNT21 = ZPAY_AMT.               " ### ## ## ##



    "### ### ##

    MODIFY GT_GRADE FROM GS_GRADE INDEX SY-TABIX.



    "###

    CLEAR: GS_GRADE, FLAG, GRADE.

  ENDIF.

  "## ## ### ## ###

  CLEAR: NEW, END.



ENDLOOP.



"## ## # ##

SORT GT_GRADE DESCENDING BY ZCODE21 ZAMOUNT21.

"##(ZCODE21 ##) ## # # ### # ## ##(=## ##)

DELETE ADJACENT DUPLICATES FROM GT_GRADE COMPARING ZCODE21.

SORT GT_GRADE BY ZCODE21.



"4. WRITE DATA

DATA: NO_SOSU_AMOUNT TYPE I.    " ### ## ## ## ###

DATA: NO_SOSU_TOTAL  TYPE I.    " ## ## ###



LOOP AT GT_GRADE INTO GS_GRADE.



  AT FIRST.

    WRITE: / '--------------------------------------------------------------------------'.

    WRITE: / '|   ####   |          ###          |####|       ####      |'.

    WRITE: / '--------------------------------------------------------------------------'.

  ENDAT.



  " ### ### ## ## ### ## # ##

  NO_SOSU_AMOUNT = GS_GRADE-ZAMOUNT21.



  WRITE: / '|  ', GS_GRADE-ZCODE21,

         '|    ', GS_GRADE-ZMNAME21,

         '|',     GS_GRADE-ZFLAG21, '     |  ',

                  NO_SOSU_AMOUNT, '      |'.

  WRITE: / '--------------------------------------------------------------------------'.



  AT LAST.

    NO_SOSU_TOTAL = TOTAL_PAY.

    WRITE: / '|', '               ', '#      #', '                     ', '|',

             '  ', NO_SOSU_TOTAL, '    ', '|'.

    WRITE: / '--------------------------------------------------------------------------'.

  ENDAT.



ENDLOOP.