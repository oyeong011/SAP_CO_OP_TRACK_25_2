
*&---------------------------------------------------------------------*

*& Report ZEDR05_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR05_PRACTICE001.





" ###### ## ##

TYPES : BEGIN OF TY_FINAL,

  ZCODE LIKE ZEDT05_004-ZCODE,

  ZMNAME LIKE ZEDT05_004-ZMNAME,

  ZFLAG LIKE ZEDT05_004-ZFLAG,

  ZAMOUNT LIKE ZEDT05_004-ZAMOUNT,

  END OF TY_FINAL.





DATA : GT_GRADE LIKE TABLE OF ZEDT05_004 WITH NON-UNIQUE KEY ZCODE, " ## ###

      GT_FINAL TYPE TABLE OF TY_FINAL, " #####

      GS_FINAL_LINE LIKE LINE OF GT_FINAL. " ##### ##



DATA : GS_GRADE LIKE LINE OF GT_GRADE, " ##### ### ##

      GS_GRADE_LINE LIKE LINE OF GT_GRADE. " ##### ##







DATA :ZAMOUNT TYPE I, " ## ##

      ZLFLAG TYPE I VALUE 0, "### #### #### ###

      ZSUM TYPE I.



SELECT * FROM ZEDT05_004 INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.





SORT GT_GRADE BY ZCODE ZGRADE. " ## # ##### ## (## ### #### ##### ####)





LOOP AT GT_GRADE INTO GS_GRADE.

  "### ## ##.

 AT FIRST.

    WRITE: / '-----------------------------------------------------------------'.

    WRITE: / '|', '####', 14 '|', '###',  35 '|', '####',  48 '|', '####',  65 '|'.

    WRITE: / '-----------------------------------------------------------------'.

  ENDAT.

  MOVE-CORRESPONDING GS_GRADE TO GS_GRADE_LINE.





  " ######

  AT NEW ZCODE.

    IF ZLFLAG = 1.

      ZSUM = GS_FINAL_LINE-ZAMOUNT * 100 .

      WRITE : / '|', GS_FINAL_LINE-ZCODE,

             14 '|', GS_FINAL_LINE-ZMNAME ,

             35 '|', GS_FINAL_LINE-ZFLAG ,

              48 '|', ZSUM,

              64 ' | '.

    ZAMOUNT = ZAMOUNT + ZSUM.

      WRITE : / SY-ULINE(65).

    ENDIF.

  ENDAT.



  AT END OF ZCODE.

    "##### A##

    IF GS_GRADE_LINE-ZGRADE = 'A'.

      GS_GRADE_LINE-ZFLAG = 'X'. "####

        IF GS_GRADE_LINE-ZSCHOOL = 'A'. " #### ##

          GS_GRADE_LINE-ZAMOUNT = GS_GRADE_LINE-ZSUM * 80 / 100. " ### ##

        ELSEIF GS_GRADE_LINE-ZSCHOOL = 'B'.  " #### ##

          GS_GRADE_LINE-ZAMOUNT = GS_GRADE_LINE-ZSUM * 90 / 100.

        ENDIF.

        MODIFY GT_GRADE FROM GS_GRADE_LINE TRANSPORTING ZAMOUNT ZFLAG.

       ELSE.

         GS_GRADE_LINE-ZAMOUNT = GS_GRADE_LINE-ZSUM.

      ENDIF.

     MOVE-CORRESPONDING GS_GRADE_LINE TO GS_FINAL_LINE.

     APPEND GS_FINAL_LINE TO GT_FINAL.

     ZLFLAG = 1.

  ENDAT.



   AT LAST.

   ZSUM = GS_FINAL_LINE-ZAMOUNT * 100 .

    WRITE : / '|', GS_FINAL_LINE-ZCODE,

             14 '|', GS_FINAL_LINE-ZMNAME ,

             35 '|', GS_FINAL_LINE-ZFLAG ,

              48 '|', ZSUM ,

              64 ' | '.

    ZAMOUNT = ZAMOUNT + ZSUM.



       WRITE: / '-----------------------------------------------------------------'.

      WRITE: / '|', '##',  48 '|',  ZAMOUNT,  65 '|'.

    WRITE: / '-----------------------------------------------------------------'.



  ENDAT.

ENDLOOP.