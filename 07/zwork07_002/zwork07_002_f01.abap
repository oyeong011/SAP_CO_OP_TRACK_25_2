
*&---------------------------------------------------------------------*

*&  Include           ZWORK07_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM get_DATA .

  SELECT * FROM ztcurr07

    INTO CORRESPONDING FIELDS OF TABLE gt_tcurr

    WHERE gdatu = p_date.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODI_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODI_DATA .

  LOOP AT gt_tcurr INTO gs_tcurr. "### ### ### ##



    gs_tcurr-crname = sy-uname.

    gs_tcurr-crdate = sy-datum.



    MODIFY gt_tcurr FROM gs_tcurr.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .

CREATE OBJECT GC_CUSTOM

  EXPORTING




*    PARENT                      =




    CONTAINER_NAME              = 'CON1'




*    STYLE                       =

*    LIFETIME                    = lifetime_default

*    REPID                       =

*    DYNNR                       =

*    NO_AUTODEF_PROGID_DYNNR     =

*  EXCEPTIONS

*    CNTL_ERROR                  = 1

*    CNTL_SYSTEM_ERROR           = 2

*    CREATE_ERROR                = 3

*    LIFETIME_ERROR              = 4

*    LIFETIME_DYNPRO_DYNPRO_LINK = 5

*    others                      = 6




    .



CREATE OBJECT GC_GRID

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = gc_custom




*    I_APPL_EVENTS     = space

*    I_PARENTDBG       =

*    I_APPLOGPARENT    =

*    I_GRAPHICSPARENT  =

*    I_NAME            =

*    I_FCAT_COMPLETE   = SPACE

*  EXCEPTIONS

*    ERROR_CNTL_CREATE = 1

*    ERROR_CNTL_INIT   = 2

*    ERROR_CNTL_LINK   = 3

*    ERROR_DP_CREATE   = 4

*    others            = 5




    .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELDCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELDCAT .

  CLEAR : gs_fieldcat, gt_fieldcat.

 gs_fieldcat-col_pos = 1.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'KURST'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 2.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'FCURR'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 3.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'TCURR'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 4.

 gs_fieldcat-coltext = '####'.

 gs_fieldcat-fieldname = 'GDATU'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 5.

 gs_fieldcat-coltext = '##'.

 gs_fieldcat-fieldname = 'UKURS'.

 gs_fieldcat-decimals = 5.

 gs_fieldcat-outputlen = 15.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 6.

 gs_fieldcat-coltext = '########'.

 gs_fieldcat-fieldname = 'FFACT'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 7.

 gs_fieldcat-coltext = '########'.

 gs_fieldcat-fieldname = 'TFACT'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 8.

 gs_fieldcat-coltext = '###'.

 gs_fieldcat-fieldname = 'CRNAME'.

 APPEND gs_fieldcat TO gt_fieldcat.



 CLEAR : gs_fieldcat.

 gs_fieldcat-col_pos = 9.

 gs_fieldcat-coltext = '###'.

 gs_fieldcat-fieldname = 'CRDATE'.

 gs_fieldcat-outputlen = 10.

 APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR : gs_variant.

  gs_variant-report = sy-repid.

  gs_variant-username = sy-uname.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = gs_variant

    I_SAVE                        = 'A'




*    I_DEFAULT                     = 'X'




    IS_LAYOUT                     = gs_layout




*    IS_PRINT                      =

*    IT_SPECIAL_GROUPS             =

*    IT_TOOLBAR_EXCLUDING          =

*    IT_HYPERLINK                  =

*    IT_ALV_GRAPHICS               =

*    IT_EXCEPT_QINFO               =

*    IR_SALV_ADAPTER               =




  CHANGING

    IT_OUTTAB                     = gt_tcurr

    IT_FIELDCATALOG               = gt_fieldcat

    IT_SORT                       = gt_sort




*    IT_FILTER                     =

*  EXCEPTIONS

*    INVALID_PARAMETER_COMBINATION = 1

*    PROGRAM_ERROR                 = 2

*    TOO_MANY_LINES                = 3

