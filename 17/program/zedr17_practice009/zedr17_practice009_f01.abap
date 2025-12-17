
*&---------------------------------------------------------------------*

*&  Include           ZEDR17_PRACTICE009_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form set_init .

  "## # 1# ##

  gv_mon_first = sy-datum.

  gv_mon_first+6(2) = '01'.

  " ## # ## ##

  call function 'RP_LAST_DAY_OF_MONTHS'

    exporting

      day_in            = gv_mon_first

    importing

      last_day_of_month = gv_mon_last




*    exceptions

*     day_in_no_date    = 1

*     others            = 2




    .

  if sy-subrc <> 0.




*   message id sy-msgid type sy-msgty number sy-msgno

*              with sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.




  endif.



  p_date = gv_mon_last.

endform.




*&---------------------------------------------------------------------*

*&      Form  SET_INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form set_input .

  if p_date is initial. " #### ## ##

    message i005. " '##### ######.' ### ## # ##

    stop.

  endif.

  if s_zpernr[] is initial and p_zdepcd is initial. " #### or #### # ## ##

    message i006. " '#### ## #### # ## 1## #### ###.' ### ## # ##

    stop.

  endif.

endform.




*&---------------------------------------------------------------------*

*&      Form  SET_ZQFLAG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form set_zqflag .

  " ### ## ## -> r_zqflag ##

  clear r_zqflag.

  clear r_zqflag[]. "  ### ## ## ##



  r_zqflag-sign = 'I'. " ##

  r_zqflag-option = 'EQ'. " =

  r_zqflag-low = ' '. " ##: ###

  append r_zqflag.



  if p_zqflag = 'X'.

    r_zqflag-low = 'X'. " ###

    append r_zqflag.

  endif.



endform.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form get_data .

  perform get_emp_data. " 1# - ##/##

  if gt_emp[] is initial.

    message i001. " '## # #### ####.' ##

    exit.

  endif.



  perform get_eval_data using p_date. "2# - ##

  perform get_salary_data using p_date. "3# - ##



endform.




*&---------------------------------------------------------------------*

*&      Form  GET_EMP_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form get_emp_data .

  clear gt_emp.

  " datbi(##) <= p_date AND datab(##) >= p_date

  " ####: a~zqflag IN r_zqflag

  if s_zpernr[] is not initial and p_zdepcd is initial.

    " ##### ##

    select a~zpernr a~zdepcode a~datbi a~datab a~zdeprank

           a~zedate  a~zqdate  a~zqflag

           b~zpname  b~zgender b~zaddress

      into corresponding fields of table gt_emp

      from zedt17_102 as a

      inner join zedt17_103 as b on b~zpernr = a~zpernr

      where a~datbi <= p_date

        and a~datab >= p_date

        and a~zpernr in s_zpernr

        and a~zqflag in r_zqflag.



  elseif s_zpernr[] is initial and p_zdepcd is not initial.

    " ##### ##

    select a~zpernr a~zdepcode a~datbi a~datab a~zdeprank

           a~zedate  a~zqdate  a~zqflag

           b~zpname  b~zgender b~zaddress

      into corresponding fields of table gt_emp

      from zedt17_102 as a

      inner join zedt17_103 as b on b~zpernr = a~zpernr

      where a~datbi <= p_date

        and a~datab >= p_date

        and a~zdepcode = p_zdepcd

        and a~zqflag in r_zqflag.



  else.

    " # # ##(###)

    select a~zpernr a~zdepcode a~datbi a~datab a~zdeprank

           a~zedate  a~zqdate  a~zqflag

           b~zpname  b~zgender b~zaddress

      into corresponding fields of table gt_emp

      from zedt17_102 as a

      inner join zedt17_103 as b on b~zpernr = a~zpernr

      where a~datbi <= p_date

        and a~datab >= p_date

        and a~zpernr in s_zpernr

        and a~zdepcode = p_zdepcd

        and a~zqflag in r_zqflag.

  endif.

endform.




*&---------------------------------------------------------------------*

*&      Form  GET_EVAL_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_P_DATE  text

*----------------------------------------------------------------------*




form get_eval_data  using p_ref_date type d.

  clear gt_eval.

  if gt_emp is initial.

    exit. " 1# ## ### #### ##

  endif.



  select zpernr zdepcode zyear datbi datab zrank

    into corresponding fields of table gt_eval

    from zedt17_104

    for all entries in gt_emp

    where zpernr = gt_emp-zpernr

      and datbi  <= p_ref_date

      and datab  >= p_ref_date.



endform.




*&---------------------------------------------------------------------*

