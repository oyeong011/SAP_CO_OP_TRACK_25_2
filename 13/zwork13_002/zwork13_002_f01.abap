
*&---------------------------------------------------------------------*

*&  Include           ZWORK13_002_F01

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_CUSTOM

    EXPORTING




*      PARENT                      =




      CONTAINER_NAME              = 'CON01'




*      STYLE                       =

*      LIFETIME                    = lifetime_default

*      REPID                       =

*      DYNNR                       =

*      NO_AUTODEF_PROGID_DYNNR     =

*    EXCEPTIONS

*      CNTL_ERROR                  = 1

*      CNTL_SYSTEM_ERROR           = 2

*      CREATE_ERROR                = 3

*      LIFETIME_ERROR              = 4

*      LIFETIME_DYNPRO_DYNPRO_LINK = 5

*      others                      = 6




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

CREATE OBJECT GC_GRID

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_CUSTOM




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

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'KURST'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'FCURR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'TCURR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'GDATU'.

  GS_FIELDCAT-SCRTEXT_M = '## ## ###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  GS_FIELDCAT-SCRTEXT_M = '########'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  GS_FIELDCAT-SCRTEXT_M = '########'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'CRNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



   CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

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




FORM ALV_LAYOUT.

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

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




    IS_VARIANT                    = GS_VARIANT

    I_SAVE                        = 'A'




*    I_DEFAULT                     = 'X'




    IS_LAYOUT                     = GS_LAYOUT




*    IS_PRINT                      =

*    IT_SPECIAL_GROUPS             =

*    IT_TOOLBAR_EXCLUDING          =

*    IT_HYPERLINK                  =

*    IT_ALV_GRAPHICS               =

*    IT_EXCEPT_QINFO               =

*    IR_SALV_ADAPTER               =




  CHANGING

    IT_OUTTAB                     = GT_TCURR

    IT_FIELDCATALOG               = GT_FIELDCAT

    IT_SORT                       = GT_SORT




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

*&      Form  GET_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATE.

  CLEAR : GT_TCURR.

  SELECT * FROM ZTCURR13

    INTO CORRESPONDING FIELDS OF TABLE GT_TCURR

    WHERE GDATU = P_DATE.

  IF GT_TCURR IS INITIAL.

    MESSAGE I001.

    STOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  POPUP_MESSAGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM POPUP_MESSAGE.

  DATA : LV_YESNO TYPE C.

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

     TITLEBAR                    = 'PDF ####'




*     DIAGNOSE_OBJECT             = ' '




      TEXT_QUESTION               = 'PDF# ##########?'

     TEXT_BUTTON_1               = 'YES'




*     ICON_BUTTON_1               = ' '




     TEXT_BUTTON_2               = 'NO'




*     ICON_BUTTON_2               = ' '

*     DEFAULT_BUTTON              = '1'




     DISPLAY_CANCEL_BUTTON       = ' '  "#### ##"




*     USERDEFINED_F1_HELP         = ' '

*     START_COLUMN                = 25

*     START_ROW                   = 6

*     POPUP_TYPE                  =

*     IV_QUICKINFO_BUTTON_1       = ' '

*     IV_QUICKINFO_BUTTON_2       = ' '




   IMPORTING

     ANSWER                      = LV_YESNO




*   TABLES

*     PARAMETER                   =

*   EXCEPTIONS

*     TEXT_NOT_FOUND              = 1

