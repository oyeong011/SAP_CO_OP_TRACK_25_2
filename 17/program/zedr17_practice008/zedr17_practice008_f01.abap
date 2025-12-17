
*&---------------------------------------------------------------------*

*&  Include           ZEDR17_PRACTICE008_F01

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*




form set_init .

  " ## # 1## ##

  data: lv_mon_first type sy-datum,

        lv_mon_last  type sy-datum.



  " ## # 1# ## (sy-datum ##)

  lv_mon_first = sy-datum.

  lv_mon_first+6(2) = '01'.



  " ## # ## ##

  call function 'RP_LAST_DAY_OF_MONTHS'

    exporting

      day_in            = lv_mon_first

    importing

      last_day_of_month = lv_mon_last.



  " #### ###

  write lv_mon_first to s_ordate-low  using edit mask '____.__.__'.

  write lv_mon_last  to s_ordate-high using edit mask '____.__.__'.

  s_ordate-sign   = 'I'.

  s_ordate-option = 'BT'.

  append s_ordate.



  " #### ###

  write lv_mon_first to s_shdate-low  using edit mask '____.__.__'.

  write lv_mon_last  to s_shdate-high using edit mask '____.__.__'.

  s_shdate-sign   = 'I'.

  s_shdate-option = 'BT'.

  append s_shdate.

endform.






*&---------------------------------------------------------------------*

*&      Form  BUILD_DATE_RANGE

*&---------------------------------------------------------------------*




form build_date_range .

  clear : gr_jdate, gr_shdate.



  " ##(##)##

  loop at s_ordate.

    if s_ordate-low is initial and s_ordate-high is initial.

      continue.  " # # ##

    endif.

    clear gr_jdate.

    gr_jdate-sign   = s_ordate-sign.

    gr_jdate-option = s_ordate-option.

    gr_jdate-low    = s_ordate-low.

    replace all occurrences of '.' in gr_jdate-low with ''.

    gr_jdate-high   = s_ordate-high.

    replace all occurrences of '.' in gr_jdate-high with ''.

    append gr_jdate.

  endloop.

  if gr_jdate[] is initial. clear gr_jdate. endif.



  " ####

  loop at s_shdate.

    if s_shdate-low is initial and s_shdate-high is initial.

      continue.  " # # ##

    endif.

    clear gr_shdate.

    gr_shdate-sign   = s_shdate-sign.

    gr_shdate-option = s_shdate-option.

    gr_shdate-low    = s_shdate-low.

    replace all occurrences of '.' in gr_shdate-low with ''.

    gr_shdate-high   = s_shdate-high.

    replace all occurrences of '.' in gr_shdate-high with ''.

    append gr_shdate.

  endloop.

  if gr_shdate[] is initial. clear gr_shdate. endif.

endform.






*&---------------------------------------------------------------------*

*&      Form  MAP_order_TEXTS

*&---------------------------------------------------------------------*




" ZMTART(####), ZSALE_FG(##), ZRET_FG(####) ## ### ##->### #####

form map_order_texts using  p_mtart type zedt17_100-zmtart " ####

                      p_sale_fg type zedt17_100-zsale_fg " ##

                      p_ret_fg type zedt17_100-zret_fg " ####

              changing  p_mt_txt

                        p_sale_txt

                        p_ret_txt.

  case p_mtart.

    when '001'. p_mt_txt = '##'.

    when '002'. p_mt_txt = '##'.

    when '003'. p_mt_txt = '##'.

    when '004'. p_mt_txt = '##'.

    when '005'. p_mt_txt = '##'.

    when '006'. p_mt_txt = '###'.

  endcase.



  case p_sale_fg.

    when '1'. p_sale_txt = '##'.

    when '2'. p_sale_txt = '##'.

  endcase.



  case p_ret_fg.

    when '1'. p_ret_txt = '####'.

    when '2'. p_ret_txt = '####'.

    when '3'. p_ret_txt = '####'.

  endcase.

endform.






*&---------------------------------------------------------------------*

*&      Form  MAP_shipping_TEXTS

*&---------------------------------------------------------------------*




" ZMTART(####),ZDFLAG(####), ZDGUBUN(####) ## ### ##->### #####

