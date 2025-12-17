
*&---------------------------------------------------------------------*

*& Include ZWORK11_002_F01

*&---------------------------------------------------------------------*






FORM set_init.

  p_date = sy-datum.

ENDFORM.



FORM get_data.

  DATA: lv_gdatu TYPE ztcurr11-gdatu.



  " 1. ## ## ##

  lv_gdatu = p_date.

  SELECT * INTO CORRESPONDING FIELDS OF TABLE gt_list

    FROM ztcurr11 WHERE gdatu = lv_gdatu.



  " 2. ### ### ### ## ##

  IF gt_list IS INITIAL.

    DATA: lv_num TYPE n LENGTH 8.

    lv_num = 99999999 - p_date.

    lv_gdatu = lv_num.

    SELECT * INTO CORRESPONDING FIELDS OF TABLE gt_list

      FROM ztcurr11 WHERE gdatu = lv_gdatu.

  ENDIF.

ENDFORM.



FORM set_add_info.

  LOOP AT gt_list INTO gs_list.

    gs_list-uname = sy-uname.

    gs_list-cdate = sy-datum.

    MODIFY gt_list FROM gs_list.

  ENDLOOP.

ENDFORM.



FORM init_alv.

  IF go_container IS INITIAL.

    CREATE OBJECT go_container EXPORTING container_name = 'CON1'.

    CREATE OBJECT go_grid      EXPORTING i_parent = go_container.

    PERFORM set_fcat.

    CALL METHOD go_grid->set_table_for_first_display

      CHANGING it_outtab = gt_list it_fieldcatalog = gt_fcat.

  ELSE.

    PERFORM refresh_alv.

  ENDIF.

ENDFORM.



FORM set_fcat.

  DATA: lv_pos TYPE i.

  DEFINE _add.

    add 1 to lv_pos.

    clear gs_fcat.

    gs_fcat-col_pos   = lv_pos.

    gs_fcat-fieldname = &1.

    gs_fcat-coltext   = &2.

    if &3 is not initial. gs_fcat-outputlen = &3. endif.

    append gs_fcat to gt_fcat.

  END-OF-DEFINITION.



  _add 'KURST'  '####'  0.

  _add 'FCURR'  '####'  0.

  _add 'TCURR'  '####'  0.

  _add 'GDATU'  '####'  0.

  _add 'UKURS'  '##'      15.

  _add 'FFACT'  '####'  0.

  _add 'TFACT'  '####'  0.

  _add 'UNAME'  '###'    12.

  _add 'CDATE'  '###'    10.

ENDFORM.



FORM refresh_alv.

  DATA ls_stbl TYPE lvc_s_stbl.

  ls_stbl-row = 'X'. ls_stbl-col = 'X'.

  go_grid->refresh_table_display( is_stable = ls_stbl ).

ENDFORM.



" =========================================================

"  [PDF ##] ## ##(ZWORK07) ## + ## ## ##

" =========================================================

FORM process_download.

  DATA: lv_save_dir     TYPE string,

        lv_pdf_path     TYPE string,

        lv_excel_path   TYPE string,

        lv_filename     TYPE string.



  " 1. ## ##

  CALL METHOD cl_gui_frontend_services=>directory_browse

    CHANGING selected_folder = lv_save_dir.



  IF lv_save_dir IS INITIAL.

    MESSAGE '#######.' TYPE 'S'. EXIT.

  ENDIF.



  " 2. ### ## (## ##)

  " ### [## ##] #### 2#(\\)# ## ## ## ##

  lv_filename = |\\Rate_{ sy-uzeit }|.



  CONCATENATE lv_save_dir lv_filename '.pdf'  INTO lv_pdf_path.

  CONCATENATE lv_save_dir lv_filename '.xlsx' INTO lv_excel_path.



  " 3. ##

  PERFORM execute_ole_logic USING lv_pdf_path lv_excel_path.



  MESSAGE |## ##: { lv_pdf_path }| TYPE 'S'.

ENDFORM.



