
*&---------------------------------------------------------------------*

*& Report ZEDR06_PRACTICE002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_PRACTICE002.




*&---------------------------------------------------------------------*




" STRUCTURE ## GS_ZEDT001

DATA : BEGIN OF GS_ZEDT001,

  ZCODE TYPE ZEDT06_001-ZCODE,

  ZPERNR TYPE ZEDT06_001-ZPERNR,

  ZKNAME TYPE ZEDT06_001-ZKNAME,

  ZENAME TYPE ZEDT06_001-ZENAME,

  ZGENDER TYPE ZEDT06_001-ZGENDER,

  ZTEL TYPE ZEDT06_001-ZTEL,

  END OF GS_ZEDT001.

" STRUCTURE ## GS_ZEDT002

DATA : BEGIN OF GS_ZEDT002,

  ZCODE TYPE ZEDT06_002-ZCODE,

  ZPERNR TYPE ZEDT06_002-ZPERNR,

  ZMAJOR TYPE ZEDT06_002-ZMAJOR,

  ZMNAME TYPE ZEDT06_002-ZMNAME,

  ZMGUBUN TYPE ZEDT06_002-ZMGUBUN,

  ZSUM TYPE ZEDT06_002-ZSUM,

  ZWAERS TYPE ZEDT06_002-ZWAERS,

  END OF GS_ZEDT002.

  " STRUCTURE ## GS_ZEDT004

DATA : BEGIN OF GS_ZEDT004,

  ZCODE TYPE ZEDT06_004-ZCODE,

  ZPERNR TYPE ZEDT06_004-ZPERNR,

  ZSCHOOL TYPE ZEDT06_004-ZSCHOOL,

  ZSEM TYPE ZEDT06_004-ZSEM,

  ZMAJOR TYPE ZEDT06_004-ZMAJOR,

  ZMNAME TYPE ZEDT06_004-ZMNAME,

  ZSUM TYPE ZEDT06_004-ZSUM,

  ZWAERS TYPE ZEDT06_004-ZWAERS,

  ZGRADE TYPE ZEDT06_004-ZGRADE,

  END OF GS_ZEDT004.

" ## ## INTERNAL TABLE ##

DATA : GT_ZEDT001 LIKE TABLE OF GS_ZEDT001.

DATA : GT_ZEDT002 LIKE TABLE OF GS_ZEDT002.

DATA : GT_ZEDT004 LIKE TABLE OF GS_ZEDT004.

CLEAR : GS_ZEDT001, GS_ZEDT002, GS_ZEDT004, GT_ZEDT001, GT_ZEDT002, GT_ZEDT004.




*&---------------------------------------------------------------------*




" ## #

CONSTANTS : GV_MAJOR_CHANGE_MESSAGE TYPE C LENGTH 10 VALUE '####'.

CONSTANTS : GV_GRADE_WARNING_MESSAGE TYPE C LENGTH 10 VALUE '####'.

CONSTANTS : GV_BLANK_MESSAGE TYPE C LENGTH 10 VALUE '          '.




*&---------------------------------------------------------------------*




" ### ####

SELECT * FROM ZEDT06_001 INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT001.

SELECT * FROM ZEDT06_002 INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT002.

SELECT * FROM ZEDT06_004 INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT004.




*&---------------------------------------------------------------------*




 " #### ### ###

 DATA : BEGIN OF GS_SUM,

   ZCODE TYPE ZEDT06_001-ZCODE,

   ZGENDER TYPE ZEDT06_001-ZGENDER,

   SUM TYPE I,

 END OF GS_SUM.

 DATA : GT_SUM LIKE TABLE OF GS_SUM.

 CLEAR : GT_SUM, GS_SUM.




*&---------------------------------------------------------------------*




" ## ## ##.

DATA : GV_GRADE_WARNING_FLAG TYPE C.        " #### ###

DATA : GV_MAJOR_CHANGE_FLAG TYPE C.         " ## ## ###

DATA : GV_TEMP_GRADE TYPE C.                " ## ## ## ##

DATA : GV_LAST_FIELD_FLAG TYPE C.           " ## # ### ## ###

DATA : GV_INIT_MAJOR TYPE C.                " ## MAJOR ##

DATA : GV_MIN_GRADE TYPE C VALUE ''.        " ## ## #.

DATA : GV_MIN_GRADE_SUM TYPE I.             " ## ### ## ###




*&---------------------------------------------------------------------*




" ## # #### ## ## # ##

CLEAR : GS_ZEDT004.

SORT : GT_ZEDT004 BY ZCODE ZPERNR ZGRADE.