*    others                        = 4




        .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_DATA .

  DATA: lv_temp_dir TYPE string,

        lv_save_dir TYPE string,

        lv_fullpath TYPE string,

        lv_delete_path TYPE rlgrap-filename, "WS_FILE_DELETE#

        lv_path     TYPE string,

        lv_pdf_path TYPE string.



  DATA: ls_wwwdata TYPE wwwdatatab,

        lv_rc      TYPE sy-subrc.



  "------------------------------------

  " 1. TEMP #### ####

  "------------------------------------

  CALL METHOD cl_gui_frontend_services=>get_temp_directory

    CHANGING temp_dir = lv_temp_dir.



  "------------------------------------

  " 2. ##### ## ## ## ##

  "------------------------------------

  CALL METHOD cl_gui_frontend_services=>directory_browse

    CHANGING selected_folder = lv_save_dir.



  " ## ### ##

  lv_fullpath = lv_save_dir && '\#####.xlsx'.

  lv_pdf_path = lv_save_dir && '\#####.pdf'.

  lv_delete_path = lv_fullpath.  " RLGRAP-FILENAME# ##

  lv_path = lv_fullpath.



  "------------------------------------

  " 1) ## ## ##

  "------------------------------------

  CALL FUNCTION 'WS_FILE_DELETE'

    EXPORTING

      file = lv_delete_path.



  "------------------------------------

  " 2) SMW0 #### ##

  "------------------------------------

  SELECT SINGLE *

    FROM wwwdata

    INTO CORRESPONDING FIELDS OF ls_wwwdata

    WHERE objid = 'ZWORK07_002_TEMPLETE'.



  IF sy-subrc <> 0.

    MESSAGE 'SMW0 #### ## # ####.' TYPE 'E'.

    RETURN.

  ENDIF.



  "------------------------------------

  " 3) ### ####

  "------------------------------------

  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      key         = ls_wwwdata

      destination = lv_delete_path

    IMPORTING

      rc          = lv_rc.



  IF lv_rc <> 0.

    MESSAGE '### #### ##' TYPE 'E'.

    RETURN.

  ENDIF.



  "------------------------------------------------------------

  " Excel OLE ##

  "------------------------------------------------------------

  DATA: excel      TYPE ole2_object,

        workbooks  TYPE ole2_object,

        workbook   TYPE ole2_object,

        worksheets TYPE ole2_object,

        worksheet  TYPE ole2_object,

        cell       TYPE ole2_object,

        col_range  TYPE ole2_object,

        page_setup TYPE ole2_object.



  FIELD-SYMBOLS <fs> TYPE any.



  " Excel ## ##

  CREATE OBJECT excel 'Excel.Application'.



  " ## ##

  SET PROPERTY OF excel 'Visible' = 0.



  " Workbooks ##

  CALL METHOD OF excel 'Workbooks' = workbooks.



  " ### ## ##

  CALL METHOD OF workbooks 'Open' = workbook

    EXPORTING

      #1 = lv_path.



  " # ## ## ####

  CALL METHOD OF workbook 'Worksheets' = worksheets.

  CALL METHOD OF worksheets 'Item' = worksheet

    EXPORTING

      #1 = 1.



  "------------------------------------------------------------

" ### ## ## ##

"------------------------------------------------------------

GET PROPERTY OF worksheet 'PageSetup' = page_setup.

SET PROPERTY OF page_setup 'Orientation' = 2. " 1=Portrait, 2=Landscape



  "------------------------------------------------------------

  " ### ###

  "------------------------------------------------------------

DATA : LT_ALV LIKE TABLE OF GS_TCURR,

         LS_ALV LIKE GS_TCURR.

DATA: LV_ROW TYPE I VALUE 2.



LOOP AT GT_TCURR INTO LS_ALV.



  " EXCEL 1# ## ##

  CALL METHOD OF WORKSHEET 'Cells' = CELL

    EXPORTING

      #1 = LV_ROW

      #2 = 1.

  SET PROPERTY OF CELL 'Value' = LS_ALV-KURST.



  " EXCEL 2# ## ##

  CALL METHOD OF WORKSHEET 'Cells' = CELL

    EXPORTING

      #1 = LV_ROW

      #2 = 2.

  SET PROPERTY OF CELL 'Value' = LS_ALV-FCURR.



  " EXCEL 3# ## ##

  CALL METHOD OF WORKSHEET 'Cells' = CELL

    EXPORTING

      #1 = LV_ROW

      #2 = 3.

  SET PROPERTY OF CELL 'Value' = LS_ALV-TCURR.



  " EXCEL 4# ## ##

  CALL METHOD OF WORKSHEET 'Cells' = CELL

    EXPORTING

      #1 = LV_ROW

      #2 = 4.

  SET PROPERTY OF CELL 'Value' = LS_ALV-GDATU.



  " EXCEL 5# ##

  CALL METHOD OF WORKSHEET 'Cells' = CELL

    EXPORTING

      #1 = LV_ROW

      #2 = 5.

  SET PROPERTY OF CELL 'Value' = LS_ALV-UKURS.



  " EXCEL 6# ########

  CALL METHOD OF WORKSHEET 'Cells' = CELL

    EXPORTING

      #1 = LV_ROW

      #2 = 6.

  SET PROPERTY OF CELL 'Value' = LS_ALV-FFACT.



  " EXCEL 7# ########

  CALL METHOD OF WORKSHEET 'Cells' = CELL

    EXPORTING

      #1 = LV_ROW

      #2 = 7.

  SET PROPERTY OF CELL 'Value' = LS_ALV-TFACT.



  " EXCEL 8# ###

  CALL METHOD OF WORKSHEET 'Cells' = CELL

    EXPORTING

      #1 = LV_ROW

      #2 = 8.

  SET PROPERTY OF CELL 'Value' = LS_ALV-CRNAME.



  " EXCEL 9# ###

  CALL METHOD OF WORKSHEET 'Cells' = CELL

    EXPORTING

      #1 = LV_ROW

      #2 = 9.

  SET PROPERTY OF CELL 'Value' = LS_ALV-CRDATE.



  LV_ROW = LV_ROW + 1.

