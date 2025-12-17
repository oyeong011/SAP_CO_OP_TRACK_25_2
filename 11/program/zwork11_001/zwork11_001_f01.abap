
"====================================================================="

include structure
ZWORK11_001_F01
.

"====================================================================="






*---------------------------------------------------------------------*

* ## ##: ####(P_KURST) ####

*---------------------------------------------------------------------*




FORM SET_SCREEN.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      SCREEN-INPUT = '0'.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.






*---------------------------------------------------------------------*

* ## ##: ALSM_EXCEL_TO_INTERNAL_TABLE ##

* - ### 1### ##, #### 2### 10#/7### ##

*---------------------------------------------------------------------*




FORM GET_DATA.

  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'

    EXPORTING

      FILENAME    = P_FILE

      I_BEGIN_COL = 1

      I_BEGIN_ROW = 2

      I_END_COL   = 7

      I_END_ROW   = 10

    TABLES

      INTERN      = T_RAW_EXCEL

    EXCEPTIONS

      INCONSISTENT_PARAMETERS = 1

      UPLOAD_OLE              = 2

      OTHERS                  = 3.



  CLEAR GT_TCURR.

  LOOP AT T_RAW_EXCEL INTO S_RAW_EXCEL.

    CASE S_RAW_EXCEL-COL.

      WHEN 1. GS_TCURR-KURST = S_RAW_EXCEL-VALUE.

      WHEN 2. GS_TCURR-FCURR = S_RAW_EXCEL-VALUE.

      WHEN 3. GS_TCURR-TCURR = S_RAW_EXCEL-VALUE.

      WHEN 4. GS_TCURR-GDATU = S_RAW_EXCEL-VALUE.

      WHEN 5. GS_TCURR-UKURS = S_RAW_EXCEL-VALUE.

      WHEN 6. GS_TCURR-FFACT = S_RAW_EXCEL-VALUE.

      WHEN 7. GS_TCURR-TFACT = S_RAW_EXCEL-VALUE.

    ENDCASE.



    AT END OF ROW.

      APPEND GS_TCURR TO GT_TCURR.

      CLEAR GS_TCURR.

    ENDAT.

  ENDLOOP.

ENDFORM.






*---------------------------------------------------------------------*

* ### ##: ## ## ##

* - GDATU = P_DATE,  KURST = 'M',  CR* = ## ###/##

*---------------------------------------------------------------------*




FORM MODI_DATA.

  LOOP AT GT_TCURR INTO GS_TCURR.

    GS_TCURR-GDATU  = P_DATE.

    GS_TCURR-KURST  = 'M'.

    GS_TCURR-CRNAME = SY-UNAME.

    GS_TCURR-CRDATE = SY-DATUM.

    MODIFY GT_TCURR FROM GS_TCURR.

  ENDLOOP.

ENDFORM.






*---------------------------------------------------------------------*

* DOCKING/GRID ##

*---------------------------------------------------------------------*




FORM CREATE_OBJECT.

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID     = SY-REPID

      DYNNR     = SY-DYNNR

      EXTENSION = 2000.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT = GC_DOCKING.

ENDFORM.






*---------------------------------------------------------------------*

* FIELDCAT ## (UKURS ####, ## 5##)

*---------------------------------------------------------------------*




FORM FIELDCAT.

  CLEAR: GS_FIELDCAT, GT_FIELDCAT.



  GS_FIELDCAT-COL_POS    = 1.

  GS_FIELDCAT-FIELDNAME  = 'KURST'.

  GS_FIELDCAT-COLTEXT    = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 2.

  GS_FIELDCAT-FIELDNAME  = 'FCURR'.

  GS_FIELDCAT-COLTEXT    = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 3.

  GS_FIELDCAT-FIELDNAME  = 'TCURR'.

  GS_FIELDCAT-COLTEXT    = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 4.

  GS_FIELDCAT-FIELDNAME  = 'GDATU'.

  GS_FIELDCAT-COLTEXT    = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 5.

  GS_FIELDCAT-FIELDNAME  = 'UKURS'.

  GS_FIELDCAT-COLTEXT    = '##'.

  GS_FIELDCAT-DECIMALS   = 5.

  GS_FIELDCAT-EDIT       = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 6.

  GS_FIELDCAT-FIELDNAME  = 'FFACT'.

  GS_FIELDCAT-COLTEXT    = '########'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 7.

  GS_FIELDCAT-FIELDNAME  = 'TFACT'.

  GS_FIELDCAT-COLTEXT    = '########'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 8.

  GS_FIELDCAT-FIELDNAME  = 'CRNAME'.

  GS_FIELDCAT-COLTEXT    = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 9.

  GS_FIELDCAT-FIELDNAME  = 'CRDATE'.

  GS_FIELDCAT-COLTEXT    = '###'.

  GS_FIELDCAT-OUTPUTLEN  = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.






