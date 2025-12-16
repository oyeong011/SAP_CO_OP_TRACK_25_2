
*&---------------------------------------------------------------------*

*& Report ZEDR20_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR20_PRACTICE001.



DATA: BEGIN OF GS_GRADE,    " ## ##

  ZCODE TYPE ZEDT20_004-ZCODE,    " ZCODE ##

  ZGRADE TYPE ZEDT20_004-ZGRADE,    " ZGRDE ##

  ZMNAME TYPE ZEDT20_004-ZMNAME,    " ZMNAME ##

  ZSCHOOL TYPE ZEDT20_004-ZSCHOOL,    " ZSCHOOL ##

  ZSUM TYPE ZEDT20_004-ZSUM,    " ZSUM ##

  ZAMOUNT TYPE ZEDT20_004-ZAMOUNT,    " ZAMOUNT ##

  ZFLAG TYPE ZEDT20_004-ZFLAG,    " ZFLAG ##

END OF GS_GRADE.    " ## ##

DATA: GT_GRADE LIKE TABLE OF GS_GRADE.    " ### ### ### ### ##



DATA: BEGIN OF GS_STUDENT,    " ### ## #### ### ### ## ##

  ZCODE TYPE ZEDT20_004-ZCODE,    " ZCODE ##

  ZMNAME TYPE ZEDT20_004-ZMNAME,    " ZMNAME ##

  ZFLAG TYPE ZEDT20_004-ZFLAG,    " ZFLAG ##

  ZAMOUNT TYPE I,    " ZAMOUNT ##

END OF GS_STUDENT.    " ## ##

DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.    " ### ### ### ### ##



" at new#### at end ##### ## #### ## ## ## ## #### ##

DATA: GV_START TYPE I VALUE -1.   " at new ### #### #### ## ##

DATA: GV_END TYPE C.    " ### ##### #### ## ## ##



CONSTANTS: C_KRW TYPE I VALUE 100.   " ### #### ## ZAMOUNT# ### ## ##



DATA: GV_SUM TYPE I VALUE 0.    " #### ### ### ## ## ##



SELECT * FROM ZEDT00_004 INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.   " ### #### DATA ###



SORT GT_GRADE BY ZCODE ZGRADE.    " ## ### #### ### ZCODE# ZGRADE# #### ##



CLEAR: GS_STUDENT, GS_GRADE.    " ## ##



LOOP AT GT_GRADE INTO GS_GRADE.   " ## ### #### ## GT_GRADE# loop#

  GV_END = ''.

  AT NEW ZCODE.   " ### zcode# ####

   GV_START = SY-TABIX.   " GV_START# ## #### ##

  ENDAT.    " AT## ##

  AT END OF ZCODE.    " ZCODE# #####

    IF GV_START NE SY-TABIX.    " GV_START# ## #### ### ###

      DELETE GT_GRADE FROM GV_START TO SY-TABIX - 1.    " GV_START## ## ### #### #### ##

    ENDIF.    " IF# ##

    GV_END = 'X'.   " ##### #### ##

  ENDAT.    " AT## ##



  IF GV_END = 'X'.     " #####

    IF GS_GRADE-ZGRADE = 'A'.   " ZGRADE# A##

      GS_GRADE-ZFLAG = 'X'.   " #### ####

      " ##### ##### ###### #####

      IF GS_GRADE-ZSCHOOL = 'A'.    " ##### 20### ##

        GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM * 8 / 10.

      ELSEIF GS_GRADE-ZSCHOOL = 'B'.    " ###### 10## ##

        GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM * 9 / 10.

      ENDIF.    " IF# ##

    ELSE.   " #### ###

      GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM.   " #### ### ##

    ENDIF.    " IF# ##

    GS_GRADE-ZAMOUNT = GS_GRADE-ZAMOUNT * C_KRW.   " ### #### ## KRW# ##

    MOVE-CORRESPONDING GS_GRADE TO GS_STUDENT.    " ### GS_GRADE## ### ### ### GS_STUDENT# ##

    APPEND GS_STUDENT TO GT_STUDENT.    " ### ### body# ##

  ENDIF.

ENDLOOP.    " Loop# ##



