
*&---------------------------------------------------------------------*

*& Report ZEDR09_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_PRACTICE001.






*===============================================================*

* ###/## ###

*===============================================================*



* ## ## ### ### # ###### ##




DATA : GS_GRADE TYPE ZEDT00_004.

DATA : GT_GRADE TYPE TABLE OF ZEDT00_004.






* ## ##




DATA : GV_IS_ZFLAG TYPE ABAP_BOOL VALUE ABAP_TRUE. "### ##

DATA : GV_IS_END TYPE ABAP_BOOL VALUE ABAP_FALSE. "## #### ## ##

DATA : GV_SUM_AMOUNT TYPE I. "#### ##

DATA : GV_TO_INTERGER TYPE I. "##### ##






*===============================================================*

* SELECT### ZEDT00_004 ##### # ####

*===============================================================*






SELECT * FROM ZEDT00_004

INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.






*===============================================================*

* MODIFY# AT##

* ### ####'##' ZEXAM# ## ## ### A# ###,

*   - ####(ZFLAG)# 'X'### ##,

*   - ##### ###### ###### (##### 20##, ##### 10##)

*===============================================================*






CLEAR : GS_GRADE.

SORT GT_GRADE BY ZCODE ZEXAM. "AT### SORT ##



LOOP AT GT_GRADE INTO GS_GRADE.



  AT NEW ZCODE. "AT NEW ## - ### #### ### ### ### ## ###

    GV_IS_ZFLAG = ABAP_TRUE. "#####

    GV_IS_END = ABAP_FALSE. "##### ### ###

  ENDAT.



  IF GS_GRADE-ZGRADE NE 'A'. "##### #### A# ####, GV_IS_ZFLAG = FALSE

     GV_IS_ZFLAG = ABAP_FALSE.

  ENDIF.



  AT END OF ZCODE. "AT END OF ## - ## #### ## ##

    GV_IS_END = ABAP_TRUE.

  ENDAT.



  "MODIFY#

  IF GV_IS_END = ABAP_TRUE."## ##### ### #, ####



    GS_GRADE-ZSUM = GS_GRADE-ZSUM * 100. "### ### ##

    IF GV_IS_ZFLAG = ABAP_TRUE. "##### 'X' ##

      GS_GRADE-ZFLAG = 'X'.



      "##/#### ## #### ##

      IF GS_GRADE-ZSCHOOL = 'A'. "##### 20## ##

        GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM * '0.8'.

      ELSE.                      "###### 10## ##

        GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM * '0.9'.

      ENDIF.



    ELSE. "#### ### #### ## ### (## x)

      GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM.



    ENDIF.



    MODIFY GT_GRADE FROM GS_GRADE INDEX SY-TABIX TRANSPORTING ZFLAG ZAMOUNT.



  ENDIF.



  CLEAR : GS_GRADE.

ENDLOOP.








* ###### ### ### ##




SORT GT_GRADE BY ZCODE ZEXAM DESCENDING. "## ### ### ## ## update###, ### ##

DELETE ADJACENT DUPLICATES FROM GT_GRADE COMPARING ZCODE. "### ## # ##








*===============================================================*

* WRITE### ## ##

*===============================================================*




CLEAR : GS_GRADE.

LOOP AT GT_GRADE INTO GS_GRADE.

  GV_SUM_AMOUNT = GV_SUM_AMOUNT + GS_GRADE-ZAMOUNT.



  "### ## ###

  AT FIRST.

    WRITE : / sy-uline(61)."## #####(sy-uline)# #### ## ##

    " sy-vline# ###(|)# #### #####, ()## # ## #### ##

    WRITE: / sy-vline, (10) ' #### ' CENTERED, sy-vline , (13) '  ###  ' CENTERED, sy-vline, (10) '  ####  ' CENTERED, sy-vline, (15) '  ####  ' CENTERED, sy-vline.

    WRITE : / sy-uline(61).

  ENDAT.



  "### ## ###

  GV_TO_INTERGER = GS_GRADE-ZAMOUNT.

  WRITE : / sy-vline, (10) GS_GRADE-ZCODE CENTERED, sy-vline, (13) GS_GRADE-ZMNAME CENTERED, sy-vline, (10) GS_GRADE-ZFLAG CENTERED, sy-vline, (15) GV_TO_INTERGER CENTERED, sy-vline.

  WRITE : / sy-uline(61).



  "### ## ###

  AT LAST.

    WRITE : / sy-vline, (39) ' ## ' CENTERED, sy-vline,(15) GV_SUM_AMOUNT CENTERED, sy-vline.

    WRITE : / sy-uline(61).

  ENDAT.

ENDLOOP.