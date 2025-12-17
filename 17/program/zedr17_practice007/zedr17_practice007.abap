
*&---------------------------------------------------------------------*

*& Report ZEDR17_PRACTICE007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




report zedr17_practice007 message-id zmed17. " message ## ## ### ##



constants: c_flag_quit  type zedt17_102-zqflag value 'X'.  " ## ### (102-zqflag# '##' ###)

constants: c_rank_a     type zedt17_104-zrank  value 'A'.  " ## A ## ##

constants: c_bonus_a    type zedt17_106-zsalary value '500'. " A## ###(= 50,000#, ###=500.00)

constants: c_curr_krw   type c length 3 value 'KRW'.       " ####: ## ##

constants: c_alv_save   type c value 'A'.                  " ALV #### ## ##(A=##### ##)



tables : zedt17_102, zedt17_103, zedt17_104, zedt17_105, zedt17_106. " ### ##






*1. ###### alv ###

*- ####(102), ####(103),

*- ####(102), ###(102##### ##?), ###(102##### ##?), ###(102), ####(102),

*- ##(103), ##(103),

*- ####(106), ###(106##### ##?), ####(106)




data : begin of gs_result_emp,

         zpernr        type zedt17_102-zpernr,    " ####

         zpname        type zedt17_103-zpname,    " ####

         zdepcode      type zedt17_102-zdepcode,  " ####

         zdepname(20),               " ###(102 #### ##)

         zdeprank      type zedt17_102-zdeprank,  " ####

         zrankname(20),               " ###(102 #### ##)

         zedate        type zedt17_102-zedate,    " ###

         zqflag        type zedt17_102-zqflag,    " ####(##/##)

         zqdate        type zedt17_102-zqdate,   " ###

         zqtext(10),        " ####(##/##)

         zgentext(10),      " ## ###

         zgender       type zedt17_103-zgender,   " ##

         zaddress      type zedt17_103-zaddress,  " ##

         zbankcode     type zedt17_106-zbankcode, " ####

         zbankname(20),                " ###(106 #### ##)

         zaccount      type zedt17_106-zaccount,  " ####

       end of gs_result_emp.

data : gt_result_emp like table of gs_result_emp.






*2. #### alv ###

*- ####(102), ####(103),

*- ####(102), ###(102##### ##?), ###(102##### ##?), ###(102),

*- ####(106), ####(104), xx####(105)




data : begin of gs_result_eval,

         zpernr        type zedt17_102-zpernr,    " ####

         zpname        type zedt17_103-zpname,    " ####

         zdepcode      type zedt17_102-zdepcode,  " ####

         zdepname(20),  " ###(102 #### ##)

         zdeprank      type zedt17_102-zdeprank,  " ####

         zrankname(20), " ###(102 #### ##)

         zedate        type zedt17_102-zedate,    " ###

         zqflag        type zedt17_102-zqflag,    " ####(##/##)

         zqtext(10),  " ####(##/##)

         zqdate        type zedt17_102-zqdate, " ####

         zsalary       type zedt17_106-zsalary,   " ####(##)

         zevalrank     type zedt17_104-zrank,     " ####(104)

         zpay_month    type zedt17_105-zmon01,    " ## # ###(105)

       end of gs_result_eval.

data : gt_result_eval like table of gs_result_eval.



" ## ### ##

data : gv_first_date type sy-datum.

data : gv_last_date type sy-datum.






** selection screen: ## ## ## **




selection-screen begin of block b1 with frame.

select-options : s_zpernr for zedt17_102-zpernr. " ####

select-options : s_zedate for zedt17_102-zedate modif id m1. " ###(#### #)

parameters : p_zdep like zedt17_102-zdepcode modif id m1. " ####(##)

parameters : p_year type bkpf-gjahr default sy-datum(4) modif id m2. " yyyy(##/## #)

parameters : p_month type bkpf-monat default sy-datum+4(2) modif id m2. " mm(##/## #)

selection-screen end of block b1.



selection-screen begin of block b2 with frame.

parameters : pr_emp radiobutton group r1 default 'X' user-command uc1. " #### ### ##

parameters : pr_pay radiobutton group r1. " #### ### ##

parameters : pr_eval radiobutton group r1. " #### ### ##

selection-screen end of block b2.



selection-screen begin of block b3 with frame.

parameters : p_active as checkbox default 'X' modif id m1. " #### ##

selection-screen end of block b3.



