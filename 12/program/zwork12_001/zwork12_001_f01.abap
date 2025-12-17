
*&---------------------------------------------------------------------*

*&  Include           ZWORK12_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SCREEN_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SCREEN_INIT .

  DATA : LS_FUNCTEXT TYPE SMP_DYNTXT.

    LS_FUNCTEXT-ICON_ID = ICON_EXPORT.

    LS_FUNCTEXT-ICON_TEXT = '## ### ####'.

    SSCRFIELDS-FUNCTXT_01 = LS_FUNCTEXT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*




FORM SET_SCREEN_OUTPUT .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      SCREEN-INPUT = '0'. "#### M## ##

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  EXCEL_TEMPLATE_DOWNLOAD

*&---------------------------------------------------------------------*




FORM EXCEL_TEMPLATE_DOWNLOAD .

  DATA: lv_fullpath TYPE string,

        lv_path     TYPE string,

        lv_file     TYPE string.



  DATA: ls_key  TYPE wwwdatatab,

        lv_dest TYPE rlgrap-filename.



  DATA: p_ext        TYPE string,

        p_title      TYPE string,

        lv_rc        TYPE sy-subrc.



  "------------------------------------------------

  " 1. SMW0 #### ## (WWWDATA)

  "------------------------------------------------

  SELECT SINGLE * INTO CORRESPONDING FIELDS OF ls_key

    FROM wwwdata

    WHERE objid = 'ZEDR12_EXCEL'.



  IF sy-subrc <> 0.

    MESSAGE '## ###(ZEDR12_EXCEL)# SMW0# #### ## ####.' TYPE 'E'.

    RETURN.

  ENDIF.



  "------------------------------------------------

  " 2. ## ## ##/### ##

  "------------------------------------------------

  p_title = '## ### ##'.

  p_ext   = 'XLSX'.          "## 'XLS' #, ### ###



  CALL METHOD cl_gui_frontend_services=>file_save_dialog

    EXPORTING

      window_title      = p_title

      default_extension = p_ext

      default_file_name = 'ZCURR12_TEMPLATE'   "## ###

    CHANGING

      filename          = lv_file

      path              = lv_path

      fullpath          = lv_fullpath

    EXCEPTIONS

      cntl_error                = 1

      error_no_gui              = 2

      not_supported_by_gui      = 3

      invalid_default_file_name = 4

      OTHERS                    = 5.



  lv_rc = sy-subrc.



  IF lv_rc <> 0.

    MESSAGE '## ## #### ## # ### ######.' TYPE 'E'.

    RETURN.

  ENDIF.



  "### ## # ## (## ##)

  IF lv_fullpath IS INITIAL.

    RETURN.

  ENDIF.



  "------------------------------------------------

  " 3. SMW0 ##### ### ####

  "------------------------------------------------

  lv_dest = lv_fullpath.



  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      key         = ls_key

      destination = lv_dest.



  IF sy-subrc <> 0.

    MESSAGE '## ### #### # ### ######.' TYPE 'E'.

  ELSE.

    MESSAGE '## #### ##### #######.' TYPE 'S'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SCREEN_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  FILE_UPLOAD

*&---------------------------------------------------------------------*




FORM FILE_UPLOAD .

  " EXCEL FILE ###

  "F4#### #### ##.

  CALL FUNCTION 'F4_FILENAME'

   IMPORTING

     FILE_NAME           = P_FILE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  EXCEL_TO_ITAB

*&---------------------------------------------------------------------*




FORM EXCEL_TO_ITAB .



  DATA: LT_EXCEL TYPE TABLE OF ALSMEX_TABLINE WITH HEADER LINE.

  DATA: LS_EXCEL LIKE LINE OF LT_EXCEL.

  FIELD-SYMBOLS <FS> TYPE ANY.



  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'

    EXPORTING

      FILENAME                      = P_FILE "######

      I_BEGIN_COL                   = 1      "### ###

      I_BEGIN_ROW                   = 2      "### ###

      I_END_COL                     = 7      "### ####

      I_END_ROW                     = 65000  "## # ##.

    TABLES

      INTERN                        = LT_EXCEL

            .

"## RAW#### ZTCURR# ## ##

    LOOP AT LT_EXCEL INTO LS_EXCEL.

      CASE LS_EXCEL-COL.

        WHEN 1.

          GS_ZTCURR-KURST = 'M'.

        WHEN 2.

          GS_ZTCURR-FCURR = LS_EXCEL-VALUE.

        WHEN 3.

          GS_ZTCURR-TCURR = LS_EXCEL-VALUE.

        WHEN 4.

          GS_ZTCURR-GDATU = P_DATE.

        WHEN 5.

          GS_ZTCURR-UKURS = LS_EXCEL-VALUE.

        WHEN 6.

          GS_ZTCURR-FFACT = LS_EXCEL-VALUE.

        WHEN 7.

          GS_ZTCURR-TFACT = LS_EXCEL-VALUE.

          GS_ZTCURR-CRNAME = SY-UNAME.

          GS_ZTCURR-CRDATE = SY-DATUM.

          APPEND GS_ZTCURR TO GT_ZTCURR.

          CLEAR GS_ZTCURR.

        ENDCASE.

    ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_CURR

