
*&---------------------------------------------------------------------*

*&  Include           ZWORK23_001_F01

*&---------------------------------------------------------------------*






FORM SCREEN_INIT.

    DATA : LS_FUNCTEXT TYPE SMP_DYNTXT. "SMP_DYNTXT = #####~

    LS_FUNCTEXT-ICON_ID = ICON_EXPORT.

    LS_FUNCTEXT-ICON_TEXT = '##### ####'.

    SSCRFIELDS-FUNCTXT_01 = LS_FUNCTEXT.

    " ICON(##) ### SELECTION-SCREEN ## #

    " 'FC01' #### ##

ENDFORM.



"##### 'M'## ##. ########.

FORM ASSO.

  LOOP AT SCREEN.

    IF SCREEN-NAME = 'P_KURST'.

      SCREEN-INPUT = 0.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.





FORM FILE_DOWNLOAD.



  "*** ### ##/## ## ***"

  DATA : LV_FILENAME TYPE STRING,

    LV_PATH TYPE STRING,

    LV_FULLPATH TYPE STRING.



    CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG

       EXPORTING




*        WINDOW_TITLE              =




         DEFAULT_EXTENSION         = CL_GUI_FRONTEND_SERVICES=>FILETYPE_EXCEL " ## '.xlsx' # ### #

         DEFAULT_FILE_NAME         = '#######'  "## # ## #




*        WITH_ENCODING             =




         FILE_FILTER               = CL_GUI_FRONTEND_SERVICES=>FILETYPE_EXCEL

         INITIAL_DIRECTORY         = 'C:' "## ##




*        PROMPT_ON_OVERWRITE       = 'X'




      CHANGING

        FILENAME                  = LV_FILENAME

        PATH                      = LV_PATH

        FULLPATH                  = LV_FULLPATH




*        USER_ACTION               =

*        FILE_ENCODING             =




       EXCEPTIONS

         CNTL_ERROR                = 1

         ERROR_NO_GUI              = 2

         NOT_SUPPORTED_BY_GUI      = 3

         INVALID_DEFAULT_FILE_NAME = 4

         others                    = 5.





    IF LV_FULLPATH IS INITIAL.

      RETURN.

    ENDIF.



    "**** ## ## ***"

    DATA : LS_WWWDATA TYPE WWWDATATAB,

          LV_FILENAME2 TYPE RLGRAP-FILENAME.



    SELECT SINGLE * FROM WWWDATA

      INTO CORRESPONDING FIELDS OF LS_WWWDATA

      WHERE OBJID = 'ZCURR_TEMPLATE'.



    IF SY-SUBRC NE 0.

      MESSAGE '### ## ##' TYPE 'E'.

    ENDIF.



    LV_FILENAME2 = LV_FULLPATH.



    CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

      EXPORTING

        KEY               = LS_WWWDATA

        DESTINATION       = LV_FILENAME2.



    IF SY-SUBRC NE 0.

      MESSAGE 'ERROR!! ERROR!!' TYPE 'E'.

    ENDIF.



ENDFORM.



FORM FILE_UPLOAD.

  " EXCEL FILE ###

  CALL FUNCTION 'F4_FILENAME'

   IMPORTING

     FILE_NAME           = P_FILE.

ENDFORM.



FORM EXCEL_TO_ITABLE.

  DATA : LT_EXCEL TYPE TABLE OF ALSMEX_TABLINE,

         LS_EXCEL LIKE LINE OF LT_EXCEL.

  FIELD-SYMBOLS <FS> TYPE ANY.



  IF P_DATE IS INITIAL.

    MESSAGE '### ######.' TYPE 'E'.

  ENDIF.



  IF P_FILE IS INITIAL.

    MESSAGE '### ######.' TYPE 'E'.

  ENDIF.



  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'

    EXPORTING

      FILENAME                      = P_FILE

      I_BEGIN_COL                   = 1   "### ### ###

      I_BEGIN_ROW                   = 2   "### ### ###

      I_END_COL                     = 7   "### ### ###

      I_END_ROW                     = 65000   "### ### ###(MAX 65000)

    TABLES

      INTERN                        = LT_EXCEL.



    IF SY-SUBRC EQ 0.   " ### # ####

      LOOP AT LT_EXCEL INTO LS_EXCEL.

        " COL : 1, 2, 3, 4...



        ASSIGN COMPONENT LS_EXCEL-COL OF STRUCTURE GS_TCURR TO <FS>.

        <FS> = LS_EXCEL-VALUE.



        AT END OF ROW.

          " ## ## = M, #### = P_DATE# ##

          " ###, ### ##

          GS_TCURR-ZKURST = 'M'.

          GS_TCURR-ZGDATU = P_DATE.

          GS_TCURR-ZCRNAME = SY-UNAME.

          GS_TCURR-ZCRDATE = SY-DATUM.



          " JPY, VND # #### ##

          IF GS_TCURR-ZFCURR EQ 'JPY' OR GS_TCURR-ZFCURR EQ 'VND'.

            GS_TCURR-ZFFACT = 100.

          ENDIF.

          APPEND GS_TCURR TO GT_TCURR.

          CLEAR LS_EXCEL.

        ENDAT.



      ENDLOOP.

    ENDIF.