LOOP AT GT_STUDENT INTO GS_STUDENT.   " #### #### LOOP# ##

  AT FIRST.   " ## ### #### #####

    WRITE :/ '--------------------------------------------------------------------------'.

    WRITE :/ '|   ####   |          ###          |####|       ####      |'.

    WRITE :/ '--------------------------------------------------------------------------'.

  ENDAT.    " AT## ##

  " ### ##

  WRITE :/ '|  ', GS_STUDENT-ZCODE, '|    ',GS_STUDENT-ZMNAME,'|',  GS_STUDENT-ZFLAG  ,'     |  ' ,        GS_STUDENT-ZAMOUNT,'      |'.

  WRITE :/ '--------------------------------------------------------------------------'.



  GV_SUM = GV_SUM + GS_STUDENT-ZAMOUNT.   " ### #### ## # #### ZAMOUNT## ##



  AT LAST.    " ### ### ### #####

    WRITE :/ '|' ,'               ','#      #','                     ','|'   ,'  ',    GV_SUM   ,'    ','|'  .

    WRITE :/ '--------------------------------------------------------------------------'.

  ENDAT.    " AT## ##

ENDLOOP.    " Loop# ##






*DATA: BEGIN OF GS_GRADE,    " ## ##

*  ZCODE TYPE ZEDT20_004-ZCODE,    " ZCODE ##

*  ZGRADE TYPE ZEDT20_004-ZGRADE,    " ZGRDE ##

*  ZMNAME TYPE ZEDT20_004-ZMNAME,    " ZMNAME ##

*  ZSCHOOL TYPE ZEDT20_004-ZSCHOOL,    " ZSCHOOL ##

*  ZSUM TYPE ZEDT20_004-ZSUM,    " ZSUM ##

*  ZAMOUNT TYPE I,    " ZAMOUNT ##

*  ZFLAG TYPE ZEDT20_004-ZFLAG,    " ZFLAG ##

*END OF GS_GRADE.    " ## ##

*DATA: GT_GRADE LIKE TABLE OF GS_GRADE.    " ### ### ### ### ##

*

*DATA: GV_SUM TYPE I VALUE 0.    " ### ### ## ##

*

*CONSTANTS: C_KRW TYPE I VALUE 100.   " ### #### ## ## ##

*

*SELECT * FROM ZEDT20_004 INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.   " ### #### DATA ###

*

*SORT GT_GRADE BY ZCODE ASCENDING ZGRADE DESCENDING.   " ### ## ## #### #### ##### ## # # ##

*

*DELETE ADJACENT DUPLICATES FROM GT_GRADE COMPARING ZCODE.   " ## ## #### ### ## ####

*

*LOOP AT GT_GRADE INTO GS_GRADE.

*  AT FIRST.

*    WRITE :/ '--------------------------------------------------------------------------'.

*    WRITE :/ '|   ####   |          ###          |####|       ####      |'.

*    WRITE :/ '--------------------------------------------------------------------------'.

*  ENDAT.

*

*  IF GS_GRADE-ZGRADE = 'A'.   " ZGRADE# A##

*      GS_GRADE-ZFLAG = 'X'.   " #### ####

*      " ##### ##### ###### #####

*      IF GS_GRADE-ZSCHOOL = 'A'.    " ##### 20### ##

*        GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM * 8 / 10.

*      ELSEIF GS_GRADE-ZSCHOOL = 'B'.    " ###### 10## ##

*        GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM * 9 / 10.

*      ENDIF.    " IF# ##

*    ELSE.   " #### ###

*      GS_GRADE-ZAMOUNT = GS_GRADE-ZSUM.   " #### ### ##

*    ENDIF.    " IF# ##

*  GS_GRADE-ZAMOUNT = GS_GRADE-ZAMOUNT * C_KRW.   " ### #### ## KRW# ##

*  MODIFY TABLE GT_GRADE FROM GS_GRADE TRANSPORTING ZAMOUNT ZFLAG.   " ### #### ### #### ##

*

*  GV_SUM = GV_SUM + GS_GRADE-ZAMOUNT.   " ### #### ## GV_SUM# ZAMOUNT# ##

*

*  " ### ##

*  WRITE :/ '|  ', GS_GRADE-ZCODE, '|    ',GS_GRADE-ZMNAME,'|',  GS_GRADE-ZFLAG  ,'     |  ' ,        GS_GRADE-ZAMOUNT,'      |'.

*  WRITE :/ '--------------------------------------------------------------------------'.

*

*  AT LAST.

*    WRITE :/ '|' ,'               ','#      #','                     ','|'   ,'  ',    GV_SUM   ,'    ','|'  .

*    WRITE :/ '--------------------------------------------------------------------------'.

*  ENDAT.

*ENDLOOP.