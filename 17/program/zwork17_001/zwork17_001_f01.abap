
*&---------------------------------------------------------------------*

*&  Include           ZWORK17_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  F4_FILE

*&---------------------------------------------------------------------*

* ## ##(F4). CSV #### ##/### p_file# ##

*----------------------------------------------------------------------*




FORM f4_file .

  DATA lv_fname TYPE rlgrap-filename." F4 #### ### ###(## ##) ##



  " ## ###: ## ### p_file# ### ###, ### ### ### ##

  IF p_file IS INITIAL.

    lv_fname = 'ZWORK17_001_TEMPLATE.xlsx'.  " ## ## ### ###

  ELSE.

    lv_fname = p_file.   " #### ### ##/### ## ###

  ENDIF.



  CALL FUNCTION 'KD_GET_FILENAME_ON_F4'

    EXPORTING

      static    = 'X'         " ## ### # ##

    CHANGING

      file_name = lv_fname

    EXCEPTIONS

      OTHERS    = 1.



  " ## ## ### P_FILE ##

  IF sy-subrc = 0 AND lv_fname IS NOT INITIAL.

    p_file = lv_fname.       " #### ##/### ## ##+###

  ENDIF.

ENDFORM.



FORM download_template .

  " ### ## ### ## CSV ### ###

  DATA: lt_csv    TYPE STANDARD TABLE OF string,

        lv_line   TYPE string,

        lv_save_s TYPE string,          " ## ## ### (####)

        lv_msg    TYPE string.



  " FILE_SAVE_DIALOG# ##

  DATA: lv_filename TYPE string,

        lv_path     TYPE string,

        lv_fullpath TYPE string,

        lv_action   TYPE i,

        lv_dir      TYPE string,

        lv_name     TYPE string.



  " ## ###/## ## (p_file# ## ### ## ##)

  IF p_file IS NOT INITIAL.

    CALL FUNCTION 'SO_SPLIT_FILE_AND_PATH'  " ## P_FILE ## ##/##### ##

      EXPORTING

        full_name     = p_file

      IMPORTING

        stripped_name = lv_name

        file_path     = lv_dir

      EXCEPTIONS

        x_error       = 1

        OTHERS        = 2.

  ENDIF.



  " #### ### ### ## ##, ### ## #### ### ##

  IF lv_name IS INITIAL.

    lv_filename = 'ZWORK17_001_TEMPLATE.xlsx'.   " ## ## ###




*    lv_filename = 'ZWORK17_001_TEMPLATE'.   " ## ## ###




  ELSE.

    lv_filename = lv_name.                      " ### ### ###

  ENDIF.



  " ### ### ### ### ### ### ##

  IF lv_dir IS NOT INITIAL.

    lv_path = lv_dir.                           " ## ##

  ENDIF.



  "  FILE_SAVE_DIALOG ## (## ##/### ##)

  CALL METHOD cl_gui_frontend_services=>file_save_dialog

    EXPORTING

      default_extension   = 'XLSX'         " ### ## # ###

      default_file_name   = lv_filename   " ## ## ###

      initial_directory   = lv_path       " ## ##

      prompt_on_overwrite = 'X'           " #### ## ##

    CHANGING

      filename            = lv_filename   " #### ## ### ###

      path                = lv_path      " #### ## ### ##

      fullpath            = lv_fullpath  " ##+### ## ## ##

      user_action         = lv_action    " ##/## ##

    EXCEPTIONS

      OTHERS              = 1.



  " ##### ## ## ##

  IF sy-subrc <> 0

   OR lv_action <> cl_gui_frontend_services=>action_ok

   OR lv_fullpath IS INITIAL.

    MESSAGE '## ### #### #####.' TYPE 'I'.

    EXIT.

  ENDIF.



  lv_save_s = lv_fullpath.

  TRANSLATE lv_save_s TO LOWER CASE. " ### ### ## #### ##



  " selection-screen## ## ### ##

  p_file = lv_save_s.



  "  CSV ## ###

  CLEAR lt_csv.

  lv_line = '####,####,####,####,##,########,########'.

  " ## ### ##

  APPEND lv_line TO lt_csv.

  APPEND 'M,USD,KRW,20250401,1470.6,1,1'   TO lt_csv.

  APPEND 'M,JPY,KRW,20250401,980.11,100,1' TO lt_csv.

  APPEND 'M,EUR,KRW,20250401,1590.9,1,1'   TO lt_csv.

  APPEND 'M,CAD,KRW,20250401,1021.89,1,1'  TO lt_csv.

  APPEND 'M,CNY,KRW,20250401,202.68,1,1'   TO lt_csv.

  APPEND 'M,VND,KRW,20250401,5.75,100,1'   TO lt_csv.

  APPEND 'M,HKD,KRW,20250401,189.03,1,1'   TO lt_csv.

  APPEND 'M,AUD,KRW,20250401,918.24,1,1'   TO lt_csv.



  " #### ## XLSX ## CSV# ##