*&      Form  GET_SALARY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_P_DATE  text

*----------------------------------------------------------------------*




form get_salary_data  using p_ref_date type d.

  clear gt_salary.

  if gt_emp is initial.

    exit.

  endif.



  select zpernr zyear datbi datab zsalary zbankcode zaccount

    into corresponding fields of table gt_salary

    from zedt17_106

    for all entries in gt_emp

    where zpernr = gt_emp-zpernr

      and datbi  <= p_ref_date

      and datab  >= p_ref_date.

endform.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form modify_data .

  " 1# ### (####)

  clear: gs_emp, gs_001, gt_001[].



  loop at gt_emp into gs_emp.

    move-corresponding gs_emp to gs_001.



    perform map_emp_texts using gs_emp-zdepcode   "##

                                 gs_emp-zdeprank  "##

                                 gs_emp-zgender   "##

                                 gs_emp-zqflag    "####

                           changing gs_001-zdep_txt

                                    gs_001-zrank_txt

                                    gs_001-zgen_txt

                                    gs_001-zcolor.



    append gs_001 to gt_001.

    clear: gs_emp, gs_001.

  endloop.





  " 2# ### (##)

  clear: gs_eval, gs_002, gt_002[].



  loop at gt_eval into gs_eval.

    move-corresponding gs_eval to gs_002.



    perform map_eval_texts using gs_eval-zdepcode

                           changing gs_002-zdep_txt.



    append gs_002 to gt_002.

    clear: gs_eval, gs_002.

  endloop.





  " 3# ### (##)

  clear: gs_salary, gs_003, gt_003[].



  loop at gt_salary into gs_salary.

    move-corresponding gs_salary to gs_003.



    perform map_salary_texts using gs_salary-zbankcode

                             changing gs_003-zbank_txt.



    append gs_003 to gt_003.

    clear: gs_salary, gs_003.

  endloop.



endform.




*&---------------------------------------------------------------------*

*&      Form  MAP_EMP_TEXTS

*&---------------------------------------------------------------------*




form map_emp_texts  using    p_depcode

                             p_rank

                             p_gender

                             p_qflag

                    changing p_dep_txt

                             p_rank_txt

                             p_gender_txt

                             p_color.



  "#### ##

  case p_depcode.

    when 'SS0001'. p_dep_txt = '###'.

    when 'SS0002'. p_dep_txt = '###'.

    when 'SS0003'. p_dep_txt = '###'.

    when 'SS0004'. p_dep_txt = '###'.

    when 'SS0005'. p_dep_txt = '###'.

    when 'SS0006'. p_dep_txt = '###'.

  endcase.



  "## ##

  case p_rank.

    when 'A'. p_rank_txt = '##'.

    when 'B'. p_rank_txt = '##'.

    when 'C'. p_rank_txt = '##'.

    when 'D'. p_rank_txt = '##'.

    when 'E'. p_rank_txt = '##'.

    when 'F'. p_rank_txt = '##'.

    when 'G'. p_rank_txt = '##'.

  endcase.



  "## ##

  if p_gender = 'M'.

    p_gender_txt = '##'.

  elseif p_gender = 'F'.

    p_gender_txt = '##'.

  else.

    clear p_gender_txt. " ## ### ##

  endif.



  " ###: ###=##, ##=##, ###=##

  if p_qflag = 'X'.

    p_color = c_col_red.     " '@0A@'

  elseif p_rank = 'A'.

    p_color = c_col_yellow. " '@09@'

  else.

    p_color = c_col_green.   " '@08@'

  endif.



endform.




*&---------------------------------------------------------------------*

*&      Form  MAP_EVAL_TEXTS

*&---------------------------------------------------------------------*




form map_eval_texts  using    p_depcode

                     changing p_dep_txt.

  case p_depcode.

    when 'SS0001'. p_dep_txt = '###'.

    when 'SS0002'. p_dep_txt = '###'.

    when 'SS0003'. p_dep_txt = '###'.

    when 'SS0004'. p_dep_txt = '###'.

    when 'SS0005'. p_dep_txt = '###'.

    when 'SS0006'. p_dep_txt = '###'.

  endcase.

endform.




*&---------------------------------------------------------------------*

*&      Form  MAP_SALARY_TEXTS

*&---------------------------------------------------------------------*




form map_salary_texts  using    p_bank

                       changing p_bank_txt.

  case p_bank.

    when '001'. p_bank_txt = '####'.

    when '002'. p_bank_txt = '####'.

    when '003'. p_bank_txt = '####'.

    when '004'. p_bank_txt = '####'.

    when '005'. p_bank_txt = '#####'.

  endcase.