LOOP AT GT_ZEDT004 INTO GS_ZEDT004.



  AT FIRST.

    WRITE :/ '--------------------------------------------------------------------------------------------'.

    WRITE :/ '|   ####   |          ##          |   ####   |      ####      |     ##     |'.

    WRITE :/ '--------------------------------------------------------------------------------------------'.

  ENDAT.



  CLEAR : GV_TEMP_GRADE.

  GV_TEMP_GRADE = GS_ZEDT004-ZMAJOR.



  " ## # ## # ##.

  AT NEW ZCODE.

      GV_INIT_MAJOR = GV_TEMP_GRADE.

      GV_MIN_GRADE = GS_ZEDT004-ZGRADE.

      GV_MIN_GRADE_SUM = GS_ZEDT004-ZSUM.

      CONTINUE.

  ENDAT.



  " ## ## ## ##

  IF GV_MIN_GRADE < GS_ZEDT004-ZGRADE.

    GV_MIN_GRADE = GS_ZEDT004-ZGRADE.

    GV_MIN_GRADE_SUM = GS_ZEDT004-ZSUM.

  ENDIF.



  " ## ## ##

  IF GV_INIT_MAJOR <> GS_ZEDT004-ZMAJOR.

    GV_MAJOR_CHANGE_FLAG = 'X'.

  ENDIF.



  " ## # ### ## ### ##.

  AT END OF ZCODE.

    GV_LAST_FIELD_FLAG = 'X'.

  ENDAT.



  " ### ### # ZEDT001# ZEDT002 ## # ##.

  IF GV_LAST_FIELD_FLAG = 'X'.

    " GT_ZEDT004 <-> GT_ZEDT002 ## ##

    CLEAR : GS_ZEDT002.

    MOVE-CORRESPONDING GS_ZEDT004 TO GS_ZEDT002.

    READ TABLE GT_ZEDT002 WITH KEY ZCODE = GS_ZEDT004-ZCODE INTO GS_ZEDT002 COMPARING ZCODE.



    IF SY-SUBRC = 0.

      " GT_ZEDT002 <-> GT_ZEDT001 ## ##

      CLEAR : GS_ZEDT001.

      MOVE-CORRESPONDING GS_ZEDT002 TO GS_ZEDT001.

      READ TABLE GT_ZEDT001 WITH KEY ZCODE = GS_ZEDT002-ZCODE INTO GS_ZEDT001 COMPARING ZCODE.



      IF SY-SUBRC = 0.



        " ## ## ##

        IF GV_INIT_MAJOR <> GS_ZEDT002-ZMAJOR.

          GV_MAJOR_CHANGE_FLAG = 'X'.

        ENDIF.



        " ## ## ##

        IF GV_MIN_GRADE = 'D' OR GV_MIN_GRADE = 'F'.

          GV_GRADE_WARNING_FLAG = 'X'.

        ENDIF.



        " ##, ### ## ### ##.

        IF GV_MAJOR_CHANGE_FLAG = 'X'.

          IF GV_GRADE_WARNING_FLAG = 'X'.

            WRITE :/ '|  ',GS_ZEDT001-ZCODE,'|  ',GS_ZEDT001-ZKNAME,'|  ', GV_MAJOR_CHANGE_MESSAGE,'|  ', GS_ZEDT001-ZTEL,'|  ', GV_GRADE_WARNING_MESSAGE,'| '.

          ELSE.

            WRITE :/ '|  ',GS_ZEDT001-ZCODE,'|  ', GS_ZEDT001-ZKNAME,'|  ', GV_MAJOR_CHANGE_MESSAGE,'|  ', '                ','|  ', GV_BLANK_MESSAGE,'|  '.

          ENDIF.

        ELSE.

          IF GV_GRADE_WARNING_FLAG = 'X'.

            WRITE :/ '|  ',GS_ZEDT001-ZCODE,'|  ', GS_ZEDT001-ZKNAME,'|  ', GV_BLANK_MESSAGE,'|  ', GS_ZEDT001-ZTEL,'|  ', GV_GRADE_WARNING_MESSAGE,'|  '.

          ELSE.

            WRITE :/ '|  ',GS_ZEDT001-ZCODE,'|  ', GS_ZEDT001-ZKNAME,'|  ', GV_BLANK_MESSAGE,'|  ', '                ', '|  ',GV_BLANK_MESSAGE,'|  '.

          ENDIF.

        ENDIF.

        WRITE :/ '--------------------------------------------------------------------------------------------'.





        " ## # ## #### # ##.

        GS_SUM-ZGENDER = GS_ZEDT001-ZGENDER.

        GS_SUM-SUM = GV_MIN_GRADE_SUM * 100.



        COLLECT GS_SUM INTO GT_SUM.



      ENDIF.



    ENDIF.



    " ## # ## # ###.

    CLEAR : GV_GRADE_WARNING_FLAG, GV_MAJOR_CHANGE_FLAG, GV_LAST_FIELD_FLAG, GV_INIT_MAJOR, GV_MIN_GRADE, GV_MIN_GRADE_SUM.

  ENDIF.



  " ##### ##.

  AT LAST.



    LOOP AT GT_SUM INTO GS_SUM.



      IF GS_SUM-ZGENDER = 'M'.

        WRITE :/ '###### : ', GS_SUM-SUM.

      ELSEIF GS_SUM-ZGENDER = 'F'.

        WRITE :/ '###### : ', GS_SUM-SUM.

      ENDIF.



    ENDLOOP.



  ENDAT.



ENDLOOP.