*  IF lv_save_s CP '*.xlsx'.      " #### XLSX# ### ##




  " #### ## XLS(X) ## CSV# ##

  IF lv_save_s CP '*.xlsx'

   OR lv_save_s CP '*.xls'.      " .xls # #### ## ### ##





    DATA: lo_excel     TYPE ole2_object,

          lo_workbooks TYPE ole2_object,

          lo_workbook  TYPE ole2_object,

          lo_sheet     TYPE ole2_object,

          lo_cell      TYPE ole2_object.



    DATA: lv_row TYPE i,         " ## # ###(1##)

          lv_idx TYPE i.         " ## # ###(1##)



    " Excel ##

    CREATE OBJECT lo_excel 'Excel.Application'.

    SET PROPERTY OF lo_excel 'Visible' = 0. " ## ### ### ##



    " Workbook ##

    CALL METHOD OF lo_excel 'Workbooks' = lo_workbooks.

    CALL METHOD OF lo_workbooks 'Add' = lo_workbook.



    " # ## ## ##

    CALL METHOD OF lo_excel 'ActiveSheet' = lo_sheet.



    " lt_csv ### ## ###

    lv_row = 1.



    LOOP AT lt_csv INTO lv_line.

      DATA lt_cols TYPE STANDARD TABLE OF string.

      DATA lv_col  TYPE string.



      REFRESH lt_cols.

      SPLIT lv_line AT ',' INTO TABLE lt_cols. " # ## ## #### ##



      lv_idx = 1.

      LOOP AT lt_cols INTO lv_col.



        " # ## #### (row, col)

        CALL METHOD OF lo_sheet 'Cells' = lo_cell

          EXPORTING

            #1 = lv_row

            #2 = lv_idx.



        " # ##

        SET PROPERTY OF lo_cell 'Value' = lv_col.



        " # #(##)## ### ## ###

        IF lv_row = 1.

          DATA lo_inter TYPE ole2_object.

          CALL METHOD OF lo_cell 'Interior' = lo_inter.

          SET PROPERTY OF lo_inter 'Color' = 65535.   " Yellow

          FREE lo_inter.

        ENDIF.



        lv_idx = lv_idx + 1.

      ENDLOOP.



      lv_row = lv_row + 1.

    ENDLOOP.

    " ## ## ### ### + ### ## ##

    DATA: lo_used_range TYPE ole2_object,

          lo_borders    TYPE ole2_object,

          lo_columns    TYPE ole2_object.



    " ## ##(## + ### ##) ####

    CALL METHOD OF lo_sheet 'UsedRange' = lo_used_range.



    " ### ## (##/## ##)

    CALL METHOD OF lo_used_range 'Borders' = lo_borders.

    " xlContinuous = 1  (##)

    SET PROPERTY OF lo_borders 'LineStyle' = 1.

    " xlThin = 2 (## # ##)

    SET PROPERTY OF lo_borders 'Weight'    = 2.



    " ### ## ##

    CALL METHOD OF lo_used_range 'Columns' = lo_columns.

    CALL METHOD OF lo_columns 'AutoFit'.



    FREE lo_columns.

    FREE lo_borders.

    FREE lo_used_range.





    " XLSX# ##

    CALL METHOD OF lo_workbook 'SaveAs'

      EXPORTING

        #1 = lv_save_s.



    " Excel ## # OLE ##

    CALL METHOD OF lo_workbook 'Close'.

    CALL METHOD OF lo_excel 'Quit'.



    FREE lo_cell.

    FREE lo_sheet.

    FREE lo_workbook.

    FREE lo_workbooks.

    FREE lo_excel.



    CONCATENATE '### ## ##:' lv_save_s

           INTO lv_msg SEPARATED BY space.

    MESSAGE lv_msg TYPE 'S'.



  ELSE.                           "  #### CSV# ##



    " ### ### .csv ##

    IF NOT ( lv_save_s CP '*.csv' ).

      CONCATENATE lv_save_s '.csv' INTO lv_save_s.

      p_file = lv_save_s.

    ENDIF.



    " ##### CP949# ## ##(## ##)

    CALL FUNCTION 'GUI_DOWNLOAD'

      EXPORTING

        filename = lv_save_s

        filetype = 'ASC'

        codepage = '949'

      TABLES

        data_tab = lt_csv

      EXCEPTIONS

        OTHERS   = 1.



    " ##### ## ### #### codepage ## ## ##

    IF sy-subrc <> 0.

      CALL FUNCTION 'GUI_DOWNLOAD'

        EXPORTING

          filename = lv_save_s

          filetype = 'ASC'

        TABLES

          data_tab = lt_csv

        EXCEPTIONS

          OTHERS   = 1.

      IF sy-subrc <> 0.

        MESSAGE '### ### ######. (## ## # ##)' TYPE 'E'.

        EXIT.

      ENDIF.

    ENDIF.



    CONCATENATE '### ## ##:' lv_save_s

           INTO lv_msg SEPARATED BY space.

    MESSAGE lv_msg TYPE 'S'.



  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  LOAD_CSV

