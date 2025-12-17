
*&---------------------------------------------------------------------*

*&  Include           ZEDR17_PRACTICE009_TOP

*&---------------------------------------------------------------------*




tables: zedt17_102. " #### ### - ####*, ####*(### ##), datbi(####), datab(####), ####, ####, ####, ####

tables: zedt17_103. " ####-#### - ####, ####, ##, ##

tables: zedt17_104. " #### - ####, ####, ##, datbi, datab, ####




*tables: zedt17_105. " #### - ####, ##, n###




tables: zedt17_106. " #### - ####, ##, datbi, datab, ####, ####, ####



" ### ## ##

constants: c_col_green(4) value '@08@'. " ## ### ###

constants: c_col_red(4) value '@0A@'. " ## ### ###

constants:  c_col_yellow(4) value '@09@'. " ## ### ###



ranges : r_zqflag for zedt17_102-zqflag. " ### ## ##






* 1# ### (####)  ###




data : begin of gs_emp,

         zcolor(4), " ##(zcolor(4))

         zpernr    like zedt17_102-zpernr, " ####(zedt17_102-zpernr)

         zpname    like zedt17_103-zpname, " ##(zedt17_103-zpname)

         zdepcode  like zedt17_102-zdepcode, " ##(zedt17_102-zdepcode) - #### ## ##

         datbi     like zedt17_102-datbi, " ####(zedt17_102-datbi)

         datab     like zedt17_102-datab, " ####(zedt17_102-datab)

         zdeprank  like zedt17_102-zdeprank, " ##(zedt17_102-zdeprank) - #### ## ##

         zgender   like zedt17_103-zgender, " ##(zedt17_103-zgender)

         zedate    like zedt17_102-zedate, " ####(zedt17_102-zedate)

         zaddress  like zedt17_103-zaddress, " ##(zedt17_103-zaddress)

         zqdate    like zedt17_102-zqdate, " ####(zedt17_102-zqdate)

         zqflag    like zedt17_102-zqflag, " ####(zedt17_102-zflag)

       end of gs_emp.

data : gt_emp like table of gs_emp.




* 1# ### (####)  ALV ###




data : begin of gs_001,

         zcolor(4), " ##(zcolor(4))

         zpernr        like zedt17_102-zpernr, " ####(zedt17_102-zpernr)

         zpname        like zedt17_103-zpname, " ##(zedt17_103-zpname)

         zdepcode      like zedt17_102-zdepcode, " ##(zedt17_102-zdepcode)

         zdep_txt(10), " ##(zedt17_102-zdepcode) - #### ### ##

         datbi         like zedt17_102-datbi, " ####(zedt17_102-datbi)

         datab         like zedt17_102-datab, " ####(zedt17_102-datab)

         zdeprank      like zedt17_102-zdeprank, " ##(zedt17_102-zdeprank)

         zrank_txt(10) , " ##(zedt17_102-zdeprank) - #### ### ##

         zgender       like zedt17_103-zgender, " ##(zedt17_103-zgender)

         zgen_txt(4), " ##(zedt17_103-zgender)

         zedate        like zedt17_102-zedate, " ####(zedt17_102-zedate)

         zaddress      like zedt17_103-zaddress, " ##(zedt17_103-zaddress)

         zqdate        like zedt17_102-zqdate, " ####(zedt17_102-zqdate)

         zqflag        like zedt17_102-zqflag, " ####(zedt17_102-zflag)

       end of gs_001.

data : gt_001 like table of gs_001.






* 2# ### (##)  ###




data : begin of gs_eval,

         zpernr   like zedt17_104-zpernr, " ####(zedt17_104-zpernr)

         zdepcode like zedt17_104-zdepcode, " ##(zedt17_104-zdepcode) - #### ## ##

         zyear    like zedt17_104-zyear, " ##(zedt17_104-zyear)

         datbi    like zedt17_104-datbi, " ####(zedt17_104-datbi)

         datab    like zedt17_104-datab, " ####(zedt17_104-datab)

         zrank    like zedt17_104-zrank, " ##(zedt17_104-zrank)

       end of gs_eval.

data : gt_eval like table of gs_eval.