ENDLOOP.



"------------------------------------------------------------

" # # AutoFit

"------------------------------------------------------------

DATA: usedrange TYPE ole2_object,

      lo_columns TYPE ole2_object.



" UsedRange ####

GET PROPERTY OF worksheet 'UsedRange' = usedrange.



" # ## ####

GET PROPERTY OF usedrange 'Columns' = lo_columns.



" AutoFit ##

CALL METHOD OF lo_columns 'AutoFit'.



FREE OBJECT lo_columns.

FREE OBJECT usedrange.



"------------------------------------------------------------

" Draw borders

"------------------------------------------------------------

DATA : RANGE TYPE OLE2_OBJECT,

       BORDERS TYPE OLE2_OBJECT,

       INTERIOR TYPE OLE2_OBJECT,

       LV_BORDER_ROW TYPE I,

       LV_BORDER_IDX TYPE I.  " ## #### ##



" DRAW HEADER BORDER

CALL METHOD OF WORKSHEET 'RANGE' = RANGE

  EXPORTING

    #1 = 'A1'

    #2 = 'I1'.



" Delete header highlight

GET PROPERTY OF RANGE 'Interior' = INTERIOR.

SET PROPERTY OF INTERIOR 'ColorIndex' = -4142.  " xlNone



" Draw header border

DO 5 TIMES.

  LV_BORDER_IDX = sy-index + 6.

  CALL METHOD OF RANGE 'BORDERS' = BORDERS EXPORTING #1 = LV_BORDER_IDX.

  SET PROPERTY OF BORDERS 'LINESTYLE' = 1.

ENDDO.



" DRAW DATA BORDER (2###)

LV_BORDER_ROW = 2.

LOOP AT GT_TCURR INTO LS_ALV.

  DATA(LV_START_CELL) = |A{ LV_BORDER_ROW }|.

  DATA(LV_END_CELL) = |I{ LV_BORDER_ROW }|.



  CALL METHOD OF WORKSHEET 'RANGE' = RANGE

    EXPORTING

      #1 = LV_START_CELL

      #2 = LV_END_CELL.



  " ##, ###, #, ##, ### ## ###

  DO 5 TIMES.

    LV_BORDER_IDX = sy-index + 6.

    CALL METHOD OF RANGE 'BORDERS' = BORDERS EXPORTING #1 = LV_BORDER_IDX.

    SET PROPERTY OF BORDERS 'LINESTYLE' = 1.

  ENDDO.



  LV_BORDER_ROW = LV_BORDER_ROW + 1.

ENDLOOP.



" Set zoom

DATA : PAGE_SETTING TYPE OLE2_OBJECT.

GET PROPERTY OF WORKSHEET 'PAGESETUP' = PAGE_SETTING.

SET PROPERTY OF PAGE_SETTING 'ZOOM' = ABAP_FALSE.



" Save workbook

CALL METHOD OF WORKBOOK 'SAVE'.



" PDF #### (## ##)

CALL METHOD OF WORKBOOK 'ExportAsFixedFormat'

  EXPORTING

    #1 = 0

    #2 = lv_pdf_path.       " PDF ## ##



" ## # ##

CALL METHOD OF WORKBOOK 'CLOSE'.

CALL METHOD OF EXCEL 'QUIT'.

FREE OBJECT WORKBOOK.

FREE OBJECT EXCEL.



" ## ## ##

CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

  EXPORTING

    FILENAME = lv_path

  CHANGING

    RC = LV_RC

  EXCEPTIONS

     FILE_DELETE_FAILED   = 1

     CNTL_ERROR           = 2

     ERROR_NO_GUI         = 3

     FILE_NOT_FOUND       = 4

     ACCESS_DENIED        = 5

     UNKNOWN_ERROR        = 6

     NOT_SUPPORTED_BY_GUI = 7

     WRONG_PARAMETER      = 8

     others               = 9.



ENDFORM.