*&---------------------------------------------------------------------*

* ## #### ## CSV / XLS(X) ## ##

*----------------------------------------------------------------------*




FORM load_csv .



  DATA: lv_name TYPE string. " ###(## ##) ### ##



  lv_name = p_file.

  TRANSLATE lv_name TO LOWER CASE. " ### ### ## #### ##



  CLEAR gt_rate. " ### ## ### ###



  " #### ## ## ## ## ##

  IF lv_name CP '*.csv'.

    PERFORM load_csv_file.



  ELSEIF lv_name CP '*.xls'

      OR lv_name CP '*.xlsx'.

    PERFORM load_xls_file.



  ELSE.

    MESSAGE 'CSV ## XLS/XLSX ### ### #####.' TYPE 'E'.

  ENDIF.



  " ### ### ### ## ###

  IF gt_rate IS INITIAL.

    MESSAGE '#### #### ####.' TYPE 'I'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  LOAD_CSV_FILE

*&---------------------------------------------------------------------*

* CSV ###

*----------------------------------------------------------------------*




FORM load_csv_file .



  DATA: lt_raw      TYPE STANDARD TABLE OF string, " GUI_UPLOAD# ## ## ###

        lv_line     TYPE string,                   " ## ## ## # #

        lt_col      TYPE STANDARD TABLE OF string, " # ## ### split# ## ###

        lv_idx      TYPE i,                        " ## # ##

        lv_filename TYPE string,                   " #### ###

        lv_dbg      TYPE string,                   " #### ###

        lv_subrc    TYPE char10.                   " sy-subrc ###



  lv_filename = p_file.



  " ####### ### ##(CSV) ###

  CALL FUNCTION 'GUI_UPLOAD'

    EXPORTING

      filename = lv_filename

      filetype = 'ASC'

    TABLES

      data_tab = lt_raw

    EXCEPTIONS

      OTHERS   = 1.



  " ### ## # ## ### ## # ##

  IF sy-subrc <> 0.

    CLEAR: lv_dbg, lv_subrc.

    WRITE sy-subrc TO lv_subrc.

    CONCATENATE 'GUI_UPLOAD ##, SY-SUBRC =' lv_subrc

           INTO lv_dbg SEPARATED BY space.

    MESSAGE lv_dbg TYPE 'E'.

    RETURN.

  ENDIF.



  lv_idx = 0.



  " ### # ## ## ##

  LOOP AT lt_raw INTO lv_line.

    lv_idx = lv_idx + 1.

    IF lv_idx = 1.

      CONTINUE." # ## ## ##### ###

    ENDIF.



    REFRESH lt_col.

    SPLIT lv_line AT ',' INTO TABLE lt_col. " ### # ## ##



    " # ### ## ### ##

    DATA: lv_kurst TYPE string,

          lv_fcurr TYPE string,

          lv_tcurr TYPE string,

          lv_gdatu TYPE string,

          lv_ukurs TYPE string,

          lv_ffact TYPE string,

          lv_tfact TYPE string.



    READ TABLE lt_col INDEX 1 INTO lv_kurst.

    READ TABLE lt_col INDEX 2 INTO lv_fcurr.

    READ TABLE lt_col INDEX 3 INTO lv_tcurr.

    READ TABLE lt_col INDEX 4 INTO lv_gdatu.

    READ TABLE lt_col INDEX 5 INTO lv_ukurs.

    READ TABLE lt_col INDEX 6 INTO lv_ffact.

    READ TABLE lt_col INDEX 7 INTO lv_tfact.



    " ## ### #### FORM## ## # # ##

    PERFORM add_rate_line

      USING lv_kurst lv_fcurr lv_tcurr

            lv_gdatu lv_ukurs lv_ffact lv_tfact.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  LOAD_XLS_FILE