form map_shipping_texts using   p_mtart type zedt17_101-zmtart " ####

                                p_zdflag type zedt17_101-zdflag " ####

                                p_zdgubun type zedt17_101-zdgubun " ####

                        changing  p_mt_txt

                                  p_df_txt

                                  p_dg_txt.

  case p_mtart.

    when '001'. p_mt_txt = '##'.

    when '002'. p_mt_txt = '##'.

    when '003'. p_mt_txt = '##'.

    when '004'. p_mt_txt = '##'.

    when '005'. p_mt_txt = '##'.

    when '006'. p_mt_txt = '###'.

  endcase.



  case p_zdflag.

    when '1'. p_df_txt = '####'.

    when '2'. p_df_txt = '###'.

    when '3'. p_df_txt = '####'.

  endcase.



  case p_zdgubun.

    when '1'. p_dg_txt = '###'.

    when '2'. p_dg_txt = '###'.

    when '3'. p_dg_txt = '###'.

    when '4'. p_dg_txt = '###'.

    when '5'. p_dg_txt = '###'.

    when '6'. p_dg_txt = '###'.

    when '7'. p_dg_txt = '###'.

  endcase.

endform.






*&---------------------------------------------------------------------*

*&      Form  fmt_date

*&---------------------------------------------------------------------*




form fmt_date  using p_date type d

               changing p_text.

  if p_date is initial.

    clear p_text.

  else.

    p_text = |{ p_date+0(4) }.{ p_date+4(2) }.{ p_date+6(2) }|. " yyyymmdd -> yyyy.mm.dd

  endif.

endform.






*&---------------------------------------------------------------------*

*&      Form  GET_order_DATA

*&---------------------------------------------------------------------*




form get_order_data .

  clear : gt_order, gt_order_print.



  " 1) ## ### ## (##: ####, id, ##, ####)

  if p_zidcd is initial. " #### ### #

    select *

      from zedt17_100

      into corresponding fields of table gt_order

      where zordno in s_zordno

      and zmatnr in s_zmatnr

    and zjdate in gr_jdate.

  else. " #### ## #

    select *

      from zedt17_100

      into corresponding fields of table gt_order

      where zordno in s_zordno

      and zmatnr in s_zmatnr

      and zjdate in gr_jdate

    and zidcode = p_zidcd.

  endif.



  loop at gt_order into gs_order.

    clear gs_order_print.



    "## ##

    move-corresponding gs_order to gs_order_print.






*    gs_order_print-zwaers = 'KRW'.






    " #### ### # ##

    if p_return <> 'X' and gs_order_print-zret_fg is not initial.

      continue.

    endif.



    " ## ## # ### ##

    perform map_order_texts using gs_order_print-zmtart

                             gs_order_print-zsale_fg

                             gs_order_print-zret_fg

                       changing gs_order_print-zmtart_txt

                                gs_order_print-zsale_fg_txt

                                gs_order_print-zret_fg_txt.



    " ###(ZCOLOR) ##: ##=##, ##=##

    if gs_order_print-zsale_fg = '1'.

      gs_order_print-zcolor = c_col_green.

    elseif gs_order_print-zsale_fg = '2'.

      gs_order_print-zcolor = c_col_red.

    endif.



    append gs_order_print to gt_order_print.

    clear gs_order_print.

  endloop.

endform.








*&---------------------------------------------------------------------*

*&      Form  GET_shipping_DATA

*&---------------------------------------------------------------------*




form get_shipping_data .

  clear : gt_shipping, gt_shipping_print.



  " 2) ## ### ## (##: ####, id, ####, ####)

  if p_zidcd is initial. " #### ### #

    select *

      from zedt17_101

      into corresponding fields of table gt_shipping " ####

      where zordno in s_zordno " id

      and zmatnr in s_zmatnr " ####

    and zddate in gr_shdate. "####

  else. " #### ## #

    select *

      from zedt17_101

      into corresponding fields of table gt_shipping

      where zordno in s_zordno

      and zmatnr in s_zmatnr

      and zddate in gr_shdate

    and zidcode = p_zidcd.

  endif.



  loop at gt_shipping into gs_shipping.

    clear gs_shipping_print.



    "## ##

    move-corresponding gs_shipping to gs_shipping_print.



    " ####(CFIELD) ##




