
*&---------------------------------------------------------------------*

*&  Include           ZWORK22_001_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SELECTION_SCREEN

*&---------------------------------------------------------------------*




FORM SELECTION_SCREEN ."## M## ##

  LOOP AT SCREEN.

    IF SCREEN-NAME = 'P_KURST'.

      SCREEN-INPUT = '0'.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CLICK_BUTTON

*&---------------------------------------------------------------------*




FORM CLICK_BUTTON ."## #### ##

  DATA : LS_DYNTXT TYPE SMP_DYNTXT.



  LS_DYNTXT-ICON_ID    = ICON_EXPORT.

  LS_DYNTXT-ICON_TEXT  = '## ### ####'.

  LS_DYNTXT-QUICKINFO  = '## ### ####'.



  SSCRFIELDS-FUNCTXT_01 = LS_DYNTXT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

  CLEAR: GS_FIELDCAT, GT_FIELDCAT.



  " ####

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'KURST'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZTCURR22'.

  GS_FIELDCAT-REF_FIELD = 'KURST'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'FCURR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZTCURR22'.

  GS_FIELDCAT-REF_FIELD = 'FCURR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'TCURR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZTCURR22'.

  GS_FIELDCAT-REF_FIELD = 'TCURR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.






*  CLEAR GS_FIELDCAT.

*  GS_FIELDCAT-COL_POS   = 4.

*  GS_FIELDCAT-FIELDNAME = 'GDATU'.

*  GS_FIELDCAT-COLTEXT   = '####'.

*  GS_FIELDCAT-REF_TABLE = 'ZTCURR22'.

*  GS_FIELDCAT-REF_FIELD = 'GDATU'.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.






  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'GDATU'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-DATATYPE  = 'CHAR'.

  GS_FIELDCAT-INTTYPE   = 'C'.

  GS_FIELDCAT-OUTPUTLEN = 10."YYYY-MM-DD ## ##

  GS_FIELDCAT-INTLEN    = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT."## ## ##

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'UKURS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZTCURR22'.

  GS_FIELDCAT-REF_FIELD = 'UKURS'.

  GS_FIELDCAT-EDIT      = 'X'."#### ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'FFACT'.

  GS_FIELDCAT-COLTEXT   = '########'.

  GS_FIELDCAT-REF_TABLE = 'ZTCURR22'.

  GS_FIELDCAT-REF_FIELD = 'FFACT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 7.

  GS_FIELDCAT-FIELDNAME = 'TFACT'.

  GS_FIELDCAT-COLTEXT   = '########'.

  GS_FIELDCAT-REF_TABLE = 'ZTCURR22'.

  GS_FIELDCAT-REF_FIELD = 'TFACT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'CRNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 9.

  GS_FIELDCAT-FIELDNAME = 'CRDATE'.

  GS_FIELDCAT-COLTEXT   = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID     = SY-REPID

      DYNNR     = SY-DYNNR

      EXTENSION = 2000.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT = GC_DOCKING.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*




FORM CALL_ALV .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT  = GS_VARIANT

      I_SAVE      = 'A'

      IS_LAYOUT   = GS_LAYOUT

    CHANGING

      IT_OUTTAB   = GT_CURR_ALV

      IT_FIELDCATALOG = GT_FIELDCAT

      IT_SORT     = GT_SORT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR : GS_LAYOUT, GS_VARIANT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*




FORM REFRESH .

  DATA : LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'."### ## ##

  LS_STABLE-COL = 'X'."# ## ##

  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*




FORM CLASS_EVENT .

  CREATE OBJECT GO_EVENT.

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  EXCEL_DOWNLOAD

*&---------------------------------------------------------------------*




