
*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

* #### ## #### ZTCURR17## ## ##

*----------------------------------------------------------------------*




FORM get_data .



  DATA lv_gdatu_inv TYPE ztcurr17-gdatu.



  " ## ##(YYYYMMDD) -> INVDT# ##

  CALL FUNCTION 'CONVERSION_EXIT_INVDT_INPUT'

    EXPORTING

      input  = p_date

    IMPORTING

      output = lv_gdatu_inv.



  CLEAR gt_rate_db.

  SELECT kurst

         fcurr

         tcurr

         gdatu

         ukurs

         ffact

         tfact

         crname

         crdate

    FROM ztcurr17

    INTO TABLE gt_rate_db

    WHERE kurst = c_kurst     " M#

      AND gdatu = lv_gdatu_inv.



  CLEAR gt_rate.



  LOOP AT gt_rate_db INTO gs_rate_db.

    CLEAR gs_rate.



    gs_rate-kurst = gs_rate_db-kurst.

    gs_rate-fcurr = gs_rate_db-fcurr.

    gs_rate-tcurr = gs_rate_db-tcurr.

    gs_rate-gdatu = gs_rate_db-gdatu.

    gs_rate-ukurs = gs_rate_db-ukurs.

    gs_rate-ffact = gs_rate_db-ffact.

    gs_rate-tfact = gs_rate_db-tfact.






*    " ###/### : ## ### (SY-UNAME, SY-DATUM)

*    gs_rate-ernam = sy-uname.

*    gs_rate-erdat = sy-datum.




    gs_rate-ernam = gs_rate_db-crname.

    gs_rate-erdat = gs_rate_db-crdate.



    APPEND gs_rate TO gt_rate.

  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

* Custom Container + ALV Grid ##

*----------------------------------------------------------------------*




FORM create_object .



  IF go_cust IS INITIAL.

    CREATE OBJECT go_cust

      EXPORTING

        container_name = 'CC_ALV'.   " ### 100# CUSTOM CONTROL#



    CREATE OBJECT go_grid

      EXPORTING

        i_parent = go_cust.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

* ALV ###### ##

*----------------------------------------------------------------------*




FORM field_catalog .

  REFRESH gt_fieldcat.



  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos   = 1.

  gs_fieldcat-fieldname = 'KURST'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-outputlen = 6.      " ## ##

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos   = 2.

  gs_fieldcat-fieldname = 'FCURR'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-outputlen = 6.      " ## ##

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos   = 3.

  gs_fieldcat-fieldname = 'TCURR'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-outputlen = 6.      " ## ##

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos   = 4.

  gs_fieldcat-fieldname = 'GDATU'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-outputlen = 10.      " 2025.04.01 ## ##

  gs_fieldcat-edit_mask = '==INVDT'.   " INVDT ## ##### ##

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos   = 5.

  gs_fieldcat-fieldname = 'UKURS'.

  gs_fieldcat-scrtext_m = '##'.

  gs_fieldcat-outputlen = 13.      " ## ##

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos   = 6.

  gs_fieldcat-fieldname = 'FFACT'.

  gs_fieldcat-scrtext_m = '########'.

  gs_fieldcat-outputlen = 13.      " ## ##

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos   = 7.

  gs_fieldcat-fieldname = 'TFACT'.

  gs_fieldcat-scrtext_m = '########'.

  gs_fieldcat-outputlen = 13.      " ## ##

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos   = 8.

  gs_fieldcat-fieldname = 'ERNAM'.

  gs_fieldcat-scrtext_m = '###'.

  gs_fieldcat-outputlen = 10.      " ## ##

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos   = 9.

  gs_fieldcat-fieldname = 'ERDAT'.

  gs_fieldcat-scrtext_m = '###'.

  gs_fieldcat-outputlen = 10.      " ## ##

  APPEND gs_fieldcat TO gt_fieldcat.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM alv_layout .

  CLEAR gs_layout.

  gs_layout-zebra      = 'X'.




*  gs_layout-cwidth_opt = 'X'.






  CLEAR gs_variant.

  gs_variant-report   = sy-repid.

  gs_variant-username = sy-uname.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*




FORM class_event .

  CREATE OBJECT go_event.



  SET HANDLER go_event->handler_toolbar      FOR go_grid.

  SET HANDLER go_event->handler_user_command FOR go_grid.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM alv_display .



  CALL METHOD go_grid->set_table_for_first_display

    EXPORTING

      is_variant      = gs_variant

      i_save          = 'A'

      is_layout       = gs_layout

    CHANGING

      it_outtab       = gt_rate

      it_fieldcatalog = gt_fieldcat.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*




