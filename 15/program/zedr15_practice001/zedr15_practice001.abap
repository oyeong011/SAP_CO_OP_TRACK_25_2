
*&---------------------------------------------------------------------*

*& Report ZEDR15_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR15_PRACTICE001.



"#### ## ###### ##

DATA : GS_GRADE TYPE ZEDT00_004. "### ##

DATA : GT_GRADE LIKE TABLE OF GS_GRADE. "###### ##



"## ##

DATA : GV_FLAG TYPE ZEDT00_004-ZFLAG,

      GV_TOTAL TYPE P DECIMALS 2,

      GV_GUBUN TYPE I.



"### ####

SELECT * FROM ZEDT00_004

  INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.



" ZCODE, ZGRADE# ##

SORT GT_GRADE BY ZCODE ZGRADE.





"### ##

LOOP AT GT_GRADE INTO GS_GRADE.



  AT FIRST.

    WRITE :/ '------------------------------------------------------------------'.

    WRITE :/ '|  ####  |         ###        |####|     ####     |'.

    WRITE :/ '------------------------------------------------------------------'.

  ENDAT.



  "ZCODE##### X# ## A# ### ### ### ##

  AT NEW ZCODE.

    GV_FLAG = 'X'. "###, ## A## ##

    GV_GUBUN = 1.

  ENDAT.



  IF GS_GRADE-ZGRADE NE 'A'.

    GV_FLAG = ''. "#### A# ### ## ##

  ENDIF.



  "ZCODE#### GV_FLAG## ## ### ## # ### ##

  AT END OF ZCODE.

    GV_GUBUN = 2. "### # ##

  ENDAT.



  IF GV_GUBUN = 2. "### ### FLAG# ## ## # ##

    IF GV_FLAG = 'X'.

      GS_GRADE-ZFLAG = 'X'.

      IF GS_GRADE-ZSCHOOL = 'A'.

        GS_GRADE-ZSUM = GS_GRADE-ZSUM * 80.

      ELSEIF GS_GRADE-ZSCHOOL = 'B'.

        GS_GRADE-ZSUM = GS_GRADE-ZSUM * 90.

      ENDIF.

    ELSE.

      GS_GRADE-ZSUM = GS_GRADE-ZSUM * 100.

    ENDIF.



    MODIFY GT_GRADE FROM GS_GRADE INDEX SY-TABIX TRANSPORTING ZSUM ZFLAG.



  WRITE :/ '|', GS_GRADE-ZCODE, '| ', GS_GRADE-ZMNAME, '|', GS_GRADE-ZFLAG, '     |',

  CONV i( GS_GRADE-ZSUM ), '     |     '.

  WRITE :/ '------------------------------------------------------------------'.



    "## ##

    GV_TOTAL = GV_TOTAL + GS_GRADE-ZSUM.

    CLEAR : GV_FLAG, GV_GUBUN.

   ENDIF.



   AT LAST.

    WRITE :/ '|' ,'               ','#      #','                ','|' , CONV i( GV_TOTAL ) ,'     |'  .

    WRITE :/ '------------------------------------------------------------------'.

  ENDAT.



ENDLOOP.