
*&---------------------------------------------------------------------*

*& Report ZEDR25_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*






Report ZEDR25_PRACTICE001.



" #### ### ##

TABLES : ZEDT25_004.



" 1. ##### ## ###### ##

"   #### ##

TYPES : BEGIN OF ssu_student,

          zcode   TYPE zedt25_004-zcode,

          zmajor  TYPE zedt25_004-zmajor,

          zmname  TYPE zedt25_004-zmname,

          zschool TYPE zedt25_004-zschool,

          zgrade  TYPE zedt25_004-zgrade,

          zflag   TYPE zedt25_004-zflag,

          zsum    TYPE zedt25_004-zsum,

          zamount TYPE zedt25_004-zamount,

          zwaers  TYPE zedt25_004-zwaers,

END OF ssu_student.



"   ### ## # ## ##

DATA : gs_student TYPE ssu_student. " ### ##

DATA : gt_student TYPE TABLE OF ssu_student. " ### ### ##



"   ## ## ### ## ### ###

DATA: BEGIN OF gs_check_flag,

        zcode      TYPE zedt25_004-zcode,

        all_a_flag TYPE c, " ## ### 'A'## #### ###

      END OF gs_check_flag.

DATA gt_check_flag LIKE STANDARD TABLE OF gs_check_flag.



"   # #### ### ## ##

DATA gv_total_amount TYPE zedt25_004-zamount.



"   #### ### ## ## ##

DATA lv_amount TYPE p DECIMALS 2.



" 2. ### ###

SELECT * FROM ZEDT25_004

INTO CORRESPONDING FIELDS OF TABLE gt_student.



  " #### #### ##

SORT gt_student BY zcode.



" 3~6. A ## LOOP#

LOOP AT gt_student INTO gs_student.

  " AT NEW: ##### ## ### ##

  AT NEW zcode.

    gs_check_flag-all_a_flag = 'X'. " ## A# #### ### ###

  ENDAT.



  " #### A# ## ## ### ##

  IF gs_student-zgrade <> 'A'.

    CLEAR gs_check_flag-all_a_flag.

  ENDIF.



  AT END OF zcode.

    gs_check_flag-zcode = gs_student-zcode.

    APPEND gs_check_flag TO gt_check_flag.

  ENDAT.

ENDLOOP.



" 7. ### ## # ## ##

LOOP AT gt_student INTO gs_student.

    gs_student-zamount = gs_student-zsum.



    " ## ### ## A## ### ##

    IF gs_student-zgrade = 'A'.

      gs_student-zflag = 'X'.



      " ### 20% ##, #### 10% ##

      IF gs_student-zschool = 'A'.

        lv_amount = gs_student-zsum * '0.8'.

        gs_student-zamount = lv_amount.

      ELSEIF gs_student-zschool = 'B'.

        lv_amount = gs_student-zsum * '0.9'.

        gs_student-zamount = lv_amount.

      ENDIF.

    ELSE.

      " ### clear

      CLEAR gs_student-zflag.

      gs_student-zamount = gs_student-zsum.

    ENDIF.



    "MODIFY### ## ### ### # #### ###

    MODIFY gt_student FROM gs_student INDEX sy-tabix.

ENDLOOP.





" 9., 11. ## ### ##,  #### # ## # ## ##

SORT gt_student BY zcode zamount DESCENDING.

DELETE ADJACENT DUPLICATES FROM gt_student COMPARING zcode.



" 12. ##

LOOP AT gt_student INTO gs_student.

  AT FIRST.

    WRITE: / '-----------------------------------------------------------------'.

    WRITE: / '|', '####', 14 '|', '###',  35 '|', '####',  48 '|', '####',  65 '|'.

    WRITE: / '-----------------------------------------------------------------'.

  ENDAT.



  WRITE: / '|', gs_student-zcode,

            14 '|', gs_student-zmname,

            35 '|', gs_student-zflag CENTERED,

            48 '|', gs_student-zamount CURRENCY 'KRW' DECIMALS 0,

            65 '|'.



  gv_total_amount = gv_total_amount + gs_student-zamount.



    AT LAST.

    WRITE: / '-----------------------------------------------------------------'.

    WRITE: / '|', '##',  48 '|', gv_total_amount CURRENCY 'KRW' DECIMALS 0,  65 '|'.

    WRITE: / '-----------------------------------------------------------------'.

  ENDAT.

ENDLOOP.