
*&---------------------------------------------------------------------*

*& Report ZEDR17_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




report zedr17_practice003.



tables : zedt17_100, zedt17_101. " ####(zedt17_100), ####(zedt17_101)



" ####(zedt17_100)

data : begin of gs_order.

    include structure
zedt17_100
.

data : end of gs_order.

data : gt_order like table of gs_order. " ## ## itab



" #### ## ### itab

data : begin of gs_order_print,

         zordno           type zedt17_100-zordno,   " ####

         zidcode          type zedt17_100-zidcode,  " ID

         zmatnr           type zedt17_100-zmatnr,   " ####

         zmatname         type zedt17_100-zmatname, " ###

         zmtart           type zedt17_100-zmtart,   " ####(##)

         zmtart_txt(10) ,   " ####(##)

         zvolum           type zedt17_100-zvolum,   " ##

         vrkme            type zedt17_100-vrkme,    " ##

         znsamt           type zedt17_100-znsamt,   " ####

         zslamt           type zedt17_100-zslamt,   " ####

         zdcamt           type zedt17_100-zdcamt,   " ####

         zsale_fg         type zedt17_100-zsale_fg,   " ##(##)

         zsale_fg_txt(10) , " ##(##)

         zjdate           type zedt17_100-zjdate,   " ####

         zret_fg          type zedt17_100-zret_fg,   " ####(##)

         zret_fg_txt(10),  " #### (###### ## #)

         zrdate           type zedt17_100-zrdate,   " #### (###### ## #)

       end of gs_order_print.

data : gt_order_print like table of gs_order_print. " ## ## itab



" ####(zedt17_101)

data : begin of gs_shipping.

    include structure
zedt17_101
.

data : end of gs_shipping.

data : gt_shipping like table of gs_shipping.



" #### ## ### itab

data : begin of gs_shipping_print,

         zordno          type zedt17_101-zordno,   " ####

         zidcode         type zedt17_101-zidcode,  " ID

         zmatnr          type zedt17_101-zmatnr,   " ####

         zmatname        type zedt17_101-zmatname, " ###

         zmtart          type zedt17_101-zmtart,   " ####(##)

         zmtart_txt(10) ,   " ####(##)

         zvolum          type zedt17_101-zvolum,   " ##

         vrkme           type zedt17_101-vrkme,    " ##

         zslamt          type zedt17_101-zslamt,   " ####

         zdflag          type zedt17_101-zdflag,   " ####(##)

         zdflag_txt(10),   " ####(##)

         zdgubun         type zedt17_101-zdgubun,  " ##(##)

         zdgubun_txt(10) ,   " ##(##)

         zddate          type zedt17_101-zddate,  " ####

         zrdate          type zedt17_101-zrdate,  " ####

         zflag           type zedt17_101-zflag,   " (###### ## #)

       end of gs_shipping_print.

data : gt_shipping_print like table of gs_shipping_print.



data gv_char_date(10). " yyyy.mm.dd## #### ## ###### ##



data : gv_order_active_flag(1)." #### ## ### ##

data : gv_ship_active_flag(1)." #### ## ### ##



" ## ## ##

constants : c_mul_krw type i value '100'. " krw ###



" range ## ## ## - db### ## (####/####)

ranges : gr_jdate for gv_char_date.   "####

ranges : gr_shdate for gv_char_date. " ####



" ####(ZORDNO), ##ID(ZIDCODE), ####(ZMATNR), ####/####(ZJDATE)

selection-screen begin of block b1 with frame.

select-options : s_zordno for zedt17_100-zordno. " ####

parameters : p_zidcd like zedt17_100-zidcode. " ##ID, ### 8#### ##

select-options : s_zmatnr for zedt17_100-zmatnr. " ####

select-options : s_ordate for gv_char_date modif id sc1. " ####, ## ### ## modif id ##

select-options : s_shdate for gv_char_date modif id sc2. " ####, ## ### ## modif id ##

selection-screen end of block b1.



" radio button: ####(zedt17_100), ####(zedt17_101)

selection-screen begin of block b2 with frame.

parameters : p_order radiobutton group r1 default 'X' user-command uc1. " ####, selection-screen ## ### ###### user-command fcode ### (uc1)

parameters : p_ship radiobutton group r1. " ####

selection-screen end of block b2.



" check box: ######/####(ZRET_FG)

selection-screen begin of block b3 with frame.

parameters : p_return as checkbox default 'X'. " ######

selection-screen end of block b3.



