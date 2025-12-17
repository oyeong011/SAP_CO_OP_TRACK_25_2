
*&---------------------------------------------------------------------*

*& Report ZEDR17_PRACTICE002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




report zedr17_practice002.






* 1. ##### ## ###### ##




data : gs_student type zedt17_001. " ## ## ### ##

data : gt_student type table of zedt17_001. " ## ### ### ##



data : gs_tuition type zedt17_002. " ### ### ### ##

data : gt_tuition type table of zedt17_002. " ### ### ### ### ##



data : gs_grade type zedt17_004. " ### ## ### ##

data : gt_grade type table of zedt17_004. " ### ## ### ### ##






* ### ### ##




data : begin of gs_result,

         zcode        like zedt17_001-zcode, " ####

         zkname       like zedt17_001-zkname, " ##

         ztransfer(10), " ####

         ztel         like zedt17_001-ztel, "####

         zwarning(10), " ##

       end of gs_result.

data : gt_result like table of gs_result.






* ### ### ## ### ## (for collect)




data : begin of gs_sum,

         zgender like zedt17_001-zgender, " m/f

         zsum    type p decimals 2, "##

       end of gs_sum.

data : gt_sum like table of gs_sum.






* ## ## ##




data : gv_warning_flag(1). " #### ## ## ###

data : gv_transfer_flag(1). " ## ## ###

data : gv_total_m type p decimals 2. " ### ### ## ##

data : gv_total_f type p decimals 2. " ### ### ## ##

data : gv_worst_grade(1). " ### ## ## ##

data : gv_no_grade_flag(1). " ## ### ## ###

data : gv_tuition_major like zedt17_002-zmajor. " ## ##

data : gv_rep_zsum type p decimals 2. " ## ### ## ## ##






* 2. ### ##




select * from zedt17_001 " ## ## ### ##

  into corresponding fields of table gt_student.



select * from zedt17_002 " ### ### ### ##

  into corresponding fields of table gt_tuition.



select * from zedt17_004 " ## ## ### ##

  into corresponding fields of table gt_grade.






* work area clear & sort




clear : gs_student, gs_tuition, gs_grade, gs_result.

clear: gv_total_m, gv_total_f.

sort gt_student by zcode.

sort gt_tuition by zcode.

sort gt_grade by zcode zgrade.






* ## loop - ## ##




loop at gt_grade into gs_grade.



  at new zcode.

    clear : gv_warning_flag, gv_transfer_flag.

    gv_worst_grade = 'A'. " ## ## #### ##

    gv_rep_zsum = gs_grade-zsum. " zsum(###) ###



    " ## ### ## ## ##

    clear gs_tuition.

    read table gt_tuition into gs_tuition

      with key zcode = gs_grade-zcode binary search

      comparing zcode.

    if sy-subrc = 0.

      gv_tuition_major = gs_tuition-zmajor.

    else.

      clear gv_tuition_major.

    endif.

  endat.



  " #### ##

  if gs_grade-zgrade = 'D' or gs_grade-zgrade = 'F'. " D# F ##

    gv_warning_flag = 'X'. " #### ### ##

  endif.



  " ## ##

  if gs_tuition-zmajor ne gs_grade-zmajor. " ## ## ##

    gv_transfer_flag = 'X'. " ## ### ##

  endif.



  " ## ##(=## ##)

  gv_rep_zsum = gs_grade-zsum. " ### ##

  if gs_grade-zgrade > gv_worst_grade. "#### ##(##### # ##) ## ##

    gv_worst_grade = gs_grade-zgrade. " ## ## ##

  endif.



  at end of zcode.

    " ## ## ##

    clear gs_student.

    read table gt_student into gs_student

      with key zcode = gs_grade-zcode binary search.

    if sy-subrc ne 0. " #### ## ## ## ##

      continue. " ## ##### ##

    endif.



    " ## ## #### ### ### ##

    clear gs_result.

    gs_result-zcode = gs_student-zcode.

    gs_result-zkname = gs_student-zkname.

    if gv_transfer_flag = 'X'. " ### ### ##

      gs_result-ztransfer = '####'.

    endif.

    if gv_warning_flag = 'X'. " #### ## ### ##

      gs_result-zwarning = '####'.

      gs_result-ztel = gs_student-ztel.

    endif.

    append gs_result to gt_result.



    " ### ### ## collect

    clear gs_sum.

    gs_sum-zgender = gs_student-zgender.

    gs_sum-zsum = gv_rep_zsum.

    collect gs_sum into gt_sum.

  endat.

endloop.






* ### ### ## ##




sort gt_sum by zgender.

clear gs_sum.

read table gt_sum into gs_sum with key zgender = 'M' binary search.

if sy-subrc = 0.

  gv_total_m = gs_sum-zsum.

endif.

clear gs_sum.

read table gt_sum into gs_sum with key zgender = 'F' binary search.

if sy-subrc = 0.

  gv_total_f = gs_sum-zsum.

endif.








* ##




data : float_to_int type i.

data : gv_tel type zedt17_001-ztel. " #### ### ## ##



write : / 'READ##'.

write : /.

write : / '-----------------------------------------------------------------------------'.

write : / '|  ####   |   ##      |  ####   |   ####        |    ##     |'.

write : / '-----------------------------------------------------------------------------'.



loop at gt_result into gs_result.

  clear gv_tel.

  if gs_result-ztel ne ''.

    gv_tel = gs_result-ztel.

  endif.



  write: / '| ', gs_result-zcode,

          '| ', gs_result-zkname(10),

          '| ', gs_result-ztransfer,

          '| ', gv_tel,

          '| ', gs_result-zwarning(10), '|'.

  write : / '-----------------------------------------------------------------------------'.

endloop.



float_to_int = gv_total_m * 100.

write : / '### ###   : ', float_to_int.

float_to_int = gv_total_f * 100.

write : / '### ###   : ', float_to_int.