
*&---------------------------------------------------------------------*

*&  Include           ZEDR17_022_F01

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




      repid     = sy-repid " docking container #### ID

      dynnr     = sy-dynnr " dockiing container ### ##




*     side      = DOCK_AT_LEFT




      extension = 2000 "  #### ### ## ##




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

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form field_catalog .

  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 1. " coll_pos# ### output ## ##

  gs_fieldcat-fieldname = 'ZCODE'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-just = 'L'. " ## ## (L#, R#, C##)

  gs_fieldcat-hotspot = 'X'. " hotspot ### ##### fieldcat ##

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

  call method gc_grid->set_table_for_first_display

    exporting




*     i_buffer_active =

*     i_bypassing_buffer            =

*     i_consistency_check           =

*     i_structure_name              =




      is_variant      = gs_variant

      i_save          = 'A' " alv##### #### ##### ## ### ##




*     i_default       = 'X'




      is_layout       = gs_layout "-> # not valid ##??




*     is_print        =

*     it_special_groups             =

*     it_toolbar_excluding          =

*     it_hyperlink    =

*     it_alv_graphics =

*     it_except_qinfo =

*     ir_salv_adapter =




    changing

      it_outtab       = gt_student

      it_fieldcatalog = gt_fieldcat

      it_sort         = gt_sort




*     it_filter       =

*    exceptions

*     invalid_parameter_combination = 1

*     program_error   = 2

*     too_many_lines  = 3

*     others          = 4




    .

  if sy-subrc <> 0.




*   Implement suitable error handling here




  endif.

  .





endform.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form refresh .

  " lvc_s_stbl ### se24 -> cl_gui_alv_grid## REFRESH_TABLE_DISPLAY ##### signature# #### ##

  data : ls_stable type lvc_s_stbl.



  " ALV #### # ## ## #/#(##,###) ### ### ##

  ls_stable-row = 'X'.

  ls_stable-col = 'X'.



  call method gc_grid->refresh_table_display " gc_grid #### # refresh### ##### ### -># ##

    exporting

      is_stable = ls_stable




*     i_soft_refresh =

*    exceptions

*     finished  = 1

*     others    = 2




    .

  if sy-subrc <> 0.




*   Implement suitable error handling here




  endif.



endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_TOOLBAR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_OBJECT  text

*      -->P_E_INTERACTIVE  text

*----------------------------------------------------------------------*




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

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form class_event .

  create object go_event. " ### ## ##

  set handler go_event->handler_toolbar for gc_grid. " ## ## # ### #### ### ##

  set handler go_event->handler_user_command for gc_grid. " ## ## # ### #### ### ##

  set handler go_event->handler_hotspot_click for gc_grid.



endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDER_USER_COMMAND

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




form alv_handler_user_command  using    p_ucomm.

  case p_ucomm.

    when 'TEXT'.

      message '##########' type 'I'.

  endcase.

endform.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_HOTSPOT_CLICK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_ROW_ID  text

*      -->P_E_COLUMN_ID  text

*      -->P_ES_ROW_NO  text

*----------------------------------------------------------------------*




form alv_handler_hotspot_click  using    p_row_id type lvc_s_row

                                         p_column_id type lvc_s_col

                                         p_row_no type lvc_s_roid.

  " hotspot ##

  " hotspot #### param # ### E_COLUMN_ID# ### lvc_s_col# #### fieldname### ##### ##

  case p_column_id-fieldname.  " column ##. ### ## ##  ##

    when 'ZCODE'."  #### ## ## ### ##

      " hotspot #### param # ### E_ROW_NO# ### lvc_s_roid# #### ROW_ID### ##### ##

      " ### ## # ##(p_row_no-row_id)# ### ALV ## ###(gt_student)## ## ## #### ##

      read table gt_student into gs_student index p_row_no-row_id. " row ##

      " ### zcode# sap #### ### 'XUS'# ## -> su01## #### ## ###(zcode)##### ##

      set parameter id 'XUS' field gs_student-zcode. " SAP ## Parameter ID for User Name (SU01# ### ID ## ##)

      call transaction 'SU01'. " hotspot #### ## ##### ###(su01) ## -> ## ### ## #### ##

  endcase.

endform.