initialization.

  " 3. ##### ##### ## default# ###### ##, ### ### 01.01~ ### ## ## ### ### ## FIX

  data : lv_next_month_first_day type d. " ## ## ## ## for ### 1## 1 ## ## # ## ##

  data : lv_date_low type d. " for 'yyyy-mm-dd' -> 'yyyy.mm.01'

  data : lv_date_high type d. " for 'yyyy-mm-dd' -> 'yyyy.mm.30'



  " ## # 1# ##

  lv_date_low = sy-datum. " ## ## ## ##

  lv_date_low+6(2) = '01'. " 6## #### 2##(dd##)# '01'# ##



  " ## # ## ##

  lv_next_month_first_day = sy-datum. " ## ## ## ##

  lv_next_month_first_day+6(2) = '01'. " ### 1## ###

  add 1 to lv_next_month_first_day+4(2). " 4## #### 2##(mm)# 1 ### # += 1

  if lv_next_month_first_day+4(2) > 12. " 12# ####

    lv_next_month_first_day+4(2) = '01'. " 1## ##

    add 1 to lv_next_month_first_day(4). " ## += 1

  endif.

  " ## # 1### ## ## ## # ### # ###

  lv_date_high = lv_next_month_first_day - 1.



  " #### ### ##

  write lv_date_low  to s_ordate-low  using edit mask '____.__.__'. " 'yyyy-mm-01' -> 'yyyy.mm.01'

  write lv_date_high to s_ordate-high using edit mask '____.__.__'. " 'yyyy-mm-30' -> 'yyyy.mm.30'

  s_ordate-sign = 'I'. " include. ## ## ##

  s_ordate-option = 'BT'. " between. low# high ### # ##

  append s_ordate.



  " #### ### ##

  write lv_date_low  to s_shdate-low  using edit mask '____.__.__'. " 'yyyy-mm-01' -> 'yyyy.mm.01'

  write lv_date_high to s_shdate-high using edit mask '____.__.__'. " 'yyyy-mm-30' -> 'yyyy.mm.30'

  s_shdate-sign = 'I'. " include. ## ## ##

  s_shdate-option = 'BT'. " between. low# high ### # ##

  append s_shdate.



  " output## selection screen ### layout ## ##. ### ### ##



at selection-screen output.



  if p_order = 'X'. " #### ## ### ##

    gv_order_active_flag = '1'.

    gv_ship_active_flag = '0'.

  elseif p_ship = 'X'. " #### ## ### ##

    gv_order_active_flag = '0'.

    gv_ship_active_flag = '1'.

  endif.



  loop at screen.

    if screen-group1 = 'SC1'. " ## #### ### ## (#### ###!!!)

      screen-active = gv_order_active_flag.

    elseif screen-group1 = 'SC2'. " ## #### ### ##

      screen-active = gv_ship_active_flag.

    endif.

    modify screen.

  endloop.



start-of-selection. " inialization ## ### # #### ### error# ##

  perform build_date_range. " ## ## yyyy.mm.dd -> yyyymmdd



  if p_order = 'X'. " #### ##### ### ##

    perform get_order_data. " ### ##

  else. " #### ##### ### ##

    perform get_shipping_data. " ### ##

  endif.



end-of-selection.

  if p_order = 'X'. " #### ##### ### ##

    perform write_order_data. " #### ### ##

  else. " #### ##### ### ##

    perform write_shipping_data. " #### ### ##

  endif.








*&---------------------------------------------------------------------*

*&      Form  BUILD_DATE_RANGE

*&---------------------------------------------------------------------*