*&---------------------------------------------------------------------*

* XLS / XLSX ### ALSM_EXCEL_TO_INTERNAL_TABLE# ##

*----------------------------------------------------------------------*




FORM load_xls_file .



  DATA: lt_excel TYPE STANDARD TABLE OF alsmex_tabline, " ## -> ## ## ###

        ls_excel TYPE alsmex_tabline,

        lv_row   TYPE i. " ## ## ## ## # ##



  " ## # # ## #### ## ###

  DATA: lv_kurst TYPE string,

        lv_fcurr TYPE string,

        lv_tcurr TYPE string,

        lv_gdatu TYPE string,

        lv_ukurs TYPE string,

        lv_ffact TYPE string,

        lv_tfact TYPE string.



  "  ## -> ## #### ## (2###, 7###)

  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'

    EXPORTING

      filename    = p_file

      i_begin_col = 1

      i_begin_row = 2      " 1## ##### 2###

      i_end_col   = 7      " #### ~ ########

      i_end_row   = 9999  " ### # ### ##

    TABLES

      intern      = lt_excel

    EXCEPTIONS

      OTHERS      = 1.



  " ## ## ## # ##

  IF sy-subrc <> 0.

    MESSAGE '## ### ## # ### ######.' TYPE 'E'.

    RETURN.

  ENDIF.



  CLEAR lv_row.



  "  ALSM ## # # ## ### ADD_RATE_LINE ##

  CLEAR: lv_kurst, lv_fcurr, lv_tcurr, lv_gdatu,

         lv_ukurs, lv_ffact, lv_tfact.



  LOOP AT lt_excel INTO ls_excel.



    " ## ### ## ## GT_RATE# ##

    IF lv_row <> 0 AND ls_excel-row <> lv_row.

      PERFORM add_rate_line

        USING lv_kurst lv_fcurr lv_tcurr

              lv_gdatu lv_ukurs lv_ffact lv_tfact.



      " ## ## ## ## ###

      CLEAR: lv_kurst, lv_fcurr, lv_tcurr, lv_gdatu,

             lv_ukurs, lv_ffact, lv_tfact.

    ENDIF.



    lv_row = ls_excel-row.



    " ## # ### ## ## ### # ##

    CASE ls_excel-col.

      WHEN 1. lv_kurst = ls_excel-value.

      WHEN 2. lv_fcurr = ls_excel-value.

      WHEN 3. lv_tcurr = ls_excel-value.

      WHEN 4. lv_gdatu = ls_excel-value.

      WHEN 5. lv_ukurs = ls_excel-value.

      WHEN 6. lv_ffact = ls_excel-value.

      WHEN 7. lv_tfact = ls_excel-value.

    ENDCASE.



  ENDLOOP.



  " ### # ##

  IF lv_row <> 0.

    PERFORM add_rate_line

      USING lv_kurst lv_fcurr lv_tcurr

            lv_gdatu lv_ukurs lv_ffact lv_tfact.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ADD_RATE_LINE