initialization.

  concatenate sy-datum(4) '0101' into gv_first_date. " ## (yyyy0101)

  concatenate sy-datum(6) '01' into gv_last_date. " ## 1# (yyyymm01)



  " ## ## ### # ##

  call function 'RP_LAST_DAY_OF_MONTHS'

    exporting

      day_in            = gv_last_date

    importing

      last_day_of_month = gv_last_date.



  clear s_zedate.

  s_zedate-sign = 'I'. " ##

  s_zedate-option = 'BT'. " ##

  s_zedate-low = gv_first_date. " ##

  s_zedate-high = gv_last_date. " ##

  append s_zedate.



  p_active = 'X'. " ##### #### ## #.

  pr_emp = 'X'. " #### ##### ## #.



at selection-screen output.

  " ### ## ### ##

  data : lv_d_active(1). " #### ## ##(####)

  data : lv_ym_eval_active(1). " #/# ## ##(##/##)



  if pr_emp = 'X'. " #### ###### ### ##

    lv_d_active = '1'.     " ## ## on

    lv_ym_eval_active = '0'. " #/# off

  else. " #### or #### ###### ### ##

    lv_d_active = '0'.     " ## ## off

    lv_ym_eval_active = '1'. " #/# on

  endif.

  loop at screen.

    if screen-group1 = 'M1'.

      screen-active = lv_d_active. " #### ## ## ## ##

    elseif screen-group1 = 'M2'.

      screen-active = lv_ym_eval_active. "  #### or #### ## ## ## ##

    endif.

    modify screen.

  endloop.



at selection-screen.

  data : lv_all_empty(1) value 'X'.   " ## range# ## # ## flag

  if pr_emp = 'X'.   " #### ###### ### ##

    "s_zedate## # #### low/high# ### ## ok

    loop at s_zedate. " range###

      if s_zedate-low is not initial or s_zedate-high is not initial.

        lv_all_empty = ''.

        exit.

      endif.

    endloop.



    " # ## # #### ### ## ## ### ##

    if lv_all_empty = 'X'.

      message e000. " "##### ######" ##### ##.

      stop. " ## ### stop

    endif.

  else.   " #### or #### ###### ### ##

    if p_year is initial or p_month is initial.

      message e000. " '##### ######; ##### ##.

      stop.

    endif.

  endif.



start-of-selection.

  if pr_emp = 'X'. " #### ##

    perform get_emp_data. " #### ### ##

    perform alv_emp_display. " ## ##

  elseif pr_pay = 'X'. " ## ##

    perform pay_update. " ## ## ### update

  else. " #### ##

    perform get_eval_data. "#### ### ##

    perform alv_eval_display. " ## ##

  endif.






*&---------------------------------------------------------------------*

*&      Form  GET_EMP_DATA

*&---------------------------------------------------------------------*

* ####(M1) ##