FORM refresh .

  gs_stbl-row = 'X'.

  gs_stbl-col = 'X'.



  CALL METHOD go_grid->refresh_table_display

    EXPORTING

      is_stable = gs_stbl.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_TOOLBAR

*&---------------------------------------------------------------------*

* ALV Toolbar# PDF ## ##

*----------------------------------------------------------------------*




FORM alv_handler_toolbar

  USING    p_e_object      TYPE REF TO cl_alv_event_toolbar_set

           p_e_interactive TYPE char1.



  DATA ls_button TYPE stb_button.



  CLEAR ls_button.

  ls_button-function  = 'PDF'.

  ls_button-text      = 'PDF'.

  ls_button-quickinfo = 'PDF ####'.

  ls_button-icon      = icon_print.

  ls_button-butn_type = 0.

  APPEND ls_button TO p_e_object->mt_toolbar.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_USER_COMMAND

*&---------------------------------------------------------------------*




FORM alv_handler_user_command USING p_ucomm TYPE sy-ucomm.

  CASE p_ucomm.

    WHEN 'PDF'.

      PERFORM make_pdf.

  ENDCASE.



ENDFORM.

FORM make_pdf .

  DATA: lv_subrc     TYPE sy-subrc,

        lv_fname     TYPE string,

        lv_objid     TYPE wwwdata-objid,

        lv_relid     TYPE wwwdata-relid,

        lv_len       TYPE i,

        lv_tmpl_file TYPE rlgrap-filename,

        lv_fname_del TYPE string,

        lv_rc        TYPE i,

        lv_rc_del    TYPE i.



  DATA: ls_www TYPE wwwdatatab.                 " MIME ## ##



  "--------------------------------------------------------------------

  " 0) ## ## ## ##

  "--------------------------------------------------------------------

  IF gt_rate IS INITIAL.

    MESSAGE 'PDF# ### #### ####.' TYPE 'I'.

    EXIT.

  ENDIF.



  "--------------------------------------------------------------------

  " 1) #### / ## ### ### ##

  "--------------------------------------------------------------------

  CLEAR gv_temp_dir.

  gv_temp_dir = 'C:\Users\USER\Desktop'.         " ###

  CALL METHOD cl_gui_frontend_services=>get_temp_directory

    CHANGING

      temp_dir = gv_temp_dir

    EXCEPTIONS

      OTHERS   = 1.



  IF sy-subrc <> 0 OR gv_temp_dir IS INITIAL.

    MESSAGE '## #### ## # ### ######.' TYPE 'E'.

  ENDIF.



  CLEAR gv_pdf_dir.

  CALL METHOD cl_gui_frontend_services=>directory_browse

    CHANGING

      selected_folder = gv_pdf_dir

    EXCEPTIONS

      OTHERS          = 1.



  IF sy-subrc <> 0 OR gv_pdf_dir IS INITIAL.

    MESSAGE 'PDF ## ### #### #####.' TYPE 'I'.

    EXIT.

  ENDIF.



  CONCATENATE gv_temp_dir '\ZWORK17_002_TEMPLATE.xlsx'

         INTO lv_tmpl_file.



  " ## ### ## (## ## ## ##)

  CALL FUNCTION 'WS_FILE_DELETE'

    EXPORTING

      file   = lv_tmpl_file

    EXCEPTIONS

      OTHERS = 0.



  "--------------------------------------------------------------------

  " 2) WWWDATA # ## ### ## ####

  "--------------------------------------------------------------------

  lv_objid = 'ZWORK17_002_TMPL'.

  lv_relid = 'MI'.



  CLEAR ls_www.

  SELECT SINGLE *

    FROM wwwdata

    INTO CORRESPONDING FIELDS OF ls_www

    WHERE relid = lv_relid

      AND objid = lv_objid.



  IF sy-subrc <> 0.

    MESSAGE 'WWW##### #### ## # ####.' TYPE 'E'.

    EXIT.

  ENDIF.



  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      key         = ls_www

      destination = lv_tmpl_file

    IMPORTING

      rc          = lv_rc.



  IF sy-subrc <> 0 OR lv_rc <> 0.

    MESSAGE |## ### #### # ### ######. RC={ lv_rc }| TYPE 'E'.

    EXIT.

  ENDIF.



  "--------------------------------------------------------------------

  " 3) Excel OLE ## + ### ##

  "--------------------------------------------------------------------

  CREATE OBJECT go_excel 'Excel.Application'.

  SET PROPERTY OF go_excel 'Visible'       = 0.

  SET PROPERTY OF go_excel 'DisplayAlerts' = 0.  " ## ## ## ##



  CALL METHOD OF go_excel 'Workbooks' = go_workbooks.

  CALL METHOD OF go_workbooks 'Open'   = go_workbook

    EXPORTING

      #1 = lv_tmpl_file.



  CALL METHOD OF go_excel 'ActiveSheet' = go_sheet.



  " #### ### ###

  PERFORM fill_excel_line.



  "--------------------------------------------------------------------

  " 3-1) # # / ### / ### ## (# #### ####)

  "--------------------------------------------------------------------

  DATA: lo_columns   TYPE ole2_object,

        lo_pagesetup TYPE ole2_object,

        lo_usedrange TYPE ole2_object,

        lo_borders   TYPE ole2_object.



  " # # ## ### : A~I #

  CALL METHOD OF go_sheet 'Columns' = lo_columns

    EXPORTING

      #1 = 'A:I'.

  CALL METHOD OF lo_columns 'AutoFit'.



  " ## ## ###

  CALL METHOD OF go_sheet 'UsedRange' = lo_usedrange.

  GET PROPERTY OF lo_usedrange 'Borders' = lo_borders.

  SET PROPERTY OF lo_borders 'LineStyle' = 1.       " ##



  " ### ##

  GET PROPERTY OF go_sheet 'PageSetup' = lo_pagesetup.

  SET PROPERTY OF lo_pagesetup 'Orientation'        = 2.  " ## ##

  SET PROPERTY OF lo_pagesetup 'Zoom'               = 0.  " ## ## ## X

  SET PROPERTY OF lo_pagesetup 'FitToPagesWide'     = 1.  " ## 1###

  SET PROPERTY OF lo_pagesetup 'FitToPagesTall'     = 1.  " ## 1###

  SET PROPERTY OF lo_pagesetup 'CenterHorizontally' = 1.  " ## ### ##



  " ## OLE ## ##

  IF lo_borders   IS NOT INITIAL. FREE lo_borders.   ENDIF.

  IF lo_usedrange IS NOT INITIAL. FREE lo_usedrange. ENDIF.

  IF lo_columns   IS NOT INITIAL. FREE lo_columns.   ENDIF.

  IF lo_pagesetup IS NOT INITIAL. FREE lo_pagesetup. ENDIF.



  "--------------------------------------------------------------------

  " 4) PDF ### ## + ## ## ## # #### ## ##

  "--------------------------------------------------------------------

  DATA: lv_date_str TYPE char8,

        lv_exist    TYPE c,

        lv_answer   TYPE c.



  WRITE p_date TO lv_date_str.



  CONCATENATE gv_pdf_dir '\ZWORK17_002_' lv_date_str '.pdf'

         INTO gv_pdf_file.



  " ## PDF ### ##

  CALL METHOD cl_gui_frontend_services=>file_exist

    EXPORTING

      file   = gv_pdf_file

    RECEIVING

      result = lv_exist

    EXCEPTIONS

      OTHERS = 1.





  IF lv_exist = 'X'.

    CALL FUNCTION 'POPUP_TO_CONFIRM'

      EXPORTING

        titlebar              = 'PDF ##'

        text_question         = '## ### PDF# ####. ########?'

        text_button_1         = '#'

        text_button_2         = '###'

        display_cancel_button = ' '

      IMPORTING

        answer                = lv_answer.



    IF lv_answer <> '1'.

      " #### #### ## # Excel ## # ##

      IF go_cell IS NOT INITIAL.

        FREE go_cell.

      ENDIF.

      IF go_sheet IS NOT INITIAL.

        FREE go_sheet.

      ENDIF.

      IF go_workbook IS NOT INITIAL.

        CALL METHOD OF go_workbook 'Close'.

        FREE go_workbook.

      ENDIF.

      IF go_workbooks IS NOT INITIAL.

        FREE go_workbooks.

      ENDIF.

      IF go_excel IS NOT INITIAL.

        CALL METHOD OF go_excel 'Quit'.

        FREE go_excel.

      ENDIF.



      MESSAGE 'PDF ### #######.' TYPE 'S'.

      EXIT.

    ENDIF.



    " #### ## -> ## ## ##

    CALL METHOD cl_gui_frontend_services=>file_delete

      EXPORTING

        filename = gv_pdf_file

      CHANGING

        rc       = lv_rc_del

      EXCEPTIONS

        OTHERS   = 0.

  ENDIF.



  "--------------------------------------------------------------------

  " 5) PDF# ##

  "--------------------------------------------------------------------

  CALL METHOD OF go_workbook 'ExportAsFixedFormat'

    EXPORTING

      #1 = 0          " xlTypePDF

      #2 = gv_pdf_file.



  "--------------------------------------------------------------------

  " 6) Excel ## ##

  "--------------------------------------------------------------------

  IF go_cell IS NOT INITIAL.

    FREE go_cell.

  ENDIF.



  IF go_sheet IS NOT INITIAL.

    FREE go_sheet.

  ENDIF.



  IF go_workbook IS NOT INITIAL.

    CALL METHOD OF go_workbook 'Close'.

    FREE go_workbook.

  ENDIF.



  IF go_workbooks IS NOT INITIAL.

    FREE go_workbooks.

  ENDIF.



  IF go_excel IS NOT INITIAL.

    CALL METHOD OF go_excel 'Quit'.

    FREE go_excel.

  ENDIF.



  "--------------------------------------------------------------------

  " 7) ## ## ### ## + ###

  "--------------------------------------------------------------------

  lv_fname_del = lv_tmpl_file.

  CALL METHOD cl_gui_frontend_services=>file_delete

    EXPORTING

      filename = lv_fname_del

    CHANGING

      rc       = lv_rc_del

    EXCEPTIONS

      OTHERS   = 0.



  CONCATENATE 'PDF ## ##:' gv_pdf_file

         INTO lv_fname SEPARATED BY space.

  MESSAGE lv_fname TYPE 'S'.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FILL_EXCEL_LINE