*&---------------------------------------------------------------------*

* CSV / XLSX## ## # ## GT_RATE# ## ## #### ##

*----------------------------------------------------------------------*

*  -->  p_kurst  : ####(## ## ##, M ##)

*  -->  p_fcurr  : ####

*  -->  p_tcurr  : ####

*  -->  p_gdatu  : ####(## ## ##, p_pdate ##)

*  -->  p_ukurs  : ##(###)

*  -->  p_ffact  : ########(## # ## # JPY/VND ##)

*  -->  p_tfact  : ########(## # ## # JPY/VND ##)

*----------------------------------------------------------------------*




FORM add_rate_line

  USING    p_kurst TYPE string

           p_fcurr TYPE string

           p_tcurr TYPE string

           p_gdatu TYPE string

           p_ukurs TYPE string

           p_ffact TYPE string

           p_tfact TYPE string.



  CLEAR gs_rate.



  " ### ####, ##### #### ## ##

  gs_rate-kurst = c_kurst.   " ## M ##

  gs_rate-gdatu = p_pdate.   " Selection-screen## ### #### ##



  gs_rate-fcurr = p_fcurr.

  gs_rate-tcurr = p_tcurr.



  " ### ### ### ALV# ### ## (#: UKURS_C)

  gs_rate-ukurs_c = p_ukurs. " #### ### #### ##



  " JPY / VND # 100 : 1, #### 1 : 1

  IF gs_rate-fcurr = 'JPY' OR gs_rate-fcurr = 'VND'.

    gs_rate-ffact = 100.

    gs_rate-tfact = 1.

  ELSE.

    gs_rate-ffact = 1.

    gs_rate-tfact = 1.

  ENDIF.



  " ### / ### ### (ALV### ### DB## #### ##)

  gs_rate-ernam = sy-uname.

  gs_rate-erdat = sy-datum.



  " ALV ### ###### # # ##

  APPEND gs_rate TO gt_rate.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

* Docking + ALV Grid ##

*----------------------------------------------------------------------*




FORM create_object .

  " ## ####/#### #### ## #### ##

  CREATE OBJECT gc_docking

    EXPORTING

      repid     = sy-repid

      dynnr     = sy-dynnr

      extension = 2000.   " ## #(##) ##



  " ## #### ## ALV Grid ## ##

  CREATE OBJECT gc_grid

    EXPORTING

      i_parent = gc_docking.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

* ALV ###### ## (UKURS ## ##)

*----------------------------------------------------------------------*




FORM field_catalog .

  REFRESH gt_fieldcat.



  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos   = 1.

  gs_fieldcat-fieldname = 'KURST'.

  gs_fieldcat-scrtext_m = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos   = 2.

  gs_fieldcat-fieldname = 'FCURR'.

  gs_fieldcat-scrtext_m = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos   = 3.

  gs_fieldcat-fieldname = 'TCURR'.

  gs_fieldcat-scrtext_m = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos   = 4.

  gs_fieldcat-fieldname = 'GDATU'.

  gs_fieldcat-scrtext_m = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos   = 5.