* 2# ### (##) ALV ###




data : begin of gs_002,

         zpernr       like zedt17_104-zpernr, " ####(zedt17_104-zpernr)

         zdepcode     like zedt17_104-zdepcode, " ##(zedt17_104-zdepcode)

         zdep_txt(10), " ##(zedt17_104-zdepcode) - #### ### ##

         zyear        like zedt17_104-zyear, " ##(zedt17_104-zyear)

         datbi        like zedt17_104-datbi, " ####(zedt17_104-datbi)

         datab        like zedt17_104-datab, " ####(zedt17_104-datab)

         zrank        like zedt17_104-zrank, " ##(zedt17_104-zrank)

       end of gs_002.

data : gt_002 like table of gs_002.






* 3# ### (##)  ###




data : begin of gs_salary,

         zpernr    like zedt17_106-zpernr, " ####(zedt17_106-zpernr)

         zyear     like zedt17_106-zyear, " ##(zedt17_106-zyear)

         datbi     like zedt17_106-datbi, " ####(zedt17_106-datbi)

         datab     like zedt17_106-datab, " ####(zedt17_106-datab)

         zsalary   like zedt17_106-zsalary, " ####(zedt17_106-zsalary)

         zbankcode like zedt17_106-zbankcode, " ###(zedt17_106-zbankcode) - #### ## ##

         zaccount  like zedt17_106-zaccount, " ####(zedt17_106-zaccount)

       end of gs_salary.

data : gt_salary like table of gs_salary.




* 3# ### (##) ALV ###




data : begin of gs_003,

         zpernr        like zedt17_106-zpernr, " ####(zedt17_106-zpernr)

         zyear         like zedt17_106-zyear, " ##(zedt17_106-zyear)

         datbi         like zedt17_106-datbi, " ####(zedt17_106-datbi)

         datab         like zedt17_106-datab, " ####(zedt17_106-datab)

         zsalary       like zedt17_106-zsalary, " ####(zedt17_106-zsalary)

         zwaers        type waers,

         zbankcode     like zedt17_106-zbankcode, " ###(zedt17_106-zbankcode)

         zbank_txt(10), " ###(zedt17_106-zbankcode) - #### ### ##

         zaccount      like zedt17_106-zaccount, " ####(zedt17_106-zaccount)

       end of gs_003.

data : gt_003 like table of gs_003.



" ## ##/## ###

data : gv_mon_first type sy-datum.

data : gv_mon_last  type sy-datum.



data : ok_code type sy-ucomm." ### ## ### ## -> ###### ## ## ####### ### ####



data : gc_docking type ref to cl_gui_docking_container. " ## ## ##

data : gc_splitter_main type ref to cl_gui_splitter_container. " ## #### 2#(##)# ##

data : gc_splitter2 type ref to cl_gui_splitter_container. " 2,3# ### ##(##) ##



data : gc_cont_docking type ref to cl_gui_container. " docking(### ### ##)

data : gc_cont_bottom type ref to cl_gui_container. " ## ## (1# ### ##)

data : gc_cont_top_left type ref to cl_gui_container. " 2#(##) ## ##

data : gc_cont_top_right type ref to cl_gui_container. " 3#(##) ## ##



data : gc_grid1 type ref to cl_gui_alv_grid. " gc_cont_bottom#  ## grid ## ##

data : gc_grid2 type ref to cl_gui_alv_grid. " gc_cont_top_right# ## grid ## ##

data : gc_grid3 type ref to cl_gui_alv_grid. " gc_cont_top_left# ## grid ## ##



data : gs_variant type disvariant. " #### ## ## ##



" class alv(cl_gui_alv_grid)##

" lvc_s_fcat

data : gs_fieldcat type lvc_s_fcat.

data : gt_fieldcat1 type lvc_t_fcat.

data : gt_fieldcat2 type lvc_t_fcat.

data : gt_fieldcat3 type lvc_t_fcat.



data : gs_layout type lvc_s_layo.



data : gs_sort type lvc_s_sort.

data : gt_sort1 type lvc_t_sort.

data : gt_sort2 type lvc_t_sort.

data : gt_sort3 type lvc_t_sort.