*&---------------------------------------------------------------------*

* EXCEL #### GT_RATE #### ## ###.

*----------------------------------------------------------------------*




FORM fill_excel_line .



  DATA: lv_row      TYPE i,

        lv_col_idx  TYPE i,

        lv_text     TYPE string,

        lv_gdatu_tx TYPE char10,    " #### ### ###

        lv_erdat_tx TYPE char10.    " #### ### ## ###

  " ##### 2### ### ##

  lv_row = 2.



  LOOP AT gt_rate INTO gs_rate.



    lv_col_idx = 1.



    " 1: ####

    CALL METHOD OF go_sheet 'Cells' = go_cell

      EXPORTING

        #1 = lv_row

        #2 = lv_col_idx.

    SET PROPERTY OF go_cell 'Value' = gs_rate-kurst.

    lv_col_idx = lv_col_idx + 1.



    " 2: ####

    CALL METHOD OF go_sheet 'Cells' = go_cell

      EXPORTING

        #1 = lv_row

        #2 = lv_col_idx.

    SET PROPERTY OF go_cell 'Value' = gs_rate-fcurr.

    lv_col_idx = lv_col_idx + 1.



    " 3: ####

    CALL METHOD OF go_sheet 'Cells' = go_cell

      EXPORTING

        #1 = lv_row

        #2 = lv_col_idx.

    SET PROPERTY OF go_cell 'Value' = gs_rate-tcurr.

    lv_col_idx = lv_col_idx + 1.



    " 4: ####

    CALL FUNCTION 'CONVERSION_EXIT_INVDT_OUTPUT'

      EXPORTING

        input  = gs_rate-gdatu       " YYYYMMDD

      IMPORTING

        output = lv_gdatu_tx.        " 2025.04.01 ##



    CALL METHOD OF go_sheet 'Cells' = go_cell

      EXPORTING

        #1 = lv_row

        #2 = lv_col_idx.