*  gs_fieldcat-fieldname = 'UKURS'.




  gs_fieldcat-fieldname = 'UKURS_C'. " ### ##

  gs_fieldcat-scrtext_m = '##'.

  gs_fieldcat-edit      = 'X'.        " ## ##

  gs_fieldcat-decimals = 2. " ## ## ### ###(###)

  gs_fieldcat-decimals_o = 2.  " ### ### ###

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos   = 6.

  gs_fieldcat-fieldname = 'FFACT'.

  gs_fieldcat-scrtext_m = '########'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos   = 7.

  gs_fieldcat-fieldname = 'TFACT'.

  gs_fieldcat-scrtext_m = '########'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos   = 8.

  gs_fieldcat-fieldname = 'ERNAM'.

  gs_fieldcat-scrtext_m = '###'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos   = 9.

  gs_fieldcat-fieldname = 'ERDAT'.

  gs_fieldcat-scrtext_m = '###'.

  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

* ALV #### ## ##

*----------------------------------------------------------------------*




FORM alv_layout .

  CLEAR gs_layout.

  gs_layout-zebra      = 'X'. " ###(zebra) ##

  gs_layout-cwidth_opt = 'X'. " ### ####



  " #### Variant ## ##

  CLEAR gs_variant.

  gs_variant-report   = sy-repid. " ## ### #### Variant ##

  gs_variant-username = sy-uname. " #### Variant

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

* ALV ##

*----------------------------------------------------------------------*




FORM alv_sort .




*  refresh gt_sort.

*  clear gs_sort.

*  gs_sort-spos      = 1.

*  gs_sort-fieldname = 'FCURR'.

*  gs_sort-up        = 'X'.

*  append gs_sort to gt_sort.




ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

* ALV ### ### ## + ## ### ##

*----------------------------------------------------------------------*




FORM class_event .

  CREATE OBJECT go_event. " ## ### #### (_CLS# ##)



  " ### ## ###

  SET HANDLER go_event->handler_data_changed FOR gc_grid.



  " ## # DATA_CHANGED ##### ## ### ##

  CALL METHOD gc_grid->register_edit_event

    EXPORTING

      i_event_id = cl_gui_alv_grid=>mc_evt_modified.



  " #### ON (## ## ##)

  CALL METHOD gc_grid->set_ready_for_input

    EXPORTING

      i_ready_for_input = 1.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

* ALV ## #####

*----------------------------------------------------------------------*




FORM alv_display .

  CALL METHOD gc_grid->set_table_for_first_display

    EXPORTING

      is_variant      = gs_variant   " Variant ##

      i_save          = 'A'          " Variant ## ##

      is_layout       = gs_layout    " #### ##

    CHANGING

      it_outtab       = gt_rate      " ## ###

      it_fieldcatalog = gt_fieldcat  " ######

      it_sort         = gt_sort.     " ####

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*

* ALV ####(##/### ##)

*----------------------------------------------------------------------*




FORM refresh .

  " #/# ## ## ##### ##

  gs_stbl-row = 'X'.

  gs_stbl-col = 'X'.

  CALL METHOD gc_grid->refresh_table_display

    EXPORTING

      is_stable = gs_stbl.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_DATA_CHANGED

*&---------------------------------------------------------------------*

* ALV## UKURS ## # ## # ## ITAB ## + ## ####

*----------------------------------------------------------------------*

* --> p_er  TYPE REF TO cl_alv_changed_data_protocol

*----------------------------------------------------------------------*




FORM alv_handle_data_changed  USING p_er TYPE REF TO cl_alv_changed_data_protocol.

  DATA: ls_mod TYPE lvc_s_modi.



  " ### # ### ##

  LOOP AT p_er->mt_good_cells INTO ls_mod.




*    if ls_mod-fieldname = 'UKURS'.




    IF ls_mod-fieldname = 'UKURS_C'.

      " ### ## GT_RATE## ###(ROW_ID ##)

      READ TABLE gt_rate INTO gs_rate INDEX ls_mod-row_id.

      IF sy-subrc = 0.

        " ### #### ## ## ## ### ##

        gs_rate-ukurs = ls_mod-value.

        " ### ### ##### ####

        MODIFY gt_rate FROM gs_rate INDEX ls_mod-row_id.

      ENDIF.

    ENDIF.

  ENDLOOP.



  " ## ## ##(##/### ##)

  gs_stbl-row = 'X'.

  gs_stbl-col = 'X'.

  IF gc_grid IS BOUND.

    CALL METHOD gc_grid->refresh_table_display

      EXPORTING

        is_stable = gs_stbl.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_RATE

