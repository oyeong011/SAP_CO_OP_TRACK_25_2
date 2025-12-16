
*&---------------------------------------------------------------------*

*&  Include           ZMM05_002_F01

*&---------------------------------------------------------------------*






FORM MODIFY_SCREEN.

  LOOP AT SCREEN.

    IF R_CRE = 'X'.

      IF SCREEN-GROUP1 = 'M2'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF R_VIEW = 'X'.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.



FORM CHECK_P.

  IF R_CRE = 'X'.

    IF P_LIFNR1 IS INITIAL OR P_BUKRS IS INITIAL OR P_BEDAT IS INITIAL.

      MESSAGE I000.

      STOP.

    ENDIF.

  ELSEIF R_VIEW = 'X'.

    IF P_LIFNR2 IS INITIAL OR P_BUKRS2 IS INITIAL OR P_EBLEN IS INITIAL.

      MESSAGE I000.

      STOP.

    ENDIF.

  ENDIF.

ENDFORM.



FORM CHECK_VENDOR_VALID.

  " 1. ### ### ## ## (ZLFA1_05)

  SELECT SINGLE LIFNR

    INTO GS_HEADER-LIFNR

    FROM ZLFA1_05

    WHERE LIFNR = P_LIFNR1.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ## ######.' TYPE 'S' DISPLAY LIKE 'E'.

    STOP.

  ENDIF.





  SELECT SINGLE EKORG EKGRP WAERS MWSKZ

    INTO (GS_HEADER-EKORG, GS_HEADER-EKGRP, GS_HEADER-WAERS, GS_HEADER-MWSKZ)

    FROM ZLFM1_05

    WHERE LIFNR = P_LIFNR1.





  IF GS_HEADER-WAERS IS INITIAL. GS_HEADER-WAERS = 'KRW'. ENDIF.

  IF GS_HEADER-MWSKZ IS INITIAL. GS_HEADER-MWSKZ = 'V0'.  ENDIF.





  GS_HEADER-BUKRS = P_BUKRS.

  GS_HEADER-BEDAT = P_BEDAT.



  " ### ## ##

  IF P_LIFNR2 IS INITIAL.

    GS_HEADER-LIFNR = P_LIFNR1.

  ELSEIF P_LIFNR1 IS INITIAL.

    GS_HEADER-LIFNR = P_LIFNR2.

  ENDIF.



ENDFORM.



FORM PREPARE_CREATE_MODE.

  REFRESH GT_ITEM.

  CLEAR GS_ITEM.

ENDFORM.





FORM SET_ALV_LATOUT.

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-STYLEFNAME = 'CELLTAB'.

ENDFORM.



FORM SET_ALV_FIELDCAT .

  DATA: LV_EDIT TYPE C LENGTH 1.



  CLEAR GT_FCAT.



  " ## ### ## ##

  IF R_VIEW = 'X'.

    LV_EDIT = ''.

  ELSE.

    LV_EDIT = 'X'.

  ENDIF.



  PERFORM APPEND_FCAT USING :

    'EBELP' '##'      ''       '',

    'MATNR' '####'   LV_EDIT  '',

    'MAKTX' '####'   ''       '',

    'MENGE' 'PO##'     LV_EDIT  'MEINS',

    'STPRS' '##(##)' LV_EDIT  '',

    'MEINS' '##'      ''       '',

    'WAERS' '##'      ''       '',

    'MWSKZ' '####'   LV_EDIT  '',

    'PRDAT' '###'     LV_EDIT  '',

    'WERKS' '###'     LV_EDIT  '',

    'LGORT' '####'   LV_EDIT  ''.

ENDFORM.



