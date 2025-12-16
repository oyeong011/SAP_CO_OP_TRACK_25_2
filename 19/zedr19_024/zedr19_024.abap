
*&---------------------------------------------------------------------*

*& Report ZEDR19_024

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR19_024.



"### ### ## (#### ## ###)

DATA GT_GRADE TYPE STANDARD TABLE OF ZEDT19_004 WITH DEFAULT KEY.



"Work Area ##

DATA GS_GRADE TYPE ZEDT19_004.



"### ###(GT_GRADE)# #### # ## ##

SELECT * FROM ZEDT19_004 INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.



"##### ## #### ## ## ####(?)

DATA : lv_all_a TYPE abap_bool, "## ## # ## A ## ### (####)

       lv_base_amt TYPE ZEDT19_004-ZSUM, "### ### ### (###### ##### ##)

       lv_pay_amt TYPE ZEDT19_004-ZAMOUNT, "## ###(## ##)

       lv_rep_idx TYPE SY-TABIX, "###(=## # #) ### ##

       lv_zflag TYPE C LENGTH 4, "####('X' ## ##)

       lv_total TYPE ZEDT19_004-ZAMOUNT. "## ##



"## # ##

SORT GT_GRADE BY ZCODE ZEXAM.

"## ## (####, ##### ###)

DELETE ADJACENT DUPLICATES FROM GT_GRADE COMPARING ZCODE ZEXAM.



LOOP AT GT_GRADE INTO GS_GRADE.



  AT NEW ZCODE. "ZCODE## ### ###

    lv_zflag = ' '. "##### ### ### ##

    lv_all_a = abap_true. "###

    lv_base_amt = GS_GRADE-ZSUM.

    lv_rep_idx = SY-TABIX. "### = # #

    lv_all_a = abap_false.

    "SY-TABIX = ## ### ## ## ## ## ### ##

    lv_pay_amt = 0.

  ENDAT.



  "# ##### A# ### false.

  IF GS_GRADE-ZGRADE <> 'A'.

    lv_all_a = abap_false.

  ENDIF.



  lv_base_amt = GS_GRADE-ZSUM. "### ### ## ##



  IF lv_all_a = abap_true.

      lv_zflag = 'X'.

      "## ### ##, ## ## ### GS_GRADE-ZSCHOOL# ## # #

      IF GS_GRADE-ZSCHOOL = 'A'.

        lv_pay_amt = lv_base_amt * 80 / 100. "## 20% ##

      ELSE.

        lv_pay_amt = lv_base_amt * 90 / 100. "#### 10% ##

      ENDIF.

    ELSE.

      lv_pay_amt = lv_base_amt. "## ## ##

    ENDIF.



  AT END OF ZCODE.

    IF lv_all_a = abap_true.

      lv_zflag = 'X'.

      "## ### ##, ## ## ### GS_GRADE-ZSCHOOL# ## # #

      IF GS_GRADE-ZSCHOOL = 'A'.

        lv_pay_amt = lv_base_amt * 80 / 100. "## 20% ##

      ELSE.

        lv_pay_amt = lv_base_amt * 90 / 100. "#### 10% ##

      ENDIF.

    ELSE.

      lv_pay_amt = lv_base_amt. "## ## ##

    ENDIF.



    "##### GT_GRADE## # ### ### ## ## lv_rep_idx# ##

    "lv_rep_idx : AT NEW ZCODE.## ### #### ###

    READ TABLE GT_GRADE INTO DATA(ls_rep) INDEX lv_rep_idx.

    IF SY-SUBRC = 0."### ### ### ##

      ls_rep-ZFLAG = lv_zflag.

      ls_rep-ZAMOUNT = lv_pay_amt. "###

      ls_rep-ZSUM = lv_base_amt.

      "##### ####(?)# # #### #

      MODIFY GT_GRADE FROM ls_rep INDEX lv_rep_idx.

      "## ### ##### # ## GT_GRADE# ###

    ENDIF.



    lv_total = lv_total + lv_pay_amt.



  ENDAT.



ENDLOOP.



"### ### GT_GRADE## ZCODE# #### ## ##### #

DELETE ADJACENT DUPLICATES FROM GT_GRADE COMPARING ZCODE.



"### ##(ZCODE## ######)

SORT GT_GRADE BY ZCODE.



LOOP AT GT_GRADE INTO GS_GRADE.



  AT FIRST.

    ULINE.

    WRITE :/ '####', 15 '##', 35 '####', 50 '####'.

    ULINE.

    ULINE.

  ENDAT.



  WRITE :/ GS_GRADE-ZCODE UNDER '####',

         GS_GRADE-ZMNAME UNDER '##',

         GS_GRADE-ZFlAG UNDER '####',

         GS_GRADE-ZAMOUNT CURRENCY 'KRW' UNDER '####'.

       ULINE.



  AT LAST.

  ULINE.

  WRITE :/ '##', 50 lv_total CURRENCY 'KRW'.

  ULINE.

  ENDAT.

ENDLOOP.