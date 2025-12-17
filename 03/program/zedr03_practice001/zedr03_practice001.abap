
*&---------------------------------------------------------------------*

*& Report ZEDR03_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_PRACTICE001.



"####"

DATA : GS_GRADE TYPE ZEDT03_004.

DATA : GT_GRADE LIKE TABLE OF ZEDT03_004. "##### ## ### ### ##"



DELETE ADJACENT DUPLICATES FROM GT_GRADE. "## ### ##"



SELECT * FROM ZEDT03_004

INTO CORRESPONDING FIELDS OF TABLE GT_GRADE. "### #### ### ###"



DATA : GV_A TYPE C LENGTH 1. "#### A### #### ####"

DATA : GV_START TYPE I. "# ## ## ### # ### ## ####"

DATA : GV_KAMOUNT TYPE I. "#### ## # ### ## ####"

DATA : GV_TOTAL TYPE I. "# ### ## ### ####"

DATA : GV_PREGRADE TYPE C LENGTH 1. "## ## ### #### ## ####"

DATA : GV_ZAMOUNT TYPE I.

DATA : GV_ZFLAG.

DATA : GV_END.



SORT GT_GRADE BY ZCODE ZGRADE. "### #### ####"



"### ### ## ##"

LOOP AT GT_GRADE INTO GS_GRADE. "### ### ### ##"

  "# #### # ## ##"

  AT NEW ZCODE.

    CLEAR : GV_END.

    GV_START = SY-TABIX.   "# ##### ## ### ## ##"

    GV_PREGRADE = 'A'.     "# ##### #### ## ### ## ### ### A# #### ### ##### ##"

  ENDAT.



  "#### A## ##"

  IF ( GS_GRADE-ZGRADE = 'A' ) AND ( GV_PREGRADE = 'A' ). "## ## ### ## ### ## A##"

      GV_A = 'O'.          "TRUE# ##"

  ELSE.

    CLEAR : GV_A.          "## ###"

  ENDIF.



  GV_PREGRADE = GS_GRADE-ZGRADE. "## ### ## ## ## ##"

  CLEAR : GS_GRADE.              "## ###"



  "# #### # A ### ##"

  AT END OF ZCODE.      "# ##### ####"

    IF GV_A = 'O'.      "#### ### ### A## ##### ### ## A"

      LOOP AT GT_GRADE INTO GS_GRADE FROM GV_START TO SY-TABIX. "# ##### #### ### ### ###"

          IF GS_GRADE-ZSCHOOL = 'A'. "#### # ####"

            GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM * 80 / 100. "20## ### ##"

          ELSE.                      "##### # ####"

            GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM * 90 / 100. "10## ### ##"

          ENDIF.

          GS_GRADE-ZFLAG = 'X'. "##### ##"

       ENDLOOP.

    ELSE. "#### # A# ###"

      LOOP AT GT_GRADE INTO GS_GRADE FROM GV_START TO SY-TABIX.

          GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM. "ZAMOUNT# ### ZSUM# ### ##"

      ENDLOOP.

    ENDIF.

    GV_TOTAL = GV_TOTAL + GS_GRADE-ZAMOUNT. "GV_TOTAL ### # #### ## ### ##"

    CLEAR : GV_A.

    GV_ZAMOUNT = GS_GRADE-ZAMOUNT.

    GV_ZFLAG = GS_GRADE-ZFLAG.

    GV_END = 1.

  ENDAT.



  "MODIFY"

  IF GV_END = 1.

      LOOP AT GT_GRADE INTO GS_GRADE FROM GV_START TO SY-TABIX.

          GS_GRADE-ZAMOUNT = GV_ZAMOUNT.

          GS_GRADE-ZFLAG = GV_ZFLAG.

      ENDLOOP.

      MODIFY GT_GRADE FROM GS_GRADE TRANSPORTING ZAMOUNT ZFLAG WHERE ZCODE = GS_GRADE-ZCODE. "ZAMOUNT# ZFLAG ### ### ##" "MODIFY# LOOP## ###!"

      CLEAR : GV_END.

  ENDIF.

ENDLOOP.



"## # ##"

DELETE ADJACENT DUPLICATES FROM GT_GRADE COMPARING ZCODE. "ZCODE# #### ## ##"

GV_TOTAL = GV_TOTAL * 100. "## # ### ## 100# ##"



"##"

LOOP AT GT_GRADE INTO GS_GRADE.

  AT FIRST.

    WRITE :/ '--------------------------------------------------------------------------'.

    WRITE :/ '|   ####   |          ###          |####|       ####      |'.

    WRITE :/ '--------------------------------------------------------------------------'.

  ENDAT.



  GV_KAMOUNT = GS_GRADE-ZAMOUNT * 100. " ## # ### ## 100# ##"



  WRITE :/'|  ', GS_GRADE-ZCODE, '|    ',GS_GRADE-ZMNAME,'|',  GS_GRADE-ZFLAG  ,'     | ' ,GV_KAMOUNT,'       |'.

  WRITE :/ '--------------------------------------------------------------------------'.



  AT LAST.

    WRITE :/ '|' ,'               ','#      #','                     ','|'   ,'  ',    GV_TOTAL   ,'    ','|'  .

    WRITE :/ '--------------------------------------------------------------------------'.

  ENDAT.



ENDLOOP.





"## 1 : ### ## ## #### ## ## ###, ## ## # ## # #### ### ### ###"

"## 2 : ### #### ### ### ###"

"## 3 : ### ## # CLEAR# ## ## ' ' ### ## ## ##"