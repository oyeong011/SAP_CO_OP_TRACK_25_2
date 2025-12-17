
*&---------------------------------------------------------------------*

*& Report ZEDR018_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR018_PRACTICE001.





data : BEGIN OF gs_grade,

  zcode  like zedt00_004-zcode,

  zpernr like zedt00_004-zpernr,

  zschool like zedt00_004-zschool,

  zsem like zedt00_004-zschool,

  zexam like zedt00_004-zexam,

  zmajor like zedt00_004-zmajor,

  zmname type zedt00_004-zmname,

  zsum like zedt00_004-zsum,

  zgrade like zedt00_004-zgrade,

  zflag like zedt00_004-zflag,

  zamount type i,

end of gs_grade.



"### ### ##

data : gt_grade like TABLE OF gs_grade.



" ### ## ##

data : gv_zamount_sum type i,

      gv_zflag type c,

      gv_end type c.



" ### # ####.

SELECT * FROM ZEDT00_004

INTO CORRESPONDING FIELDS OF TABLE GT_GRADE.



" ## ## ## ##

sort gt_grade by zcode zpernr zexam.



clear gs_grade.



" ### ## # ####.

loop at gt_grade INTO gs_grade. " ## # ## ### ### ### ## # ### structure ### ###

  at first.

    WRITE :/ '-------------------------------------------------------------------'.

    WRITE :/ '|  ####   |          ###         | ####  |  ####   |'.

    WRITE :/ '-------------------------------------------------------------------'.

  ENDAT.



   at new zcode. "### zcode# ##### # ###.

      gv_zflag = 'X'.

      clear gv_end.

   endat.



   if gs_grade-zgrade <> 'A'. " A# ## ### ###

     clear gv_zflag. " ### ### ####

   ENDIF.



   at END OF zcode. " ### ## #

     gv_end = 'X'. " ### # ## ####

   endat.



   if gv_end = 'X'.

     gs_grade-zsum = gs_grade-zsum * 100. " ##### # ### #.

     if gv_zflag = 'X'. " ##### ##

       gs_grade-zflag = 'X'. " zflag ####

       if gs_grade-zschool = 'A'." ### 20# ##

         gs_grade-zamount = gs_grade-zsum * '0.8'.

       ELSEIF gs_grade-zschool = 'B'." #### 10# ##

         gs_grade-zamount = gs_grade-zsum * '0.9'.

       ENDIF.

     else.

        gs_grade-zamount = gs_grade-zsum.

     ENDIF.

     gv_zamount_sum = gv_zamount_sum + gs_grade-zamount.

     modify gt_grade from gs_grade index sy-tabix.

     WRITE :/ '| ', gs_grade-zcode, '|   ', gs_grade-zmname, '|    ', gs_grade-zflag, '    |', gs_grade-zamount, '|'.

     WRITE :/ '-------------------------------------------------------------------'.

   endif.



   at last.

    WRITE :/ '|    ##     |                                      ', gv_zamount_sum, '|'.

    WRITE :/ '-------------------------------------------------------------------'.

   endat.



ENDLOOP.