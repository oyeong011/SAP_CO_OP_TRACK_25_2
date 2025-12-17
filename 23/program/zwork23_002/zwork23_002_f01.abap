
*&---------------------------------------------------------------------*

*&  Include           ZWORK23_002_F01

*&---------------------------------------------------------------------*








FORM GET_DATA.

  SELECT * FROM ZTCURR23

    INTO CORRESPONDING FIELDS OF TABLE GT_TCURR

    WHERE GDATU EQ P_DATE.

ENDFORM.





FORM CREATE_OBJECT.

  CREATE OBJECT GC_CUSTOM

    EXPORTING

      CONTAINER_NAME              = 'CON1'.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_CUSTOM.



ENDFORM.



FORM SAVE_PDF.

  " ### DATA# ### ## ## #### ##

  " ## ## ##.

  DATA : LV_TEMP TYPE STRING,

    LV_SOURCE TYPE RLGRAP-FILENAME,

    LV_DEST TYPE RLGRAP-FILENAME.

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

     EXPORTING

       WINDOW_TITLE         = '### ##'

       INITIAL_FOLDER       = 'C:'  "####

    CHANGING

      SELECTED_FOLDER      = LV_TEMP  "### ##

     EXCEPTIONS

       CNTL_ERROR           = 1

       ERROR_NO_GUI         = 2

       NOT_SUPPORTED_BY_GUI = 3

       others               = 4.



  CONCATENATE LV_TEMP '\##.xlsx' INTO LV_SOURCE.

  CONCATENATE LV_TEMP '\##.pdf' INTO LV_DEST.





   "**** ## ## ***"

   "### ## ## PDF ## ##

   CALL FUNCTION 'WS_FILE_DELETE'

     EXPORTING

       FILE          = LV_DEST.



    DATA : LS_WWWDATA TYPE WWWDATATAB,

          LV_FILENAME2 TYPE RLGRAP-FILENAME.

    "SMW0(ZED23)# ### ### ## ##

    SELECT SINGLE * FROM WWWDATA

      INTO CORRESPONDING FIELDS OF LS_WWWDATA

      WHERE OBJID = 'ZCURR_TEMPLATE_EMPTY'.



    IF SY-SUBRC NE 0.

      MESSAGE '### ##' TYPE 'E'.

    ENDIF.



    CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

      EXPORTING

        KEY               = LS_WWWDATA

        DESTINATION       = LV_SOURCE.



    IF SY-SUBRC NE 0.

      MESSAGE 'ERROR!! ERROR!!' TYPE 'E'.

    ENDIF.





    DATA : LV_APPLICATION TYPE OLE2_OBJECT,

          LV_WORKBOOKS TYPE OLE2_OBJECT,

          LV_WORKBOOK TYPE OLE2_OBJECT,

          LV_WORKSHEET TYPE OLE2_OBJECT.



    "EXCEL ###### ## ##

    CREATE OBJECT LV_APPLICATION 'EXCEL.APPLICATION'.

    " ### ## ##

    CALL METHOD OF LV_APPLICATION 'WORKBOOKS' = LV_WORKBOOKS.

    CALL METHOD OF LV_WORKBOOKS 'OPEN' = LV_WORKBOOK

      EXPORTING #1 = LV_SOURCE.



   "#### ####

   GET PROPERTY OF LV_APPLICATION 'ACTIVESHEET' = LV_WORKSHEET.

   SET PROPERTY OF LV_WORKSHEET 'Name' = '#####'.



   "### ### (#) : CELL# ### ### ###

   DATA : DELI TYPE C.

   DELI = CL_ABAP_CHAR_UTILITIES=>HORIZONTAL_TAB.



   TYPES : t_C(1500) TYPE C,

         T_DATA TYPE TABLE OF T_C.

   DATA : LS_EXCEL TYPE LINE OF T_DATA,

         LT_EXCEL TYPE T_DATA,

         LV_INDEX TYPE I.



   LOOP AT GT_TCURR INTO GS_TCURR.

     CLEAR : LS_EXCEL.

     LS_EXCEL = |{ GS_TCURR-KURST }{ DELI }{ GS_TCURR-FCURR }{ DELI }{ GS_TCURR-TCURR }{ DELI }{ GS_TCURR-GDATU }{ DELI }{ GS_TCURR-UKURS }{ DELI }{ GS_TCURR-FFACT }{ DELI }{ GS_TCURR-TFACT }{ DELI }{ GS_TCURR-CRNAME }{ DELI }{ GS_TCURR-CRDATE }|.

     APPEND LS_EXCEL TO LT_EXCEL.

   ENDLOOP.



   DATA : LV_RC TYPE I,

         LV_CELLS TYPE OLE2_OBJECT.

   " CLIPBOARD## EXCEL# ####

   CALL METHOD CL_GUI_FRONTEND_SERVICES=>CLIPBOARD_EXPORT

      EXPORTING

        NO_AUTH_CHECK        = SPACE

      IMPORTING

        DATA                 = LT_EXCEL

     CHANGING

       RC                   = LV_RC "RETURN CODE

      EXCEPTIONS

        CNTL_ERROR           = 1

        ERROR_NO_GUI         = 2

        NOT_SUPPORTED_BY_GUI = 3

        NO_AUTHORITY         = 4

        others               = 5.



   " #### #### #####

   CALL METHOD OF LV_WORKSHEET 'CELLS' = LV_CELLS

      EXPORTING "##### CELL# ##

        #1 = 2   "ROW

        #2 = 1.    "COL

   CALL METHOD OF LV_CELLS 'SELECT'.  "###### '##(##)'# ## ##

   CALL METHOD OF LV_WORKSHEET 'PASTE'.



   " # ### ###

   "DATA : RANGE, BORDERS # TOP# ##

    DATA : I TYPE I.

    I = 2.

    LOOP AT LT_EXCEL INTO LS_EXCEL.

      DATA(FIRST) = |A{ I }|.   "## ##

      DATA(SECOND) = |I{ I }|.  "## #



      CALL METHOD OF LV_WORKSHEET 'RANGE' = RANGE

        EXPORTING

          #1 = FIRST

          #2 = SECOND.

      CALL METHOD OF RANGE 'BORDERS' = BORDERS NO FLUSH

        EXPORTING #1 = 7.  " 7 = #####

      SET PROPERTY OF BORDERS 'LINESTYLE' = 1.

      CALL METHOD OF RANGE 'BORDERS' = BORDERS NO FLUSH

        EXPORTING #1 = 8.  " 8 = ######

      SET PROPERTY OF BORDERS 'LINESTYLE' = 1.

      CALL METHOD OF RANGE 'BORDERS' = BORDERS NO FLUSH

        EXPORTING #1 = 9.  " 9 = #####

      SET PROPERTY OF BORDERS 'LINESTYLE' = 1.

      CALL METHOD OF RANGE 'BORDERS' = BORDERS NO FLUSH

        EXPORTING #1 = 10.  " 10 = ######

      SET PROPERTY OF BORDERS 'LINESTYLE' = 1.

      CALL METHOD OF RANGE 'BORDERS' = BORDERS NO FLUSH

        EXPORTING #1 = 11.  " 11 = ######

      SET PROPERTY OF BORDERS 'LINESTYLE' = 1.



      I = I + 1.

    ENDLOOP.



   " # ## -> ### ## : ZOOM# FALSE#

   DATA : LV_PAGESETUP TYPE OLE2_OBJECT.

   GET PROPERTY OF LV_WORKSHEET 'PAGESETUP' = LV_PAGESETUP.

   SET PROPERTY OF LV_PAGESETUP 'ZOOM' = ABAP_FALSE.

   "SET PROPERTY OF LV_PAGESETUP 'FITTOPAGESWIDE' = 1.



   CALL METHOD OF LV_WORKBOOK 'SAVE'.



   " ## ### EXCEL# ### ##~

   " CALL METHOD OF LV_WORKBOOK 'SaveAs'

   "  EXPORTING

   "    #1 = LV_DEST

   "    #2 = 1.



   "PDF# ##

   CALL METHOD OF LV_WORKBOOK 'ExportAsfixedFormat'

     EXPORTING

       #1 = 0         "PDF

       #2 = LV_DEST.  "####+###



  CALL METHOD OF LV_WORKBOOK 'CLOSE'.

  CALL METHOD OF LV_APPLICATION 'QUIT'.



  FREE OBJECT : LV_APPLICATION, LV_WORKBOOK.



  "DELETE FILE : ### ## #### ##

  DATA : LV_STR TYPE STRING.

  LV_STR = LV_SOURCE.

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

    EXPORTING

      "FILENAME             = |LV_SOURCE|

      FILENAME             = LV_STR

    CHANGING

      RC                   = LV_RC

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

  IF SY-SUBRC <> 0.

    MESSAGE '## ##' TYPE 'I'.

  ENDIF.



ENDFORM.





FORM FIELD_CATALOG.

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

  GS_FIELDCAT-OUTPUTLEN = 12.

  GS_FIELDCAT-DECIMALS = 5.

  "GS_FIELDCAT-DECIMALS_O = 2.

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





FORM ALV_SORT.

ENDFORM.





FORM ALV_LAYOUT.

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

ENDFORM.





FORM CALL_ALV.

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

     EXPORTING




*      I_SAVE                        =

*      I_DEFAULT                     = 'X'




       IS_LAYOUT                     = GS_LAYOUT




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

       IT_OUTTAB                     = GT_TCURR

       IT_FIELDCATALOG               = GT_FIELDCAT




*       IT_SORT                       = GT_SORT

*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



ENDFORM.