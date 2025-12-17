
*&---------------------------------------------------------------------*

*& Report ZEDR10_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR10_PRACTICE001.



" ### ##

DATA: LINER(100) TYPE C VALUE '-------------------------------------------------------------------------------------'.



" ZEDT10_004# TYPE## #### ## ###




*TYPES: BEGIN OF TS_ZEDT10_004,

*    ZCODE   TYPE ZEDT10_004-ZCODE,    " ####

**    ZPERNR  TYPE ZEDT10_004-ZPERNR,   " ####

*    ZSCHOOL TYPE ZEDT10_004-ZSCHOOL,  " ####

**    ZSEM    TYPE ZEDT10_004-ZSEM,     " ####

**    ZEXAM   TYPE ZEDT10_004-ZEXAM,    " ####

**    ZMAJOR  TYPE ZEDT10_004-ZMAJOR,   " ##

*    ZMNAME  TYPE ZEDT10_004-ZMNAME,   " ###

*    ZSUM    TYPE ZEDT10_004-ZSUM,     " ####

**    ZWAERS  TYPE ZEDT10_004-ZWAERS,   " CURRENCY KEY

*    ZGRADE  TYPE ZEDT10_004-ZGRADE,   " ##

*    ZFLAG   TYPE ZEDT10_004-ZFLAG,    " ####

*    ZAMOUNT TYPE ZEDT10_004-ZAMOUNT,  " #### ##.

*END OF TS_ZEDT10_004.






" HEADER# INTERNAL TABLE ##

DATA: GS_GRADE TYPE ZEDT10_1004,

      GT_GRADE LIKE TABLE OF GS_GRADE WITH NON-UNIQUE KEY ZCODE.



" #### ####.

SELECT * FROM ZEDT10_1004

INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.



SORT GT_GRADE.



" #### ##. ## ## ## ### ##.

DATA: GV_SUM TYPE I.



" ## FLAG

DATA: GV_GRADE_ZFLAG TYPE XFELD.



" END FLAG

DATA: GV_END_FLAG TYPE XFELD.

DATA: GV_MIN_GRADE TYPE ZEDT10_1004-ZGRADE.



DATA: LV_INT TYPE I.






*LOOP AT GT_GRADE INTO GS_GRADE.

*  AT FIRST.

*    WRITE:/ LINER.

*    WRITE:/ '| ####   |             ###                       | #### |   ####     |'.

*    WRITE:/ LINER.

*  ENDAT.

*

** ## ## ----------------------------

*  " ## 1: ### ## ## ##

*  AT NEW ZCODE.

*    GV_GRADE_ZFLAG = 'X'.

*    GV_MIN_GRADE = 'Z'.  " ## ## ##

*  ENDAT.

*

*  " ## ## ####

*  IF GS_GRADE-ZGRADE < GV_MIN_GRADE.

*    GV_MIN_GRADE = GS_GRADE-ZGRADE.

*  ENDIF.

*

*  AT END OF ZCODE.

*    " ## ### A# ## ###

*    IF GV_MIN_GRADE = 'A'.

*      GV_GRADE_ZFLAG = 'X'.

*    ELSE.

*      GV_GRADE_ZFLAG = ''.

*    ENDIF.

*

*    MODIFY GT_GRADE FROM GS_GRADE

*      TRANSPORTING ZFLAG ZAMOUNT

*      WHERE ZCODE = GS_GRADE-ZCODE.

*  ENDAT.

** #. ## ## ----------------------------

*

** # ZCODE ## ------------------------

*  " DEPERATED: ~FLAG # #### ##~

*  IF GV_END_FLAG = 'X'.

*    " # ## ## -------------------------

*    WRITE:/ '|'.

*    WRITE: GS_GRADE-ZCODE.

*    WRITE: '|'.

*    WRITE: GS_GRADE-ZMNAME.

*    WRITE: '|   '.

*    WRITE: GV_GRADE_ZFLAG.

*    WRITE: '    |'.

*

*    " ### ## ## ----------------------

*    LV_INT = GS_GRADE-ZSUM.

*    " #### ### ### ## ##

*    IF GV_GRADE_ZFLAG = 'X'.

*      " ### 20# ##

*      IF GS_GRADE-ZSCHOOL = 'A'.

*        LV_INT = LV_INT * 80.

*        WRITE: LV_INT.

*        " #### 10# ##

*      ELSE.

*        LV_INT = LV_INT * 90.