*---------------------------------------------------------------------*

* VARIANT(##/####) ## ##

*---------------------------------------------------------------------*




FORM ALV_LAYOUT.

  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT   = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.



FORM ALV_SORT.

  "## ## ## # ### APPEND (# ### ## ##)

ENDFORM.






*---------------------------------------------------------------------*

* # ## or ###

*---------------------------------------------------------------------*




FORM ALV_DISPLAY.

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT  = GS_VARIANT

      I_SAVE      = 'A'

      IS_LAYOUT   = GS_LAYOUT

    CHANGING

      IT_OUTTAB     = GT_TCURR

      IT_FIELDCATALOG = GT_FIELDCAT

      IT_SORT         = GT_SORT.

ENDFORM.






*---------------------------------------------------------------------*

* ### #### (SMW0 -> WWWDATA ####)

*---------------------------------------------------------------------*




FORM TEMPLETE_DOWN.

  DATA LV_RC TYPE SY-SUBRC.



  SELECT SINGLE * INTO CORRESPONDING FIELDS OF GS_KEY

    FROM WWWDATA

    WHERE OBJID = 'ZWORK11_001_TEMPLETE'.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ## # ####.' TYPE 'E'.

    EXIT.

  ENDIF.



  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG

    EXPORTING

      WINDOW_TITLE      = '### ##'

      DEFAULT_EXTENSION = 'XLSX'

      DEFAULT_FILE_NAME = '## ### INPUT'

    CHANGING

      FILENAME = GV_FILE

      PATH     = GV_PATH

      FULLPATH = GV_FULLPATH.



  GV_DEST = GV_FULLPATH.



  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY         = GS_KEY

      DESTINATION = GV_DEST

    IMPORTING

      RC          = LV_RC.



  IF SY-SUBRC = 0.

    MESSAGE '### #### ##' TYPE 'S'.

  ENDIF.

ENDFORM.






*---------------------------------------------------------------------*

* ##: ALV ## ### # ZTCURR11 MODIFY

*---------------------------------------------------------------------*




FORM SAVE_DATA.

  DATA: GS_SAVE LIKE ZTCURR11,

        GT_SAVE LIKE TABLE OF GS_SAVE.



  LOOP AT GT_TCURR INTO GS_TCURR.

    MOVE-CORRESPONDING GS_TCURR TO GS_SAVE.

    APPEND GS_SAVE TO GT_SAVE.

  ENDLOOP.



  MODIFY ZTCURR11 FROM TABLE GT_SAVE.

ENDFORM.






*---------------------------------------------------------------------*

* ALV REFRESH (##/### ##)

*---------------------------------------------------------------------*




FORM REFRESH.

  DATA LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.

ENDFORM.






*---------------------------------------------------------------------*

* ALV ## ### ##: UKURS ## ##

*---------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED

  USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

        P_ONF4

        P_ONF4_BEFORE

        P_ONF4_AFTER

        P_UCOMM.



  DATA LS_MODI TYPE LVC_S_MODI.

  CLEAR LS_MODI.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'UKURS'.

      READ TABLE GT_TCURR INTO GS_TCURR INDEX LS_MODI-ROW_ID.

      "## # # ## ## ## ## (#: ## ## #)

      MODIFY GT_TCURR FROM GS_TCURR INDEX LS_MODI-ROW_ID.

      CLEAR GS_TCURR.

    ENDIF.

  ENDLOOP.



  PERFORM REFRESH.

ENDFORM.






*---------------------------------------------------------------------*

* ### ##: ### ##(ALV ENTER) ### ##

*---------------------------------------------------------------------*




FORM CLASS_EVENT.

  CREATE OBJECT GO_EVENT.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.



  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.

ENDFORM.