
*&---------------------------------------------------------------------*

*& Report ZEDR17_015

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR17_015.






*tables : zedt17_001.

*data : begin of gs_student.

*  include type zedt17_001.

*  data : end of gs_student.

*data : gt_student like table of gs_student.

*

** [Function ALV]

*selection-screen begin of block b1 with frame.

*  select-options : s_zcode for zedt17_001-zcode.

*selection-screen end of block b1.

*

*initialization.

*s_zcode-low = 'SSU-01'.

*s_zcode-high = 'SSU-99'.

*append s_zcode.

*

*at selection-screen output.

*  loop at screen.

*    if screen-group1 = 'SC1'.

*      screen-input = 0.

*    endif.

*    modify screen.

*  endloop.

*

*start-of-selection.

*  perform get_data.

*  perform modify_data.

*end-of-selection.

*  perform alv_display.

*

*

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

*form get_data .

*  select * from zedt17_001

*    into corresponding fields of table gt_student

*    where zcode in s_zcode.

*endform.

**&---------------------------------------------------------------------*

**&      Form  MODIFY_DATA

**&---------------------------------------------------------------------*

*form modify_data .

*

*endform.

*

**&---------------------------------------------------------------------*

**&      Form  ALV_DISPLAY

**&---------------------------------------------------------------------*

*form alv_display .

* call function 'REUSE_ALV_LIST_DISPLAY'

*  exporting

*    i_structure_name = 'ZEDT17_001'

*  tables

*    t_outtab = gt_student.

*endform.



*****************************************************************************

** ## #### ### ALV




" 1. ## #### ####### ### ##




*" se11# type group## slis ### #, ## ## # ## ##### ##

*types : begin of slis_fieldcat_main.

*  include type slis_fieldcat_main0.

*  include type slis_fieldcat_main1.

*types : end of slis_fieldcat_main.

*

*types : begin of slis_fieldcat_alv_spec,

*  key_sel(1) type c,

*  no_sum(1) type c,

*  sp_group(4) type c,

*  reprep(1) type c,

*  input(1) type c,

*  edit(1) type c,

*  hotspot(1) type c,

*  end of slis_fieldcat_alv_spec.

*

*types : begin of slis_fieldcat_alv.

*  include type slis_fieldcat_main.

*  include type slis_fieldcat_alv_spec.

*types : end of slis_fieldcat_alv.

*

*types : begin of slis_fieldcat_alv1.

*  include type slis_fieldcat_main1.

*types : end of slis_fieldcat_alv1.

*

*types : slis_t_fieldcat_alv type slis_fieldcat_alv occurs 1.

*types: begin of slis_fieldcat_main0,

*         row_pos        like sy-curow, " output in row

*         col_pos        like sy-cucol, " position of the column

*         fieldname      type slis_fieldname,

*         tabname        type slis_tabname,

*         currency(5)    type c,

*         cfieldname     type slis_fieldname, " field with currency unit

*         ctabname       type slis_tabname,   " and table

*         ifieldname     type slis_fieldname, " initial column

*         quantity(3)    type c,

*         qfieldname     type slis_fieldname, " field with quantity unit

*         qtabname       type slis_tabname,   " and table

*         round          type i,        " round in write statement

*         exponent(3)       type c,     " exponent for floats

*         key(1)         type c,        " column with key-color

*         ...

*  end of slis_fieldcat_main0.






tables : zedt17_001.



data : gs_student type zedt17_002.




*data : begin of gs_student,

*  zcode type zedt17_001-zcode, "####

*  zpernr type zedt17_001-zpernr, "####

*  crdate type zedt17_001-crdate, "####

*  zmajor type zedt17_002-zmajor, "##

*  zmname type zedt17_002-zmname, "###

*  zsum type zedt17_002-zsum, "####

*  zwaers type zedt17_002-zwaers. "##

*  data : end of gs_student.




data : gt_student like table of gs_student.



data : gs_fieldcat type slis_fieldcat_alv.

data : gt_fieldcat type slis_t_fieldcat_alv.



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

  select * from zedt17_002

    into corresponding fields of table gt_student

    where zcode in s_zcode.




*  select a~zcode a~zpernr a~crdate b~zmajor b~zmname b~zsum b~zwaers

*    into corresponding fields of table gt_student

*    from zedt17_001 as a

*    inner join zedt17_002 as b

*      on a~zcode = b~zcode

*    where a~zcode in s_zcode.




endform.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*




form modify_data .



endform.






*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




form alv_display .

 perform field_catalog.




* perform call_alv.




 call function 'REUSE_ALV_GRID_DISPLAY'

 exporting




*  i_structure_name = 'zedt17_001'




   it_fieldcat = gt_fieldcat

 tables

   t_outtab = gt_student.

endform.






* [ALV ## #### ##]



*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




form field_catalog .

  clear : gs_fieldcat, gt_fieldcat.

  gs_fieldcat-col_pos = 1. " coll_pos# ### output ## ##

  gs_fieldcat-fieldname = 'ZCODE'. " ### ####### ### ### dump ##### ##

                                   " alv ### ######## ###### ### ## ## ### ##.

  gs_fieldcat-seltext_m = '####'. " _m# medium ##. ## ### # ## # (s, l# ##)

                                   " sltext_s = short, sltext_m = medium, sltext_l = large

  gs_fieldcat-key = 'X'. " # ### ## -> ### ##### ###

  gs_fieldcat-just = 'L'. " ## ## (L#, R#, C##)

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-fieldname = 'ZPERNR'.

  gs_fieldcat-seltext_m = '####'.

  gs_fieldcat-key = 'X'. " # ### ## -> ### ##### ###

  gs_fieldcat-just = 'C'. " ## ## (L#, R#, C##)

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZMNAME'.

  gs_fieldcat-seltext_m = '##'.

  gs_fieldcat-just = 'R'. " ## ## (L#, R#, C##)

  gs_fieldcat-no_out = 'X'. " ## ## ##

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZMNAME'.

  gs_fieldcat-seltext_m = '###'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 5.

  gs_fieldcat-fieldname = 'ZSUM'.

  gs_fieldcat-seltext_m = '####'.

  gs_fieldcat-currency = 'KRW'. " ### ### ### ### ####

  gs_fieldcat-do_sum = 'X'. " ## ## ## ### ### #### ## # ##.

  gs_fieldcat-no_zero = 'X'. " 0# ##

  gs_fieldcat-no_sign = 'X'. " #### ##

  gs_fieldcat-outputlen = 20. " ### ## ##

  gs_fieldcat-emphasize = 'X'. " ## ##

  gs_fieldcat-edit = 'X'. " ## ### # ### ## #### ##

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'ZWAERS'.

  gs_fieldcat-seltext_m = '##'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 7.

  gs_fieldcat-fieldname = 'CRDATE'.

  gs_fieldcat-seltext_m = '###'.

  gs_fieldcat-edit_mask = '____-__-__'.

  gs_fieldcat-outputlen = 10. " ### ## ##

  append gs_fieldcat to gt_fieldcat.

endform.