form build_date_range .

  clear : gr_jdate, gr_shdate.



  " ##(##)##

  loop at s_ordate.

    clear gr_jdate.

    gr_jdate-sign = s_ordate-sign.

    gr_jdate-option = s_ordate-option.

    gr_jdate-low = s_ordate-low.

    replace all occurrences of '.' in gr_jdate-low with ''.

    gr_jdate-high = s_ordate-high.

    replace all occurrences of '.' in gr_jdate-high with ''.

    append gr_jdate.

  endloop.



  " #### (##### ###)

  loop at s_shdate.

    clear gr_shdate.

    gr_shdate-sign = s_shdate-sign.

    gr_shdate-option = s_shdate-option.

    gr_shdate-low = s_shdate-low.

    replace all occurrences of '.' in gr_shdate-low with ''.

    gr_shdate-high = s_shdate-high.

    replace all occurrences of '.' in gr_shdate-high with ''.

    append gr_shdate.

  endloop.

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

      into table gt_order

      where zordno in s_zordno

      and zmatnr in s_zmatnr

    and zjdate in gr_jdate.

  else. " #### ## #

    select *

      from zedt17_100

      into table gt_order

      where zordno in s_zordno

      and zmatnr in s_zmatnr

      and zjdate in gr_jdate

    and zidcode = p_zidcd.

  endif.



  loop at gt_order into gs_order.

    clear gs_order_print.



    "## ##

    move-corresponding gs_order to gs_order_print.



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

      into table gt_shipping " ####

      where zordno in s_zordno " id

      and zmatnr in s_zmatnr " ####

    and zddate in gr_shdate. "####

  else. " #### ## #

    select *

      from zedt17_101

      into table gt_shipping

      where zordno in s_zordno

      and zmatnr in s_zmatnr

      and zddate in gr_shdate

    and zidcode = p_zidcd.

  endif.



  loop at gt_shipping into gs_shipping.

    clear gs_shipping_print.



    "## ##

    move-corresponding gs_shipping to gs_shipping_print.



    " #### ### # ##

    if p_return <> 'X' and gs_shipping_print-zflag is not initial.

      continue.

    endif.





    " ## ## # ### ##

    perform map_shipping_texts using gs_shipping_print-zmtart

                                     gs_shipping_print-zdflag

                                     gs_shipping_print-zdgubun

                       changing gs_shipping_print-zmtart_txt

                                gs_shipping_print-zdflag_txt

                                gs_shipping_print-zdgubun_txt.



    append gs_shipping_print to gt_shipping_print.

    clear gs_shipping_print.

  endloop.

endform.








**&---------------------------------------------------------------------*

**&      Form  write_order_data

**&---------------------------------------------------------------------*




" #### ### ###### ## ##

" ZORDNO(####), ZIDCODE(ID), ZMATNR(####), ZMATNAME(###), ZMTART(####),

" ZVOLUM(##), VRKME(##), ZNSAMT(####), ZSLAMT(####), ZDCAMT(####),

" ZSALE_FG(##), ZJDATE(####), ( ZRET_FG(####), ZRDATE(####) )

form write_order_data .

  if gt_order_print is initial.

    write / '### ##'.

    return.

  endif.



  " ##

  if p_return = 'X'.

    write :  / '-----------------------------------------------------------------------------------------------------------------------------------------------------------------'.

    write :  /

      '|' no-gap, 2 '####' no-gap, 10

      '|' no-gap, 12 'ID' no-gap , 20

      '|' no-gap, 22 '####' no-gap, 30

      '|' no-gap, 32 '###' no-gap, 46

      '|' no-gap, 48 '####' no-gap, 56

      '|' no-gap, 58 '##' no-gap, 62

      '|' no-gap, 64 '##' no-gap, 68

      '|' no-gap, 70 '####' no-gap, 85

      '|' no-gap, 87 '####' no-gap, 102

      '|' no-gap, 104 '####' no-gap, 119

      '|' no-gap, 121 '##' no-gap, 125

      '|' no-gap, 127 '####' no-gap, 137

      '|' no-gap, 139 '####' no-gap, 149

      '|' no-gap, 151 '####' no-gap, 161 '|'.

    write :  / '-----------------------------------------------------------------------------------------------------------------------------------------------------------------'.

  else.

    write :  / '-----------------------------------------------------------------------------------------------------------------------------------------'.

    write :  /

      '|' no-gap, 2 '####' no-gap, 10

      '|' no-gap, 12 'ID' no-gap , 20

      '|' no-gap, 22 '####' no-gap, 30

      '|' no-gap, 32 '###' no-gap, 46

      '|' no-gap, 48 '####' no-gap, 56

      '|' no-gap, 58 '##' no-gap, 62

      '|' no-gap, 64 '##' no-gap, 68

      '|' no-gap, 70 '####' no-gap, 85

      '|' no-gap, 87 '####' no-gap, 102

      '|' no-gap, 104 '####' no-gap, 119

      '|' no-gap, 121 '##' no-gap, 125

      '|' no-gap, 127 '####' no-gap, 137 '|'.

    write :  / '-----------------------------------------------------------------------------------------------------------------------------------------'.

  endif.



  " ##

  loop at gt_order_print into gs_order_print.

    " ## ## ##

    data : lv_jdate(10).  " ####

    data : lv_rdate(10).  " ####



    data lv_nsamt type p decimals 0. " ### ###

    data lv_slamt type p decimals 0.

    data lv_dcamt type p decimals 0.



    perform fmt_date using gs_order_print-zjdate changing lv_jdate.

    perform fmt_date using gs_order_print-zrdate changing lv_rdate.



    lv_nsamt = gs_order_print-znsamt * c_mul_krw.

    lv_slamt = gs_order_print-zslamt * c_mul_krw.

    lv_dcamt = gs_order_print-zdcamt * c_mul_krw.



    if p_return = 'X'.

      write : /

        '|' no-gap, 2   gs_order_print-zordno      no-gap, 10 " #### (8)

        '|' no-gap, 12  gs_order_print-zidcode     no-gap, 20 " ID (8)

        '|' no-gap, 22  gs_order_print-zmatnr      no-gap, 30 " #### (8)

        '|' no-gap, 32  gs_order_print-zmatname    no-gap, 46 " ### (4)

        '|' no-gap, 48  gs_order_print-zmtart_txt  no-gap, 56 " #### (8)

        '|' no-gap, 58  gs_order_print-zvolum      no-gap, 62 " ## (4)

        '|' no-gap, 64  gs_order_print-vrkme       no-gap, 68 " ## (4)




