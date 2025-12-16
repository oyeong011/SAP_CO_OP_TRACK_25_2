
*&---------------------------------------------------------------------*

*&  Include           ZDOCKING_CONTAINER17_F01

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




*      parent                      =




      repid                       = sy-repid " docking container #### ID

      dynnr                       = sy-dynnr " dockiing container ### ##




*      side                        = DOCK_AT_LEFT




      extension                   = 2000 "  #### ### ## ##




*      style                       =

*      lifetime                    = lifetime_default

*      caption                     =

*      metric                      = 0

*      ratio                       =

*      no_autodef_progid_dynnr     =

*      name                        =

*    exceptions

*      cntl_error                  = 1

*      cntl_system_error           = 2

*      create_error                = 3

*      lifetime_error              = 4

*      lifetime_dynpro_dynpro_link = 5

*      others                      = 6




      .

  if sy-subrc <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  endif.

create object gc_grid

  exporting




*    i_shellstyle      = 0

*    i_lifetime        =




    i_parent          = gc_docking




*    i_appl_events     = space

*    i_parentdbg       =

*    i_applogparent    =

*    i_graphicsparent  =

*    i_name            =

*    i_fcat_complete   = SPACE

*  exceptions

*    error_cntl_create = 1

*    error_cntl_init   = 2

*    error_cntl_link   = 3

*    error_dp_create   = 4

*    others            = 5




    .

if sy-subrc <> 0.




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




*      i_buffer_active               =

*      i_bypassing_buffer            =

*      i_consistency_check           =

*      i_structure_name              =




      is_variant                    = gs_variant

      i_save                        = 'A' " alv##### #### ##### ## ### ##




*      i_default                     = 'X'




      is_layout                     = gs_layout "-> # not valid ##??




*      is_print                      =

*      it_special_groups             =

*      it_toolbar_excluding          =

*      it_hyperlink                  =

*      it_alv_graphics               =

*      it_except_qinfo               =

*      ir_salv_adapter               =




    changing

      it_outtab                     = gt_student

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

  call method gc_grid->refresh_table_display " gc_grid #### # refresh### ##### ### -># ##

    exporting

      is_stable      = ls_stable




*      i_soft_refresh =

*    exceptions

*      finished       = 1

*      others         = 2




          .

  if sy-subrc <> 0.




*   Implement suitable error handling here




  endif.



endform.