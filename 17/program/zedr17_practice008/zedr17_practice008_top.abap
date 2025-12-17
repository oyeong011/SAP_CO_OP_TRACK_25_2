
*&---------------------------------------------------------------------*

*&  Include           ZEDR17_PRACTICE008_TOP

*&---------------------------------------------------------------------*






tables : zedt17_100, zedt17_101. " ####(zedt17_100), ####(zedt17_101)



" ### ## ##

constants: c_col_green(4) value '@08@', " ## ### ###

           c_col_red(4) value '@0A@'. " ## ### ###



" ####(zedt17_100)

data : begin of gs_order.

    include structure
zedt17_100
.

data : end of gs_order.

data : gt_order like table of gs_order. " ## ## itab



" #### ## ### itab

data : begin of gs_order_print,

         zcolor(4), " ###

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

         zwaers           type zedt17_100-zwaers, " ##

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

         zcolor(4), " ###

         zordno          type zedt17_101-zordno,   " ####

         zidcode         type zedt17_101-zidcode,  " ID

         zmatnr          type zedt17_101-zmatnr,   " ####

         zmatname        type zedt17_101-zmatname, " ###

         zmtart          type zedt17_101-zmtart,   " ####(##)

         zmtart_txt(10) ,   " ####(##)

         zvolum          type zedt17_101-zvolum,   " ##

         vrkme           type zedt17_101-vrkme,    " ##

         zslamt          type zedt17_101-zslamt,   " ####

         zwaers          type zedt17_100-zwaers, " ##

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





" range ## ## ## - db### ## (####/####)

ranges : gr_jdate for zedt17_100-zjdate,  " DATS(8)

         gr_shdate for zedt17_101-zddate. " DATS(8)



data : ok_code type sy-ucomm." ### ## ### ## -> ###### ## ## ####### ### ####



data : gc_docking type ref to cl_gui_docking_container. " ## ## ##

data : gc_grid_100 type ref to cl_gui_alv_grid. " #### grid ## ##

data : gc_grid_200 type ref to cl_gui_alv_grid. " #### grid ## ##



data : gs_variant type disvariant. " #### ## ## ##



" class alv(cl_gui_alv_grid)##

" lvc_s_fcat

data : gs_fieldcat type lvc_s_fcat.

data : gt_fieldcat type lvc_t_fcat.

data : gs_layout type lvc_s_layo.

data : gs_sort type lvc_s_sort.

data : gt_sort type lvc_t_sort.