*    set property of go_cell 'Value' = gs_rate-gdatu.




    SET PROPERTY OF go_cell 'Value' = lv_gdatu_tx..

    lv_col_idx = lv_col_idx + 1.



    " 5: ##

    CALL METHOD OF go_sheet 'Cells' = go_cell

      EXPORTING

        #1 = lv_row

        #2 = lv_col_idx.

    SET PROPERTY OF go_cell 'Value' = gs_rate-ukurs.

    lv_col_idx = lv_col_idx + 1.



    " 6: ########

    CALL METHOD OF go_sheet 'Cells' = go_cell

      EXPORTING

        #1 = lv_row

        #2 = lv_col_idx.

    SET PROPERTY OF go_cell 'Value' = gs_rate-ffact.

    lv_col_idx = lv_col_idx + 1.



    " 7: ########

    CALL METHOD OF go_sheet 'Cells' = go_cell

      EXPORTING

        #1 = lv_row

        #2 = lv_col_idx.

    SET PROPERTY OF go_cell 'Value' = gs_rate-tfact.

    lv_col_idx = lv_col_idx + 1.



    " 8: ###

    CALL METHOD OF go_sheet 'Cells' = go_cell

      EXPORTING

        #1 = lv_row

        #2 = lv_col_idx.

    SET PROPERTY OF go_cell 'Value' = gs_rate-ernam.

    lv_col_idx = lv_col_idx + 1.



    " 9: ###

    CALL METHOD OF go_sheet 'Cells' = go_cell

      EXPORTING

        #1 = lv_row

        #2 = lv_col_idx.

    SET PROPERTY OF go_cell 'Value' = gs_rate-erdat.



    lv_row = lv_row + 1.



  ENDLOOP.



ENDFORM.