*        '|' no-gap, 70  gs_order_print-znsamt       no-gap, 85 " #### (15)

*        '|' no-gap, 87  gs_order_print-zslamt      no-gap, 102 " #### (15)

*        '|' no-gap, 104  gs_order_print-zdcamt     no-gap, 119 " #### (15)




        '|' no-gap, 70  lv_nsamt       no-gap, 85 " #### (15)

        '|' no-gap, 87  lv_slamt      no-gap, 102 " #### (15)

        '|' no-gap, 104  lv_dcamt     no-gap, 119 " #### (15)

        '|' no-gap, 121 gs_order_print-zsale_fg_txt no-gap, 125 " ## (4)

        '|' no-gap, 127 lv_jdate                   no-gap, 137 " #### (10)

        '|' no-gap, 139 gs_order_print-zret_fg_txt no-gap, 149 " #### (10)

        '|' no-gap, 151 lv_rdate                   no-gap, 161 '|'. " #### (10)

      write :  / '-----------------------------------------------------------------------------------------------------------------------------------------------------------------'.

    else.

      write : /

        '|' no-gap, 2   gs_order_print-zordno      no-gap, 10 " #### (8)

        '|' no-gap, 12  gs_order_print-zidcode     no-gap, 20 " ID (8)

        '|' no-gap, 22  gs_order_print-zmatnr      no-gap, 30 " #### (8)

        '|' no-gap, 32  gs_order_print-zmatname    no-gap, 46 " ### (4)

        '|' no-gap, 48  gs_order_print-zmtart_txt  no-gap, 56 " #### (8)

        '|' no-gap, 58  gs_order_print-zvolum      no-gap, 62 " ## (4)

        '|' no-gap, 64  gs_order_print-vrkme       no-gap, 68 " ## (4)

        '|' no-gap, 70  lv_nsamt       no-gap, 85 " #### (15)

        '|' no-gap, 87  lv_slamt      no-gap, 102 " #### (15)

        '|' no-gap, 104  lv_dcamt     no-gap, 119 " #### (15)

        '|' no-gap, 121 gs_order_print-zsale_fg_txt no-gap, 125 " ## (4)

        '|' no-gap, 127 lv_jdate                   no-gap, 137 '|'. " #### (10)

      write :  / '-----------------------------------------------------------------------------------------------------------------------------------------'.

    endif.

  endloop.

endform.






**&---------------------------------------------------------------------*

**&      Form  write_shipping_data

**&---------------------------------------------------------------------*




" #### ### ###### ## ##

" ZORDNO(####), ZIDCODE(ID), ZMATNR(####), ZMATNAME(###), ZMTART(####),

" ZVOLUM(##), VRKME(##), ZSLAMT(####), ZDFLAG(####), ZDGUBUN(##), ZDDATE(####), ( ZRDATE(####) )

