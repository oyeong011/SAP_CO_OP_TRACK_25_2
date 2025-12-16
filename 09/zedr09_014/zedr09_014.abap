
*&---------------------------------------------------------------------*

*& Report ZEDR09_014

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_014.






* 1. ####### ### ##




DATA : GS_GRADE TYPE ZEDT00_004.






* 2. ####### ###### ##




DATA : GT_GRADE TYPE TABLE OF ZEDT00_004.






* 3. ### ##### ######, ZSUM ## ## ## ##




DATA : GV_IS_ZFLAG TYPE ABAP_BOOL VALUE ABAP_TRUE. "### #, True(#####)# # ###

DATA : GV_TEMP_ZSUM TYPE I.

DATA : GV_TEMP_ZSCHOOL TYPE C LENGTH 1.

DATA : GV_SUM_AMOUNT TYPE I VALUE 0. "#####






* 4. DATA ####




SELECT * FROM ZEDT00_004

INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.






* 5. # ## ####'##' ZEXAM# ## ## ### A# ###,

*  - ####(ZFLAG)# 'X'### ##

*  - ##### ###### ######. (##### 20##, ##### 10##)






CLEAR : GS_GRADE.



SORT GT_GRADE BY ZCODE. "AT### sort##



LOOP AT GT_GRADE INTO GS_GRADE.

  "AT #### ## ## ## ## ## ##

  GV_TEMP_ZSUM = GS_GRADE-ZSUM.

  GV_TEMP_ZSCHOOL = GS_GRADE-ZSCHOOL.



  AT NEW ZCODE. "AT NEW ## - ## ### #### ## ### ### ### true# ###

    GV_IS_ZFLAG = ABAP_TRUE.

  ENDAT.



  IF GS_GRADE-ZGRADE NE 'A'. "##### #### A# ####, LV_IS_ZFLAG = FALSE

    GV_IS_ZFLAG = ABAP_FALSE.

  ENDIF.



  AT END OF ZCODE. "AT END OF ## - ## #### ###, ####(ZFLAG)# #### ### ##



    IF GV_IS_ZFLAG = ABAP_TRUE. "# ### A# ####(ZFLAG)# 'X'

      GS_GRADE-ZFLAG = 'X'.



      "##/#### ## ### ##

      GS_GRADE-ZSUM = GV_TEMP_ZSUM * 100.

      IF GV_TEMP_ZSCHOOL = 'A'.

        GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM * '0.8'. "##### 20## ##

      ELSE.

        GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM * '0.9'. "###### 10## ##

      ENDIF.



      "###### ## ### ###### ###, TRANSPORTING ##

       MODIFY GT_GRADE FROM GS_GRADE TRANSPORTING ZFLAG ZAMOUNT

         WHERE ZCODE = GS_GRADE-ZCODE.



    ELSE. "#### ## ##

      GS_GRADE-ZSUM = GV_TEMP_ZSUM * 100.

      GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM. "## ##



      MODIFY GT_GRADE FROM GS_GRADE TRANSPORTING ZAMOUNT

        WHERE ZCODE = GS_GRADE-ZCODE.



    ENDIF.



  ENDAT.



  CLEAR : GS_GRADE.

ENDLOOP.






* 6.###### ###, ## ##




SORT GT_GRADE BY ZCODE.

DELETE ADJACENT DUPLICATES FROM GT_GRADE COMPARING ZCODE.






* 7. #### ### ####.




LOOP AT GT_GRADE INTO GS_GRADE.

  " ## #### AMOUNT ### ###

  GV_SUM_AMOUNT = GV_SUM_AMOUNT + GS_GRADE-ZAMOUNT.



  AT FIRST. "AT FIRST## - ### ## ##

    WRITE: / '-------------------------------------------------------------'.

    WRITE: / '| ## ## |      ###       | #### |    ####    |'.

    WRITE: / '-------------------------------------------------------------'.

  ENDAT.



  " ### ## ##

  WRITE : / '|', GS_GRADE-ZCODE , '|', GS_GRADE-ZMNAME, '|', GS_GRADE-ZFLAG, '|', GS_GRADE-ZAMOUNT, '|'.

  WRITE: / '-------------------------------------------------------------'.





  AT LAST. "AT LAST ## - ### ## ##

    WRITE: / '-------------------------------------------------------------'.

    WRITE: / '| ##                               |', GV_SUM_AMOUNT , '|'.

    WRITE: / '-------------------------------------------------------------'.

  ENDAT.



ENDLOOP.