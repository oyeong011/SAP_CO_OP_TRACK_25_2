
*&---------------------------------------------------------------------*

*& Report ZEDR00_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR00_PRACTICE001.

"1. DATA##

DATA : BEGIN OF GS_GRADE.

  include structure
ZEDT00_004
.

DATA : ZCAL_SUM TYPE I,

      END OF GS_GRADE.



DATA : GT_GRADE LIKE TABLE OF GS_GRADE.

"FOR #### ## ##

DATA : GV_ZCODE LIKE ZEDT00_004-ZCODE.

DATA : GV_SUM TYPE I.

DATA : GV_GRADE, GV_NEW, GV_END, GV_FLAG.

"## ## ## ##

DATA : GV_SUM_ALL TYPE I.



"2. GET DATA

SELECT * FROM ZEDT00_004

INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.



SORT GT_GRADE BY ZCODE ZPERNR ZEXAM.



CLEAR : GS_GRADE.

CLEAR : GV_ZCODE, GV_GRADE, GV_END, GV_SUM.



"3. MODIFY DATA

LOOP AT GT_GRADE INTO GS_GRADE.

  AT NEW ZCODE.

    GV_ZCODE = GS_GRADE-ZCODE.

    GV_NEW = 'X'.

  ENDAT.



  IF GV_NEW = 'X'.

    IF GS_GRADE-ZGRADE = 'A'.

      GV_GRADE = 'A'.

    ENDIF.

  ELSE.

    IF GV_GRADE = 'A'.

      IF GS_GRADE-ZGRADE = 'A'.

        GV_FLAG = 'X'.

      ELSE.

        CLEAR : GV_GRADE, GV_FLAG.

      ENDIF.

    ENDIF.

  ENDIF.



  AT END OF ZCODE.

    GV_END = 'X'.

    CLEAR : GV_ZCODE.

  ENDAT.



  IF GV_END = 'X'.

    GS_GRADE-ZCAL_SUM = GS_GRADE-ZSUM * 100.

    IF GV_FLAG = 'X'.

      GS_GRADE-ZFLAG = 'X'.

      IF GS_GRADE-ZSCHOOL = 'A'.

        GS_GRADE-ZCAL_SUM = GS_GRADE-ZCAL_SUM * '0.8'.

      ELSEIF GS_GRADE-ZSCHOOL = 'B'.

        GS_GRADE-ZCAL_SUM = GS_GRADE-ZCAL_SUM * '0.9'.

      ENDIF.

    ENDIF.



    GV_SUM_ALL = GV_SUM_ALL + GS_GRADE-ZCAL_SUM.



    MODIFY GT_GRADE FROM GS_GRADE INDEX SY-TABIX.



    CLEAR : GS_GRADE.

    CLEAR : GV_FLAG, GV_GRADE.

  ENDIF.



  CLEAR : GV_NEW, GV_END.

  CLEAR : GS_GRADE.

ENDLOOP.



SORT GT_GRADE DESCENDING BY ZCODE ZCAL_SUM.

DELETE ADJACENT DUPLICATES FROM GT_GRADE COMPARING ZCODE.



SORT GT_GRADE BY ZCODE.



"4. WRITE DATA

LOOP AT GT_GRADE INTO GS_GRADE.

  AT FIRST.

    WRITE :/ '--------------------------------------------------------------------------'.

    WRITE :/ '|   ####   |          ###          |####|       ####      |'.

    WRITE :/ '--------------------------------------------------------------------------'.

  ENDAT.



  WRITE :/ '|  ', GS_GRADE-ZCODE, '|    ',GS_GRADE-ZMNAME,'|',  GS_GRADE-ZFLAG  ,'     |  ' ,        GS_GRADE-ZCAL_SUM,'      |'.

  WRITE :/ '--------------------------------------------------------------------------'.



  AT LAST.

    WRITE :/ '|' ,'               ','#      #','                     ','|'   ,'  ',    GV_SUM_ALL   ,'    ','|'  .

    WRITE :/ '--------------------------------------------------------------------------'.

  ENDAT.



ENDLOOP.