endform.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form create_object .

  create object gc_docking

    exporting




*     parent    =




      repid     = sy-repid

      dynnr     = sy-dynnr




*     side      = DOCK_AT_LEFT




      extension = 2000.




*    style                       =

*    lifetime                    = lifetime_default

*    caption                     =

*    metric                      = 0

*    ratio                       =

*    no_autodef_progid_dynnr     =

*    name                        =

*  exceptions

*    cntl_error                  = 1

*    cntl_system_error           = 2

*    create_error                = 3

*    lifetime_error              = 4

*    lifetime_dynpro_dynpro_link = 5

*    others                      = 6




  .



  create object gc_splitter_main " ## ##

    exporting




*     link_dynnr        =

*     link_repid        =

*     shellstyle        =

*     left    =

*     top     =

*     width   =

*     height  =

*     metric  = cntl_metric_dynpro

*     align   = 15




      parent  = gc_docking

      rows    = 2

      columns = 1.




*    no_autodef_progid_dynnr =

*    name              =

*  exceptions

*    cntl_error        = 1

*    cntl_system_error = 2

*    others            = 3




  .

  call method gc_splitter_main->get_container " ## ##

    exporting

      row       = 1

      column    = 1

    receiving

      container = gc_cont_docking.

  call method gc_splitter_main->get_container " ### ##

    exporting

      row       = 2

      column    = 1

    receiving

      container = gc_cont_bottom.

  create object gc_splitter2 " ## ## #, ##### ## ##

    exporting




*     link_dynnr        =

*     link_repid        =

*     shellstyle        =

*     left    =

*     top     =

*     width   =

*     height  =

*     metric  = cntl_metric_dynpro

*     align   = 15




      parent  = gc_cont_docking " ### ### ### ####

      rows    = 1

      columns = 2




*     no_autodef_progid_dynnr =

*     name    =

*  exceptions

*     cntl_error        = 1

*     cntl_system_error = 2

*     others  = 3




    .

  call method gc_splitter2->get_container " #### ## (for 2# ##)

    exporting

      row       = 1

      column    = 1

    receiving

      container = gc_cont_top_left.

  call method gc_splitter2->get_container " #### ## (for 3# ##)

    exporting

      row       = 1

      column    = 2

    receiving

      container = gc_cont_top_right.

  create object gc_grid1 " 1# ####

    exporting




*     i_shellstyle      = 0

*     i_lifetime        =




      i_parent = gc_cont_bottom




*     i_appl_events     = space

*     i_parentdbg       =

*     i_applogparent    =

*     i_graphicsparent  =

*     i_name   =

*     i_fcat_complete   = SPACE

*  exceptions

*     error_cntl_create = 1

*     error_cntl_init   = 2

*     error_cntl_link   = 3

*     error_dp_create   = 4

*     others   = 5




    .

  if sy-subrc <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  endif.



  create object gc_grid2 " 2# ##

    exporting




*     i_shellstyle      = 0

*     i_lifetime        =




      i_parent = gc_cont_top_left




*     i_appl_events     = space

*     i_parentdbg       =

*     i_applogparent    =

*     i_graphicsparent  =

*     i_name   =

*     i_fcat_complete   = SPACE

*  exceptions

*     error_cntl_create = 1

*     error_cntl_init   = 2

*     error_cntl_link   = 3

*     error_dp_create   = 4

*     others   = 5




    .

  if sy-subrc <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  endif.



  create object gc_grid3 " 3# ##

    exporting




*     i_shellstyle      = 0

*     i_lifetime        =




      i_parent = gc_cont_top_right




*     i_appl_events     = space

*     i_parentdbg       =

*     i_applogparent    =

*     i_graphicsparent  =

*     i_name   =

*     i_fcat_complete   = SPACE

*  exceptions

*     error_cntl_create = 1

*     error_cntl_init   = 2

*     error_cntl_link   = 3

*     error_dp_create   = 4

*     others   = 5




    .

  if sy-subrc <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  endif.





endform.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form field_catalog .

  perform fieldcat_cont_bottom.

  perform fieldcat_cont_top_left.

  perform fieldcat_cont_top_right.

endform.




*&---------------------------------------------------------------------*

