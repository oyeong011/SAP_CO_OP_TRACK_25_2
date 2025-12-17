
*&---------------------------------------------------------------------*

*& Report ZEDR17_PRACTICE001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




report zedr17_practice001.






* 1. ##### ## ###### ##




data : gs_grade type zedt17_004. " ### ##

data : gt_grade type table of zedt17_004. " ### ### ##






* 2. ## ### #### ### ####




select * from zedt17_004 " zedt17_004 #### ### ## ####

into corresponding fields of table gt_grade." gt_grade ### #### ##






* 6. # ## #### ## ZEXAM# ## ## ##(ZGRADE)# A# ### #####(ZFLAG) X##




clear : gs_grade. " work area# ## clear

sort gt_grade by zcode zgrade. " ##



data : gv_a_flag(1). " ## A## ## ###

data : gv_discount_rate type p decimals 2. " ### (###-0.8, ####-0.9, ####X-0.0)

data : gv_zsum type p decimals 2. " zamount ## ## ##

data : gv_zschool(1). " gs_grade-zschool ## ## ##

data : gv_amount type i. " ##

data : float_to_int type i. " flot to int (KRW)

data : gv_modify_flag(1). " modify ## ###

data : gv_zmname(20). " zmname ## ## ##



loop at gt_grade into gs_grade.



  at first.

    write : / '--------------------------------------------------------------------------'.

    write : / '|   ####   |          ###          |####|       ####      |'.

    write : / '--------------------------------------------------------------------------'.

  endat.



  gv_zschool = gs_grade-zschool. " at new #### gs_grade-zschool# *##### ## # ##

  gv_zmname = gs_grade-zmname. "  " at new #### gs_grade-zmname# *##### ## # ##



 " 5. AT NEW 1# ## ##

  at new zcode.

    " ### ## ### flag# 'X'# ###

    gv_a_flag = 'X'.



    " ZSCHOOL(####)# A(###)# ## 20%, B(####)# ## 10% ### ##

    if gv_zschool eq 'A'.

      gv_discount_rate = '0.80'.

    elseif gv_zschool eq 'B'.

      gv_discount_rate = '0.90'.

    endif.

  endat.



  gv_zsum = gs_grade-zsum. " zsum # ##



  " #### zgrade# 'A' ## ## -> flag ###

  if gs_grade-zgrade ne 'A'. " ne# != ## (<># ##)

    gv_a_flag = ''.

  endif.



  " 6. AT END 1# ## ##

  " ## ### ### ### flag# 'X'## 'X' ##

  clear gv_modify_flag.

  at end of zcode.

    if gv_a_flag = 'X'.

      gs_grade-zflag = 'X'. " ####

      gs_grade-zamount = gv_zsum * gv_discount_rate. " ### ### ## ### ##

    else.

      gs_grade-zflag = ''. " #### ##

      gs_grade-zamount = gv_zsum. " ## ## X #### ##

    endif.

    gv_amount = gv_amount + gs_grade-zamount. " ## ##



    float_to_int = gs_grade-zamount * 100.

    write : / '|  ', gs_grade-zcode, '|    ', gv_zmname,'|',  gs_grade-zflag  ,'     |  ' ,        float_to_int,'      |'.

    write : / '--------------------------------------------------------------------------'.



    gv_modify_flag = 'X'. " at end ## modify ##






*    " ## ##

*    sort gt_grade by zcode.

*    delete adjacent duplicates from gt_grade comparing zcode. " ### ###(zcode ##) ##




  endat.



  " modify# endloop ### # # ##

  " gt_grade ### ##### zcode# gs_grade# zcode# ## # ###,

  " ## ## zflag# zamount ## ## gs_grade ### ##

  if gv_modify_flag = 'X'.

    modify gt_grade from gs_grade transporting zflag zamount where zcode = gs_grade-zcode.

  endif.



  " 4. AT LAST ## 1# ## ##

  at last.

    float_to_int = gv_amount * 100.

    write : / '|               #      #                         |  ',    float_to_int   ,'      |'.

    write : / '--------------------------------------------------------------------------'.

  endat.





endloop.