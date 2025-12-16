
*&---------------------------------------------------------------------*

*& Report ZEDR04_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_PRACTICE001.



DATA GV_FIRST VALUE 'F'.  " 'T'# ## ## ZCODE, 'F'# ##

DATA GV_LAST VALUE 'F'.   " 'T'# ## ZCODE# ## ### #, 'F'# ##

DATA GV_FLAG.             " ### ##

DATA GV_TOTALSUM TYPE I VALUE 0.  " #### ## (###)

DATA GV_AMOUNT TYPE I.            " #### (###)



DATA GS_GRADE TYPE ZEDT04_004.        " ###(####) ##

DATA GT_GRADE LIKE TABLE OF GS_GRADE. " ### ### ##



" DB## INTERNAL TABLE# DATA ####

SELECT * FROM ZEDT04_004 INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.



SORT GT_GRADE BY ZCODE. " ## ZCODE## ### ##



" ZFLAG, ZAMOUNT ####

LOOP AT GT_GRADE INTO GS_GRADE.

  AT NEW ZCODE.       " ### ZCODE ## ### GV_FIRST ### #

    GV_FIRST = 'T'.

  ENDAT.



  IF GV_FIRST = 'T'.  " ### ## ### # GV_FIRST ### ## #

    GV_FIRST = 'F'.

    GV_FLAG = 'X'.

  ENDIF.



  IF GS_GRADE-ZGRADE <> 'A'.  " A## ## ### ### ## #

    GV_FLAG = ''.

  ENDIF.



  AT END OF ZCODE. " ## ZCODE ### ### GV_LAST ### #

    GV_LAST = 'T'.

  ENDAT.



  IF GV_LAST = 'T'. " ZFLAG, ZAMOUNT ## # GV_LAST ### ## #

    GV_LAST = 'F'.



    IF GV_FLAG = 'X'. " ###

      GS_GRADE-ZFLAG = 'X'.

      IF GS_GRADE-ZSCHOOL = 'A'.  " ###

        GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM * '0.8'.

      ELSE.                       " ####

        GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM * '0.9'.

      ENDIF.

    ELSE.             " ### ##

      GS_GRADE-ZFLAG = ''.

      GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM.

    ENDIF.



    " ### #### ZFLAG, ZAMOUNT ##

    MODIFY GT_GRADE FROM GS_GRADE TRANSPORTING ZFLAG ZAMOUNT WHERE ZCODE = GS_GRADE-ZCODE.

  ENDIF.

ENDLOOP.



" ZCODE ## # ##

DELETE ADJACENT DUPLICATES FROM GT_GRADE COMPARING ZCODE.



" ### ##

LOOP AT GT_GRADE INTO GS_GRADE.

  AT FIRST. " ### ### ## ## ### ### ##

    WRITE / '-----------------------------------------------------------------'.

    WRITE / '|  ####  |        ###        |####|     ####     | '.

  ENDAT.



  GV_AMOUNT = GS_GRADE-ZAMOUNT * 100.     " ### ### #### ## 100 ##

  GV_TOTALSUM = GV_TOTALSUM + GV_AMOUNT.  " #### ##



  WRITE / '-----------------------------------------------------------------'.

  WRITE : / '|', GS_GRADE-ZCODE, '|', GS_GRADE-ZMNAME, '|', GS_GRADE-ZFLAG, '     |', GV_AMOUNT, '     |'.



  AT LAST.  " #### ## ## ## ### ### ##

    WRITE / '-----------------------------------------------------------------'.

    WRITE : / '|                   #  #                   |  ', GV_TOTALSUM, '   |'.

    WRITE / '-----------------------------------------------------------------'.

  ENDAT.

ENDLOOP.