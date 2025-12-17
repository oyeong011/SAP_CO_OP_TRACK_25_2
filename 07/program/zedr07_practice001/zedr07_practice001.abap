
*&---------------------------------------------------------------------*

*& Report ZEDR07_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_PRACTICE001.



"## ##

DATA : gs_zedt07 TYPE ZEDT07_004.



DATA : gv_money_temp TYPE i. "### ### ## ##

DATA : gv_major TYPE c LENGTH 15. "### #### ##

DATA : gv_cal_sum TYPE i. "### ### ##

DATA : gv_code TYPE c. "## #### zcode# ##

DATA : gv_code_end TYPE c. "### #### zcode

DATA : gv_grade TYPE c. "# zcode# ### # A## ##

DATA : gv_temp TYPE c.

DATA : gv_money TYPE i. "zsum# # #####



DATA : gt_zedt07 TYPE TABLE OF ZEDT07_004. "## ### ## ### ### ##.



SELECT * FROM ZEDT07_004

  INTO CORRESPONDING FIELDS OF TABLE gt_zedt07.



  SORT gt_zedt07 BY zcode zpernr zexam. "### ## ### ##### # 3 #### sort ###.



  CLEAR : gs_zedt07.

  CLEAR : gv_cal_sum, gv_code, gv_grade, gv_temp, gv_money.



  "LOOP# #### ### # ##

  LOOP AT gt_zedt07 INTO gs_zedt07.



   AT NEW zcode. "## #### zcode#

     gv_code ='X'.

   ENDAT.



   IF gv_code ='X'. "# zcode# ##

     IF gs_zedt07-zgrade = 'A'. "#### ## ### A#

       gv_grade = 'A'.

     ENDIF.

   ELSE. "### ## #### zcode# # ### # ## ### ###

     IF gv_grade = 'A'. "## zcode### ### A##

       IF gs_zedt07-zgrade = 'A'. "## ##### ### A##

         gv_temp = 'X'. "### ### ## ## ##.



       ELSE. "## ### ### A# ###

         CLEAR : gv_grade, gv_temp. "# ### # ## zcode# ###

       ENDIF.

     ENDIF.

   ENDIF.



   AT END OF zcode. "## ##### #### zcode#

     gv_code_end ='X'.

   ENDAT.



   IF gv_code_end ='X'. "## ##### ##### # ####

     gv_money = gs_zedt07-zsum * 100.

     IF gv_temp ='X'. "## #####

       gs_zedt07-zflag ='X'. "#### ### ##

       IF gs_zedt07-zschool ='A'. "##### 20%

         gv_money = gv_money * 80 / 100.

       ELSE. "#### ### #######

         gv_money = gv_money * 90 / 100. "#### 10%

       ENDIF.

     ENDIF.



     gv_cal_sum = gv_cal_sum + gv_money. "## ####

     gs_zedt07-zsum = gv_money. "### ##

     MODIFY gt_zedt07 FROM gs_zedt07 INDEX SY-TABIX. "### ### # ##

     CLEAR : gs_zedt07.

     CLEAR : gv_grade, gv_temp. "#### # zcode#### ### ### ## ## ### ###

   ENDIF.



   CLEAR : gs_zedt07.

   CLEAR : gv_code, gv_code_end. "#### zcode ### ## ###

  ENDLOOP.



  SORT gt_zedt07 DESCENDING BY zcode. "## ### ### ### flag# ## ### #### ###

  "## ### #####



  DELETE ADJACENT DUPLICATES FROM gt_zedt07 COMPARING zcode. "## ##



  SORT gt_zedt07 BY zcode. "## #### ##





  LOOP AT gt_zedt07 INTO gs_zedt07.

    gv_money_temp = gs_zedt07-zsum. "### ###

    gv_major = gs_zedt07-zmname. "### #### ##



    AT FIRST.

      WRITE :/ '----------------------------------------------------------------------------------------'.

      WRITE :/ '|       ####        |       ###          |   ####   |       ####        |'.

      WRITE :/ '----------------------------------------------------------------------------------------'.

    ENDAT.



"    WRITE :/ '|                       |                       |              |                       |'.

    WRITE :/ '|     ', gs_zedt07-zcode, '     ', '|     ', gv_major,  ' |     ',



    gs_zedt07-zflag, '     ', '|     ', gv_money_temp, '     |'.

WRITE :/ '----------------------------------------------------------------------------------------'.



    AT LAST.

      WRITE :/ '|                         #      #                           |     ', gv_cal_sum, '     |'.

      WRITE :/ '|--------------------------------------------------------------------------------------|'.

    ENDAT.



ENDLOOP.