*     OTHERS                      = 2




            .

  IF LV_YESNO = '1'.

    PERFORM DOWNLOAD_PDF.

  ELSEIF LV_YESNO = '2'.

    MESSAGE '#######' TYPE 'S'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_PDF

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DOWNLOAD_PDF.



  PERFORM SET_DIRECTORY. "GV_SAVE_DIR# ## ## ##"

  LV_XLSXFILE = GV_SAVE_DIR && '\' && '####.xlsx'.



  SELECT SINGLE * FROM WWWDATA

    WHERE OBJID = 'ZTCURR_EXCEL_EXPANDED'

    INTO CORRESPONDING FIELDS OF @LS_KEY. "# ## # ##"



  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'     "### ## ### ### ####"

    EXPORTING

      KEY         = LS_KEY

      DESTINATION = LV_XLSXFILE.



  CREATE OBJECT LO_APPLICATION 'EXCEL.APPLICATION'.

  SET PROPERTY OF LO_APPLICATION 'VISIBLE' = 0.



  CALL METHOD OF LO_APPLICATION 'WORKBOOKS' = LO_WORKBOOKS.

  CALL METHOD OF LO_WORKBOOKS 'OPEN' = LO_WORKBOOK

    EXPORTING

      #1 = LV_XLSXFILE. "### ### ##"

  GET PROPERTY OF LO_APPLICATION 'ACTIVESHEET' = LO_WORKSHEET.



  LOOP AT GT_TCURR INTO GS_TCURR. "## ### ### #### ## ### ##"

    CALL METHOD OF LO_WORKSHEET 'CELLS' = LO_CELL

      EXPORTING #1 = LV_ROW  #2 = 1.  "#1# ## ### ###, #2# ## ### ### ### A#"

    SET PROPERTY OF LO_CELL 'VALUE' = GS_TCURR-KURST.



    CALL METHOD OF LO_WORKSHEET 'CELLS' = LO_CELL

      EXPORTING #1 = LV_ROW  #2 = 2.  "#1# ## ### ###, #2# ## ### ### ### B#"

    SET PROPERTY OF LO_CELL 'VALUE' = GS_TCURR-FCURR.



    CALL METHOD OF LO_WORKSHEET 'CELLS' = LO_CELL

      EXPORTING #1 = LV_ROW  #2 = 3.  "#1# ## ### ###, #2# ## ### ### ### C#"

    SET PROPERTY OF LO_CELL 'VALUE' = GS_TCURR-TCURR.



    CALL METHOD OF LO_WORKSHEET 'CELLS' = LO_CELL

      EXPORTING #1 = LV_ROW  #2 = 4.  "#1# ## ### ###, #2# ## ### ### ### D#"

    SET PROPERTY OF LO_CELL 'VALUE' = GS_TCURR-GDATU.



    CALL METHOD OF LO_WORKSHEET 'CELLS' = LO_CELL

      EXPORTING #1 = LV_ROW  #2 = 5.  "#1# ## ### ###, #2# ## ### ### ### E#"

    SET PROPERTY OF LO_CELL 'VALUE' = GS_TCURR-UKURS.



    CALL METHOD OF LO_WORKSHEET 'CELLS' = LO_CELL

      EXPORTING #1 = LV_ROW  #2 = 6. "#1# ## ### ###, #2# ## ### ### ### F#"

    SET PROPERTY OF LO_CELL 'VALUE' = GS_TCURR-FFACT.



    CALL METHOD OF LO_WORKSHEET 'CELLS' = LO_CELL

      EXPORTING #1 = LV_ROW  #2 = 7. "#1# ## ### ###, #2# ## ### ### ### G#"

    SET PROPERTY OF LO_CELL 'VALUE' = GS_TCURR-TFACT.



    CALL METHOD OF LO_WORKSHEET 'CELLS' = LO_CELL

      EXPORTING #1 = LV_ROW  #2 = 8. "#1# ## ### ###, #2# ## ### ### ### H#"

    SET PROPERTY OF LO_CELL 'VALUE' = GS_TCURR-CRNAME.



    CALL METHOD OF LO_WORKSHEET 'CELLS' = LO_CELL

      EXPORTING #1 = LV_ROW  #2 = 9. "#1# ## ### ###, #2# ## ### ### ### I#"

    SET PROPERTY OF LO_CELL 'VALUE' = GS_TCURR-CRDATE.



    LV_ROW = LV_ROW + 1. "# ##"

  ENDLOOP.

  CALL METHOD OF LO_WORKBOOK 'SAVE'. "## ## ##"



  LV_PDFNAME = SUBSTRING_BEFORE( VAL = LV_XLSXFILE SUB = '.').  "##### .xlsx ### ##"

  LV_PDFFILE = LV_PDFNAME && '.pdf'.                            "PDF ### ##"



  CALL METHOD OF LO_WORKBOOK 'EXPORTASFIXEDFORMAT'

    EXPORTING

      #1 = 0              "PDF ## ##"

      #2 = LV_PDFFILE.    "### ### ##"



  CALL METHOD OF LO_WORKBOOK 'CLOSE'.

  CALL METHOD OF LO_APPLICATION 'QUIT'.



  FREE: LO_CELL, LO_WORKSHEET, LO_WORKBOOK, LO_WORKBOOKS, LO_APPLICATION. "## #### ## ## ### #### ##"



  LV_XLSXFILE_STRING = LV_XLSXFILE. "STRING## ##"





  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

    EXPORTING

      FILENAME             = LV_XLSXFILE_STRING

    CHANGING

      RC                   = LV_RC    "RETURN CODE"

    EXCEPTIONS




*      FILE_DELETE_FAILED   = 1

*      CNTL_ERROR           = 2

*      ERROR_NO_GUI         = 3

*      FILE_NOT_FOUND       = 4

*      ACCESS_DENIED        = 5

*      UNKNOWN_ERROR        = 6

*      NOT_SUPPORTED_BY_GUI = 7

*      WRONG_PARAMETER      = 8




      others               = 9

          .

  IF SY-SUBRC = 0.

    MESSAGE 'PDF #### ##' TYPE 'S'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_DIRECTORY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DIRECTORY.

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>GET_TEMP_DIRECTORY

    CHANGING

      TEMP_DIR             = GV_TEMP_DIR




*    EXCEPTIONS

*      CNTL_ERROR           = 1

*      ERROR_NO_GUI         = 2

*      NOT_SUPPORTED_BY_GUI = 3

*      others               = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

    EXPORTING




*      WINDOW_TITLE         =




      INITIAL_FOLDER       = GV_TEMP_DIR

    CHANGING

      SELECTED_FOLDER      = GV_SAVE_DIR




*    EXCEPTIONS

*      CNTL_ERROR           = 1

*      ERROR_NO_GUI         = 2

*      NOT_SUPPORTED_BY_GUI = 3

*      others               = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

ENDFORM.