*        WRITE: LV_INT.

*      ENDIF.

*    ELSE.

*      LV_INT = LV_INT * 100.

*      WRITE: LV_INT.

*    ENDIF.

*    WRITE: '   |'.

*    WRITE:/ LINER.

*    " #. ### ## ## ----------------------

*

*    GV_SUM = GV_SUM + LV_INT.

*    " #. # ## ## -------------------------

*

*    " INTERNAL TABLE MODIFY ## -----------

*    GS_GRADE-ZFLAG = GV_GRADE_ZFLAG.

*    MOVE LV_INT TO GS_GRADE-ZAMOUNT.

*

*    MODIFY GT_GRADE FROM GS_GRADE

*      TRANSPORTING ZFLAG ZAMOUNT

*      WHERE ZCODE = GS_GRADE-ZCODE.

*

*    " #. INTERNAL TABLE MODIFY ## -----------

*

*  ENDIF.

** #. # ZCODE ## ------------------------

*

*  " ## # #### ## ##

*  AT LAST.

*    WRITE:/ '|                  #                      #                      | '.

*    WRITE: GV_SUM.

*    WRITE: '  |'.

*    WRITE:/ LINER.

*  ENDAT.

*

*  CLEAR GS_GRADE.

*ENDLOOP.

*

*" SORT # ## ### ##

*SORT GT_GRADE.

*DELETE ADJACENT DUPLICATES FROM GT_GRADE.






" ## ###

LOOP AT GT_GRADE INTO GS_GRADE.

  AT FIRST.

    WRITE:/ LINER.

    WRITE:/ '| ####   |             ###                       | #### |   ####     |'.

    WRITE:/ LINER.

  ENDAT.






* ## ## ----------------------------




  " ZCODE ## ### FLAG ###

  AT NEW ZCODE.

    " ## FLAG ## ###

    GV_GRADE_ZFLAG = 'X'.

    GV_END_FLAG = ''.

  ENDAT.



  " #### A# ### ### ###.

  IF GS_GRADE-ZGRADE <> 'A'.

    GV_GRADE_ZFLAG = ''.

  ENDIF.



  " ### #### ###

  AT END OF ZCODE.

    GV_END_FLAG = 'X'.

  ENDAT.




* #. ## ## ----------------------------



* # ZCODE ## ------------------------




  " DEPERATED: ~FLAG # #### ##~

  IF GV_END_FLAG = 'X'.

    " # ## ## -------------------------

    WRITE:/ '|'.

    WRITE: GS_GRADE-ZCODE.

    WRITE: '|'.

    WRITE: GS_GRADE-ZMNAME.

    WRITE: '|   '.

    WRITE: GV_GRADE_ZFLAG.

    WRITE: '    |'.



    " ### ## ## ----------------------

    LV_INT = GS_GRADE-zsum.

    " #### ### ### ## ##

    IF GV_GRADE_ZFLAG = 'X'.

      " ### 20# ##

      IF GS_GRADE-ZSCHOOL = 'A'.

        lv_int = lv_int * 80.

        WRITE: lv_int.

      " #### 10# ##

      ELSE.

        lv_int = lv_int * 90.

        WRITE: lv_int.

      ENDIF.

    else.

      lv_int = lv_int * 100.

      write: lv_int.

    ENDIF.

    WRITE: '   |'.

    WRITE:/ LINER.

    " #. ### ## ## ----------------------



    GV_SUM = GV_SUM + LV_INT.

    " #. # ## ## -------------------------



    " INTERNAL TABLE MODIFY ## -----------

    GS_GRADE-ZFLAG = GV_GRADE_ZFLAG.

    GS_GRADE-ZAMOUNT = LV_INT / 100.



    MODIFY GT_GRADE FROM GS_GRADE

      TRANSPORTING ZFLAG ZAMOUNT

      WHERE ZCODE = GS_GRADE-ZCODE.



    " #. INTERNAL TABLE MODIFY ## -----------



  ENDIF.




* #. # ZCODE ## ------------------------






  " ## # #### ## ##

  AT LAST.

    WRITE:/ '|                  #                      #                      | '.

    WRITE: GV_SUM.

    WRITE: '  |'.

    WRITE:/ LINER.

  ENDAT.



  CLEAR GS_GRADE.

ENDLOOP.



" SORT # ## ### ##

SORT GT_GRADE.

DELETE adjacent duplicates from GT_GRADE.