* - 102(####) + 103(##) + 106(##/##) ## ##

* - ##(s_zpernr), ###(s_zedate), (##)####(p_zdep), (##)####(p_active='X')

* - gt_result_emp # ## # #### ##(CASE)

*&---------------------------------------------------------------------*




form get_emp_data .

  clear gt_result_emp.



  if p_zdep is initial and p_active <> 'X'. " #### ### + #### checkbox ## ## ##(##/## ##)

    " ## ## ## ## #### ## ##(##/###)# ##

    " ##+## ## ##

    select

        a~zpernr  a~zdepcode  a~zdeprank  a~zedate  a~zqflag a~zqdate

        b~zpname  b~zgender   b~zaddress

        c~zbankcode          c~zaccount

        from zedt17_102 as a

        inner join zedt17_103 as b on b~zpernr = a~zpernr

        left  outer join zedt17_106 as c on c~zpernr = a~zpernr

        into corresponding fields of table gt_result_emp

        where a~zpernr in s_zpernr " ## ##

          and a~zedate in s_zedate. " ### ##



  elseif p_zdep is initial and p_active = 'X'. " #### ### + '####' checkbox ##(####)

    "  ## ## ## ####, #### #### '###'#

    "  a~zqflag <> c_flag_quit (X=##, ##=##)

    select

      a~zpernr  a~zdepcode  a~zdeprank  a~zedate  a~zqflag a~zqdate

      b~zpname  b~zgender   b~zaddress

      c~zbankcode          c~zaccount

      from zedt17_102 as a

      inner join zedt17_103 as b on b~zpernr = a~zpernr

      left  outer join zedt17_106 as c on c~zpernr = a~zpernr

      into corresponding fields of table gt_result_emp

      where a~zpernr in s_zpernr

        and a~zedate in s_zedate

        and a~zqflag <> c_flag_quit. " ## ##

  elseif p_zdep is not initial and p_active <> 'X'. " ## ## ## + '####' ## # #(##/## ##)

    " ## ### ## ### ##, ##/## ## ##

    " ## + ## ## (zqflag ## ##)

    " '##### ## # ## ##(### ##) ## ##'

    select

      a~zpernr  a~zdepcode  a~zdeprank  a~zedate  a~zqflag a~zqdate

      b~zpname  b~zgender   b~zaddress

      c~zbankcode          c~zaccount

      from zedt17_102 as a

      inner join zedt17_103 as b on b~zpernr = a~zpernr

      left  outer join zedt17_106 as c on c~zpernr = a~zpernr

      into corresponding fields of table gt_result_emp

      where a~zpernr  in s_zpernr

        and a~zedate  in s_zedate

        and a~zdepcode =  p_zdep. " ## ###



  else.

    " ## ## ## + '####' ##

    " ## ## + ## ## ## ###

    " a~zqflag <> c_flag_quit (## ##)

    select

      a~zpernr  a~zdepcode  a~zdeprank  a~zedate  a~zqflag a~zqdate

      b~zpname  b~zgender   b~zaddress

      c~zbankcode          c~zaccount

      from zedt17_102 as a

      inner join zedt17_103 as b on b~zpernr = a~zpernr

      left  outer join zedt17_106 as c on c~zpernr = a~zpernr

      into corresponding fields of table gt_result_emp

      where a~zpernr  in s_zpernr

        and a~zedate  in s_zedate

        and a~zdepcode =  p_zdep

        and a~zqflag   <> c_flag_quit. " ####+####

  endif.



  " p_active #### #: #### ## ## ## ##(= ### # ##)# ## ##

  if p_active <> 'X'.

    delete gt_result_emp where zqflag = 'X'

                           and zqdate is not initial

                           and zqdate <= s_zedate-high. " #### ## ## ### ## ##

  endif.



  " ### -> #### ##

  loop at gt_result_emp into gs_result_emp.

    perform map_emp_texts using

      gs_result_emp-zdepcode

      gs_result_emp-zdeprank

      gs_result_emp-zbankcode

      gs_result_emp-zqflag

      gs_result_emp-zgender

    changing

      gs_result_emp-zdepname

      gs_result_emp-zrankname

      gs_result_emp-zbankname

      gs_result_emp-zqtext   " ##/## ####

      gs_result_emp-zgentext. " ##/## ####

    modify gt_result_emp from gs_result_emp.

  endloop.



endform.




*&---------------------------------------------------------------------*

*&      Form  alv_emp_display

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




form alv_emp_display .



  " ### ### ### ## # ##

  if gt_result_emp is initial.

    message '### #### ####.' type 'E'. " # ## ##

    exit.

  endif.



  " ALV ## ### ##

  data : gs_fieldcat type slis_fieldcat_alv.

  data : gt_fieldcat type slis_t_fieldcat_alv.

  data : gs_layout   type slis_layout_alv.  " layout

  data : gs_sort     type slis_sortinfo_alv.  " sort

  data : gt_sort     type slis_t_sortinfo_alv.



  clear : gs_fieldcat, gt_fieldcat.



  " ## #### ##(## ## ##)

  gs_fieldcat-col_pos = 1.

  gs_fieldcat-fieldname = 'ZPERNR'.

  gs_fieldcat-seltext_m = '####'.

  gs_fieldcat-key = 'X'. " ##

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  gs_fieldcat-col_pos = 2.

  gs_fieldcat-fieldname = 'ZPNAME'.

  gs_fieldcat-seltext_m = '####'.

  gs_fieldcat-key = 'X'. " ##

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZDEPCODE'.

  gs_fieldcat-seltext_m = '####'.

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZDEPNAME'.

  gs_fieldcat-seltext_m = '###'.

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZRANKNAME'.

  gs_fieldcat-seltext_m = '###'.

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  gs_fieldcat-col_pos = 5.

  gs_fieldcat-fieldname = 'ZEDATE'.

  gs_fieldcat-seltext_m = '###'.

  gs_fieldcat-outputlen = 10.

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'ZQTEXT'.

  gs_fieldcat-seltext_m = '####'.

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  gs_fieldcat-col_pos = 7.

  gs_fieldcat-fieldname = 'ZGENTEXT'.

  gs_fieldcat-seltext_m = '##'.

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  gs_fieldcat-col_pos = 8.

  gs_fieldcat-fieldname = 'ZADDRESS'.

  gs_fieldcat-seltext_m = '##'.

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  gs_fieldcat-col_pos = 9.

  gs_fieldcat-fieldname = 'ZBANKNAME'.

  gs_fieldcat-seltext_m = '###'.

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  gs_fieldcat-col_pos = 10.

  gs_fieldcat-fieldname = 'ZACCOUNT'.

  gs_fieldcat-seltext_m = '####'.

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  " #### ####(s_zedate-high)## # ## ## ##

  delete gt_result_emp where zedate > s_zedate-high.



  " ####: ###(zebra), # ##

  clear gs_layout.

  gs_layout-colwidth_optimize = 'X'.

  gs_layout-zebra             = 'X'.



  " ##: ## ##

  clear gt_sort.

  gs_sort-spos = 3.

  gs_sort-fieldname = 'ZPERNR'.

  gs_sort-up = 'X'.

  append gs_sort to gt_sort.



  " ALV ##

  call function 'REUSE_ALV_GRID_DISPLAY'

    exporting

      i_callback_program = sy-repid

      it_fieldcat        = gt_fieldcat

      is_layout          = gs_layout

      it_sort            = gt_sort

      i_save             = c_alv_save " ### #### ## ##

    tables

      t_outtab           = gt_result_emp

    exceptions

      program_error      = 1

      others             = 2.



  if sy-subrc <> 0.

    message 'ALV ## # ### ######.' type 'E'.

  endif.

endform.




*&---------------------------------------------------------------------*

*&      Form  MAP_EMP_TEXTS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




" ####, ####, ####, ####, ## ## -> ### ##

form map_emp_texts using    p_zdepcode  type zedt17_102-zdepcode   " ####

                              p_zdeprank  type zedt17_102-zdeprank   " ####

                              p_zbankcode type zedt17_106-zbankcode  " ####

                              p_zqflag    type zedt17_102-zqflag     " ####

                              p_zgender   type zedt17_103-zgender    " ##

                    changing  p_zdepname

                              p_zrankname

                              p_zbankname

                              p_zqtext

                              p_zgentext.



  " ### ##

  case p_zdepcode.

    when 'SS0001'. p_zdepname = '###'.

    when 'SS0002'. p_zdepname = '###'.

    when 'SS0003'. p_zdepname = '###'.

    when 'SS0004'. p_zdepname = '###'.

    when 'SS0005'. p_zdepname = '###'.

    when 'SS0006'. p_zdepname = '###'.

  endcase.



  " ### ##

  case p_zdeprank.

    when 'A'. p_zrankname = '##'.

    when 'B'. p_zrankname = '##'.

    when 'C'. p_zrankname = '##'.

    when 'D'. p_zrankname = '##'.

    when 'E'. p_zrankname = '##'.

    when 'F'. p_zrankname = '##'.

    when 'G'. p_zrankname = '##'.

  endcase.



  " ### ##

  case p_zbankcode.

    when '001'. p_zbankname = '##'.

    when '002'. p_zbankname = '##'.

    when '003'. p_zbankname = '##'.

    when '004'. p_zbankname = '##'.

    when '005'. p_zbankname = '###'.

  endcase.



  " #### ##

  if p_zqflag = 'X'.

    p_zqtext = '##'.

  else.

    p_zqtext = '##'.

  endif.



  " ## ##

  if p_zgender = 'M'.

    p_zgentext = '##'.

  elseif p_zgender = 'F'.

    p_zgentext = '##'.

  endif.

endform.




*&---------------------------------------------------------------------*

*&      Form  GET_EVAL_DATA

*&---------------------------------------------------------------------*

* ####(M2) ##

* - 102(##) + 103(##) + 104(##) + 106(##)

* - 105(##)# ## #### ## ### ##

* - ### 0## ## ##

* - ###, ### #### (PERFORM map_emp_texts)

* - ## ### ##(#)# ##

*----------------------------------------------------------------------*




form get_eval_data .

  clear gt_result_eval.

  p_active = space. " ##### ### ###(#### ## # ### #### ##)



  " ####/## ## ##

  data: lv_mon_first type sy-datum.

  data: lv_mon_last  type sy-datum.



  concatenate p_year p_month '01' into lv_mon_first.

  call function 'RP_LAST_DAY_OF_MONTHS'

    exporting

      day_in            = lv_mon_first

    importing

      last_day_of_month = lv_mon_last.



  " ##/## ## + ## ## ### ## ## (### # 4#)

  if p_zdep is initial and p_active <> 'X'.  " case 1 : ## X, #### X

    if s_zpernr is initial.

      select a~zpernr a~zdepcode a~zdeprank a~zedate a~zqflag a~zqdate

             b~zpname

             c~zrank  as zevalrank

             d~zsalary

        into corresponding fields of table gt_result_eval

        from zedt17_102 as a

        inner join zedt17_103 as b on b~zpernr = a~zpernr

        inner join zedt17_104 as c on c~zpernr = a~zpernr

        left  outer join zedt17_106 as d on d~zpernr = a~zpernr

        where a~zedate <= lv_mon_last.

    else.

      select a~zpernr a~zdepcode a~zdeprank a~zedate a~zqflag a~zqdate

             b~zpname

             c~zrank  as zevalrank

             d~zsalary

        into corresponding fields of table gt_result_eval

        from zedt17_102 as a

        inner join zedt17_103 as b on b~zpernr = a~zpernr

        inner join zedt17_104 as c on c~zpernr = a~zpernr

        left  outer join zedt17_106 as d on d~zpernr = a~zpernr

        where a~zpernr in s_zpernr

          and a~zedate <= lv_mon_last.

    endif.



  elseif p_zdep is initial and p_active = 'X'. " case 2 : ## X, ####

    if s_zpernr is initial.

      select a~zpernr a~zdepcode a~zdeprank a~zedate a~zqflag a~zqdate

             b~zpname

             c~zrank  as zevalrank

             d~zsalary

        into corresponding fields of table gt_result_eval

        from zedt17_102 as a

        inner join zedt17_103 as b on b~zpernr = a~zpernr

        inner join zedt17_104 as c on c~zpernr = a~zpernr

        left  outer join zedt17_106 as d on d~zpernr = a~zpernr

        where a~zedate <= lv_mon_last

          and a~zqflag <> c_flag_quit.

    else.

      select a~zpernr a~zdepcode a~zdeprank a~zedate a~zqflag a~zqdate

             b~zpname

             c~zrank  as zevalrank

             d~zsalary

        into corresponding fields of table gt_result_eval

        from zedt17_102 as a

        inner join zedt17_103 as b on b~zpernr = a~zpernr

        inner join zedt17_104 as c on c~zpernr = a~zpernr

        left  outer join zedt17_106 as d on d~zpernr = a~zpernr

        where a~zpernr in s_zpernr

          and a~zedate <= lv_mon_last

          and a~zqflag <> c_flag_quit.

    endif.



  elseif p_zdep is not initial and p_active <> 'X'.  " case 3 : ## O, #### X

    if s_zpernr is initial.

      select a~zpernr a~zdepcode a~zdeprank a~zedate a~zqflag a~zqdate

             b~zpname

             c~zrank  as zevalrank

             d~zsalary

        into corresponding fields of table gt_result_eval

        from zedt17_102 as a

        inner join zedt17_103 as b on b~zpernr = a~zpernr

        inner join zedt17_104 as c on c~zpernr = a~zpernr

        left  outer join zedt17_106 as d on d~zpernr = a~zpernr

        where a~zedate  <= lv_mon_last

          and a~zdepcode = p_zdep.

    else.

      select a~zpernr a~zdepcode a~zdeprank a~zedate a~zqflag a~zqdate

             b~zpname

             c~zrank  as zevalrank

             d~zsalary

        into corresponding fields of table gt_result_eval

        from zedt17_102 as a

        inner join zedt17_103 as b on b~zpernr = a~zpernr

        inner join zedt17_104 as c on c~zpernr = a~zpernr

        left  outer join zedt17_106 as d on d~zpernr = a~zpernr

        where a~zpernr  in s_zpernr

          and a~zedate  <= lv_mon_last

          and a~zdepcode = p_zdep.

    endif.



  else.  " case 4 : ## O, ####

    if s_zpernr is initial.

      select a~zpernr a~zdepcode a~zdeprank a~zedate a~zqflag a~zqdate

             b~zpname

             c~zrank  as zevalrank

             d~zsalary

        into corresponding fields of table gt_result_eval

        from zedt17_102 as a

        inner join zedt17_103 as b on b~zpernr = a~zpernr

        inner join zedt17_104 as c on c~zpernr = a~zpernr

        left  outer join zedt17_106 as d on d~zpernr = a~zpernr

        where a~zedate  <= lv_mon_last

          and a~zdepcode = p_zdep

          and a~zqflag <> c_flag_quit.

    else.

      select a~zpernr a~zdepcode a~zdeprank a~zedate a~zqflag a~zqdate

             b~zpname

             c~zrank  as zevalrank

             d~zsalary

        into corresponding fields of table gt_result_eval

        from zedt17_102 as a

        inner join zedt17_103 as b on b~zpernr = a~zpernr

        inner join zedt17_104 as c on c~zpernr = a~zpernr

        left  outer join zedt17_106 as d on d~zpernr = a~zpernr

        where a~zpernr  in s_zpernr

          and a~zedate  <= lv_mon_last

          and a~zdepcode = p_zdep

          and a~zqflag   <> 'X'.

    endif.

  endif.



  " ####(# changing #### ####, ## ## ##)

  data: lv_bankname(20).

  data: lv_gtext(10).

  data: lv_qtext(10).



  " ## ## + 0# ## + ##/## ##

  data lv_pay type zedt17_105-zmon01.

  " # ###(# ##) ##: '01' ~ '12'

  data lv_mon2(2).

  lv_mon2 = p_month.

  condense lv_mon2 no-gaps.

  if strlen( lv_mon2 ) = 1.

    concatenate '0' lv_mon2 into lv_mon2.

  endif.





  loop at gt_result_eval into gs_result_eval.






*** ### ## ***




   " field symbol ## #### #### ##

    data: ls_month type zedt17_105. " zedt17_105#### # ## ## ###

    data: lv_fieldname type fieldname. " ### ### ## ## ( ex. ZMON01 ~ ZMON12)

    field-symbols: <f_pay> type any. " lv_fieldname## ### ##### ### ## ##(generic)



    " ## ### ## ## ## ### 1# ##

    select single * into ls_month

      from zedt17_105

      where zpernr = gs_result_eval-zpernr

      and zyear  = p_year.



    " ZMON01 ~ ZMON12 ## ### ## # # ##

    concatenate 'ZMON' lv_mon2 into lv_fieldname. " lv_mon2# ## '01'~'12'

    " ### ls_month ### ### lv_fieldname# ##### <f_pay># ###

    assign component lv_fieldname of structure ls_month to <f_pay>.

    if <f_pay> is assigned. " ### ###

      lv_pay = <f_pay>. " ## ## ## ## lv_pay# ##

    else.

      clear lv_pay. " ### #### ###

    endif.




*** ### ## ***



*    clear lv_pay.

*

*    " ### ## ### ## ##

*    case lv_mon2.

*      when '01'.

*        select single zmon01 into lv_pay

*          from zedt17_105

*          where zpernr = gs_result_eval-zpernr

*            and zyear  = p_year.

*      when '02'.

*        select single zmon02 into lv_pay

*          from zedt17_105

*          where zpernr = gs_result_eval-zpernr

*            and zyear  = p_year.

*      when '03'.

*        select single zmon03 into lv_pay

*          from zedt17_105

*          where zpernr = gs_result_eval-zpernr

*            and zyear  = p_year.

*      when '04'.

*        select single zmon04 into lv_pay

*          from zedt17_105

*          where zpernr = gs_result_eval-zpernr

*            and zyear  = p_year.

*      when '05'.

*        select single zmon05 into lv_pay

*          from zedt17_105

*          where zpernr = gs_result_eval-zpernr

*            and zyear  = p_year.

*      when '06'.

*        select single zmon06 into lv_pay

*          from zedt17_105

*          where zpernr = gs_result_eval-zpernr

*            and zyear  = p_year.

*      when '07'.

*        select single zmon07 into lv_pay

*          from zedt17_105

*          where zpernr = gs_result_eval-zpernr

*            and zyear  = p_year.

*      when '08'.

*        select single zmon08 into lv_pay

*          from zedt17_105

*          where zpernr = gs_result_eval-zpernr

*            and zyear  = p_year.

*      when '09'.

*        select single zmon09 into lv_pay

*          from zedt17_105

*          where zpernr = gs_result_eval-zpernr

*            and zyear  = p_year.

*      when '10'.

*        select single zmon10 into lv_pay

*          from zedt17_105

*          where zpernr = gs_result_eval-zpernr

*            and zyear  = p_year.

*      when '11'.

*        select single zmon11 into lv_pay

*          from zedt17_105

*          where zpernr = gs_result_eval-zpernr

*            and zyear  = p_year.

*      when '12'.

*        select single zmon12 into lv_pay

*          from zedt17_105

*          where zpernr = gs_result_eval-zpernr

*            and zyear  = p_year.

*    endcase.






    " ## ##(lv_mon_last) #### ## ##### 0# ##(## ## ##)

    if gs_result_eval-zqflag = 'X'

       and gs_result_eval-zqdate is not initial

       and gs_result_eval-zqdate <= lv_mon_last.

      lv_pay = 0.

    endif.



    " 0## ##### ## (## ##)

    if lv_pay is initial or lv_pay = 0.

      delete gt_result_eval index sy-tabix.

      continue.

    endif.



    " ### ##

    gs_result_eval-zpay_month = lv_pay.



    " ### ## (##/##/###### ##)

    perform map_emp_texts using

      gs_result_eval-zdepcode

      gs_result_eval-zdeprank

      space

      gs_result_eval-zqflag

      space

    changing

      gs_result_eval-zdepname

      gs_result_eval-zrankname

      lv_bankname " ## ### ##

      lv_qtext  " ##/## ### ##

      lv_gtext.  " ## ### ##



    gs_result_eval-zqtext = lv_qtext.

    modify gt_result_eval from gs_result_eval.

  endloop.



endform.








*&---------------------------------------------------------------------*

*&      Form  ALV_EVAL_DISPLAY

*&---------------------------------------------------------------------*




form alv_eval_display .

  " ### ### ## # ##

  if gt_result_eval is initial.

    message '### ## #### ####.' type 'E'.

    exit.

  endif.



  data: gs_fieldcat type slis_fieldcat_alv.

  data: gt_fieldcat type slis_t_fieldcat_alv.

  data: gs_layout type slis_layout_alv.

  data: gs_sort type slis_sortinfo_alv.

  data : gt_sort type slis_t_sortinfo_alv.



  clear: gs_fieldcat, gt_fieldcat.



  " 1) ####

  gs_fieldcat-col_pos   = 1.

  gs_fieldcat-fieldname = 'ZPERNR'.

  gs_fieldcat-seltext_m = '####'.

  gs_fieldcat-key = 'X'.

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  " 2) ####

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-fieldname = 'ZPNAME'.

  gs_fieldcat-seltext_m = '####'.

  gs_fieldcat-key = 'X'.

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  " 3) ####

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZDEPCODE'.

  gs_fieldcat-seltext_m = '####'.

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  " 4) ###

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZDEPNAME'.

  gs_fieldcat-seltext_m = '###'.

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  " 5) ###

  gs_fieldcat-col_pos = 5.

  gs_fieldcat-fieldname = 'ZRANKNAME'.

  gs_fieldcat-seltext_m = '###'.

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  " 6) ###

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'ZEDATE'.

  gs_fieldcat-seltext_m = '###'.

  gs_fieldcat-outputlen = 10.

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  " 7) ####(##) ##/##

  gs_fieldcat-col_pos = 7.

  gs_fieldcat-fieldname = 'ZSALARY'.

  gs_fieldcat-seltext_m = '####'.

  gs_fieldcat-do_sum = 'X'.

  gs_fieldcat-currency = c_curr_krw.

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  " 8) ####

  gs_fieldcat-col_pos   = 8.

  gs_fieldcat-fieldname = 'ZEVALRANK'.

  gs_fieldcat-seltext_m = '####'.

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  " 9) ### ### ##/## (### ### ##)

  gs_fieldcat-col_pos   = 9.

  gs_fieldcat-fieldname = 'ZPAY_MONTH'.

  gs_fieldcat-seltext_m = |{ p_month }####|.

  gs_fieldcat-do_sum    = 'X'.

  gs_fieldcat-currency  = c_curr_krw.

  append gs_fieldcat to gt_fieldcat.

  clear gs_fieldcat.



  " ####(zebre/####)

  clear gs_layout.

  gs_layout-colwidth_optimize = 'X'.

  gs_layout-zebra             = 'X'.



  " ##: ##

  clear: gt_sort.

  gs_sort-spos = 1.

  gs_sort-fieldname = 'ZPERNR'.

  gs_sort-up = 'X'.

  append gs_sort to gt_sort.



  call function 'REUSE_ALV_GRID_DISPLAY'

    exporting

      i_callback_program = sy-repid

      it_fieldcat        = gt_fieldcat

      is_layout          = gs_layout

      it_sort            = gt_sort

      i_save             = c_alv_save

    tables

      t_outtab           = gt_result_eval

    exceptions

      program_error      = 1

      others             = 2.



endform.




*&---------------------------------------------------------------------*

*&      Form  PAY_UPDATE

*&---------------------------------------------------------------------*

* 13-2. ####

* 1) ALV ## ##. ##/## ###

* 2) ## # ZMONXX# UPDATE (CASE ##)

* 3) #### ## (#: 3# ## # 3# ## ##)

