
*&---------------------------------------------------------------------*

*&  INCLUDE           ZWORK01_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      FORM  MAIN

*&---------------------------------------------------------------------*

*       ##### #### ## ##### #### ####

*----------------------------------------------------------------------*




FORM MAIN .

  IF P_DATE IS NOT INITIAL.

    PERFORM GET_DATA.

    CALL SCREEN 100.

  ELSE.

    MESSAGE '##### ######' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  GET_DATA

*&---------------------------------------------------------------------*

*       ZTCURR01# ##### #### #### GT_CURR# #### ####

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT * FROM ZTCURR01

    INTO CORRESPONDING FIELDS OF TABLE GT_CURR

    WHERE GDATU = P_DATE.

  IF GT_CURR IS INITIAL.

    MESSAGE '#### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       ALV #### ##

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_CUSTOM

    EXPORTING




*      PARENT                      =




      CONTAINER_NAME              = 'CON1'




*      STYLE                       =

*      LIFETIME                    = LIFETIME_DEFAULT

*      REPID                       =

*      DYNNR                       =

*      NO_AUTODEF_PROGID_DYNNR     =

*    EXCEPTIONS

*      CNTL_ERROR                  = 1

*      CNTL_SYSTEM_ERROR           = 2

*      CREATE_ERROR                = 3

*      LIFETIME_ERROR              = 4

*      LIFETIME_DYNPRO_DYNPRO_LINK = 5

*      OTHERS                      = 6




      .

  CREATE OBJECT GC_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_CUSTOM.




*      I_APPL_EVENTS     = SPACE

*      I_PARENTDBG       =

*      I_APPLOGPARENT    =

*      I_GRAPHICSPARENT  =

*      I_NAME            =

*      I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*      ERROR_CNTL_CREATE = 1

*      ERROR_CNTL_INIT   = 2

*      ERROR_CNTL_LINK   = 3

*      ERROR_DP_CREATE   = 4

*      OTHERS            = 5




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       ALV ###### ##

*----------------------------------------------------------------------*




FORM FIELD_CATALOG .



  CLEAR : GS_FIELDCAT,GT_FIELDCAT.

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

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-JUST = 'L'.

  GS_FIELDCAT-OUTPUTLEN = 15.

  GS_FIELDCAT-DECIMALS = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  GS_FIELDCAT-SCRTEXT_M = '########'.

  GS_FIELDCAT-OUTPUTLEN = 13.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  GS_FIELDCAT-SCRTEXT_M = '########'.

  GS_FIELDCAT-OUTPUTLEN = 13.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'CRNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  ORDER_ALV_LAYOUT

*&---------------------------------------------------------------------*




" LAYOUT# #### ####

FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'. " ### ## ###



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  ORDER_ALV_SORT

*&---------------------------------------------------------------------*




" SORT# #### ####

FORM ALV_SORT .



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM ALV_DISPLAY

*&---------------------------------------------------------------------*




" ALV# #### #### PT_TABLE# ### #### ###

FORM ALV_DISPLAY USING PT_TABLE TYPE STANDARD TABLE.

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =




      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'




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

      IT_OUTTAB                     = PT_TABLE

      IT_FIELDCATALOG               = GT_FIELDCAT

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      OTHERS                        = 4




          .

ENDFORM.






*---------------------------------------------------------------------*

* FORM: PDF_DOWNLOAD

*---------------------------------------------------------------------*




FORM PDF_DOWNLOAD .






*---------------------------------------------------------------------*

* 1. ## ## ##, ## ## (DIRECTORY_BROWSE ##)

*---------------------------------------------------------------------*




  DATA: LV_FILENAME          TYPE STRING VALUE 'TEMPLATE.XLSX',

        LV_SELECTED_FOLDER   TYPE STRING,

        LV_FULLPATH          TYPE STRING,

        LV_RC                TYPE I.






* ## ## #




  CALL METHOD CL_GUI_FRONTEND_SERVICES=>DIRECTORY_BROWSE

    CHANGING

      SELECTED_FOLDER = LV_SELECTED_FOLDER

    EXCEPTIONS

      CNTL_ERROR       = 1

      ERROR_NO_GUI     = 2

      NOT_SUPPORTED_BY_GUI = 3

      OTHERS           = 4.



  IF SY-SUBRC <> 0 OR LV_SELECTED_FOLDER IS INITIAL.

    RETURN.

  ENDIF.






* ### ## + ### ##




  CONCATENATE LV_SELECTED_FOLDER '\' LV_FILENAME INTO LV_FULLPATH.



  IF LV_FULLPATH IS INITIAL.

    RETURN.

  ENDIF.






*---------------------------------------------------------------------*

* 2. SMW0 ### ####

*---------------------------------------------------------------------*




  DATA: LS_ITEM TYPE WWWDATATAB,

        LV_FILE TYPE RLGRAP-FILENAME.



  LV_FILE = LV_FULLPATH.



  SELECT SINGLE * FROM WWWDATA

    WHERE OBJID = 'ZEXCEL_TEMPLATE_CURR'

    INTO CORRESPONDING FIELDS OF @LS_ITEM.



  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY         = LS_ITEM

      DESTINATION = LV_FILE.






*---------------------------------------------------------------------*

* 3. ## ### ##