form write_shipping_data .

  if gt_shipping_print is initial.

    write / '### ##'.

    return.

  endif.



  " ##

  if p_return = 'X'.

    write :  / '-------------------------------------------------------------------------------------------------------------------------------------'.

    write :  /

      '|' no-gap, 2 '####' no-gap, 10

      '|' no-gap, 12 'ID' no-gap , 20

      '|' no-gap, 22 '####' no-gap, 30

      '|' no-gap, 32 '###' no-gap, 46

      '|' no-gap, 48 '####' no-gap, 56

      '|' no-gap, 58 '##' no-gap, 62

      '|' no-gap, 64 '##' no-gap, 68

      '|' no-gap, 70 '####' no-gap, 85

      '|' no-gap, 87 '####' no-gap, 97

      '|' no-gap, 99 '##' no-gap, 109

      '|' no-gap, 111 '####' no-gap, 121

      '|' no-gap, 123 '####' no-gap, 133 '|'.

    write :  / '-------------------------------------------------------------------------------------------------------------------------------------'.

  else.

    write :  / '-------------------------------------------------------------------------------------------------------------------------'.

    write :  /

      '|' no-gap, 2 '####' no-gap, 10

      '|' no-gap, 12 'ID' no-gap , 20

      '|' no-gap, 22 '####' no-gap, 30

      '|' no-gap, 32 '###' no-gap, 46

      '|' no-gap, 48 '####' no-gap, 56

      '|' no-gap, 58 '##' no-gap, 62

      '|' no-gap, 64 '##' no-gap, 68

      '|' no-gap, 70 '####' no-gap, 85

      '|' no-gap, 87 '####' no-gap, 97

      '|' no-gap, 99 '##' no-gap, 109

      '|' no-gap, 111 '####' no-gap, 121 '|'.

    write :  / '-------------------------------------------------------------------------------------------------------------------------'.

  endif.



  " ##

  loop at gt_shipping_print into gs_shipping_print.

    " ## ## ##

    data : lv_ddate(10).  " ####

    data : lv_rdate(10).  " ####



    data lv_slamt type p decimals 0." ### ###



    perform fmt_date using gs_shipping_print-zddate changing lv_ddate. " ####

    perform fmt_date using gs_shipping_print-zrdate changing lv_rdate.  "####



    lv_slamt = gs_shipping_print-zslamt * c_mul_krw.  " ####



    if p_return = 'X'.

      write : /

        '|' no-gap, 2   gs_shipping_print-zordno      no-gap, 10 " #### (8)

        '|' no-gap, 12  gs_shipping_print-zidcode     no-gap, 20 " ID (8)

        '|' no-gap, 22  gs_shipping_print-zmatnr      no-gap, 30 " #### (8)

        '|' no-gap, 32  gs_shipping_print-zmatname    no-gap, 46 " ### (4)

        '|' no-gap, 48  gs_shipping_print-zmtart_txt  no-gap, 56 " #### (8)

        '|' no-gap, 58  gs_shipping_print-zvolum      no-gap, 62 " ## (4)

        '|' no-gap, 64  gs_shipping_print-vrkme       no-gap, 68 " ## (4)

        '|' no-gap, 70  lv_slamt       no-gap, 85 " #### (15)

        '|' no-gap, 87  gs_shipping_print-zdflag_txt      no-gap, 97 " ####  (10)

        '|' no-gap, 99  gs_shipping_print-zdgubun_txt     no-gap, 109 " ## (10)

        '|' no-gap, 111 gs_shipping_print-zddate  no-gap, 121 " #### (10)




*        '|' no-gap, 123 gs_shipping_print-ZRDATE  no-gap, 133 '|'. " #### (10)




        '|' no-gap, 123 lv_rdate  no-gap, 133 '|'. " #### (10)

      write :  / '-------------------------------------------------------------------------------------------------------------------------------------'.

    else.

      write : /

      '|' no-gap, 2   gs_shipping_print-zordno      no-gap, 10 " #### (8)

      '|' no-gap, 12  gs_shipping_print-zidcode     no-gap, 20 " ID (8)

      '|' no-gap, 22  gs_shipping_print-zmatnr      no-gap, 30 " #### (8)

      '|' no-gap, 32  gs_shipping_print-zmatname    no-gap, 46 " ### (4)

      '|' no-gap, 48  gs_shipping_print-zmtart_txt  no-gap, 56 " #### (8)

      '|' no-gap, 58  gs_shipping_print-zvolum      no-gap, 62 " ## (4)

      '|' no-gap, 64  gs_shipping_print-vrkme       no-gap, 68 " ## (4)

      '|' no-gap, 70  lv_slamt       no-gap, 85 " #### (15)

      '|' no-gap, 87  gs_shipping_print-zdflag_txt      no-gap, 97 " ####  (10)

      '|' no-gap, 99  gs_shipping_print-zdgubun_txt     no-gap, 109 " ## (10)

      '|' no-gap, 111 gs_shipping_print-zddate  no-gap, 121 '|'. " #### (10)

          write :  / '-------------------------------------------------------------------------------------------------------------------------'.

    endif.

  endloop.

endform.