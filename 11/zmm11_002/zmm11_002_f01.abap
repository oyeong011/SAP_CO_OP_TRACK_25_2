
*&---------------------------------------------------------------------*

*& Include ZMM11_002_F01

*&---------------------------------------------------------------------*




FORM modify_screen_attributes.

  LOOP AT SCREEN.

    CASE screen-group1.

      WHEN 'GR1'. screen-active = COND i( WHEN rb_new = 'X' THEN 1 ELSE 0 ).

      WHEN 'GR2'. screen-active = COND i( WHEN rb_inq = 'X' THEN 1 ELSE 0 ).

      WHEN 'KEY'. screen-active = 1.

    ENDCASE.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.



FORM check_master_data.

  SELECT COUNT(*) FROM zmm11_comp_vend

    WHERE bukrs = @p_bukrs AND lifnr = @p_lifnr.

  IF sy-subrc <> 0.

    MESSAGE '##### ### ### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.



FORM check_date_validity.

  IF p_bedat IS INITIAL.

    MESSAGE '#### #####.' TYPE 'E'.

  ENDIF.

ENDFORM.



FORM check_po_existence.

  SELECT SINGLE @abap_true FROM zmm11_po_head INTO @DATA(lv_exists)

    WHERE ebeln = @p_ebeln.

  IF sy-subrc <> 0.

    MESSAGE '#### ## #######.' TYPE 'E'.

  ENDIF.

ENDFORM.



FORM init_alv_container.

  CREATE OBJECT go_docker

    EXPORTING repid = sy-repid dynnr = sy-dynnr extension = 2000.

  CREATE OBJECT go_grid

    EXPORTING i_parent = go_docker.

ENDFORM.



FORM set_layout_and_variant.

  gs_layout-zebra = 'X'.

  gs_layout-cwidth_opt = 'X'.

  gs_layout-sel_mode = 'A'.

  gs_variant-report = sy-repid.

ENDFORM.



FORM build_fcat_create.

  CLEAR gt_fcat.

  PERFORM add_field USING:

    'EBELP' '##'     1 space space space,

    'MATNR' '####' 2 'ZMM11_MAT_MST' 'ZMATNR' 'X',

    'MAKTX' '###'   3 space space space,

    'MENGE' 'PO##'   4 space space 'X',

    'STPRS' '##'     5 space space space,

    'MEINS' '##'     6 space space space,

    'WAERS' '##'     7 space space space,

    'MWSKZ' '####' 8 space space space,

    'PRDAT' '###'   9 space space 'X',

    'WERKS' '###'   10 space space space,

    'LGORT' '####' 11 space space space.

ENDFORM.



FORM build_fcat_display.

  CLEAR gt_fcat.

  PERFORM add_field USING:

    'EBELN' '####' 1 space space space,

    'EBELP' '##'     2 space space space,

    'MATNR' '####' 3 space space space,

    'MAKTX' '###'   4 space space space,

    'MENGE' '##'     5 space space space,

    'PRDAT' '###'   6 space space space.

ENDFORM.



FORM add_field USING p_field p_text p_pos p_ref_tab p_ref_field p_edit.

  DATA(ls_fcat) = VALUE lvc_s_fcat(

    fieldname = p_field coltext = p_text col_pos = p_pos

    ref_table = p_ref_tab ref_field = p_ref_field edit = p_edit

    f4availabl = COND #( WHEN p_ref_tab IS NOT INITIAL THEN 'X' ELSE space )

  ).

  IF p_field = 'MENGE'. ls_fcat-qfieldname = 'MEINS'. ENDIF.

  IF p_field = 'STPRS'. ls_fcat-cfieldname = 'WAERS'. ENDIF.

  APPEND ls_fcat TO gt_fcat.

ENDFORM.



FORM register_events.

  CREATE OBJECT go_handler.

  SET HANDLER go_handler->on_f4_request FOR go_grid.

  DATA: lt_f4 TYPE lvc_t_f4.

  APPEND VALUE #( fieldname = 'MATNR' register = 'X' chngeafter = 'X' ) TO lt_f4.

  go_grid->register_f4_for_fields( it_f4 = lt_f4 ).

ENDFORM.



FORM display_alv USING pt_data TYPE STANDARD TABLE.

  go_grid->set_table_for_first_display(

    EXPORTING is_layout = gs_layout is_variant = gs_variant i_save = 'A'

    CHANGING  it_outtab = pt_data it_fieldcatalog = gt_fcat ).

ENDFORM.



FORM refresh_grid.

  DATA(ls_stbl) = VALUE lvc_s_stbl( row = 'X' col = 'X' ).

  go_grid->refresh_table_display( is_stable = ls_stbl ).

ENDFORM.



FORM append_empty_line.

  DATA: lv_next TYPE zmm11_po_item-ebelp.

  IF gt_alv_data IS NOT INITIAL.

    lv_next = gt_alv_data[ lines( gt_alv_data ) ]-ebelp + 10.

  ELSE.

    lv_next = 10.

  ENDIF.



  CLEAR gs_alv_data.

  gs_alv_data-ebelp = lv_next.

  SELECT SINGLE waers, mwskz FROM zmm11_org_mst

    INTO (@gs_alv_data-waers, @gs_alv_data-mwskz)

    WHERE lifnr = @p_lifnr.

  APPEND gs_alv_data TO gt_alv_data.

  PERFORM refresh_grid.