FORM EXCEL_DOWNLOAD.



  DATA: LS_KEY          TYPE WWWDATATAB,

        LV_DESTINATION  TYPE RLGRAP-FILENAME,

        LV_FILENAME     TYPE STRING,

        LV_PATH         TYPE STRING,

        LV_FULLPATH     TYPE STRING,

        LV_RC           TYPE SY-SUBRC.

  "### ## ##

  SELECT SINGLE *

    FROM WWWDATA

    WHERE OBJID = @C_OBJID

    INTO CORRESPONDING FIELDS OF @LS_KEY.



  IF SY-SUBRC <> 0 OR LS_KEY IS INITIAL.

    MESSAGE 'SMW0# ### ###(ZCURRENCY_TEMPLATE)# ## # ####.' TYPE 'E'.

    EXIT.

  ENDIF.

  "## ## # ### ## ##

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG

    EXPORTING

      WINDOW_TITLE      = '## ### ##'

      DEFAULT_FILE_NAME = 'CURRENCY_TEMPLATE.XLSX'

      FILE_FILTER       = 'Excel Files (*.XLSX)|*.XLSX|'

    CHANGING

      FILENAME          = LV_FILENAME

      PATH              = LV_PATH

      FULLPATH          = LV_FULLPATH.



  IF SY-SUBRC <> 0 OR LV_FULLPATH IS INITIAL.

    MESSAGE '### #######.' TYPE 'I'.

    EXIT.

  ENDIF.



  LV_DESTINATION = LV_FULLPATH.

  "SMW0 ## #### ##

  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY         = LS_KEY

      DESTINATION = LV_DESTINATION

    IMPORTING

      RC          = LV_RC.



  IF LV_RC = 0.

    MESSAGE |## #### #######: { LV_FULLPATH }| TYPE 'S'.

  ELSE.

    MESSAGE '## #### # ### ######.' TYPE 'E'.

  ENDIF.



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

  CLEAR GS_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'GDATU'.  "##### ##

  GS_SORT-UP = 'X'.             "####

  APPEND GS_SORT TO GT_SORT.

ENDFORM.




*---------------------------------------------------------------------*

* FORM NORMALIZE_DATE

*---------------------------------------------------------------------*




FORM NORMALIZE_DATE USING    PV_INPUT  TYPE ANY

                    CHANGING PV_OUTPUT TYPE DATS.



  DATA: LV_STR TYPE STRING.



  " ### ##: ##/##/# ##

  LV_STR = PV_INPUT.

  REPLACE ALL OCCURRENCES OF CL_ABAP_CHAR_UTILITIES=>CR_LF IN LV_STR WITH ''.

  REPLACE ALL OCCURRENCES OF CL_ABAP_CHAR_UTILITIES=>NEWLINE IN LV_STR WITH ''.

  CONDENSE LV_STR NO-GAPS.



  " #### ##

  REPLACE ALL OCCURRENCES OF '-' IN LV_STR WITH ''.

  REPLACE ALL OCCURRENCES OF '.' IN LV_STR WITH ''.

  REPLACE ALL OCCURRENCES OF '/' IN LV_STR WITH ''.



  " ## ## 8### ###

  IF STRLEN( LV_STR ) = 8 AND LV_STR CO '0123456789'.

    PV_OUTPUT = LV_STR.

  ELSE.

    CLEAR PV_OUTPUT.

  ENDIF.



ENDFORM.




*---------------------------------------------------------------------*

* FORM READ_DATA

*---------------------------------------------------------------------*




FORM READ_DATA USING P_FILE TYPE RLGRAP-FILENAME.



  DATA: LO_EXCEL     TYPE OLE2_OBJECT,

        LO_WORKBOOKS TYPE OLE2_OBJECT,

        LO_WORKBOOK  TYPE OLE2_OBJECT,

        LO_SHEET     TYPE OLE2_OBJECT,

        LO_CELL      TYPE OLE2_OBJECT,

        LV_VALUE     TYPE STRING,

        LV_ROW       TYPE I VALUE 2.



  CREATE OBJECT LO_EXCEL 'EXCEL.APPLICATION'."## #### ##(## ##)

  SET PROPERTY OF LO_EXCEL 'VISIBLE' = 0.

  GET PROPERTY OF LO_EXCEL 'WORKBOOKS' = LO_WORKBOOKS."## ## ##

  CALL METHOD OF LO_WORKBOOKS 'OPEN' EXPORTING #1 = P_FILE.

  GET PROPERTY OF LO_EXCEL 'ACTIVESHEET' = LO_SHEET.



  CLEAR GT_CURR.

  "### # ## ##

  DO.

    CLEAR: GS_CURR, LV_VALUE.



    CALL METHOD OF LO_SHEET 'CELLS' = LO_CELL EXPORTING #1 = LV_ROW #2 = 1.

    GET PROPERTY OF LO_CELL 'VALUE' = GS_CURR-KURST.

    FREE OBJECT LO_CELL.



    IF GS_CURR-KURST IS INITIAL.

      EXIT."##->### ##

    ENDIF.



    CALL METHOD OF LO_SHEET 'CELLS' = LO_CELL EXPORTING #1 = LV_ROW #2 = 2.

    GET PROPERTY OF LO_CELL 'VALUE' = GS_CURR-FCURR.

    FREE OBJECT LO_CELL.



    CALL METHOD OF LO_SHEET 'CELLS' = LO_CELL EXPORTING #1 = LV_ROW #2 = 3.

    GET PROPERTY OF LO_CELL 'VALUE' = GS_CURR-TCURR.

    FREE OBJECT LO_CELL.



    CALL METHOD OF LO_SHEET 'CELLS' = LO_CELL EXPORTING #1 = LV_ROW #2 = 4.

    GET PROPERTY OF LO_CELL 'VALUE' = LV_VALUE.

    FREE OBJECT LO_CELL.

    REPLACE ALL OCCURRENCES OF '-' IN LV_VALUE WITH ''.

    CONDENSE LV_VALUE NO-GAPS.

    GS_CURR-GDATU = LV_VALUE.



    CALL METHOD OF LO_SHEET 'CELLS' = LO_CELL EXPORTING #1 = LV_ROW #2 = 5.

    GET PROPERTY OF LO_CELL 'VALUE' = GS_CURR-UKURS.

    FREE OBJECT LO_CELL.



    CALL METHOD OF LO_SHEET 'CELLS' = LO_CELL EXPORTING #1 = LV_ROW #2 = 6.

    GET PROPERTY OF LO_CELL 'VALUE' = GS_CURR-FFACT.

    FREE OBJECT LO_CELL.



    CALL METHOD OF LO_SHEET 'CELLS' = LO_CELL EXPORTING #1 = LV_ROW #2 = 7.

    GET PROPERTY OF LO_CELL 'VALUE' = GS_CURR-TFACT.

    FREE OBJECT LO_CELL.

    "###/### ## ##

    GS_CURR-CRNAME = SY-UNAME.

    GS_CURR-CRDATE = SY-DATUM.



    APPEND GS_CURR TO GT_CURR.

    ADD 1 TO LV_ROW.

  ENDDO.

  "## ## # ### ##

  CALL METHOD OF LO_EXCEL 'QUIT'.

  FREE OBJECT LO_SHEET.

  FREE OBJECT LO_WORKBOOK.

  FREE OBJECT LO_WORKBOOKS.

  FREE OBJECT LO_EXCEL.



  MESSAGE |# { LINES( GT_CURR ) }## #### ########.| TYPE 'S'.



