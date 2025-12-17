
*&---------------------------------------------------------------------*

*&  Include           ZEDR17_023_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*




form set_init .

  s_zcode-low = 'SSU-01'.

  s_zcode-high = 'SSU-99'.

  append s_zcode.

endform.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




form get_data .

  select * from zedt17_001

  into corresponding fields of table gt_student

  where zcode in s_zcode.

endform.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




form create_object .

  create object gc_docking

    exporting

      repid                       = sy-repid " docking container #### ID

      dynnr                       = sy-dynnr " dockiing container ### ##

      extension                   = 2000 "  #### ### ## ##

      .

create object gc_grid

  exporting

    i_parent          = gc_docking

    .

endform.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




form field_catalog .

  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 1. " coll_pos# ### output ## ##

  gs_fieldcat-fieldname = 'ZCODE'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-just = 'L'. " ## ## (L#, R#, C##)

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-fieldname = 'ZPERNR'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-just = 'C'. " ## ## (L#, R#, C##)

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZKNAME'.

  gs_fieldcat-scrtext_m = '##'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZENAME'.

  gs_fieldcat-scrtext_m = '###'.

  append gs_fieldcat to gt_fieldcat.




*

*  clear : gs_fieldcat.

*  gs_fieldcat-col_pos = 5.

*  gs_fieldcat-fieldname = 'ZGENDER'.

*  gs_fieldcat-scrtext_m = '##'.

*  append gs_fieldcat to gt_fieldcat.

*

*  clear : gs_fieldcat.

*  gs_fieldcat-col_pos = 6.

*  gs_fieldcat-fieldname = 'ZTEL'.

*  gs_fieldcat-scrtext_m = '####'.

*  append gs_fieldcat to gt_fieldcat.




endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




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




form alv_display .

  call method gc_grid->set_table_for_first_display

    exporting

      is_variant                    = gs_variant

      i_save                        = 'A' " alv##### #### ##### ## ### ##

      is_layout                     = gs_layout "-> # not valid ##??

    changing

      it_outtab                     = gt_student

      it_fieldcatalog               = gt_fieldcat

      it_sort                       = gt_sort

          .

    .





endform.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*




form refresh .

  " lvc_s_stbl ### se24 -> cl_gui_alv_grid## REFRESH_TABLE_DISPLAY ##### signature# #### ##

  data : ls_stable type lvc_s_stbl.



  " ALV #### # ## ## #/#(##,###) ### ### ##

  ls_stable-row = 'X'.

  ls_stable-col = 'X'.



  call method gc_grid->refresh_table_display " gc_grid #### # refresh### ##### ### -># ##

    exporting

      is_stable      = ls_stable

          .

endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_TOOLBAR

*&---------------------------------------------------------------------*




form alv_handler_toolbar  using    p_object type ref to cl_alv_event_toolbar_set

                                   p_interactive.

" toolbar ##

" e_object type cl_alv_event_toolbar_set

" cl_alv_event_toolbar_set -> mt_toolbar ##

" mt_toolbar -> ttb_button

" ttb_button -> stb_button #### toolbar ## ##

  data : ls_toolbar type stb_button. " p_object->mt_toolbar# ## ### stb_button

  ls_toolbar-function = 'TEXT'. " ##) ## ### (ok_code## ##### ###)

  ls_toolbar-icon = icon_checked. " ##) ###

  ls_toolbar-quickinfo = 'INFORMATION'. " ##) ### ## ##

  append ls_toolbar to p_object->mt_toolbar. " ## #### ##



endform.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*




form class_event .

  create object go_event. " ### ## ##

  set handler go_event->handler_toolbar for gc_grid. " ## ## # ### #### ### ##

  set handler go_event->handler_user_command for gc_grid. " ## ## # ### #### ### ##

  set handler go_event->handler_double_click for gc_grid.



endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDER_USER_COMMAND

*&---------------------------------------------------------------------*




form alv_handler_user_command  using    p_ucomm.

  case p_ucomm.

    when 'TEXT'.

      message '##########' type 'I'.

  endcase.

endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DOUBLE_CLICK

*&---------------------------------------------------------------------*




form alv_handler_double_click  using    p_row type lvc_s_row

                                        p_column type lvc_s_col

                                        p_row_no type lvc_s_roid.

  " double click ##

  " double_click #### param # ### E_COLUMN# ### lvc_s_col# #### FIELDNAME#### ##

  " - p_row    : ##### ## # ## (### # ##)

  " - p_column : ##### ## ## ## (FIELDNAME # ##)

  " - p_row_no : ALV #### #### row id ## (ROW_ID ####)

 data : lv_char(2). " ###(row_id)# ## #### ## ## ##

 data : lv_message(20). " #### # ### popup# ### ##



 case p_column-fieldname. " ##### ##### ##### ##

   when 'ZCODE'." #### ## ##### ##

     clear gs_student.

     lv_char = p_row_no-row_id. " ##### ## alv row ## (### msg### ##)

     read table gt_student into gs_student index p_row_no-row_id. " ## # #### alv ## ##### ### #

     if sy-subrc = 0. " ## index# ### ####

       lv_char = p_row_no-row_id. " #### # ## ### ##

       concatenate lv_char '## ######' into lv_message. " msg concat##

       message lv_message type 'I'. " info### ##

     endif.

   endcase.



endform.