*&---------------------------------------------------------------------*




FORM SAVE_DATA .

  "ALV # #### GT_TCURR# ##

  DATA LV_ANSWER TYPE C.



  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR                    = ' '

      TEXT_QUESTION               = '########?'

      TEXT_BUTTON_1               = 'YES'(001)




*     ICON_BUTTON_1               = ' '




      TEXT_BUTTON_2               = 'NO'(002)




*     ICON_BUTTON_2               = ' '




      DEFAULT_BUTTON              = '1'

      DISPLAY_CANCEL_BUTTON       = ' '

    IMPORTING

      ANSWER                      = LV_ANSWER.



  CASE LV_ANSWER.

    WHEN '1'.

      PERFORM UPDATE_DB.

      MESSAGE '#######.' TYPE 'S'.  " S = #####

    WHEN'2'.

      MESSAGE '#######.' TYPE 'I'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

     EXPORTING

       REPID                       = SY-REPID

       DYNNR                       = SY-DYNNR

       EXTENSION                   = 2000.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_DOCKING.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-FIELDNAME = 'KURST'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-FIELDNAME = 'FCURR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-FIELDNAME = 'TCURR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-FIELDNAME = 'GDATU'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  GS_FIELDCAT-DECIMALS = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-COLTEXT = '########'.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-COLTEXT = '########'.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-FIELDNAME = 'CRNAME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY .

CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = GS_VARIANT

    I_SAVE                        = 'A'




*    I_DEFAULT                     = 'X'




    IS_LAYOUT                     = GS_LAYOUT



  CHANGING

    IT_OUTTAB                     = GT_ZTCURR

    IT_FIELDCATALOG               = GT_FIELDCAT



        .

IF SY-SUBRC <> 0.




* Implement suitable error handling here




ENDIF.



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

  DATA: LS_STABLE TYPE LVC_S_STBL. "####.




*   ####USERCOMMAND ######

*    CURSOR#####




  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



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




*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Form  UPDATE_DB

*&---------------------------------------------------------------------*




FORM UPDATE_DB .

  DATA: LS_ZTCURR TYPE ZTCURR12.

  CLEAR: LS_ZTCURR.

  LOOP AT GT_ZTCURR INTO GS_ZTCURR.

    CALL FUNCTION 'CONVERSION_EXIT_INVDT_OUTPUT'

      EXPORTING

        INPUT         = GS_ZTCURR-GDATU

     IMPORTING

       OUTPUT        = GS_ZTCURR-GDATU

              .



    LS_ZTCURR-KURST = GS_ZTCURR-KURST.

    LS_ZTCURR-FCURR = GS_ZTCURR-FCURR.

    LS_ZTCURR-TCURR = GS_ZTCURR-TCURR.

    LS_ZTCURR-GDATU = GS_ZTCURR-GDATU.

    LS_ZTCURR-UKURS = GS_ZTCURR-UKURS.

    LS_ZTCURR-FFACT = GS_ZTCURR-FFACT.

    LS_ZTCURR-TFACT = GS_ZTCURR-TFACT.

    LS_ZTCURR-CRNAME = SY-UNAME.

    LS_ZTCURR-CRDATE = SY-DATUM.



    MODIFY ZTCURR12 FROM LS_ZTCURR.



  ENDLOOP.

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




FORM ALV_HANDLER_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONF4_AFTER

                                        P_UCOMM.

  DATA: LS_MODI TYPE LVC_S_MODI. "### # ## ###



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

   IF LS_MODI-FIELDNAME = 'UKURS'.

    READ TABLE GT_ZTCURR INTO GS_ZTCURR INDEX LS_MODI-ROW_ID.

    IF SY-SUBRC <> 0.

      CONTINUE.

    ENDIF.



    GS_ZTCURR-UKURS = LS_MODI-VALUE.



    "### ### ##

    MODIFY GT_ZTCURR FROM GS_ZTCURR INDEX LS_MODI-ROW_ID.

   ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*




FORM CLASS_EVENT .

"Register_edit : screen# ITAB ###

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED




*    EXCEPTIONS

*      ERROR      = 1

*      others     = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

  CREATE OBJECT GO_EVENT.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED  USING    P_MODIFIED

                                         PT_GOOD_CELLS TYPE LVC_T_MODI.

DATA: LS_MODI TYPE LVC_S_MODI.



CLEAR: LS_MODI.



LOOP AT PT_GOOD_CELLS INTO LS_MODI.

  IF LS_MODI-FIELDNAME = 'UKURS'.

    READ TABLE GT_ZTCURR INTO GS_ZTCURR INDEX LS_MODI-ROW_ID.



    CLEAR GS_ZTCURR.

  ENDIF.

ENDLOOP.



 PERFORM REFRESH.





ENDFORM.