*    gs_shipping_print-zwaers = 'KRW'.






    " #### ### # ##

    if p_return <> 'X' and gs_shipping_print-zflag is not initial.

      continue.

    endif.





    " ## ## -> ### ##

    perform map_shipping_texts using gs_shipping_print-zmtart

                                     gs_shipping_print-zdflag

                                     gs_shipping_print-zdgubun

                       changing gs_shipping_print-zmtart_txt

                                gs_shipping_print-zdflag_txt

                                gs_shipping_print-zdgubun_txt.



    " ###(ZCOLOR) ##: zflag='X' # ##, # # ##

    if gs_shipping_print-zflag = 'X'.

      gs_shipping_print-zcolor = c_col_red.

    else.

      gs_shipping_print-zcolor = c_col_green.

    endif.



    append gs_shipping_print to gt_shipping_print.

    clear gs_shipping_print.

  endloop.

endform.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form create_object using gc_docking type ref to cl_gui_docking_container

                         gc_grid type ref to cl_gui_alv_grid.

  create object gc_docking

    exporting




*     parent    =




      repid     = sy-repid " ####  id ##

      dynnr     = sy-dynnr " ### ## ##




*     side      = DOCK_AT_LEFT




      extension = 2000 " #### ##




*     style     =

*     lifetime  = lifetime_default

*     caption   =

*     metric    = 0

*     ratio     =

*     no_autodef_progid_dynnr     =

*     name      =

*    exceptions

*     cntl_error                  = 1

*     cntl_system_error           = 2

*     create_error                = 3

*     lifetime_error              = 4

*     lifetime_dynpro_dynpro_link = 5

*     others    = 6




    .

  if sy-subrc <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  endif.



  create object gc_grid

    exporting




*     i_shellstyle      = 0

*     i_lifetime        =




      i_parent = gc_docking




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

*&      Form  FIELD_CATALOG_100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form field_catalog_100 .

  clear : gs_fieldcat, gt_fieldcat.

  gs_fieldcat-col_pos = 1.

  gs_fieldcat-fieldname = 'ZCOLOR'.

  gs_fieldcat-coltext = '##'.

  gs_fieldcat-icon = 'X'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-fieldname = 'ZORDNO'.

  gs_fieldcat-scrtext_m = '####'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZIDCODE'.

  gs_fieldcat-scrtext_m = '##ID'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZMATNR'.

  gs_fieldcat-scrtext_m = '####'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 5.

  gs_fieldcat-fieldname = 'ZMATNAME'.

  gs_fieldcat-scrtext_m = '###'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'ZMTART_TXT'.

  gs_fieldcat-scrtext_m = '####'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 7.

  gs_fieldcat-fieldname = 'ZVOLUM'.

  gs_fieldcat-scrtext_m = '##'.

  gs_fieldcat-qfieldname = 'VRKME'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 8.

  gs_fieldcat-fieldname = 'VRKME'.

  gs_fieldcat-scrtext_m = '##'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 9.

  gs_fieldcat-fieldname = 'ZNSAMT'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-cfieldname = 'ZWAERS'.

  gs_fieldcat-do_sum = 'X'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 10.

  gs_fieldcat-fieldname = 'ZSLAMT'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-cfieldname = 'ZWAERS'.

  gs_fieldcat-do_sum = 'X'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 11.

  gs_fieldcat-fieldname = 'ZDCAMT'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-cfieldname = 'ZWAERS'.

  gs_fieldcat-do_sum = 'X'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 12.

  gs_fieldcat-fieldname = 'ZWAERS'.

  gs_fieldcat-scrtext_m = '##'.

  gs_fieldcat-emphasize = 'X'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 13.

  gs_fieldcat-fieldname = 'ZSALE_FG_TXT'.

  gs_fieldcat-scrtext_m = '####'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 14.

  gs_fieldcat-fieldname = 'ZJDATE'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-outputlen = '10'.

  append gs_fieldcat to gt_fieldcat.



  if p_return = 'X'.

    clear : gs_fieldcat.

    gs_fieldcat-col_pos = 15.

    gs_fieldcat-fieldname = 'ZRET_FG_TXT'.

    gs_fieldcat-scrtext_m = '####'.

    append gs_fieldcat to gt_fieldcat.



    clear : gs_fieldcat.

    gs_fieldcat-col_pos = 16.

    gs_fieldcat-fieldname = 'ZRDATE'.

    gs_fieldcat-scrtext_m = '####'.

    gs_fieldcat-outputlen = '10'.

    append gs_fieldcat to gt_fieldcat.

  endif.

