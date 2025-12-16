
*&---------------------------------------------------------------------*

*&  Include           ZCUSTOM_CONTAINER17_F01

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  SET_INITIAL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form set_initial .

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



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 5.

  gs_fieldcat-fieldname = 'ZGENDER'.

  gs_fieldcat-scrtext_m = '##'.

  append gs_fieldcat to gt_fieldcat.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'ZTEL'.

  gs_fieldcat-scrtext_m = '####'.

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




*  gs_layout-no_colhead = 'X'. " alv ## ## ## -> #### ##




  gs_layout-zebra = 'X'. " ## ### ## ### -> ### ## ##. # # #### ## # #




*  gs_layout-no_vline = 'X'. " no vertial line. grid# ### ##### ##

*  gs_layout-no_hline = 'X'. " no horizontal line. grid# ### ##### ##.




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

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form create_object .

  create object gc_custom " Pattern# ## ## ##

    exporting




*      parent                      =




      container_name              = 'CON1' " ### custom control




*      style                       =

*      lifetime                    = lifetime_default

*      repid                       =

*      dynnr                       =

*      no_autodef_progid_dynnr     =

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



  create object gc_grid " Pattern# ## ## ##

    exporting




*      i_shellstyle      = 0

*      i_lifetime        =




      i_parent          = GC_CUSTOM " grid# ##: container. #, ## container# #### grid ### ##




*      i_appl_events     = space

*      i_parentdbg       =

*      i_applogparent    =

*      i_graphicsparent  =

*      i_name            =

*      i_fcat_complete   = SPACE

*    exceptions

*      error_cntl_create = 1

*      error_cntl_init   = 2

*      error_cntl_link   = 3

*      error_dp_create   = 4

*      others            = 5




      .

  if sy-subrc <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  endif.

endform.






*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form call_alv .

  call method gc_grid->set_table_for_first_display

    exporting




*      i_buffer_active               =

*      i_bypassing_buffer            =

*      i_consistency_check           =

*      i_structure_name              =

*      is_variant                    =

*      i_save                        =

*      i_default                     = 'X'




      is_layout                     = gs_layout




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




*t_outtab = gt_student.




endform.