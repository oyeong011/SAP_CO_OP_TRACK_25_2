
*&---------------------------------------------------------------------*

*&  Include           ZWORK06_001_F01

*&---------------------------------------------------------------------*





*&---------------------------------------------------------------------*

*&      Form  F4_FILE_OPEN

*&---------------------------------------------------------------------*

*       ## ## ## F4 ##

*----------------------------------------------------------------------*

*      <-- CV_FILE : ### ## ##

*----------------------------------------------------------------------*




FORM F4_FILE_OPEN  CHANGING CV_FILE.

  DATA: LT_FILETAB TYPE FILETABLE,                " ## ## ## ###

        LV_RC      TYPE i,                        " ## ##

        LV_TITLE   TYPE STRING VALUE '## ## ##'. " ##### ##



  " ## ## ## ##### ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_OPEN_DIALOG

    EXPORTING

      WINDOW_TITLE      = LV_TITLE

      DEFAULT_EXTENSION = 'XLSX'

      FILE_FILTER       = 'Excel Files (*.xlsx)|*.xlsx|All Files (*.*)|*.*'

      MULTISELECTION    = ABAP_FALSE

    CHANGING

      FILE_TABLE        = LT_FILETAB

      RC                = LV_RC

    EXCEPTIONS

      OTHERS            = 1.



    " # ## ## ### ##

    IF SY-SUBRC = 0.

      READ TABLE LT_FILETAB INDEX 1 INTO DATA(LS_FILE).

      IF SY-SUBRC = 0.

        CV_FILE = LS_FILE-FILENAME.

      ENDIF.

    ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  READ_FILE_DATA

*&---------------------------------------------------------------------*

*       ## ### ## #### ##

*----------------------------------------------------------------------*

*      <-- CV_FILE : ### ## ##

*----------------------------------------------------------------------*




FORM READ_FILE_DATA CHANGING CV_FILE.



  DATA : LT_EXCEL TYPE TABLE OF ALSMEX_TABLINE. " ## ## ###



CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'

  EXPORTING

    FILENAME                      = CV_FILE  " ### ##

    I_BEGIN_COL                   = 1        " ## # ###

    I_BEGIN_ROW                   = 2        " ## # ###

    I_END_COL                     = 256      " ### ## ##

    I_END_ROW                     = 10000    " ## ###

  TABLES

    INTERN                        = LT_EXCEL

  EXCEPTIONS

    INCONSISTENT_PARAMETERS       = 1

    UPLOAD_OLE                    = 2

    OTHERS                        = 3.



  " ### ### ## ##

 IF LT_EXCEL IS INITIAL.

   MESSAGE '## ### ####.' TYPE 'I'.

 ENDIF.



  " ## ## # ZTCURR06 ### ##

  PERFORM CONVERT_EXCEP_TO_TABLE USING LT_EXCEL.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONVERT_EXCEP_TO_TABLE

*&---------------------------------------------------------------------*

*       ALSMEX ### ### ### ##

*----------------------------------------------------------------------*

*      --> P_EXCEL : ALSMEX_TABLINE ###

*----------------------------------------------------------------------*




FORM CONVERT_EXCEP_TO_TABLE  USING P_EXCEL TYPE STANDARD TABLE.



  FIELD-SYMBOLS: <S> TYPE alsmex_tabline, " # ## ###

                 <C> TYPE alsmex_tabline. " # ## ###

  CLEAR GT_ZTCURR06.



  LOOP AT P_EXCEL ASSIGNING <S> GROUP BY <S>-ROW ASCENDING.



    GS_ZTCURR06-KURST = 'M'.      " #### ###

    GS_ZTCURR06-GDATU = P_DATE.   " #### ##



    LOOP AT GROUP <S> ASSIGNING <C>.

      CASE <C>-COL.

        WHEN 2. gs_ztcurr06-fcurr = <c>-value.  " ####

        WHEN 3. gs_ztcurr06-tcurr = <c>-value.  " ####

        WHEN 4. gs_ztcurr06-gdatu = <c>-value.  " #####

        WHEN 5. gs_ztcurr06-ukurs = <c>-value.  " ##

        WHEN 6. gs_ztcurr06-ffact = <c>-value.  " ## ####

        WHEN 7. gs_ztcurr06-tfact = <c>-value.  " ## ####

      ENDCASE.

    ENDLOOP.





    " ### # # ##

    APPEND GS_ZTCURR06 TO GT_ZTCURR06.



    CLEAR GS_ZTCURR06.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       ALV ### ### ##

*----------------------------------------------------------------------*




FORM MODIFY_DATA .



  CLEAR : GS_ZTCURR06_ALV, GS_ZTCURR06.



  " ### ### # ALV# ### ##

  LOOP AT GT_ZTCURR06 INTO GS_ZTCURR06.

    MOVE-CORRESPONDING GS_ZTCURR06 TO GS_ZTCURR06_ALV.



    GS_ZTCURR06_ALV-GDATU = P_DATE.     " ## #### ##

    GS_ZTCURR06_ALV-AENAM = SY-UNAME.   " ###

    GS_ZTCURR06_ALV-AEDAT = SY-DATUM.   " ###





    APPEND GS_ZTCURR06_ALV TO GT_ZTCURR06_ALV.

    CLEAR : GS_ZTCURR06, GS_ZTCURR06_ALV.

  ENDLOOP.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       ## #### # ALV GRID ##

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .



  " ## #### ##

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      EXTENSION                   = 2000.



  " ALV GRID ##

  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_DOCKING.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       ALV ## ##

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .

CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY




*  EXPORTING

*    IS_LAYOUT                     =




  CHANGING

    IT_OUTTAB                     = GT_ZTCURR06_ALV   " ## ###

    IT_FIELDCATALOG               = GT_FIELDCAT       " ######




*    IT_SORT                      =

*    IT_FILTER                    =




        .

IF SY-SUBRC <> 0.




* Implement suitable error handling here




ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_FIELDCAT

*&---------------------------------------------------------------------*

*       ALV ###### ##

*----------------------------------------------------------------------*




FORM ALV_FIELDCAT .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'KURST'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'FCURR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'TCURR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'GDATU'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  GS_FIELDCAT-DECIMALS = 5.




*  GS_FIELDCAT-CFIELDNAME = 'FCURR'.




  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  GS_FIELDCAT-COLTEXT = '########'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'AENAM'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'AEDAT'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



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

FORM CLASS_EVANT.



  " ### ### ## ##

  CREATE OBJECT GO_EVENT.



  " ### ## ### ### ##

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.



  " # ## ### ##

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.





ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_DATA_CHANGED

*&---------------------------------------------------------------------*

*       ALV ### ## # ##### ##

*----------------------------------------------------------------------*

*      --> P_DATA_CHANGED : #### ####

*----------------------------------------------------------------------*




FORM ALV_HANDLE_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                       P_ONF4

                                       P_ONF4_BEFORE

                                       P_ONF4_AFTER

                                       P_UCOMM.



  DATA : LS_MODI TYPE LVC_S_MODI.    " ## # ##



  CLEAR : LS_MODI.



   " ### # ## ##

  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.



    " ALV ####### ## # ##

    READ TABLE GT_ZTCURR06_ALV INTO GS_ZTCURR06_ALV INDEX LS_MODI-ROW_ID.

    IF SY-SUBRC <> 0.

      CONTINUE.

    ENDIF.



    " ### ### ##

    IF LS_MODI-FIELDNAME = 'UKURS'.

      GS_ZTCURR06_ALV-UKURS = LS_MODI-VALUE.

    ELSEIF LS_MODI-FIELDNAME = 'GDATU'.

      GS_ZTCURR06_ALV-GDATU = LS_MODI-VALUE.

    ENDIF.



    " ## ## ## ##

    MODIFY GT_ZTCURR06_ALV FROM GS_ZTCURR06_ALV INDEX LS_MODI-ROW_ID.

    CLEAR GS_ZTCURR06_ALV.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_CHANGED_UKURS

*&---------------------------------------------------------------------*

*       ### ##/#### DB# ##

*----------------------------------------------------------------------*




FORM SAVE_CHANGED_UKURS .



  " ALV ### #### DB ####

  CLEAR : GS_ZTCURR06_ALV.

  LOOP AT GT_ZTCURR06_ALV INTO GS_ZTCURR06_ALV.



    CLEAR : GS_ZTCURR06.

    MOVE-CORRESPONDING GS_ZTCURR06_ALV TO GS_ZTCURR06.



    " ## ##.

    MODIFY ZTCURR06 FROM GS_ZTCURR06.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_TEMPLATE

*&---------------------------------------------------------------------*

*       ## ### CSV ####

*----------------------------------------------------------------------*




FORM DOWNLOAD_TEMPLATE .



  DATA: lv_filename TYPE string,    " ###

      lv_path     TYPE string,      " ##

      lv_fullpath TYPE string.      " ## ##



  " ## ## ## #####

  CALL METHOD cl_gui_frontend_services=>file_save_dialog

    EXPORTING

      window_title      = '## ##'

      default_extension = 'csv'

      default_file_name = '## ###.csv'

    CHANGING

      filename          = lv_filename

      path              = lv_path

      fullpath          = lv_fullpath

    EXCEPTIONS

      OTHERS            = 1.



    " #### ### ##

  IF lv_fullpath IS INITIAL.

    MESSAGE '##### #######.' TYPE 'I'.

    RETURN.

  ENDIF.



  " ALV #### CSV# ####

  CALL METHOD cl_gui_frontend_services=>gui_download

    EXPORTING

      filename                = lv_fullpath

      filetype                = 'ASC'          " ### ## CSV ##

      write_field_separator   = 'X'            " ### ##

    CHANGING

      data_tab                = gt_ztcurr06_alv

    EXCEPTIONS

      OTHERS                  = 1.



  IF sy-subrc = 0.

    MESSAGE '## ### #########.' TYPE 'S'.

  ELSE.

    MESSAGE '#### # ## ##' TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       ALV ## ##

*----------------------------------------------------------------------*




FORM REFRESH .



  DATA : LS_STABLE TYPE LVC_S_STBL.     " ###/## ## ##



  " ALV ### ####

  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE




*      I_SOFT_REFRESH =

*    EXCEPTIONS

*      FINISHED       = 1

*      others         = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.





ENDFORM.