*&---------------------------------------------------------------------*

* ALV ##### GT_RATE -> DB ### ZTCURR17 ##

* 1) #### ##

* 2) YES# ZTCURR17 # ## (ERNAM/ERDAT# DB# ##)

*---------------------------------------------------------------------*




FORM save_rate .



  DATA: lv_answer TYPE c.       " #### ## ### ##(1:#/2:###)

  DATA: lv_text   TYPE string.  " ## # #### ###

  DATA : lv_ukurs_df TYPE decfloat16.       " ## ##(## # DB ## ###)



  " ## ### ### ## ##

  IF gt_rate IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'I'.

    EXIT.

  ENDIF.



  " 1) ## ##

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      titlebar              = '## ##'

      text_question         = '##### ## ########?'

      text_button_1         = '#'

      text_button_2         = '###'

      default_button        = '1'

      display_cancel_button = ' '

    IMPORTING

      answer                = lv_answer.



  " #(1)# ### ## ##

  IF lv_answer <> '1'.

    MESSAGE '### #######.' TYPE 'I'.

    EXIT.

  ENDIF.



  " 2) ALV# ## -> DB ### MOVE

  CLEAR gt_rate_db.

  LOOP AT gt_rate INTO gs_rate.

    CLEAR gs_rate_db.



    gs_rate_db-mandt = sy-mandt.          " #####

    gs_rate_db-kurst = gs_rate-kurst.     " ####

    gs_rate_db-fcurr = gs_rate-fcurr.     " From ##

    gs_rate_db-tcurr = gs_rate-tcurr.     " To ##



    " ##### : ## ##(YYYYMMDD) -> INVDT ##### ## # ##

    DATA lv_gdatu_inv TYPE ztcurr17-gdatu.



    CALL FUNCTION 'CONVERSION_EXIT_INVDT_INPUT'

      EXPORTING

        input  = gs_rate-gdatu        " ty_rate ## SY-DATUM # ##

      IMPORTING

        output = lv_gdatu_inv.        " ##### INVERTED DATE



    gs_rate_db-gdatu = lv_gdatu_inv.



    " ## / ##




*    gs_rate_db-ukurs = gs_rate-ukurs.




    IF gs_rate-ukurs_c IS NOT INITIAL.

      " ### #### decfloat16## ## ##(### ##)

      lv_ukurs_df = gs_rate-ukurs_c.      " CHAR # decfloat16 (## ##)

      gs_rate_db-ukurs = lv_ukurs_df.     " decfloat16 # DB ##(DEC/CURR)

    ELSE.

      CLEAR gs_rate_db-ukurs.

    ENDIF.

    gs_rate_db-ffact = gs_rate-ffact.

    gs_rate_db-tfact = gs_rate-tfact.

    " ###/### ## (ZTCURR17# CRNAME, CRDATE)

    IF gs_rate_db-crname IS INITIAL.

      gs_rate_db-crname = sy-uname.

    ENDIF.

    IF gs_rate_db-crdate IS INITIAL.

      gs_rate_db-crdate = sy-datum.

    ENDIF.

    " #### ####

    IF gs_rate_db-crzeit IS INITIAL.

      gs_rate_db-crzeit = sy-uzeit.

    ENDIF.



    APPEND gs_rate_db TO gt_rate_db.

  ENDLOOP.



  " DB# ## (##### ## MODIFY)

  MODIFY ztcurr17 FROM TABLE gt_rate_db.

  IF sy-subrc = 0.

    MESSAGE '##### ZTCURR17# #######.' TYPE 'S'.

  ELSE.

    MESSAGE '#### ## # ### ######.' TYPE 'E'.

  ENDIF.



ENDFORM.