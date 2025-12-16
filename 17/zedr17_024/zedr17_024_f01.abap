
*&---------------------------------------------------------------------*

*&  Include           ZEDR17_024_F01

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

      repid     = sy-repid " docking container #### ID

      dynnr     = sy-dynnr " dockiing container ### ##

      extension = 2000. "  #### ### ## ##                = 6

  if sy-subrc <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  endif.

  create object gc_grid

    exporting

      i_parent = gc_docking.

endform.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




form field_catalog .

  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 1. " coll_pos# ### output ## ##

  gs_fieldcat-fieldname = 'ZCOLOR'.

  gs_fieldcat-scrtext_m = '##'.

  gs_fieldcat-just = 'L'. " ## ## (L#, R#, C##)

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 2. " coll_pos# ### output ## ##

  gs_fieldcat-fieldname = 'ZCODE'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-just = 'L'. " ## ## (L#, R#, C##)

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZPERNR'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-just = 'C'. " ## ## (L#, R#, C##)

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZKNAME'.

  gs_fieldcat-scrtext_m = '##'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 5.

  gs_fieldcat-fieldname = 'ZENAME'.

  gs_fieldcat-scrtext_m = '###'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'ZGENDER'.

  gs_fieldcat-scrtext_m = '##'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 7.

  gs_fieldcat-fieldname = 'ZTEL'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-edit      = 'X'. " ## #### ## ## # ##

  gs_fieldcat-outputlen = 16. " ## ### ## ##/## ## # ##





  append gs_fieldcat to gt_fieldcat.

endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




form alv_layout .

  clear gs_layout.

  gs_layout-zebra = 'X'. " ## ### ## ### -> ### ## ##. # # #### ## # #



  " variant# #### ## #### ## #### ##### #### ### # ##

  " (## ## ##, ###, ## #)




*   gs_layout-edit  = 'X'.




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

      is_variant      = gs_variant

      i_save          = 'A' " alv##### #### ##### ## ### ##

      is_layout       = gs_layout "-> # not valid ##??

    changing

      it_outtab       = gt_student

      it_fieldcatalog = gt_fieldcat

      it_sort         = gt_sort.

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

      is_stable = ls_stable.

endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_TOOLBAR

*&---------------------------------------------------------------------*




form alv_handler_toolbar  using    p_object type ref to cl_alv_event_toolbar_set

                                   p_interactive.

  " toolbar ##

  " e_object type cl_alv_event_toolbar_set

  " cl_alv_event_toolbar_set -> mt_toolbar ##

  " mt_toolbar -> ttb_button

  " ttb_button -> stb_button #### toolbar ## ##

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

  " register_edit : screen# itab ###

  call method gc_grid->register_edit_event

    exporting

      i_event_id = cl_gui_alv_grid=>mc_evt_modified. " ###,enter,tab# ## ### data_changed event##

  create object go_event. " ### ## ##

  set handler go_event->handler_toolbar for gc_grid. " ## ## # ### #### ### ##

  set handler go_event->handler_user_command for gc_grid. " ## ## # ### #### ### ##

  set handler go_event->handler_data_changed for gc_grid. " ztel ### ##

  set handler go_event->handler_data_changed_finished for gc_grid. " ### ztel ### ##

  " ##) data_changed# data_changed_finished# ##(##)## ##### # ###

  " ### ## #### ###, ### ##### ##### ### ##### ####

endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDER_USER_COMMAND

*&---------------------------------------------------------------------*




form alv_hander_user_command  using    p_ucomm.

  case p_ucomm.

    when 'TEXT'.

      message '##########' type 'I'.

  endcase.

endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGD

*&---------------------------------------------------------------------*




form alv_handler_data_changed  using   p_data_changed type ref to cl_alv_changed_data_protocol

                                       p_onf4

                                       p_onf4_before

                                       p_onf4_after

                                       p_ucomm.

  " cl_alv_changed_data_protocol => mt_good_cells

  " - cl_alv_changed_data_protocol:  cl_gui_alv_grid ##### data_changed ##### er_data_changed ##### associated type

  " - mt_good_cells": er_data_changed# attributes # ##

  " gt_good_cells type lvc_t_modi

  " - mt_good_cells ## LVC_T_MODI #### ##

  " lvc_t_modi type lvc_s_modi

  " lvc_s_modi=>fieldname (####), row_id (#####), value (###)



  data : ls_modi type lvc_s_modi.

  data : lv_len(02).