FORM APPEND_FCAT USING P_FIELD P_TEXT P_EDIT P_QFIELD.

  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = P_FIELD.

  GS_FCAT-COLTEXT   = P_TEXT.

  GS_FCAT-EDIT      = P_EDIT.

  GS_FCAT-QFIELDNAME = P_QFIELD. " ##/## ## ## ##





  IF P_FIELD = 'MENGE'.

    GS_FCAT-REF_TABLE = 'ZEKPO_05'. " ### ## ####

    GS_FCAT-REF_FIELD = 'MENGE'.

  ENDIF.



  IF P_FIELD = 'EBELP'.

    GS_FCAT-REF_TABLE = 'ZEKPO_05'. " ## ####

    GS_FCAT-REF_FIELD = 'EBELP'.    " ###

    GS_FCAT-OUTPUTLEN = 6.          " ## 6## ### ##

  ENDIF.



  IF P_FIELD = 'STPRS'.

    GS_FCAT-REF_TABLE = 'ZEKPO_05'.

    GS_FCAT-REF_FIELD = 'STPRS'.

    GS_FCAT-DATATYPE = 'CURR'.

  ENDIF.



  IF P_FIELD = 'PRDAT'.

    GS_FCAT-DATATYPE = 'DATS'.

  ENDIF.





  APPEND GS_FCAT TO GT_FCAT.

ENDFORM.




* ZMM05_002_F01






FORM BTN_ADD_ROW .

  DATA : LV_MAX_INT TYPE I.             " ## ##

  DATA : LS_CELLTAB TYPE LVC_S_STYL.



  LOOP AT GT_ITEM INTO GS_ITEM.

    IF GS_ITEM-EBELP > LV_MAX_INT.

      LV_MAX_INT = GS_ITEM-EBELP.

    ENDIF.

  ENDLOOP.



  IF LV_MAX_INT IS INITIAL.

    LV_MAX_INT = 10.

  ELSE.

    LV_MAX_INT = LV_MAX_INT + 10.

  ENDIF.



  " 2. ## ## ##

  CLEAR GS_ITEM.



  GS_ITEM-EBELP = LV_MAX_INT.

  GS_ITEM-WAERS = GS_HEADER-WAERS.

  GS_ITEM-MWSKZ = GS_HEADER-MWSKZ.



  " 3. ## ## ## ####

  LS_CELLTAB-FIELDNAME = 'MATNR'.

  LS_CELLTAB-STYLE     = CL_GUI_ALV_GRID=>MC_STYLE_ENABLED.

  INSERT LS_CELLTAB INTO TABLE GS_ITEM-CELLTAB.



  LS_CELLTAB-FIELDNAME = 'MENGE'.

  LS_CELLTAB-STYLE     = CL_GUI_ALV_GRID=>MC_STYLE_ENABLED.

  INSERT LS_CELLTAB INTO TABLE GS_ITEM-CELLTAB.



  LS_CELLTAB-FIELDNAME = 'WERKS'.

  LS_CELLTAB-STYLE     = CL_GUI_ALV_GRID=>MC_STYLE_ENABLED.

  INSERT LS_CELLTAB INTO TABLE GS_ITEM-CELLTAB.



  LS_CELLTAB-FIELDNAME = 'LGORT'.

  LS_CELLTAB-STYLE     = CL_GUI_ALV_GRID=>MC_STYLE_ENABLED.

  INSERT LS_CELLTAB INTO TABLE GS_ITEM-CELLTAB.



  LS_CELLTAB-FIELDNAME = 'STPRS'.

  LS_CELLTAB-STYLE     = CL_GUI_ALV_GRID=>MC_STYLE_ENABLED.

  INSERT LS_CELLTAB INTO TABLE GS_ITEM-CELLTAB.



  LS_CELLTAB-FIELDNAME = 'MWSKZ'.

  LS_CELLTAB-STYLE     = CL_GUI_ALV_GRID=>MC_STYLE_ENABLED.

  INSERT LS_CELLTAB INTO TABLE GS_ITEM-CELLTAB.



  LS_CELLTAB-FIELDNAME = 'PRDAT'.

  LS_CELLTAB-STYLE     = CL_GUI_ALV_GRID=>MC_STYLE_ENABLED.

  INSERT LS_CELLTAB INTO TABLE GS_ITEM-CELLTAB.





  " 4. ### ##

  APPEND GS_ITEM TO GT_ITEM.





  IF GO_GRID IS BOUND.

    DATA : LS_STABLE TYPE LVC_S_STBL.



    LS_STABLE-ROW = 'X'.

    LS_STABLE-COL = 'X'.



    CALL METHOD GO_GRID->REFRESH_TABLE_DISPLAY

      EXPORTING

        IS_STABLE = LS_STABLE.

  ENDIF.

