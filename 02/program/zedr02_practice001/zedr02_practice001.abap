
*&---------------------------------------------------------------------*

*& Report ZEDR02_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR02_PRACTICE001.



"###### ### ### ##

DATA: GT_GRADE TYPE TABLE OF ZEDT00_004.



"### ####

SELECT * FROM ZEDT00_004

  INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.



"### ##

DATA: GS_GRADE TYPE ZEDT00_004.



CLEAR: GS_GRADE.



DATA : GV_ALLA TYPE C LENGTH 1. "## A## Y, #### A# ### N

DATA : GV_SUM TYPE ZEDT00_004-ZSUM. "ZSUM ## ###

DATA : GV_SCHOOL TYPE ZEDT00_004-ZSCHOOL. "ZSCHOOL ## ###

DATA : GV_TOTAL TYPE ZEDT00_004-ZSUM. "##



CONSTANTS: C_RATE TYPE I VALUE '100'. "### ### ## ##



GV_TOTAL = 0. "## ###



"### #### LOOP

LOOP AT GT_GRADE INTO GS_GRADE.

  AT NEW ZCODE. "### ZCODE# #### GV_ALLA# Y# ###

    GV_ALLA = 'Y'.

  ENDAT.



  IF GS_GRADE-ZGRADE <> 'A'. "A# ## ZGRADE ### GV_ALLA# N## ##

    GV_ALLA = 'N'.

  ENDIF.



  "KEY# ## ***### #### ## #### ## #### ##

  GV_SUM = GS_GRADE-ZSUM.

  GV_SCHOOL = GS_GRADE-ZSCHOOL.



  AT END OF ZCODE. "# ZCODE# ### ## #### ##

    IF GV_ALLA = 'Y'. "## A## ZFLAG# X# ##

      GS_GRADE-ZFLAG = 'X'.

      IF GV_SCHOOL = 'A'.

        GS_GRADE-ZAMOUNT = GV_SUM * '0.8'. "#### ##

      ELSE.

        GS_GRADE-ZAMOUNT = GV_SUM * '0.9'. "##### ##

      ENDIF.

    ELSE.

      GS_GRADE-ZFLAG = ''. "A# ## ## ### #### ##

      GS_GRADE-ZAMOUNT = GV_SUM.

    ENDIF.



    GS_GRADE-ZAMOUNT = GS_GRADE-ZAMOUNT * C_RATE. "### ##

    GV_TOTAL = GV_TOTAL + GS_GRADE-ZAMOUNT. "## ##

    MODIFY GT_GRADE FROM GS_GRADE TRANSPORTING ZFLAG ZAMOUNT. "### ## ##

  ENDAT.



ENDLOOP.



SORT GT_GRADE BY ZCODE ASCENDING ZEXAM DESCENDING. "### ZCODE# ### ## ##



DELETE ADJACENT DUPLICATES FROM GT_GRADE COMPARING ZCODE. "### ZCODE# ## ##



"### ##

LOOP AT GT_GRADE INTO GS_GRADE.

  AT FIRST. "## ##

    WRITE: / SY-ULINE(67).

    WRITE: / '|', ' #### ', '|', '       ###       ', '|', '####', '|', '    ####    ', '|'.

    WRITE: / SY-ULINE(67).

  ENDAT.



  WRITE: / '|', GS_GRADE-ZCODE, '|', GS_GRADE-ZMNAME, '|', GS_GRADE-ZFLAG, '      ', '|', GS_GRADE-ZAMOUNT DECIMALS 0, '|'.

  WRITE: / SY-ULINE(67).



  AT LAST. "## ##

    WRITE: / '|', '              #            #              ', '|', GV_TOTAL DECIMALS 0, '|'.

    WRITE: / SY-ULINE(67).

  ENDAT.



ENDLOOP.