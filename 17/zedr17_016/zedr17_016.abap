
*&---------------------------------------------------------------------*

*& Report ZEDR17_016

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR17_016.






* [ALV_LAYOUT], [## #### ##]






tables : zedt17_001.






*data : gs_student type zedt17_002.




data : begin of gs_student,

  zcheckbox type c, " #### ## ## ##

  zcolor(4), "### ## #### ## ##(4)

  zcode type zedt17_001-zcode, "####

  zpernr type zedt17_001-zpernr, "####

  zkname type zedt17_001-zkname, "##

  zename type zedt17_001-zename, "####

  zgender type zedt17_001-zgender, "##

  zmajor type zedt17_002-zmajor, "##

  zmname type zedt17_002-zmname. "###




*  zsum type zedt17_002-zsum, "####

*  zwaers type zedt17_002-zwaers. "##




  data : end of gs_student.




*data : gt_student like table of gs_student.




data : gt_student like gs_student occurs 0 with header line.



data : gs_fieldcat type slis_fieldcat_alv.

data : gt_fieldcat type slis_t_fieldcat_alv.



data : gs_layout type slis_layout_alv. " alv #### - ### ##



data : gs_sort type slis_sortinfo_alv.

data : gt_sort type slis_t_sortinfo_alv.



selection-screen begin of block b1 with frame.

  select-options : s_zcode for zedt17_001-zcode.

  parameters : p_zpernr like zedt17_001-zpernr.

  parameters : p_zgen like zedt17_001-zgender modif id sc1.

selection-screen end of block b1.





initialization.

s_zcode-low = 'SSU-01'.

s_zcode-high = 'SSU-99'.

append s_zcode.



at selection-screen output.

  loop at screen.

    if screen-group1 = 'SC1'.

      screen-input = 0.

    endif.

    modify screen.

  endloop.





start-of-selection.

  perform get_data.

  perform modify_data.

end-of-selection.

  perform alv_display.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




form get_data .




*  select * from zedt17_002

*    into corresponding fields of table gt_student

*    where zcode in s_zcode.




  select a~zcode a~zpernr a~zkname a~zename a~zgender b~zmajor b~zmname

    into corresponding fields of table gt_student

    from zedt17_001 as a

    inner join zedt17_002 as b

      on a~zcode = b~zcode

    where a~zcode in s_zcode.

endform.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*




form modify_data .

  " ###### #### #### ###

  " ## ## ##### ## ##

  " => ####.

  clear gs_student.

  loop at gt_student into gs_student.

    if gs_student-zename is initial.

      gs_student-zcolor = '@0A@'. " ## ###

      " @0A@ : ## ###

      " @0B@ : ## ##

      " @0C@ : ## ##

      " @08@ : ##

    endif.



    modify gt_student from gs_student index sy-tabix.

    clear gs_student.

  endloop.

endform.






*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




form alv_display .

 perform field_catalog.

 perform alv_layout.

 perform alv_sort.

 perform call_alv.

endform.






*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




form alv_layout .

  gs_layout-no_colhead = 'X'. " alv ## ## ## -> #### ##

  gs_layout-zebra = 'X'. " ## ### ## ### -> ### ## ##. # # #### ## # #

  gs_layout-no_vline = 'X'. " no vertial line. grid# ### ##### ##

  gs_layout-no_hline = 'X'. " no horizontal line. grid# ### ##### ##.




*  gs_layout-edit = 'X'. " ## ## ####. ####### edit## ## ###.

*  gs_layout-totals_before_items = 'X'. " ## ### # # ### ##




endform.






*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

**" function# ## ## #### ##: reuse_alv_fieldcatlog_merge ####

**" ## #### ### ######(gt_fieldcat)# ##




form call_alv .




*  call function 'REUSE_ALV_FIELDCATALOG_MERGE'

*    exporting

*      i_program_name         =     sy-repid

*      i_internal_tabname     =    'GT_STUDENT'

*      i_inclname             =     sy-repid

*    changing

*      ct_fieldcat            =     gt_fieldcat.




 call function 'REUSE_ALV_GRID_DISPLAY'

 exporting




*  i_structure_name = 'zedt17_001'




   it_fieldcat = gt_fieldcat

   is_layout = gs_layout

   it_sort = gt_sort

 tables

   t_outtab = gt_student.

endform.






*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




form alv_sort .

  gs_sort-spos = 1. " ## ####

  gs_sort-fieldname = 'ZCODE'. " ### ### ### ##

  gs_sort-up = 'X'. " #### #### ##




*  gs_sort-down = 'X'. " #### #### ##




  gs_sort-subtot = 'X'. " ####

  append gs_sort to gt_sort.

endform.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




form field_catalog .



  " ####




*  clear : gs_fieldcat, gt_fieldcat.

*  gs_fieldcat-col_pos = 1.

*  gs_fieldcat-fieldname = 'ZCHECKBOX'.

*  gs_fieldcat-seltext_m = '####'.

*  gs_fieldcat-checkbox = 'X'. " ####

*  gs_fieldcat-edit = 'X'. " ## ##

*  append gs_fieldcat to gt_fieldcat.






  " ### ##

  clear : gs_fieldcat, gt_fieldcat.

  gs_fieldcat-col_pos = 1.

  gs_fieldcat-fieldname = 'ZCOLOR'.

  gs_fieldcat-seltext_m = '##'.

  gs_fieldcat-icon = 'X'. " #####

  append gs_fieldcat to gt_fieldcat.





  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 2. " coll_pos# ### output ## ##

  gs_fieldcat-fieldname = 'ZCODE'.

  " ### ####### ### ### dump ##### ##

  " alv ### ######## ###### ### ## ## ### ##.

  gs_fieldcat-seltext_m = '####'.

  " _m# medium ##. ## ### # ## # (s, l# ##)

  " sltext_s = short, sltext_m = medium, sltext_l = large




*  gs_fieldcat-key = 'X'. " # ### ## -> ### ##### ###




  gs_fieldcat-icon = 'X'. " icon ## #### ##

  gs_fieldcat-just = 'L'. " ## ## (L#, R#, C##)

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZPERNR'.

  gs_fieldcat-seltext_m = '####'.




*  gs_fieldcat-key = 'X'. " # ### ## -> ### ##### ###




  gs_fieldcat-just = 'C'. " ## ## (L#, R#, C##)

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZKNAME'.

  gs_fieldcat-seltext_m = '##'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 5.

  gs_fieldcat-fieldname = 'ZENAME'.

  gs_fieldcat-seltext_m = '###'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'ZGENDER'.

  gs_fieldcat-seltext_m = '##'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 7.

  gs_fieldcat-fieldname = 'ZMNAME'.

  gs_fieldcat-seltext_m = '##'.

  gs_fieldcat-just = 'R'. " ## ## (L#, R#, C##)

  gs_fieldcat-no_out = 'X'. " ## ## ##

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 8.

  gs_fieldcat-fieldname = 'ZMNAME'.

  gs_fieldcat-seltext_m = '###'.

  append gs_fieldcat to gt_fieldcat.

endform.