ENDFORM.



FORM GET_PO_DATA.

  DATA: LT_EKPO_TEMP TYPE TABLE OF ZEKPO_05.

  DATA: LS_EKPO_TEMP LIKE LINE OF LT_EKPO_TEMP.

  DATA: LV_MWSKZ_MASTER TYPE MWSKZ.



  SELECT SINGLE * FROM ZEKKO_05

    INTO CORRESPONDING FIELDS OF GS_HEADER

    WHERE EBELN = P_EBLEN

      AND BUKRS = P_BUKRS2

      AND LIFNR = P_LIFNR2.



  IF SY-SUBRC <> 0.

    MESSAGE '## PO #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    STOP.

  ENDIF.



  CLEAR LV_MWSKZ_MASTER.

  SELECT SINGLE MWSKZ

    INTO LV_MWSKZ_MASTER

    FROM ZLFM1_05

   WHERE LIFNR = GS_HEADER-LIFNR.

  SELECT * FROM ZEKPO_05

    INTO TABLE LT_EKPO_TEMP

    WHERE EBELN = P_EBLEN

    ORDER BY EBELP.



  IF SY-SUBRC <> 0.

    MESSAGE '## PO# #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    STOP.

  ENDIF.



  REFRESH GT_ITEM.

  LOOP AT LT_EKPO_TEMP INTO LS_EKPO_TEMP.

    CLEAR GS_ITEM.

    MOVE-CORRESPONDING LS_EKPO_TEMP TO GS_ITEM.



    GS_ITEM-WAERS = GS_HEADER-WAERS.



    IF GS_ITEM-MWSKZ IS INITIAL.

       GS_ITEM-MWSKZ = LV_MWSKZ_MASTER.

    ENDIF.



    APPEND GS_ITEM TO GT_ITEM.

  ENDLOOP.



ENDFORM.