ENDFORM.




*---------------------------------------------------------------------*

* FORM MODIFY_DATA

*---------------------------------------------------------------------*




FORM MODIFY_DATA.



  CLEAR GS_CURR.

  CLEAR GS_CURR_ALV.

  REFRESH GT_CURR_ALV.



  DATA: LV_GDATU_CHAR(8) TYPE C.

  "selection-screen ## ##->8## ### ##

  WRITE P_DATE TO LV_GDATU_CHAR.



  LOOP AT GT_CURR INTO GS_CURR.

    "## ## ## M

    GS_CURR-KURST = 'M'.

    GS_CURR-GDATU = LV_GDATU_CHAR."## ## ##

    "### ## ##

    GS_CURR-CRNAME = SY-UNAME.

    GS_CURR-CRDATE = SY-DATUM.

    "## ## ### 100->1## ##

    IF GS_CURR-FCURR = 'JPY' OR GS_CURR-FCURR = 'VND'.

      GS_CURR-FFACT = 100.

      GS_CURR-TFACT = 1.

    ELSE.

      GS_CURR-FFACT = 1.

      GS_CURR-TFACT = 1.

    ENDIF.



    MODIFY GT_CURR FROM GS_CURR TRANSPORTING KURST GDATU FFACT TFACT CRNAME CRDATE.

    "ALV ### ### ##

    CLEAR GS_CURR_ALV.

    GS_CURR_ALV-KURST = GS_CURR-KURST.

    GS_CURR_ALV-FCURR = GS_CURR-FCURR.

    GS_CURR_ALV-TCURR = GS_CURR-TCURR.

    GS_CURR_ALV-GDATU = GS_CURR-GDATU.

    GS_CURR_ALV-UKURS = GS_CURR-UKURS.

    GS_CURR_ALV-FFACT = GS_CURR-FFACT.

    GS_CURR_ALV-TFACT = GS_CURR-TFACT.

    GS_CURR_ALV-CRNAME = GS_CURR-CRNAME.

    GS_CURR_ALV-CRDATE = GS_CURR-CRDATE.



    APPEND GS_CURR_ALV TO GT_CURR_ALV.



  ENDLOOP.



  MESSAGE |{ LINES( GT_CURR_ALV ) }## ## #### #######.| TYPE 'S'.



ENDFORM.




*---------------------------------------------------------------------*

* FORM SAVE_CURRENCY_DATA

*---------------------------------------------------------------------*