endform.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form field_catalog_200 .

  clear : gs_fieldcat, gt_fieldcat.

  gs_fieldcat-col_pos = 1.

  gs_fieldcat-fieldname = 'ZCOLOR'.

  gs_fieldcat-coltext = '##'.

  gs_fieldcat-icon = 'X'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-fieldname = 'ZORDNO'.

  gs_fieldcat-scrtext_m = '####'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZIDCODE'.

  gs_fieldcat-scrtext_m = '##ID'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZMATNR'.

  gs_fieldcat-scrtext_m = '####'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 5.

  gs_fieldcat-fieldname = 'ZMATNAME'.

  gs_fieldcat-scrtext_m = '###'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'ZMTART_TXT'.

  gs_fieldcat-scrtext_m = '####'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 7.

  gs_fieldcat-fieldname = 'ZVOLUM'.

  gs_fieldcat-scrtext_m = '##'.

  gs_fieldcat-qfieldname = 'VRKME'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 8.

  gs_fieldcat-fieldname = 'VRKME'.

  gs_fieldcat-scrtext_m = '##'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 10.

  gs_fieldcat-fieldname = 'ZSLAMT'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-cfieldname = 'ZWAERS'.

  gs_fieldcat-do_sum = 'X'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 11.

  gs_fieldcat-fieldname = 'ZWAERS'.

  gs_fieldcat-scrtext_m = '##'.

  gs_fieldcat-emphasize = 'X'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 12.

  gs_fieldcat-fieldname = 'ZDFLAG_TXT'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-currency = 'KRW'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 13.

  gs_fieldcat-fieldname = 'ZDGUBUN_TXT'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-emphasize = 'X'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 14.

  gs_fieldcat-fieldname = 'ZDDATE'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-outputlen = '10'.

  append gs_fieldcat to gt_fieldcat.



  if p_return = 'X'.

    clear : gs_fieldcat.

    gs_fieldcat-col_pos = 15.

    gs_fieldcat-fieldname = 'ZRDATE'.

    gs_fieldcat-scrtext_m = '####'.

    gs_fieldcat-outputlen = '10'.

    append gs_fieldcat to gt_fieldcat.



    clear : gs_fieldcat.

    gs_fieldcat-col_pos = 16.

    gs_fieldcat-fieldname = 'ZFLAG'.

    gs_fieldcat-scrtext_m = '####'.

    gs_fieldcat-outputlen = '8'.

    gs_fieldcat-just = 'C'.

    gs_fieldcat-emphasize = 'X'.

    append gs_fieldcat to gt_fieldcat.

  endif.

endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form alv_layout .

  clear gs_layout.

  gs_layout-zebra = 'X'. " ## ### ## ### -> ### ## ##. # # #### ## # #



  " variant# #### ## #### ## #### ##### #### ### # ##

  " (## ## ##, ###, ## #)

  clear gs_variant.

  gs_variant-report = sy-repid.

  gs_variant-username = sy-uname.

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

  clear : gs_Sort, gt_sort.

  gs_sort-spos = 1. " ## ####

  gs_sort-fieldname = 'ZIDCODE'. " ### ### ### ##

  gs_sort-up = 'X'. " #### #### ##




*  gs_sort-down = 'X'. " #### #### ##




  gs_sort-subtot = 'X'. " ####

  append gs_sort to gt_sort.

endform.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form call_alv using gt_itab type standard table

                    gc_grid type ref to cl_gui_alv_grid

                    gs_layout type lvc_s_layo

                    gs_variant like disvariant.

  call method gc_grid->set_table_for_first_display

    exporting




*      i_buffer_active               =

*      i_bypassing_buffer            =

*      i_consistency_check           =

*      i_structure_name              =




      is_variant                    = gs_variant

      i_save                        = 'A'

      i_default                     = 'X'

      is_layout                     = gs_layout




*      is_print                      =

*      it_special_groups             =

*      it_toolbar_excluding          =

*      it_hyperlink                  =

*      it_alv_graphics               =

*      it_except_qinfo               =

*      ir_salv_adapter               =




    changing

      it_outtab                     = gt_itab

      it_fieldcatalog               = gt_fieldcat

      it_sort                       = gt_sort




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