FORM CHECK_ALV_DATA_CHANGED USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.



  DATA: LS_MODI  TYPE LVC_S_MODI,

        LS_ZMARA TYPE ZMARA05,

        LS_LFM1  TYPE ZLFM1_05.    " ###-#### ##



  DATA: LV_MATNR TYPE ZMARA05-ZMATNR,

        LV_WERKS TYPE WERKS_D,

        LV_LGORT TYPE LGORT_D,

        LV_DATE  TYPE DATUM,

        LV_WAERS TYPE WAERS,           " ##

        LV_MWSKZ TYPE MWSKZ.           " ####



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.



    CASE LS_MODI-FIELDNAME.



      WHEN 'MATNR'.

        " # ## ##

        IF LS_MODI-VALUE IS INITIAL.

          CONTINUE.

        ENDIF.



        CLEAR LV_MATNR.

        LV_MATNR = LS_MODI-VALUE.

        IF STRLEN( LV_MATNR ) < 10.

          SHIFT LV_MATNR RIGHT DELETING TRAILING SPACE.

          OVERLAY LV_MATNR WITH '0000000000'.  " 10## 0

        ENDIF.



        " 1) ZMARA05 ### ## (## ##)

        SELECT SINGLE * FROM ZMARA05 INTO LS_ZMARA

          WHERE ZMATNR = LV_MATNR.



        IF SY-SUBRC <> 0.

          PERFORM ADD_PROTOCOL USING P_DATA_CHANGED LS_MODI 'E' 'ZMARA05# #### ## #####.'.

        ELSE.

          " 2) #### ##/#### ## (ZLFM1_05)

          SELECT SINGLE WAERS MWSKZ

            INTO (LV_WAERS, LV_MWSKZ)

            FROM ZLFM1_05

            WHERE LIFNR = GS_HEADER-LIFNR.



          IF SY-SUBRC <> 0.

            " LFM1# #### ### ###

            LV_WAERS = 'KRW'.

            LV_MWSKZ = 'V0'.

          ENDIF.



          " 3) ##(ALV)# ## ##



          " [####]

          CALL METHOD P_DATA_CHANGED->MODIFY_CELL

            EXPORTING I_ROW_ID = LS_MODI-ROW_ID I_FIELDNAME = 'MAKTX' I_VALUE = LS_ZMARA-ZMATNAME.



          " [##]

          CALL METHOD P_DATA_CHANGED->MODIFY_CELL

            EXPORTING I_ROW_ID = LS_MODI-ROW_ID I_FIELDNAME = 'MEINS' I_VALUE = LS_ZMARA-MEINS.



          " [####]

          CALL METHOD P_DATA_CHANGED->MODIFY_CELL

            EXPORTING I_ROW_ID = LS_MODI-ROW_ID I_FIELDNAME = 'BPRME' I_VALUE = LS_ZMARA-MEINS.



          " [##]

          CALL METHOD P_DATA_CHANGED->MODIFY_CELL

            EXPORTING I_ROW_ID = LS_MODI-ROW_ID I_FIELDNAME = 'STPRS' I_VALUE = LS_ZMARA-STPRS.



          " [###]

          IF LS_ZMARA-ZWERKS IS NOT INITIAL.

            CALL METHOD P_DATA_CHANGED->MODIFY_CELL

              EXPORTING I_ROW_ID = LS_MODI-ROW_ID I_FIELDNAME = 'WERKS' I_VALUE = LS_ZMARA-ZWERKS.

          ENDIF.



          " [####]

          IF LS_ZMARA-ZLGORT IS NOT INITIAL.

            CALL METHOD P_DATA_CHANGED->MODIFY_CELL

              EXPORTING I_ROW_ID = LS_MODI-ROW_ID I_FIELDNAME = 'LGORT' I_VALUE = LS_ZMARA-ZLGORT.

          ENDIF.



          " [##] - ##### ##!

          CALL METHOD P_DATA_CHANGED->MODIFY_CELL

            EXPORTING I_ROW_ID = LS_MODI-ROW_ID I_FIELDNAME = 'WAERS' I_VALUE = LV_WAERS.



          " [####] - ##### ##!

          CALL METHOD P_DATA_CHANGED->MODIFY_CELL

            EXPORTING I_ROW_ID = LS_MODI-ROW_ID I_FIELDNAME = 'MWSKZ' I_VALUE = LV_MWSKZ.



        ENDIF.



      " =========================================================

      " 2. ### (WERKS) ### ##

      " =========================================================

      WHEN 'WERKS'.



        CALL METHOD P_DATA_CHANGED->GET_CELL_VALUE

          EXPORTING I_ROW_ID = LS_MODI-ROW_ID

                    I_FIELDNAME = 'MATNR'

          IMPORTING E_VALUE = LV_MATNR.



        IF LV_MATNR IS NOT INITIAL.

          IF STRLEN( LV_MATNR ) < 10.

            SHIFT LV_MATNR RIGHT DELETING TRAILING SPACE.

            OVERLAY LV_MATNR WITH '0000000000'.

          ENDIF.

        ENDIF.



        IF LS_MODI-VALUE IS INITIAL.

          CONTINUE.

        ENDIF.



        LV_WERKS = LS_MODI-VALUE.

        SELECT SINGLE ZWERKS FROM ZMARA05

          INTO LV_WERKS

          WHERE ZMATNR = LV_MATNR

            AND ZWERKS = LV_WERKS.

        IF SY-SUBRC <> 0.

          PERFORM ADD_PROTOCOL USING P_DATA_CHANGED LS_MODI 'E' '#### ## ######.'.

        ENDIF.



      " =========================================================

      " 3. #### (LGORT) ### ##

      " =========================================================

      WHEN 'LGORT'.

        IF LS_MODI-VALUE IS INITIAL.

          CONTINUE.

        ENDIF.



        LV_LGORT = LS_MODI-VALUE.



        CALL METHOD P_DATA_CHANGED->GET_CELL_VALUE

          EXPORTING I_ROW_ID = LS_MODI-ROW_ID

                    I_FIELDNAME = 'MATNR'

          IMPORTING E_VALUE = LV_MATNR.



        IF LV_MATNR IS NOT INITIAL.

          IF STRLEN( LV_MATNR ) < 10.

            SHIFT LV_MATNR RIGHT DELETING TRAILING SPACE.

            OVERLAY LV_MATNR WITH '0000000000'.

          ENDIF.

        ENDIF.



        " ## ## ### # ##

        CALL METHOD P_DATA_CHANGED->GET_CELL_VALUE

          EXPORTING I_ROW_ID = LS_MODI-ROW_ID I_FIELDNAME = 'WERKS'

          IMPORTING E_VALUE  = LV_WERKS.



        IF LV_WERKS IS INITIAL.

          PERFORM ADD_PROTOCOL USING P_DATA_CHANGED LS_MODI 'E' '#### ## #####.'.

        ELSE.

          " ## #### ### ##

          SELECT SINGLE COUNT(*) FROM ZMARA05

            WHERE ZMATNR = LV_MATNR

              AND ZLGORT = LV_LGORT.

          IF SY-SUBRC <> 0.

            PERFORM ADD_PROTOCOL USING P_DATA_CHANGED LS_MODI 'E' '## ### ## #######.'.

          ENDIF.

        ENDIF.



      " =========================================================

      " 4. ###

      " =========================================================

      WHEN 'PRDAT'.

        LV_DATE = LS_MODI-VALUE.



        IF LV_DATE IS INITIAL OR LV_DATE = '00000000'.

          PERFORM ADD_PROTOCOL USING P_DATA_CHANGED LS_MODI 'E' '#### #####.'.

        ENDIF.



        " ### ###(BEDAT)# ##

        IF LV_DATE < GS_HEADER-BEDAT.

          PERFORM ADD_PROTOCOL USING P_DATA_CHANGED LS_MODI 'E' '#### ### #### ###.'.

        ENDIF.



    ENDCASE.



  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ADD_PROTOCOL (PDF ##: ## ### ##)

*&---------------------------------------------------------------------*




FORM ADD_PROTOCOL USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                        P_MODI         TYPE LVC_S_MODI

                        P_TYPE         TYPE CHAR1

                        P_MSG          TYPE STRING.



  CALL METHOD P_DATA_CHANGED->ADD_PROTOCOL_ENTRY

    EXPORTING

      I_MSGID     = '00'       " ## ### ###

      I_MSGNO     = '010'      " ## ### ## (&1 &2 &3 &4)

      I_MSGTY     = P_TYPE

      I_MSGV1     = P_MSG

      I_FIELDNAME = P_MODI-FIELDNAME

      I_ROW_ID    = P_MODI-ROW_ID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REGIST_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REGIST_EVENT.

  IF GO_EVENT_RECEIVER IS INITIAL.

    CREATE OBJECT GO_EVENT_RECEIVER.

    SET HANDLER GO_EVENT_RECEIVER->HANDLE_DATA_CHANGED FOR GO_GRID.



    " Enter # ## #

    CALL METHOD GO_GRID->REGISTER_EDIT_EVENT

      EXPORTING

        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_ENTER.



    " Modified ###

    CALL METHOD GO_GRID->REGISTER_EDIT_EVENT

      EXPORTING

        I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  BTN_REMOVE_ROW

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form BTN_REMOVE_ROW .

  DATA : LT_ROWS TYPE LVC_T_ROW,

         LS_ROW TYPE LVC_S_ROW.

  CALL METHOD GO_GRID->GET_SELECTED_ROWS

    IMPORTING

      ET_INDEX_ROWS = LT_ROWS.

  IF LT_ROWS IS INITIAL.

    MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  SORT LT_ROWS BY INDEX DESCENDING.



  LOOP AT LT_ROWS INTO LS_ROW.

    DELETE GT_ITEM INDEX LS_ROW-INDEX.

  ENDLOOP.



  IF GO_GRID IS BOUND.

    DATA : LS_STABLE TYPE LVC_S_STBL.

    LS_STABLE-ROW = 'X'.

    LS_STABLE-COL = 'X'.



    CALL METHOD GO_GRID->REFRESH_TABLE_DISPLAY

      EXPORTING

        IS_STABLE = LS_STABLE.

  ENDIF.



  MESSAGE '#######.' TYPE 'S'.

endform.




*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*




FORM SAVE_DATA .

  DATA : LS_EKKO TYPE ZEKKO_05,        " ## ### ##

         LS_EKPO TYPE ZEKPO_05,        " ### ### ##

         LT_EKPO TYPE TABLE OF ZEKPO_05.

  DATA : LV_EBELN TYPE EBELN.          " ## ##

  DATA : LV_ANSWER TYPE C.

  DATA : LV_ERROR_FLAG TYPE C.



  " 0. ### #### ##

  CALL METHOD GO_GRID->CHECK_CHANGED_DATA.



  IF GT_ITEM IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  CLEAR LV_ERROR_FLAG.

  LOOP AT GT_ITEM INTO GS_ITEM.

    IF GS_ITEM-MATNR IS INITIAL OR

       GS_ITEM-MENGE IS INITIAL OR

       GS_ITEM-STPRS IS INITIAL OR

       GS_ITEM-WERKS IS INITIAL.



      LV_ERROR_FLAG = 'X'.

      EXIT. " ## ## # ## ##

    ENDIF.

  ENDLOOP.



  IF LV_ERROR_FLAG = 'X'.

    MESSAGE '## ##(##, ##, ##, ###)# #######.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT. " ## ## ##

  ENDIF.





  " 1. ## ##

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR              = '## ##'

      TEXT_QUESTION         = '##### ########?'

      TEXT_BUTTON_1         = '#'

      TEXT_BUTTON_2         = '###'

      DISPLAY_CANCEL_BUTTON = ''

    IMPORTING

      ANSWER                = LV_ANSWER.



  IF LV_ANSWER <> '1'.

    EXIT.

  ENDIF.



  IF GT_ITEM IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  " 2. PO ## ##

  IF R_CRE = 'X'.

    " DB## ## # ## ## (#### EBELN# ### ## ### # ###)

    SELECT SINGLE MAX( EBELN ) FROM ZEKKO_05 INTO LV_EBELN.



    IF LV_EBELN IS INITIAL.

      LV_EBELN = '4500000001'.

    ELSE.

      LV_EBELN = LV_EBELN + 1.

    ENDIF.

    GS_HEADER-EBELN = LV_EBELN.

  ELSE.

    " ## ### ## ### ## ##

    IF GS_HEADER-EBELN IS INITIAL.

       GS_HEADER-EBELN = P_EBLEN.

    ENDIF.

  ENDIF.



  " 3. ## ### ##

  MOVE-CORRESPONDING GS_HEADER TO LS_EKKO.



  " [###] ERNAM, ERDAT ## ### #### #### ## ##/##

  " LS_EKKO-ERNAM = SY-UNAME.

  " LS_EKKO-ERDAT = SY-DATUM.



  " ## ##

  MODIFY ZEKKO_05 FROM LS_EKKO.



  " 4. ### ### ##

  LOOP AT GT_ITEM INTO GS_ITEM.

    CLEAR LS_EKPO.

    MOVE-CORRESPONDING GS_ITEM TO LS_EKPO.



    LS_EKPO-EBELN = GS_HEADER-EBELN.

    LS_EKPO-MANDT = SY-MANDT.



    APPEND LS_EKPO TO LT_EKPO.

  ENDLOOP.



  " ## ### ## # ###

  DELETE FROM ZEKPO_05 WHERE EBELN = GS_HEADER-EBELN.

  MODIFY ZEKPO_05 FROM TABLE LT_EKPO.



  " 5. ## # ##

  IF SY-SUBRC = 0.

    COMMIT WORK AND WAIT.

    MESSAGE S005 WITH '## ##. ##:' GS_HEADER-EBELN.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '## ##' TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_VENDOR_ON_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_VENDOR_VALID_ON_SCREEN.

  DATA: LV_DUMMY TYPE C.



  " 1. ### ## ## ##

  IF P_LIFNR1 IS INITIAL OR

     P_LIFNR2 IS INITIAL OR

     P_BUKRS IS INITIAL.

    MESSAGE '#### ##### ## ######.' TYPE 'E'.

  ENDIF.



  " 2. ZLFB1_05 ##### ### + #### ## ##

  CLEAR LV_DUMMY.

  SELECT SINGLE 'X'

    INTO @LV_DUMMY

    FROM ZLFB1_05

   WHERE LIFNR = @P_LIFNR1

     AND BUKRS = @P_BUKRS.



  IF SY-SUBRC <> 0.

    MESSAGE '### ##### ## #### #### ####.' TYPE 'E'.

  ENDIF.

ENDFORM.