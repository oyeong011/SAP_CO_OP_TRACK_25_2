
*&---------------------------------------------------------------------*

*& Report ZEDR022_006

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR022_006.






* ## ### ## ### ### ##




DATA: BEGIN OF gs_grade, "### ##

        zcode    TYPE zedt00_004-zcode,    "####

        zpernr   TYPE zedt00_004-zpernr,   "####

        zschool  TYPE zedt00_004-zschool,  "###/#### ##

        zsem     TYPE zedt00_004-zsem,     "####

        zexam    TYPE zedt00_004-zexam,    "####

        zmajor   TYPE zedt00_004-zmajor,   "##

        zmname   TYPE zedt00_004-zmname,   "###

        zsum     TYPE zedt00_004-zsum,     "####(ex.100.00)

        zwaers   TYPE zedt00_004-zwaers,   "###

        zgrade   TYPE zedt00_004-zgrade,   "##

        zflag    TYPE zedt00_004-zflag,    "####

        zamount  TYPE zedt00_004-zamount,  "####

        zcal_sum TYPE p DECIMALS 2,        "### ####

      END OF gs_grade.



DATA gt_grade LIKE TABLE OF gs_grade. "### ### ##



DATA : BEGIN OF gs_write, "### ###

  zcode TYPE zedt00_004-zcode, "####

  zmname TYPE zedt00_004-zmname, "##

  zflag TYPE zedt00_004-zflag, "####

  zamount TYPE zedt00_004-zamount, "####

 END OF gs_write.



DATA gt_write LIKE TABLE OF gs_write. "### ###



DATA : gv_is_scholar    TYPE abap_bool VALUE abap_true,   "### ##

       gv_is_last       TYPE abap_bool VALUE abap_false,  "## #### # ##

       gv_total_amount  TYPE i,                           "####

       gv_amount_int    TYPE i.                           "### ## ####






* DATA ####(## ##)




SELECT * FROM zedt00_004

  INTO CORRESPONDING FIELDS OF TABLE gt_grade.



CLEAR : gs_grade.

SORT gt_grade BY zcode zexam. "AT ### SORT ##

"#### #### zcode# sort, ## ### ## ####+### ## ##### #### ##-> zexam sort






* # ## ####(ZCODE)## ####(ZEXAM)# ## ## ### A# ### ####(ZFLAG)# X####

* ## ####(ZAMOUNT)# ####(ZSUM)## ###

* ###('A' : 20%), ####('B' : 10%) ##






"## # ## ## ### #

"1. ## ## A### ###->ZFLAG = 'X', ZAMOUNT = ZSUM * 0.8

"2. ## ## A### ####->ZFLAG = 'X', ZAMOUNT = ZSUM * 0.9

"3. #### A# ## -> ZFLAG = '', ZAMOUNT = ZSUM



LOOP AT gt_grade INTO gs_grade.




* AT NEW 1# ## ##(### # ### #)




  AT NEW zcode. "##

    gv_is_scholar = abap_true.  "###### ##

    gv_is_last    = abap_false. "## # ##

  ENDAT.



  IF gs_grade-zgrade NE 'A'. "# ##### A# ###

    gv_is_scholar = abap_false. "#### ##

  ENDIF.






* AT END 1# ## ##(## ## ## #)




  AT END OF zcode. "# ### ### #### # ## #(##,##,##, ## # 4#)

    gv_is_last = abap_true. "## ## ##

  ENDAT.



  IF gv_is_last = abap_true. "## ## ##




* ##### ## ### ### ##




    gs_grade-zcal_sum = gs_grade-zsum * 100. "100.00 -> 10000## ##



    IF gv_is_scholar = abap_true. "## ######

      gs_grade-zflag = 'X'. "####(ZFLAG) X##



      IF gs_grade-zschool = 'A'.        " ### : 20% ##

        gs_grade-zcal_sum = gs_grade-zcal_sum * '0.8'.

      ELSE.                             " #### : 10% ##

        gs_grade-zcal_sum = gs_grade-zcal_sum * '0.9'.

      ENDIF.



    ELSE.

      gs_grade-zcal_sum = gs_grade-zcal_sum. " ### ## : ## ###

    ENDIF.



    gs_grade-zamount = gs_grade-zcal_sum. " ## ####(zamount) ##




* ## # modify ### ## ### ### # #### ##### ## ### ### ### ##




    MODIFY gt_grade FROM gs_grade INDEX sy-tabix

      TRANSPORTING zflag zamount zcal_sum. "####,###,####### ####



  ENDIF.



  CLEAR : gs_grade.

ENDLOOP.






* ## ### ## (#### # ## # ## ##)




SORT gt_grade BY zcode zexam DESCENDING.

DELETE ADJACENT DUPLICATES FROM gt_grade COMPARING zcode.



LOOP AT gt_grade INTO gs_grade.

  MOVE-CORRESPONDING gs_grade To gs_write. "#### ## ## gs_write #### ##

  APPEND gs_write TO gt_write. "gs_write ### ### #### ##

 ENDLOOP.



 CLEAR : gs_write.

gv_total_amount = 0.



LOOP AT gt_write INTO gs_write.

  gv_total_amount = gv_total_amount + gs_write-zamount.

  gv_amount_int   = TRUNC( gs_write-zamount ).  " ### ##



  " # ## ##

  AT FIRST.

    WRITE :/ '---------------------------------------------------------------'.

    WRITE :/ '|', (10) '####',

             '|', (15) '##',

             '|', (10) '####',

             '|', (15) '####', '|'.

    WRITE :/ '---------------------------------------------------------------'.

  ENDAT.



  " ### ##

  WRITE :/ '|', (10) gs_write-zcode,

           '|', (15) gs_write-zmname,

           '|', (10) gs_write-zflag,

           '|', (15) gv_amount_int, '|'.

  WRITE :/ '---------------------------------------------------------------'.



  " ## ##

  AT LAST.

    WRITE :/ '|', (10) '##',

             '|', (15) space,

             '|', (10) space,

             '|', (15) gv_total_amount, '|'.

    WRITE :/ '---------------------------------------------------------------'.

  ENDAT.



ENDLOOP.