
*&---------------------------------------------------------------------*

*&  Include           ZWORK07_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_SCREEN .

  LOOP AT SCREEN.

    IF screen-group1 = 'M1'.

      screen-input = '0'. "## ##### ####

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE' "## ### ### #### ####

    EXPORTING

      FILENAME                      = p_file

      I_BEGIN_COL                   = 1

      I_BEGIN_ROW                   = 2

      I_END_COL                     = 7

      I_END_ROW                     = 10

    TABLES

      INTERN                        = t_raw_excel

   EXCEPTIONS

     INCONSISTENT_PARAMETERS       = 1

     UPLOAD_OLE                    = 2

     OTHERS                        = 3

            .



  CLEAR gt_tcurr.

  LOOP AT t_raw_excel INTO s_raw_excel.

    CASE s_raw_excel-col.

      WHEN 1. gs_tcurr-kurst = s_raw_excel-value.

      WHEN 2. gs_tcurr-fcurr = s_raw_excel-value.

      WHEN 3. gs_tcurr-tcurr = s_raw_excel-value.

      WHEN 4. gs_tcurr-gdatu = s_raw_excel-value.

      WHEN 5. gs_tcurr-ukurs = s_raw_excel-value.

      WHEN 6. gs_tcurr-ffact = s_raw_excel-value.

      WHEN 7. gs_tcurr-tfact = s_raw_excel-value.

    ENDCASE.



    AT END OF row.

      APPEND gs_tcurr TO gt_tcurr.

      CLEAR gs_tcurr.

    ENDAT.



  ENDLOOP.

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






*    DATA : lv_date TYPE dats.

*    lv_date = p_date.






    gs_tcurr-gdatu = p_date. "## ## #### ### ## ###

    gs_tcurr-kurst = 'M'. "## ## M## ##



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

CREATE OBJECT GC_DOCKING

  EXPORTING




*    PARENT                      =




    REPID                       = sy-repid

    DYNNR                       = sy-dynnr




*    SIDE                        = DOCK_AT_LEFT




    EXTENSION                   = 2000




*    STYLE                       =

*    LIFETIME                    = lifetime_default

*    CAPTION                     =

*    METRIC                      = 0

*    RATIO                       =

*    NO_AUTODEF_PROGID_DYNNR     =

*    NAME                        =

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




    I_PARENT          = gc_docking




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

 gs_fieldcat-edit = 'X'.

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

CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

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

IF SY-SUBRC <> 0.




* Implement suitable error handling here




ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  TEMPLETE_DOWN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM TEMPLETE_DOWN .

  DATA : lv_rc TYPE sy-subrc.



  " SMW0## #### ##

  SELECT SINGLE *

    INTO CORRESPONDING FIELDS OF gs_key FROM wwwdata

    WHERE objid = 'ZWORK07_001_TEMPLETE'.



  IF sy-subrc <> 0.

    MESSAGE '#### ## # ####.' TYPE 'E'.

    EXIT.

  ENDIF.



  "#### ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG

    EXPORTING

      WINDOW_TITLE = '### ##'

      DEFAULT_EXTENSION = 'XLSX'

      DEFAULT_FILE_NAME = '## ### INPUT'

    CHANGING

      FILENAME = GV_FILE

      PATH = GV_path

      FULLPATH = GV_FULLPATH

    .

  gv_dest = gv_fullpath.



  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT' "### ####

    EXPORTING

      KEY               = gs_key

      DESTINATION       = gv_dest

    IMPORTING

      RC                = lv_rc.



  IF sy-subrc = 0.

    MESSAGE '### #### ##' TYPE 'S'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_DATA . "alv## ### ### #### ##

  DATA : gs_save LIKE ztcurr07.

  DATA : gt_save LIKE TABLE OF gs_save.



  LOOP AT gt_tcurr INTO gs_tcurr.

    MOVE-CORRESPONDING gs_tcurr TO gs_save.

    APPEND gs_save TO gt_save.

  ENDLOOP.



  MODIFY ztcurr07 FROM TABLE gt_save.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH .

  DATA : ls_stable TYPE lvc_s_stbl.



  ls_stable-row = 'X'.

  ls_stable-col = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = ls_stable




*      I_SOFT_REFRESH =

*    EXCEPTIONS

*      FINISHED       = 1

*      others         = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO cl_alv_changed_data_protocol

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONF4_AFTER

                                        P_UCOMM.

  DATA : ls_modi TYPE lvc_s_modi.



  CLEAR : ls_modi.



  LOOP AT p_data_changed->mt_good_cells INTO ls_modi.

    IF ls_modi-fieldname = 'UKURS'.



      READ TABLE gt_tcurr INTO gs_tcurr INDEX ls_modi-row_id.






*      DATA lv_value TYPE p DECIMALS 5.  "p ##, ### 5##

*      lv_value = ls_modi-value.

*      lv_value = lv_value * 100.

*

*      BREAK-POINT.

*      gs_tcurr-ukurs = lv_value.






      MODIFY gt_tcurr FROM gs_tcurr INDEX ls_modi-row_id.

      CLEAR gs_tcurr.



    ENDIF.

  ENDLOOP.



  PERFORM refresh.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT .

  CREATE OBJECT go_event.



  SET HANDLER go_event->handler_data_changed FOR gc_grid.



  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = cl_gui_alv_grid=>mc_evt_modified




*    EXCEPTIONS

*      ERROR      = 1

*      others     = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.





ENDFORM.