ENDFORM.



FORM delete_selected_lines.

  DATA: lt_rows TYPE lvc_t_row.

  go_grid->get_selected_rows( IMPORTING et_index_rows = lt_rows ).

  IF lt_rows IS INITIAL. MESSAGE '### ## #####.' TYPE 'I'. RETURN. ENDIF.

  SORT lt_rows DESCENDING BY index.

  LOOP AT lt_rows INTO DATA(ls_row). DELETE gt_alv_data INDEX ls_row-index. ENDLOOP.

  PERFORM refresh_grid.

ENDFORM.



FORM exec_f4_matnr USING p_field p_row p_event_data TYPE REF TO cl_alv_event_data.

  DATA: lt_ret TYPE TABLE OF ddshretval, lt_mat TYPE TABLE OF zmm11_mat_mst.

  p_event_data->m_event_handled = 'X'.



  SELECT * FROM zmm11_mat_mst INTO TABLE lt_mat.



  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'

    EXPORTING retfield = 'ZMATNR' value_org = 'S'

    TABLES value_tab = lt_mat return_tab = lt_ret

    EXCEPTIONS OTHERS = 1.



  IF sy-subrc = 0 AND lt_ret IS NOT INITIAL.

    DATA(lv_mat) = lt_ret[ 1 ]-fieldval.

    READ TABLE lt_mat INTO DATA(ls_mat) WITH KEY zmatnr = lv_mat.

    IF sy-subrc = 0.

      FIELD-SYMBOLS: <lt_modi> TYPE lvc_t_modi.

      ASSIGN p_event_data->m_data->* TO <lt_modi>.

      PERFORM add_modi USING p_row:

        'MATNR' ls_mat-zmatnr   CHANGING <lt_modi>,

        'MAKTX' ls_mat-zmatname CHANGING <lt_modi>,

        'STPRS' ls_mat-stprs    CHANGING <lt_modi>,

        'MEINS' ls_mat-meins    CHANGING <lt_modi>,

        'WERKS' ls_mat-zwerks   CHANGING <lt_modi>,

        'LGORT' ls_mat-zlgort   CHANGING <lt_modi>.

    ENDIF.

  ENDIF.

ENDFORM.



FORM add_modi USING p_row p_field p_val CHANGING pt_modi TYPE lvc_t_modi.

  APPEND VALUE #( row_id = p_row fieldname = p_field value = p_val ) TO pt_modi.

ENDFORM.



FORM validate_lines.

  LOOP AT gt_alv_data INTO gs_alv_data.

    IF gs_alv_data-prdat IS INITIAL OR gs_alv_data-prdat < p_bedat.

      MESSAGE '#### ###### (### #### #).' TYPE 'E'.

    ENDIF.

  ENDLOOP.

ENDFORM.



FORM save_to_database.

  DATA: lv_po TYPE zmm11_po_head-ebeln.

  DATA: lv_calc TYPE i.



  SELECT MAX( ebeln ) FROM zmm11_po_head INTO @DATA(lv_max).



  IF lv_max IS INITIAL.

    lv_po = '0000000001'.

  ELSE.

    lv_calc = lv_max + 1.

    " ### ## ## (WIDTH, ALIGN, PAD ##)

    lv_po = |{ lv_calc WIDTH = 10 ALIGN = RIGHT PAD = '0' }|.

  ENDIF.



  CLEAR: gt_head_ins, gt_item_ins.

  APPEND INITIAL LINE TO gt_head_ins ASSIGNING FIELD-SYMBOL(<fs_h>).

  <fs_h>-ebeln = lv_po.

  <fs_h>-bedat = p_bedat.

  <fs_h>-bukrs = p_bukrs.

  <fs_h>-lifnr = p_lifnr.



  SELECT SINGLE ekgrp, ekorg, waers FROM zmm11_org_mst

    INTO (@<fs_h>-ekgrp, @<fs_h>-ekorg, @<fs_h>-waers)

    WHERE lifnr = @p_lifnr.



  LOOP AT gt_alv_data INTO gs_alv_data.

    APPEND INITIAL LINE TO gt_item_ins ASSIGNING FIELD-SYMBOL(<fs_i>).

    MOVE-CORRESPONDING gs_alv_data TO <fs_i>.

    <fs_i>-ebeln = lv_po.

  ENDLOOP.



  INSERT zmm11_po_head FROM TABLE gt_head_ins.

  INSERT zmm11_po_item FROM TABLE gt_item_ins.



  IF sy-subrc = 0.

    COMMIT WORK.

    MESSAGE |#### { lv_po } ## ##| TYPE 'S'.

    LEAVE TO SCREEN 0.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '## ##' TYPE 'E'.

  ENDIF.

ENDFORM.



FORM select_po_data.

  SELECT * FROM zmm11_po_item INTO TABLE @gt_item_ins WHERE ebeln = @p_ebeln.

ENDFORM.