ENDFORM.





FORM ALV_HANDLER_DATA_CHANGED

  USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

        P_ONF4

        P_ONF4_BEFORE

        P_ONF4_AFTER

        P_UCOMM.



  DATA : LS_MODI TYPE LVC_S_MODI.

  DATA : LS_TEMP TYPE P DECIMALS 5 LENGTH 9.



  LOOP AT P_DATA_CHANGED->MT_MOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'ZUKURS'.

      CLEAR GS_TCURR.

      READ TABLE GT_TCURR INTO GS_TCURR INDEX LS_MODI-ROW_ID.

      IF SY-SUBRC EQ 0.



        "MOVE LS_MODI-VALUE TO LS_TEMP. -> ##. ## ## ##



        REPLACE ALL OCCURRENCES OF ',' IN LS_MODI-VALUE WITH ''.  "####

        LS_TEMP = LS_MODI-VALUE.    "# ## : CHAR(128) -> P DEC(5) LENGTH 9

        GS_TCURR-ZUKURS = LS_TEMP.



        MODIFY GT_TCURR FROM GS_TCURR INDEX LS_MODI-ROW_ID.

      ENDIF.



"      REFRESH ## MODIFY_CELL ## ##.

"      IF LS_MODI-VALUE IS NOT INITIAL.

"        CALL METHOD P_DATA_CHANGED->MODIFY_CELL

"          EXPORTING

"             I_ROW_ID    = LS_MODI-ROW_ID

"*            I_TABIX     =

"             I_FIELDNAME = 'ZUKURS'

"            I_VALUE     = LS_MODI-VALUE

"            .

"      ENDIF.

    ENDIF.

  ENDLOOP.

  PERFORM REFRESH.

ENDFORM.



"ALV## ENTER ## #

FORM CLASS_EVENT.



  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_ENTER.



  CREATE OBJECT GO_EVENT.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.



ENDFORM.



"ALV # #### GT_TCURR# ##

FORM SAVE_CURR.



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





FORM UPDATE_DB.



  DATA : LS_ZTCURR23 TYPE ZTCURR23.

  CLEAR GS_TCURR.

  LOOP AT GT_TCURR INTO GS_TCURR.

    LS_ZTCURR23-KURST = GS_TCURR-ZKURST.

    LS_ZTCURR23-FCURR = GS_TCURR-ZFCURR.

    LS_ZTCURR23-TCURR = GS_TCURR-ZTCURR.

    LS_ZTCURR23-GDATU = GS_TCURR-ZGDATU.

    LS_ZTCURR23-UKURS = GS_TCURR-ZUKURS.

    LS_ZTCURR23-FFACT = GS_TCURR-ZFFACT.

    LS_ZTCURR23-TFACT = GS_TCURR-ZTFACT.

    LS_ZTCURR23-CRNAME = SY-UNAME.

    LS_ZTCURR23-CRDATE = SY-DATUM.



    MODIFY ZTCURR23 FROM LS_ZTCURR23.

    "MODIFY ZTCURR23 FROM GS_TCURR.



  ENDLOOP.



ENDFORM.





FORM REFRESH.

  DATA : LS_STABLE TYPE LVC_S_STBL.

  "LS_STABLE-ROW = 'X'.

  "LS_STABLE-COL = 'X'.

  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

     EXPORTING

       IS_STABLE      = LS_STABLE




*      I_SOFT_REFRESH =

*    EXCEPTIONS

*      FINISHED       = 1

*      others         = 2




          .



ENDFORM.





FORM CREATE_OBJECT.

  CREATE OBJECT GC_DOCKING

     EXPORTING

       REPID                       = SY-REPID

       DYNNR                       = SY-DYNNR

       EXTENSION                   = 2000.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_DOCKING.



ENDFORM.



FORM FIELD_CATALOG.

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-FIELDNAME = 'ZKURST'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-FIELDNAME = 'ZFCURR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-FIELDNAME = 'ZTCURR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-FIELDNAME = 'ZGDATU'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-FIELDNAME = 'ZUKURS'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  GS_FIELDCAT-DECIMALS = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-COLTEXT = '########'.

  GS_FIELDCAT-FIELDNAME = 'ZFFACT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-COLTEXT = '########'.

  GS_FIELDCAT-FIELDNAME = 'ZTFACT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-FIELDNAME = 'ZCRNAME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-FIELDNAME = 'ZCRDATE'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.



FORM ALV_SORT.

ENDFORM.



FORM ALV_LAYOUT.

ENDFORM.



FORM CALL_ALV.

   CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING




*        IS_VARIANT                    =

*        I_SAVE                        =

*       I_DEFAULT                     = 'X'




        IS_LAYOUT                     = GS_LAYOUT

     CHANGING

       IT_OUTTAB                     = GT_TCURR

        IT_FIELDCATALOG               = GT_FIELDCAT

        IT_SORT                       = GT_SORT

.



ENDFORM.