*&      Form  FIELDCAT_CONT_BOTTOM

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form fieldcat_cont_bottom . " 1#(####)

  clear : gs_fieldcat, gt_fieldcat1.

  gs_fieldcat-col_pos = 1.

  gs_fieldcat-fieldname = 'ZCOLOR'.

  gs_fieldcat-coltext = '##'.

  gs_fieldcat-icon = 'X'.

  append gs_fieldcat to gt_fieldcat1.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-key = 'X'.

  gs_fieldcat-fieldname = 'ZPERNR'.

  gs_fieldcat-scrtext_m = '####'.

  append gs_fieldcat to gt_fieldcat1.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZPNAME'.

  gs_fieldcat-scrtext_m = '##'.

  append gs_fieldcat to gt_fieldcat1.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZDEP_TXT'.

  gs_fieldcat-scrtext_m = '##'.

  append gs_fieldcat to gt_fieldcat1.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 5.

  gs_fieldcat-fieldname = 'DATBI'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-outputlen = '10'.

  append gs_fieldcat to gt_fieldcat1.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'DATAB'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-outputlen = '10'.

  append gs_fieldcat to gt_fieldcat1.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 7.

  gs_fieldcat-fieldname = 'ZRANK_TXT'.

  gs_fieldcat-scrtext_m = '##'.

  append gs_fieldcat to gt_fieldcat1.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 8.

  gs_fieldcat-fieldname = 'ZGEN_TXT'.

  gs_fieldcat-scrtext_m = '##'.

  append gs_fieldcat to gt_fieldcat1.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 9.

  gs_fieldcat-fieldname = 'ZEDATE'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-outputlen = '10'.

  append gs_fieldcat to gt_fieldcat1.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 10.

  gs_fieldcat-fieldname = 'ZADDRESS'.

  gs_fieldcat-scrtext_m = '##'.

  append gs_fieldcat to gt_fieldcat1.



  if p_zqflag = 'X'.

    clear : gs_fieldcat.

    gs_fieldcat-col_pos = 11.

    gs_fieldcat-fieldname = 'ZQDATE'.

    gs_fieldcat-scrtext_m = '####'.

    gs_fieldcat-outputlen = '10'.

    append gs_fieldcat to gt_fieldcat1.



    clear : gs_fieldcat.

    gs_fieldcat-col_pos = 12.

    gs_fieldcat-fieldname = 'ZQFLAG'.

    gs_fieldcat-scrtext_m = '####'.

    gs_fieldcat-outputlen = '8'.

    append gs_fieldcat to gt_fieldcat1.

  endif.

endform.




*&---------------------------------------------------------------------*

*&      Form  FIELDCAT_CONT_TOP_RIGHT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form fieldcat_cont_top_right . " 2# (##)

  clear : gs_fieldcat , gt_fieldcat2.

  gs_fieldcat-col_pos = 1.

  gs_fieldcat-key = 'X'.

  gs_fieldcat-fieldname = 'ZPERNR'.

  gs_fieldcat-scrtext_m = '####'.

  append gs_fieldcat to gt_fieldcat2.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-fieldname = 'ZDEP_TXT'.

  gs_fieldcat-scrtext_m = '##'.

  append gs_fieldcat to gt_fieldcat2.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZYEAR'.

  gs_fieldcat-scrtext_m = '##'.

  append gs_fieldcat to gt_fieldcat2.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'DATBI'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-outputlen = '10'.

  append gs_fieldcat to gt_fieldcat2.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 5.

  gs_fieldcat-fieldname = 'DATAB'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-outputlen = '10'.

  append gs_fieldcat to gt_fieldcat2.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'ZRANK'.

  gs_fieldcat-scrtext_m = '##'.

  append gs_fieldcat to gt_fieldcat2.

endform.




*&---------------------------------------------------------------------*

*&      Form  FIELDCAT_CONT_TOP_LEFT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form fieldcat_cont_top_left . " 3# (##)

  clear : gs_fieldcat , gt_fieldcat3.

  gs_fieldcat-col_pos = 1.

  gs_fieldcat-key = 'X'.

  gs_fieldcat-fieldname = 'ZPERNR'.

  gs_fieldcat-scrtext_m = '####'.

  append gs_fieldcat to gt_fieldcat3.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-fieldname = 'ZYEAR'.

  gs_fieldcat-scrtext_m = '##'.

  append gs_fieldcat to gt_fieldcat3.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'DATBI'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-outputlen = '10'.

  append gs_fieldcat to gt_fieldcat3.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'DATAB'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-outputlen = '10'.

  append gs_fieldcat to gt_fieldcat3.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 5.

  gs_fieldcat-fieldname = 'ZSALARY'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-do_sum = 'X'.

  gs_fieldcat-cfieldname = 'ZWAERS'.

  gs_fieldcat-outputlen = '16'.

  append gs_fieldcat to gt_fieldcat3.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'ZWAERS'.

  gs_fieldcat-scrtext_m = '##'.

  gs_fieldcat-no_out = 'X'.

  append gs_fieldcat to gt_fieldcat3.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 7.

  gs_fieldcat-fieldname = 'ZBANK_TXT'.

  gs_fieldcat-scrtext_m = '###'.

  append gs_fieldcat to gt_fieldcat3.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 8.

  gs_fieldcat-fieldname = 'ZACCOUNT'.

  gs_fieldcat-scrtext_m = '####'.

  append gs_fieldcat to gt_fieldcat3.

