
*&---------------------------------------------------------------------*

*&  Include           ZEDR17_018_F01

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

  s_zcode-low = 'SSU-01'.

  s_zcode-high = 'SSU-99'.

  append s_zcode.

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

  select * from zedt17_001

    into corresponding fields of table gt_student

    where zcode in s_zcode.

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




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form alv_layout .

  gs_layout-no_colhead = 'X'. " alv ## ## ## -> #### ##

  gs_layout-zebra = 'X'. " ## ### ## ### -> ### ## ##. # # #### ## # #

  gs_layout-no_vline = 'X'. " no vertial line. grid# ### ##### ##

  gs_layout-no_hline = 'X'. " no horizontal line. grid# ### ##### ##.




*  gs_layout-edit = 'X'. " ## ## ####. ####### edit## ## ###.

*  gs_layout-totals_before_items = 'X'. " ## ### # # ### ##




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

  gs_sort-spos = 1. " ## ####

  gs_sort-fieldname = 'ZCODE'. " ### ### ### ##

  gs_sort-up = 'X'. " #### #### ##




*  gs_sort-down = 'X'. " #### #### ##




  gs_sort-subtot = 'X'. " ####

  append gs_sort to gt_sort.

endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form alv_display .

 call function 'REUSE_ALV_GRID_DISPLAY'

 exporting




*  i_structure_name = 'zedt17_001'




   it_fieldcat = gt_fieldcat

   is_layout = gs_layout

   it_sort = gt_sort

 tables

   t_outtab = gt_student.

endform.