FORM execute_ole_logic USING p_pdf_path p_xls_path.

  DATA: lo_excel     TYPE ole2_object,

        lo_workbooks TYPE ole2_object,

        lo_workbook  TYPE ole2_object,

        lo_sheet     TYPE ole2_object,

        lo_pagesetup TYPE ole2_object,

        lo_usedrange TYPE ole2_object,

        lo_columns   TYPE ole2_object.



  " 1. ## ##

  CREATE OBJECT lo_excel 'EXCEL.APPLICATION'.

  SET PROPERTY OF lo_excel 'Visible' = 0.

  SET PROPERTY OF lo_excel 'DisplayAlerts' = 0.



  " 2. # ##

  CALL METHOD OF lo_excel 'Workbooks' = lo_workbooks.

  CALL METHOD OF lo_workbooks 'Add' = lo_workbook.

  GET PROPERTY OF lo_excel 'ActiveSheet' = lo_sheet.



  " 3. ### ## (##)

  GET PROPERTY OF lo_sheet 'PageSetup' = lo_pagesetup.

  SET PROPERTY OF lo_pagesetup 'Orientation' = 2.

  FREE OBJECT lo_pagesetup.



  " 4. ## ##

  PERFORM set_cell USING lo_sheet 1 1 '####'.

  PERFORM set_cell USING lo_sheet 1 2 '####'.

  PERFORM set_cell USING lo_sheet 1 3 '####'.

  PERFORM set_cell USING lo_sheet 1 4 '####'.

  PERFORM set_cell USING lo_sheet 1 5 '##'.

  PERFORM set_cell USING lo_sheet 1 6 '####'.

  PERFORM set_cell USING lo_sheet 1 7 '####'.

  PERFORM set_cell USING lo_sheet 1 8 '###'.

  PERFORM set_cell USING lo_sheet 1 9 '###'.



  " 5. ### ##

  DATA: lv_row      TYPE i VALUE 2,

        lv_date_str TYPE char10.



  LOOP AT gt_list INTO gs_list.

    IF gs_list-uname IS INITIAL. gs_list-uname = sy-uname. ENDIF.

    IF gs_list-cdate IS INITIAL. gs_list-cdate = sy-datum. ENDIF.



    CLEAR lv_date_str.

    CONCATENATE gs_list-cdate(4) '.' gs_list-cdate+4(2) '.' gs_list-cdate+6(2) INTO lv_date_str.



    PERFORM set_cell USING lo_sheet lv_row 1 gs_list-kurst.

    PERFORM set_cell USING lo_sheet lv_row 2 gs_list-fcurr.

    PERFORM set_cell USING lo_sheet lv_row 3 gs_list-tcurr.

    PERFORM set_cell USING lo_sheet lv_row 4 gs_list-gdatu.

    PERFORM set_cell USING lo_sheet lv_row 5 gs_list-ukurs.

    PERFORM set_cell USING lo_sheet lv_row 6 gs_list-ffact.

    PERFORM set_cell USING lo_sheet lv_row 7 gs_list-tfact.

    PERFORM set_cell USING lo_sheet lv_row 8 gs_list-uname.

    PERFORM set_cell USING lo_sheet lv_row 9 lv_date_str.



    ADD 1 TO lv_row.

  ENDLOOP.



  " 6. AutoFit

  GET PROPERTY OF lo_sheet 'UsedRange' = lo_usedrange.

  GET PROPERTY OF lo_usedrange 'Columns' = lo_columns.

  CALL METHOD OF lo_columns 'AutoFit'.

  FREE OBJECT lo_columns.

  FREE OBJECT lo_usedrange.



  " 7. ### (## ## ##)

  DATA: lo_range  TYPE ole2_object,

        lo_border TYPE ole2_object,

        lv_idx    TYPE i.



  " (1) ## ###

  CALL METHOD OF lo_sheet 'Range' = lo_range EXPORTING #1 = 'A1' #2 = 'I1'.

  DO 5 TIMES.

    lv_idx = sy-index + 6.

    CALL METHOD OF lo_range 'Borders' = lo_border EXPORTING #1 = lv_idx.

    SET PROPERTY OF lo_border 'LineStyle' = 1.

  ENDDO.



  " (2) ### ###

  DATA: lv_start_cell TYPE string,

        lv_end_cell   TYPE string,

        lv_last_row   TYPE i.



  lv_last_row = lv_row - 1.



  IF lv_last_row >= 2.

    lv_start_cell = 'A2'.

    lv_end_cell   = |I{ lv_last_row }|.



    CALL METHOD OF lo_sheet 'Range' = lo_range EXPORTING #1 = lv_start_cell #2 = lv_end_cell.



    DO 5 TIMES.

      lv_idx = sy-index + 6.

      CALL METHOD OF lo_range 'Borders' = lo_border EXPORTING #1 = lv_idx.

      SET PROPERTY OF lo_border 'LineStyle' = 1.

    ENDDO.

  ENDIF.

  FREE OBJECT: lo_range, lo_border.



  " 8. PDF #### (## ## ##)

  CALL METHOD OF lo_workbook 'ExportAsFixedFormat'

    EXPORTING

      #1 = 0            " xlTypePDF

      #2 = p_pdf_path.  " ## ##



  " 9. ##

  CALL METHOD OF lo_workbook 'Close' EXPORTING #1 = 0.

  CALL METHOD OF lo_excel 'Quit'.



  FREE OBJECT: lo_workbook, lo_workbooks, lo_sheet, lo_excel.

ENDFORM.



FORM set_cell USING p_sheet p_row p_col p_val.

  DATA: lo_cell TYPE ole2_object.

  CALL METHOD OF p_sheet 'Cells' = lo_cell EXPORTING #1 = p_row #2 = p_col.

  SET PROPERTY OF lo_cell 'Value' = p_val.

  FREE OBJECT lo_cell.

" ### [## ##] ## ENDFORM# ### PBO ### #####.

ENDFORM.