*  " ## 1

*  clear : ls_modi, lv_len.

*  loop at p_data_changed->mt_good_cells into ls_modi.

*    if ls_modi-fieldname = 'ZTEL'.

*      read table gt_student into gs_student index ls_modi-row_id.

*      if ls_modi-value is initial.

*        gs_student-zcolor = icon_led_red.

*      else.

*        lv_len = strlen( ls_modi-value ).

*        if lv_len = '11'.

*          gs_student-zcolor = icon_led_green.

*        else.

*          gs_student-zcolor = icon_led_yellow.

*        endif.

*      endif.

*

*      modify gt_student from gs_student index ls_modi-row_id.

*      clear gs_student.

*    endif.

*  endloop.

*

*  perform refresh.



*  " ## 2

*  loop at p_data_changed->mt_good_cells into ls_modi.

*    if ls_modi-fieldname = 'ZTEL'.

*      clear gs_student.

*      read table gt_student into gs_student index ls_modi-row_id.

*      if ls_modi-value is initial.

*        call method p_data_changed->modify_cell

*          exporting

*            i_row_id    = ls_modi-row_id

*            i_fieldname = 'ZCOLOR'

*            i_value     = icon_led_red.

*      else.

*        lv_len = strlen( ls_modi-value ).

*        if lv_len = '11'.

*          call method p_data_changed->modify_cell

*            exporting

*              i_row_id    = ls_modi-row_id

*              i_fieldname = 'ZCOLOR'

*          i_value = icon_led_green.

*        else.

*          call method p_data_changed->modify_cell

*            exporting

*              i_row_id    = ls_modi-row_id

*              i_fieldname = 'ZCOLOR'

*          i_value = icon_led_yellow.

*        endif.

*      endif.

*      modify gt_student from gs_student index ls_modi-row_id.

*      clear gs_student.

*    endif.

*  endloop.

*  perform refresh.






" ## 3

loop at p_data_changed->mt_good_cells into ls_modi.

  if ls_modi-fieldname = 'ZTEL'.

    read table gt_student into gs_student index ls_modi-row_id.

    if ls_modi-value is initial.

      gs_student-zcolor = icon_led_red.

    else.

      lv_len = strlen( ls_modi-value ).

      if lv_len = '11'.

        gs_student-zcolor = icon_led_green.

      else.

        gs_student-zcolor = icon_led_yellow.

      endif.

    endif.

    modify gt_student from gs_student index ls_modi-row_id.

    clear gs_student.

  endif.

endloop.

call method cl_gui_cfw=>set_new_ok_code

  exporting

    new_code = 'OK'.







endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*




form alv_data_changed_finished  using    p_modified

                                         pt_good_cells type lvc_t_modi.

  " mt_good cells type lvc_t_modi

  " - pt_good_cells : ### ### # ##

  " - fieldname: ### ###

  " - row_id : ### # ## (alv ## ###)

  " - value : #### ### ## #

  " lvc_t_modi type lvc_s_modi

  " - p_modified: 'X'## ### ### ## #### ## (### #### ## ## ## ## ## )

  " lvc_s_modi=>fieldname(####), row_id(#####), value(###)

  data : ls_modi type lvc_s_modi.

  clear : ls_modi.

  loop at pt_good_cells into ls_modi.

    if ls_modi-fieldname = 'ZTEL'. " #### ## ### ##

      read table gt_student into gs_student index ls_modi-row_id.

      if gs_student-zcolor ne icon_led_green. " ### ## -> green ### ## X

        delete table gt_student from gs_student. " #### ## ## ## #### ## ## ## ##### ##

      endif.

      clear gs_student.

    endif.

  endloop.

  perform refresh.

endform.