*---------------------------------------------------------------------*




  DATA: LO_APPLICATION TYPE OLE2_OBJECT,

        LO_WORKBOOKS   TYPE OLE2_OBJECT,

        LO_WORKBOOK    TYPE OLE2_OBJECT,

        LO_WORKSHEET   TYPE OLE2_OBJECT,

        LO_CELL        TYPE OLE2_OBJECT.



  CREATE OBJECT LO_APPLICATION 'EXCEL.APPLICATION'.

  SET PROPERTY OF LO_APPLICATION 'VISIBLE' = 0.



  CALL METHOD OF LO_APPLICATION 'WORKBOOKS' = LO_WORKBOOKS.

  CALL METHOD OF LO_WORKBOOKS 'OPEN' = LO_WORKBOOK

    EXPORTING

      #1 = LV_FILE.



  GET PROPERTY OF LO_APPLICATION 'ACTIVESHEET' = LO_WORKSHEET.






*---------------------------------------------------------------------*

* 4. ### ##

*---------------------------------------------------------------------*




  DATA LV_ROW TYPE I VALUE 2.



  LOOP AT GT_CURR INTO GS_CURR.



    " A#

    CALL METHOD OF LO_WORKSHEET 'CELLS' = LO_CELL

      EXPORTING #1 = LV_ROW  #2 = 1.

    SET PROPERTY OF LO_CELL 'VALUE' = GS_CURR-KURST.



    " B#

    CALL METHOD OF LO_WORKSHEET 'CELLS' = LO_CELL

      EXPORTING #1 = LV_ROW  #2 = 2.

    SET PROPERTY OF LO_CELL 'VALUE' = GS_CURR-FCURR.



    " C#

    CALL METHOD OF LO_WORKSHEET 'CELLS' = LO_CELL

      EXPORTING #1 = LV_ROW  #2 = 3.

    SET PROPERTY OF LO_CELL 'VALUE' = GS_CURR-TCURR.



    " D#

    CALL METHOD OF LO_WORKSHEET 'CELLS' = LO_CELL

      EXPORTING #1 = LV_ROW  #2 = 4.

    SET PROPERTY OF LO_CELL 'VALUE' = GS_CURR-GDATU.



    " E#

    CALL METHOD OF LO_WORKSHEET 'CELLS' = LO_CELL

      EXPORTING #1 = LV_ROW  #2 = 5.

    SET PROPERTY OF LO_CELL 'VALUE' = GS_CURR-UKURS.



    " F#

    CALL METHOD OF LO_WORKSHEET 'CELLS' = LO_CELL

      EXPORTING #1 = LV_ROW  #2 = 6.

    SET PROPERTY OF LO_CELL 'VALUE' = GS_CURR-FFACT.



    " G#

    CALL METHOD OF LO_WORKSHEET 'CELLS' = LO_CELL

      EXPORTING #1 = LV_ROW  #2 = 7.

    SET PROPERTY OF LO_CELL 'VALUE' = GS_CURR-TFACT.



    LV_ROW = LV_ROW + 1.

  ENDLOOP.






*---------------------------------------------------------------------*

* 5. EXCEL ##

*---------------------------------------------------------------------*




  CALL METHOD OF LO_WORKBOOK 'SAVE'.






*---------------------------------------------------------------------*

* 6. PDF# ##

*---------------------------------------------------------------------*




  DATA: LV_PURE_NAME     TYPE STRING,

        LV_PDF_FULL_PATH TYPE STRING.






* ##### ### ## (TEMPLATE.XLSX # TEMPLATE)




  LV_PURE_NAME = SUBSTRING_BEFORE(

                    VAL = LV_FILENAME

                    SUB = '.' ).






* PDF ## ## ##




  CONCATENATE LV_SELECTED_FOLDER '\' LV_PURE_NAME '.PDF'

         INTO LV_PDF_FULL_PATH.



  CALL METHOD OF LO_WORKBOOK 'EXPORTASFIXEDFORMAT'

    EXPORTING

      #1 = 0                " PDF

      #2 = LV_PDF_FULL_PATH.




*---------------------------------------------------------------------*

* 7. EXCEL ##

*---------------------------------------------------------------------*




  CALL METHOD OF LO_WORKBOOK 'CLOSE'.

  CALL METHOD OF LO_APPLICATION 'QUIT'.



  FREE: LO_CELL, LO_WORKSHEET, LO_WORKBOOK, LO_WORKBOOKS, LO_APPLICATION.






*---------------------------------------------------------------------*

* 8. ## XLSX ##

*---------------------------------------------------------------------*




  DATA: LV_FILE_STRING TYPE STRING.



  LV_FILE_STRING = LV_FILE.



  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_DELETE

    EXPORTING

      FILENAME = LV_FILE_STRING

    CHANGING

      RC       = LV_RC

    EXCEPTIONS

      OTHERS   = 1.



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  MESSAGE_PDF

*&---------------------------------------------------------------------*

*      #### #### ## YES OR NO

*----------------------------------------------------------------------*

*  -->  P1        TEXT

*  <--  P2        TEXT

*----------------------------------------------------------------------*




FORM MESSAGE_PDF .

  DATA LV_ANSWER TYPE C.



  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR              = 'PDF####'

      TEXT_QUESTION         = 'PDF# ##########?'

      TEXT_BUTTON_1         = 'YES'

      TEXT_BUTTON_2         = 'NO'

      DISPLAY_CANCEL_BUTTON = ' '

    IMPORTING

      ANSWER                = LV_ANSWER.



  IF LV_ANSWER = '1'.

    " YES ### #

    PERFORM PDF_DOWNLOAD.

    MESSAGE 'PDF #### ##!.' TYPE 'S'.



  ELSEIF LV_ANSWER = '2'.

    " NO ### #

    MESSAGE '#######.' TYPE 'S'.

  ENDIF.

ENDFORM.