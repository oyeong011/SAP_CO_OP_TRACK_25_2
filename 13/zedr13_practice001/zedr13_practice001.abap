
*&---------------------------------------------------------------------*

*& Report ZEDR13_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR13_PRACTICE001.



DATA : GS_GRADE TYPE ZEDT13_004, "Word Area ##"

       GT_GRADE TYPE TABLE OF ZEDT13_004. "##### ## ITAB ##"




*### ####




SELECT * FROM ZEDT13_004

INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.






*## ##




SORT GT_GRADE.

DATA GV_PASS TYPE C VALUE 'X'. "### ##"

DATA GV_LAST TYPE C. "GV_LAST ##."






*## ### ##




DATA GV_SUM TYPE P VALUE 0.



LOOP AT GT_GRADE INTO GS_GRADE.

  AT FIRST.

    WRITE : SY-ULINE(74).

    WRITE :/ SY-VLINE, 5 TEXT-000, "####"

             16 SY-VLINE, 27 TEXT-001, "###"

             43 SY-VLINE, 44 TEXT-002, "####"

             52 SY-VLINE, 60 TEXT-003, "####"

             74 SY-VLINE.

    WRITE :/ SY-ULINE(74).

  ENDAT.

  AT NEW ZCODE.

    GV_PASS = 'X'. "### ## ##, ## X# ## ### A# ##"

  ENDAT.

  IF GS_GRADE-ZGRADE <> 'A'. "A# #### ### #"

    CLEAR : GV_PASS.

  ENDIF.

  AT END OF ZCODE.

    GV_LAST = 'X'. "### #### ## ### ### ### #####"

  ENDAT.

  GS_GRADE-ZFLAG = GV_PASS. "###### GV_PASS# X## ### ### ##"

  IF GV_LAST = 'X'. "### ### ##### ##"

    GS_GRADE-ZSUM = GS_GRADE-ZSUM * 100. "## ###"

    IF GS_GRADE-ZFLAG = 'X' AND GS_GRADE-ZSCHOOL = 'A'. "IF### #### #####"

      GS_GRADE-ZSUM = GS_GRADE-ZSUM * '0.8'.  "A ##### 20##"

    ELSEIF GS_GRADE-ZFLAG = 'X' AND GS_GRADE-ZSCHOOL = 'B'.

      GS_GRADE-ZSUM = GS_GRADE-ZSUM * '0.9'.  "B #### 10##"

    ENDIF.

    GV_SUM = GV_SUM + GS_GRADE-ZSUM.

    WRITE :/ SY-VLINE, 5 GS_GRADE-ZCODE,

           16 SY-VLINE, 22 GS_GRADE-ZMNAME,

           43 SY-VLINE, GS_GRADE-ZFLAG,

           51 GS_GRADE-ZSUM DECIMALS 0, 52 SY-VLINE,

           74 SY-VLINE.

    WRITE :/ SY-ULINE(74).

  ENDIF.

  MODIFY GT_GRADE FROM GS_GRADE INDEX SY-TABIX.

  AT LAST.

    WRITE :/ SY-VLINE, 19 TEXT-004, "#      #"

            52 GV_SUM, 52 SY-VLINE,

            74 SY-VLINE.

    WRITE :/ SY-ULINE(74).

  ENDAT.




*#### ## ### ## ###




  CLEAR : GV_LAST.

ENDLOOP.



SORT GT_GRADE BY ZCODE ZEXAM DESCENDING.

DELETE ADJACENT DUPLICATES FROM GT_GRADE COMPARING ZCODE. "## ### ##"