* 4) ## ## ##### #### ##

* 5) ## = ##/12, ## A# +50,000

* 6) ZEDT17_105 CURR #### ## ##(#: 1000# # 10.00## /100 ##)

* 7) ## # # 1#### ## # ## ### ##

* 8) 0## ###### ##

*---------------------------------------------------------------------*




form pay_update .



  " #### ##

  if p_year is initial or p_month is initial.

    message e000.   " ##### ######

  endif.



  " ## ## ## ##

  data: lv_mon_first type sy-datum.

  data: lv_mon_last  type sy-datum.



  concatenate p_year p_month '01' into lv_mon_first.

  call function 'RP_LAST_DAY_OF_MONTHS'

    exporting

      day_in            = lv_mon_first

    importing

      last_day_of_month = lv_mon_last.



  " #(# ##) ###: '01' ~ '12'

  data lv_mon2(2).

  lv_mon2 = p_month.

  condense lv_mon2 no-gaps.

  if strlen( lv_mon2 ) = 1.

    concatenate '0' lv_mon2 into lv_mon2.

  endif.



  " #### ## ## (## ## ## ##)

  data: begin of gs_cand,

          zpernr   type zedt17_102-zpernr,

          zdepcode type zedt17_102-zdepcode,

          zdeprank type zedt17_102-zdeprank,

          zedate   type zedt17_102-zedate,

          zqflag   type zedt17_102-zqflag,

          zqdate   type zedt17_102-zqdate,

          zyear    type zedt17_104-zyear,

          zrank    type zedt17_104-zrank,

          zsalary  type zedt17_106-zsalary,

        end of gs_cand.

  data: gt_cand like table of gs_cand.



  " #### ##

  " - ### <= ### ##

  " - #### ### ### ##

  " - ##(104) ## = p_year, ##(106) ## = p_year

  clear gt_cand.



  if p_zdep is initial.

    select a~zpernr a~zdepcode a~zdeprank a~zedate a~zqflag a~zqdate

           c~zyear  c~zrank

           d~zsalary

      into corresponding fields of table gt_cand

      from zedt17_102 as a

      inner join zedt17_104 as c on c~zpernr = a~zpernr

      inner join zedt17_106 as d on d~zpernr = a~zpernr

      where a~zedate <= lv_mon_last

        and c~zyear  =  p_year

        and d~zyear  =  p_year.

  else.

    select a~zpernr a~zdepcode a~zdeprank a~zedate a~zqflag a~zqdate

           c~zyear  c~zrank

           d~zsalary

      into corresponding fields of table gt_cand

      from zedt17_102 as a

      inner join zedt17_104 as c on c~zpernr = a~zpernr

      inner join zedt17_106 as d on d~zpernr = a~zpernr

      where a~zedate  <= lv_mon_last

        and a~zdepcode =  p_zdep

        and c~zyear   =  p_year

        and d~zyear   =  p_year.

  endif.



  if gt_cand is initial.

    message i002.   " #### ### ####.

    exit.

  endif.



  " ### 105 # # ## + ### ##

  data: ls_pay    type zedt17_105.

  data: lv_amount type zedt17_105-zmon01.   " ### ## (CURR)

  data: lv_raw    type zedt17_106-zsalary.  " ##(CURR)



  data lv_failed type c value space.



  " ## ##

  loop at gt_cand into gs_cand.



    " #### ##: ### ## #### #### ### #### ##

    check not ( gs_cand-zqflag = c_flag_quit

      and gs_cand-zqdate is not initial

      and gs_cand-zqdate <= lv_mon_last ).



    " #### = ##/12

    clear: lv_raw, lv_amount.

    " ##/12

    lv_raw = gs_cand-zsalary / 12.



    " A## ###: 50,000# = 500.00(CURR ###)

    if gs_cand-zrank = c_rank_a.

      lv_raw = lv_raw + c_bonus_a.

    endif.



    " 0### ##(#### ## ##)

    if lv_raw <= 0.

      continue.

    endif.



    lv_amount = lv_raw. " ### ##### ### ##



    " ##### #### ### ##/#### ##

    clear ls_pay.

    select single * into ls_pay

      from zedt17_105

      where zpernr = gs_cand-zpernr

        and zyear  = p_year.



    data lv_exist type c value space.

    if sy-subrc = 0.

      lv_exist = 'X'. " ## ### ##

    else.

      clear ls_pay. " ## ###

      ls_pay-zpernr = gs_cand-zpernr.

      ls_pay-zyear  = p_year.

    endif.



    " ## ## CASE# ####

    case lv_mon2.

      when '01'. ls_pay-zmon01 = lv_amount.

      when '02'. ls_pay-zmon02 = lv_amount.

      when '03'. ls_pay-zmon03 = lv_amount.

      when '04'. ls_pay-zmon04 = lv_amount.

      when '05'. ls_pay-zmon05 = lv_amount.

      when '06'. ls_pay-zmon06 = lv_amount.

      when '07'. ls_pay-zmon07 = lv_amount.

      when '08'. ls_pay-zmon08 = lv_amount.

      when '09'. ls_pay-zmon09 = lv_amount.

      when '10'. ls_pay-zmon10 = lv_amount.

      when '11'. ls_pay-zmon11 = lv_amount.

      when '12'. ls_pay-zmon12 = lv_amount.

    endcase.



    " ##: ### MODIFY, ### INSERT

    if lv_exist = 'X'.

      modify zedt17_105 from ls_pay.

    else.

      insert zedt17_105 from ls_pay.

    endif.



    " ## ## # ## ## -> ##

    if sy-subrc <> 0.

      lv_failed = 'X'.

      exit.

    endif.



  endloop.



  "  #### ###. ##/## # ###

  if lv_failed = 'X'.

    rollback work.

    message e003.   " #### ##

  else.

    commit work.

    message s004.   " ### #######.

  endif.



endform.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### #### ####.