endform.






*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form alv_sort .

  clear : gs_sort, gt_sort1.

  gs_sort-spos = 1. " ## ####

  gs_sort-fieldname = 'ZPERNR'. " ### ### ### ##

  gs_sort-up = 'X'. " #### #### ##




*  gs_sort-down = 'X'. " #### #### ##

*  gs_sort-subtot = 'X'. " ####




  append gs_sort to gt_sort1.

endform.




*&---------------------------------------------------------------------*

*&      Form  LAYOUT_SET

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form layout_set .

  clear gs_layout.

  gs_layout-zebra = 'X'. " ## ### ## ### -> ### ## ##. # # #### ## # #

  gs_layout-totals_bef = 'X'. " ## # #### ## ##### ##



  " variant# #### ## #### ## #### ##### #### ### # ##

  " (## ## ##, ###, ## #)

  clear gs_variant.

  gs_variant-report = sy-repid.

  gs_variant-username = sy-uname.

endform.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form call_alv .

    call method gc_grid1->set_table_for_first_display " ####  ##

  " 1# ### (##) - ##

    exporting




*      i_buffer_active               =

*      i_bypassing_buffer            =

*      i_consistency_check           =

*      i_structure_name              =




      is_variant                    = gs_variant

      i_save                        = 'A'




*      i_default                     = 'X'




      is_layout                     = gs_layout




*      is_print                      =

*      it_special_groups             =

*      it_toolbar_excluding          =

*      it_hyperlink                  =

*      it_alv_graphics               =

*      it_except_qinfo               =

*      ir_salv_adapter               =




    changing

      it_outtab                     = gt_001 " #### ### ##

      it_fieldcatalog               = gt_fieldcat1

      it_sort                       = gt_sort1




*      it_filter                     =

*    exceptions

*      invalid_parameter_combination = 1

*      program_error                 = 2

*      too_many_lines                = 3

*      others                        = 4




          .

  if sy-subrc <> 0.




*   Implement suitable error handling here




  endif.

  " 2# ### (##) - ## ##

  call method gc_grid2->set_table_for_first_display " #### ##

    exporting




*      i_buffer_active               =

*      i_bypassing_buffer            =

*      i_consistency_check           =

*      i_structure_name              =




      is_variant                    = gs_variant

      i_save                        = 'A'




*      i_default                     = 'X'




      is_layout                     = gs_layout




*      is_print                      =

*      it_special_groups             =

*      it_toolbar_excluding          =

*      it_hyperlink                  =

*      it_alv_graphics               =

*      it_except_qinfo               =

*      ir_salv_adapter               =




    changing

      it_outtab                     = gt_002 " #### ##

      it_fieldcatalog               = gt_fieldcat2

      it_sort                       = gt_sort1




*      it_filter                     =

*    exceptions

*      invalid_parameter_combination = 1

*      program_error                 = 2

*      too_many_lines                = 3

*      others                        = 4




          .

  if sy-subrc <> 0.




*   Implement suitable error handling here




  endif.



  call method gc_grid3->set_table_for_first_display " ## ##

   " 3# ### (##) - ## ##

    exporting




*      i_buffer_active               =

*      i_bypassing_buffer            =

*      i_consistency_check           =

*      i_structure_name              =




      is_variant                    = gs_variant

      i_save                        = 'A'




*      i_default                     = 'X'




      is_layout                     = gs_layout




*      is_print                      =

*      it_special_groups             =

*      it_toolbar_excluding          =

*      it_hyperlink                  =

*      it_alv_graphics               =

*      it_except_qinfo               =

*      ir_salv_adapter               =




    changing

      it_outtab                     = gt_003 " ## ##

      it_fieldcatalog               = gt_fieldcat3

      it_sort                       = gt_sort1




*      it_filter                     =

*    exceptions

*      invalid_parameter_combination = 1

*      program_error                 = 2

*      too_many_lines                = 3

*      others                        = 4




          .

  if sy-subrc <> 0.




*   Implement suitable error handling here




  endif.

endform.