FORM SAVE_CURRENCY_DATA.



  DATA: LV_ANSWER           TYPE C,

        LS_SAVE             TYPE ZTCURR22,

        LT_SAVE             TYPE TABLE OF ZTCURR22,

        LV_DATE_EXTERNAL(10) TYPE C,

        LV_DATE_INTERNAL(8)  TYPE C.

  "### ## ## ##

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR              = '####'

      TEXT_QUESTION         = '##### ########?'

      TEXT_BUTTON_1         = 'YES'

      TEXT_BUTTON_2         = 'NO'

      DEFAULT_BUTTON        = '1'

      DISPLAY_CANCEL_BUTTON = ''

    IMPORTING

      ANSWER                = LV_ANSWER.



  IF LV_ANSWER <> '1'.

    MESSAGE '#######.' TYPE 'I'.

    EXIT.

  ENDIF.

  "SELECTION-SCREEN ##->INTERNAL DATE ##

  WRITE P_DATE TO LV_DATE_EXTERNAL.



  CALL FUNCTION 'CONVERSION_EXIT_INVDT_INPUT'

    EXPORTING

      INPUT  = LV_DATE_EXTERNAL

    IMPORTING

      OUTPUT = LV_DATE_INTERNAL

    EXCEPTIONS

      OTHERS = 1.



  IF SY-SUBRC <> 0.

    MESSAGE 'INVDT ## ##' TYPE 'E'.

    EXIT.

  ENDIF.

  "ALV ### ## ##

  LOOP AT GT_CURR_ALV INTO GS_CURR_ALV.



    CLEAR LS_SAVE.



    LS_SAVE-KURST  = GS_CURR_ALV-KURST.

    LS_SAVE-FCURR  = GS_CURR_ALV-FCURR.

    LS_SAVE-TCURR  = GS_CURR_ALV-TCURR.

    LS_SAVE-UKURS  = GS_CURR_ALV-UKURS.

    LS_SAVE-FFACT  = GS_CURR_ALV-FFACT.

    LS_SAVE-TFACT  = GS_CURR_ALV-TFACT.

    LS_SAVE-CRNAME = GS_CURR_ALV-CRNAME.

    LS_SAVE-CRDATE = GS_CURR_ALV-CRDATE.



    LS_SAVE-GDATU = LV_DATE_INTERNAL.



    APPEND LS_SAVE TO LT_SAVE.



  ENDLOOP.

  "## M## ## ## ## # ## ##

  "DELETE FROM ZTCURR22 WHERE KURST = 'M'.

  MODIFY ZTCURR22 FROM TABLE LT_SAVE.



  IF SY-SUBRC = 0.

    COMMIT WORK AND WAIT.

    MESSAGE '### ##### #######.' TYPE 'S'.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '## # ### ######.' TYPE 'E'.

  ENDIF.



ENDFORM.




*---------------------------------------------------------------------*

* FORM ALV_HANDLER_DATA_CHANGED

*---------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED

  USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

        P_ONF4

        P_ONF4_BEFORE

        P_ONF4_AFTER

        P_UCOMM.



  DATA: LS_MODI  TYPE LVC_S_MODI,

        LV_VALUE TYPE UKURS_CURR.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.



    LV_VALUE = LS_MODI-VALUE.

    "ALV ## ## ##

    P_DATA_CHANGED->MODIFY_CELL(

      EXPORTING

        I_ROW_ID    = LS_MODI-ROW_ID

        I_FIELDNAME = LS_MODI-FIELDNAME

        I_VALUE     = LV_VALUE ).



    READ TABLE GT_CURR_ALV INTO GS_CURR_ALV INDEX LS_MODI-ROW_ID.



    IF SY-SUBRC = 0.

      ASSIGN COMPONENT LS_MODI-FIELDNAME OF STRUCTURE GS_CURR_ALV TO FIELD-SYMBOL(<FS>).

      IF SY-SUBRC = 0.

        <FS> = LV_VALUE.

        MODIFY GT_CURR_ALV FROM GS_CURR_ALV INDEX LS_MODI-ROW_ID.

      ENDIF.

    ENDIF.



  ENDLOOP.



  PERFORM REFRESH.



ENDFORM.




*---------------------------------------------------------------------*

* FORM CHANGE_DATA

*---------------------------------------------------------------------*




FORM CHANGE_DATA USING PV_INPUT TYPE ANY

                 CHANGING PV_OUTPUT TYPE STRING.



  DATA LV_TEMP TYPE STRING.



  LV_TEMP = PV_INPUT.



  CONDENSE LV_TEMP NO-GAPS.

  REPLACE ALL OCCURRENCES OF ',' IN LV_TEMP WITH ''.



  IF LV_TEMP IS INITIAL.

    CLEAR PV_OUTPUT.

    RETURN.

  ENDIF.

  "## ### ## ## # #### ##

  IF LV_TEMP CP '[0-9]*' OR LV_TEMP CP '[0-9]*.[0-9]*'.

    PV_OUTPUT = LV_TEMP.

  ELSE.

    CLEAR PV_OUTPUT.

  ENDIF.



ENDFORM.