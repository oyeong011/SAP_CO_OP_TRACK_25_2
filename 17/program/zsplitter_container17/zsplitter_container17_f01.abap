
*&---------------------------------------------------------------------*

*&  Include           ZSPLITTER_CONTAINER17_F01

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

create object gc_docking

  exporting




*    parent                      =




    repid                       = sy-repid

    dynnr                       = sy-dynnr




*    side                        = DOCK_AT_LEFT




    extension                   = 2000




*    style                       =

*    lifetime                    = lifetime_default

*    caption                     =

*    metric                      = 0

*    ratio                       =

*    no_autodef_progid_dynnr     =

*    name                        =

*  exceptions

*    cntl_error                  = 1

*    cntl_system_error           = 2

*    create_error                = 3

*    lifetime_error              = 4

*    lifetime_dynpro_dynpro_link = 5

*    others                      = 6




    .

if sy-subrc <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




endif.

create object gc_splitter

  exporting




*    link_dynnr        =

*    link_repid        =

*    shellstyle        =

*    left              =

*    top               =

*    width             =

*    height            =

*    metric            = cntl_metric_dynpro

*    align             = 15




    parent            = gc_docking " ### ### ## #### ## ##

    rows              = 2 " ### ### ## #### ## ##

    columns           = 1 " ### ### ## #### ## ##




*    no_autodef_progid_dynnr =

*    name              =

*  exceptions

*    cntl_error        = 1

*    cntl_system_error = 2

*    others            = 3




    .

if sy-subrc <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




endif.



call method gc_splitter->get_container " splitter# ### container ##

  exporting

    row       = 1

    column    = 1

  receiving

    container = gc_container1. " container 1 ##

    .



call method gc_splitter->get_container " splitter# ### container ##

  exporting

    row       = 2

    column    = 1

  receiving

    container = gc_container2. " container 2 ##

    .



create object gc_grid1

  exporting




*    i_shellstyle      = 0

*    i_lifetime        =




    i_parent          = gc_container1




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



create object gc_grid2

  exporting




*    i_shellstyle      = 0

*    i_lifetime        =




    i_parent          = gc_container2




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

  perform container1_field.

  perform container2_field.

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

  perform container1_sort.

  perform container2_sort.

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

call method gc_grid1->set_table_for_first_display

  exporting




*    i_buffer_active               =

*    i_bypassing_buffer            =

*    i_consistency_check           =

*    i_structure_name              =




    is_variant                    = gs_variant

    i_save                        = 'A' " alv##### #### ##### ## ### ##




*    i_default                     = 'X'




    is_layout                     = gs_layout




*    is_print                      =

*    it_special_groups             =

*    it_toolbar_excluding          =

*    it_hyperlink                  =

*    it_alv_graphics               =

*    it_except_qinfo               =

*    ir_salv_adapter               =




  changing

    it_outtab                     = gt_student

    it_fieldcatalog               = gt_fieldcat1

    it_sort                       = gt_sort1




*    it_filter                     =

*  exceptions

*    invalid_parameter_combination = 1

*    program_error                 = 2

*    too_many_lines                = 3

*    others                        = 4




        .

if sy-subrc <> 0.




* Implement suitable error handling here




endif.



call method gc_grid2->set_table_for_first_display

  exporting




*    i_buffer_active               =

*    i_bypassing_buffer            =

*    i_consistency_check           =

*    i_structure_name              =




    is_variant                    = gs_variant

    i_save                        = 'A'




*    i_default                     = 'X'




    is_layout                     = gs_layout




*    is_print                      =

*    it_special_groups             =

*    it_toolbar_excluding          =

*    it_hyperlink                  =

*    it_alv_graphics               =

*    it_except_qinfo               =

*    ir_salv_adapter               =




  changing

    it_outtab                     = gt_student

    it_fieldcatalog               = gt_fieldcat2

    it_sort                       = gt_sort2




*    it_filter                     =

*  exceptions

*    invalid_parameter_combination = 1

*    program_error                 = 2

*    too_many_lines                = 3

*    others                        = 4




        .

if sy-subrc <> 0.




* Implement suitable error handling here




endif.





endform.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER1_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form container1_field .

  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 1. " coll_pos# ### output ## ##

  gs_fieldcat-fieldname = 'ZCODE'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-just = 'L'. " ## ## (L#, R#, C##)

  append gs_fieldcat to gt_fieldcat1.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-fieldname = 'ZPERNR'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-just = 'C'. " ## ## (L#, R#, C##)

  append gs_fieldcat to gt_fieldcat1.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZKNAME'.

  gs_fieldcat-scrtext_m = '##'.

  append gs_fieldcat to gt_fieldcat1.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZENAME'.

  gs_fieldcat-scrtext_m = '####'.

  append gs_fieldcat to gt_fieldcat1.

endform.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER2_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form container2_field .

  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 1. " coll_pos# ### output ## ##

  gs_fieldcat-fieldname = 'ZCODE'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-just = 'L'. " ## ## (L#, R#, C##)

  append gs_fieldcat to gt_fieldcat2.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-fieldname = 'ZPERNR'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-just = 'C'. " ## ## (L#, R#, C##)

  append gs_fieldcat to gt_fieldcat2.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZKNAME'.

  gs_fieldcat-scrtext_m = '##'.

  append gs_fieldcat to gt_fieldcat2.



  clear : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZENAME'.

  gs_fieldcat-scrtext_m = '####'.

  append gs_fieldcat to gt_fieldcat2.

endform.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER1_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form container1_sort .

  gs_sort-spos = 1. " ## ####

  gs_sort-fieldname = 'ZCODE'. " ### ### ### ##

  gs_sort-up = 'X'. " #### #### ##




*  gs_sort-down = 'X'. " #### #### ##




  gs_sort-subtot = 'X'. " ####

  append gs_sort to gt_sort1.

endform.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER2_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form container2_sort .

  gs_sort-spos = 1. " ## ####

  gs_sort-fieldname = 'ZCODE'. " ### ### ### ##

  gs_sort-up = 'X'. " #### #### ##




*  gs_sort-down = 'X'. " #### #### ##




  gs_sort-subtot = 'X'. " ####

  append gs_sort to gt_sort2.

endform.