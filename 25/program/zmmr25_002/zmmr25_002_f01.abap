
*&---------------------------------------------------------------------*

*& Include ZMMR25_002_F01

*&---------------------------------------------------------------------*



*----------------------------------------------------------------------

* ## ## # ###

*----------------------------------------------------------------------






FORM DETERMINE_MODE.



  IF R_VIEW = 'X'.

    GV_MODE = C_MODE_DISP.

  ELSEIF R_CRE = 'X'.

    GV_MODE = C_MODE_CREATE.

  ELSE.

    GV_MODE = C_MODE_CREATE.

  ENDIF.



ENDFORM.






*----------------------------------------------------------------------

* ## ## ### ##

*----------------------------------------------------------------------






FORM INIT_SELECTION.



  " ## ## ## ##

  R_CRE = 'X'.

  R_VIEW = ''.



  " ### ##

  P_BEDAT = SY-DATUM.

  P_BUKRS = '1000'.

  P_LIFNR1 = '1000000000'.



  " ## ## ###

  P_EBELN = '4500000001'.

  P_BUKRS2 = P_BUKRS.

  P_LIFNR2 = P_LIFNR1.



ENDFORM.






*----------------------------------------------------------------------

* SELECTION-SCREEN ## ## ##

*----------------------------------------------------------------------






FORM SELECTION_SCREEN_CONTROL.



  LOOP AT SCREEN.

    CASE ABAP_TRUE.

      WHEN R_VIEW.

        IF SCREEN-GROUP1 = 'M1'.

          SCREEN-ACTIVE = '0'.

        ENDIF.

      WHEN R_CRE.

        IF SCREEN-GROUP1 = 'M2'.

          SCREEN-ACTIVE = '0'.

        ENDIF.

    ENDCASE.

    MODIFY SCREEN.

  ENDLOOP.



ENDFORM.






*----------------------------------------------------------------------

* ## ## ## ####

*----------------------------------------------------------------------






FORM RUN_DISPLAY_MODE.



  DATA: LS_LFM1 TYPE ZEDT25_LFM1.



  " ## ### ###

  PERFORM CLEAR_PO_DATA.



  " PO ## # ### ##

  PERFORM GET_PO_HEADER USING P_EBELN P_BUKRS2 P_LIFNR2.



  IF GT_EKKO IS INITIAL.

    MESSAGE '## PO #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    STOP.

  ENDIF.



  PERFORM GET_PO_ITEM USING P_EBELN.

  PERFORM CONVERT_ITEM_TO_ALV.



  " #### ##/#### ## ##

  CLEAR LS_LFM1.

  SELECT SINGLE WAERS MWSKZ

    INTO (LS_LFM1-WAERS, LS_LFM1-MWSKZ)

    FROM ZEDT25_LFM1

    WHERE LIFNR = GS_EKKO-LIFNR

      AND EKORG = GS_EKKO-EKORG.



  IF SY-SUBRC = 0.

    " ALV #### ### ##

    LOOP AT GT_EKPO_ALV INTO GS_EKPO_ALV.

      IF GS_EKPO_ALV-MWSKZ IS INITIAL.

        GS_EKPO_ALV-MWSKZ = LS_LFM1-MWSKZ.

      ENDIF.

      IF GS_EKPO_ALV-WAERS IS INITIAL.

        GS_EKPO_ALV-WAERS = LS_LFM1-WAERS.

      ENDIF.

      MODIFY GT_EKPO_ALV FROM GS_EKPO_ALV INDEX SY-TABIX.

    ENDLOOP.

  ENDIF.



  " ## ## # ALV ##

  PERFORM DISPLAY_HEADER_TO_SCREEN USING P_EBELN.

  PERFORM REFRESH_ALV_0100.



ENDFORM.






*----------------------------------------------------------------------

* ALV ### ## #### ##

*----------------------------------------------------------------------






FORM BUILD_FCAT_0100.



  CLEAR GT_FCAT.



  " ## ## ##

  PERFORM ADD_FCAT_0100 USING 'EBELP' '####' ''.

  PERFORM ADD_FCAT_0100 USING 'MATNR' '####' 'X'.

  PERFORM ADD_FCAT_0100 USING 'MAKTX' '###' ''.



  " ##/## ##

  PERFORM ADD_FCAT_0100 USING 'MENGE' '##' 'X'.

  PERFORM ADD_FCAT_0100 USING 'STPRS' '##' 'X'.

  PERFORM ADD_FCAT_0100 USING 'MEINS' '##' ''.



  " ##/## ##

  PERFORM ADD_FCAT_0100 USING 'WAERS' '##' ''.

  PERFORM ADD_FCAT_0100 USING 'MWSKZ' '####' ''.



  " ## ##

  PERFORM ADD_FCAT_0100 USING 'PRDAT' '###' 'X'.

  PERFORM ADD_FCAT_0100 USING 'WERKS' '###' 'X'.

  PERFORM ADD_FCAT_0100 USING 'LGORT' '####' 'X'.



ENDFORM.






*----------------------------------------------------------------------

* ## #### ## ##

*----------------------------------------------------------------------






FORM ADD_FCAT_0100 USING P_FIELDNAME TYPE LVC_FNAME

                          P_COLTEXT   TYPE SCRTEXT_L

                          P_EDIT      TYPE C.



  CLEAR GS_FCAT.

  GS_FCAT-FIELDNAME = P_FIELDNAME.

  GS_FCAT-COLTEXT = P_COLTEXT.



  " ## ## ## ##

  IF GV_MODE = C_MODE_DISP.

    GS_FCAT-EDIT = ''.

  ELSE.

    GS_FCAT-EDIT = P_EDIT.

  ENDIF.



  " ### ## ## ##

  CASE P_FIELDNAME.

    WHEN 'MAKTX'.

      GS_FCAT-OUTPUTLEN = 20.



    WHEN 'PRDAT'.

      GS_FCAT-OUTPUTLEN = 10.



    WHEN 'MENGE'.

      GS_FCAT-REF_TABLE = 'ZEDT25_ZEKPO'.

      GS_FCAT-REF_FIELD = 'MENGE'.

      GS_FCAT-QFIELDNAME = 'MEINS'.

      GS_FCAT-NO_ZERO = 'X'.



  ENDCASE.



  APPEND GS_FCAT TO GT_FCAT.



ENDFORM.






*----------------------------------------------------------------------

* ALV #### # ### ## ##

*----------------------------------------------------------------------






FORM CREATE_OBJECT_0100.



  " Custom Container ##

  CREATE OBJECT GO_CONTAINER

    EXPORTING

      CONTAINER_NAME = 'CC_ALV'.



  " ALV Grid ##

  CREATE OBJECT GO_ALV

    EXPORTING

      I_PARENT = GO_CONTAINER.



  " ## ### ##

  CALL METHOD GO_ALV->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



ENDFORM.






*----------------------------------------------------------------------

* ALV ### ## ##

*----------------------------------------------------------------------






FORM ALV_DISPLAY_0100.



  " ## #### ##

  IF GT_FCAT IS INITIAL.

    PERFORM BUILD_FCAT_0100.

  ENDIF.



  " #### ##

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-STYLEFNAME = 'CELLTAB'.



  " ALV ##

  CALL METHOD GO_ALV->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT = GS_LAYOUT

    CHANGING

      IT_FIELDCATALOG = GT_FCAT

      IT_OUTTAB = GT_EKPO_ALV.



ENDFORM.






*----------------------------------------------------------------------

* ALV ### ### ####

*----------------------------------------------------------------------






FORM REFRESH_ALV_0100.



  IF GO_ALV IS BOUND.

    CALL METHOD GO_ALV->REFRESH_TABLE_DISPLAY( ).

  ENDIF.



ENDFORM.






*----------------------------------------------------------------------

* PO ## ### ##

*----------------------------------------------------------------------






FORM GET_PO_HEADER USING P_EBELN TYPE EBELN

                         P_BUKRS TYPE BUKRS

                         P_LIFNR TYPE LIFNR.



  CLEAR: GT_EKKO, GS_EKKO.



  CHECK P_EBELN IS NOT INITIAL.



  SELECT SINGLE *

    INTO GS_EKKO

    FROM ZEDT25_ZEKKO

    WHERE EBELN = P_EBELN

      AND BUKRS = P_BUKRS

      AND LIFNR = P_LIFNR.



  IF SY-SUBRC = 0.

    APPEND GS_EKKO TO GT_EKKO.

  ENDIF.



ENDFORM.






*----------------------------------------------------------------------

* PO ### ### ##

*----------------------------------------------------------------------






FORM GET_PO_ITEM USING P_EBELN TYPE EBELN.



  CLEAR GT_EKPO.



  SELECT *

    INTO TABLE GT_EKPO

    FROM ZEDT25_ZEKPO

    WHERE EBELN = P_EBELN

    ORDER BY EBELP.



ENDFORM.






*----------------------------------------------------------------------

* PO ## ### ###

*----------------------------------------------------------------------






FORM CLEAR_PO_DATA.



  CLEAR: GT_EKKO, GS_EKKO, GT_EKPO, GS_EKPO.



ENDFORM.






*----------------------------------------------------------------------

* ## ### # ##

*----------------------------------------------------------------------






FORM ADD_ITEM_LINE.



  DATA: LV_EBELP TYPE EBELP,

        LS_LFM1  TYPE ZEDT25_LFM1,

        LV_MAX   TYPE EBELP.



  " ## #### ##

  CLEAR: LV_EBELP, LV_MAX.



  LOOP AT GT_EKPO_ALV INTO GS_EKPO_ALV.

    IF GS_EKPO_ALV-EBELP > LV_MAX.

      LV_MAX = GS_EKPO_ALV-EBELP.

    ENDIF.

  ENDLOOP.



  LV_EBELP = COND #( WHEN LV_MAX IS INITIAL THEN '00010'

                     ELSE LV_MAX + 10 ).



  " ### ## ##

  CLEAR LS_LFM1.



  IF GS_EKKO-LIFNR IS NOT INITIAL AND GS_EKKO-EKORG IS NOT INITIAL.

    SELECT SINGLE *

      INTO LS_LFM1

      FROM ZEDT25_LFM1

      WHERE LIFNR = GS_EKKO-LIFNR

        AND EKORG = GS_EKKO-EKORG.

  ENDIF.



  " ## # ### ##

  CLEAR GS_EKPO_ALV.

  GS_EKPO_ALV-EBELP = LV_EBELP.

  GS_EKPO_ALV-PRDAT = SY-DATUM.

  GS_EKPO_ALV-STPRS = '1'.

  GS_EKPO_ALV-MEINS = 'EA'.

  GS_EKPO_ALV-BPRME = 'EA'.

  GS_EKPO_ALV-MATNR = ''.

  GS_EKPO_ALV-MAKTX = ''.

  GS_EKPO_ALV-WERKS = ''.

  GS_EKPO_ALV-LGORT = ''.



  " ### ### ##

  IF LS_LFM1-MWSKZ IS NOT INITIAL.

    GS_EKPO_ALV-MWSKZ = LS_LFM1-MWSKZ.

  ENDIF.



  IF LS_LFM1-WAERS IS NOT INITIAL.

    GS_EKPO_ALV-WAERS = LS_LFM1-WAERS.

  ENDIF.



  APPEND GS_EKPO_ALV TO GT_EKPO_ALV.



  PERFORM REFRESH_ALV_0100.



ENDFORM.






*----------------------------------------------------------------------

* ### ### # ##

*----------------------------------------------------------------------






FORM DELETE_ITEM_LINE.



  DATA: LT_ROWS TYPE LVC_T_ROW,

        LS_ROW   TYPE LVC_S_ROW,

        LV_IDX   TYPE SY-TABIX.



  CHECK GO_ALV IS BOUND.



  " ### # ####

  CALL METHOD GO_ALV->GET_SELECTED_ROWS

    IMPORTING

      ET_INDEX_ROWS = LT_ROWS.



  IF LT_ROWS IS INITIAL.

    MESSAGE '### ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  " #### ## (### ## ## ##)

  SORT LT_ROWS BY INDEX DESCENDING.



  LOOP AT LT_ROWS INTO LS_ROW.

    LV_IDX = LS_ROW-INDEX.

    CHECK LV_IDX > 0.

    DELETE GT_EKPO_ALV INDEX LV_IDX.

  ENDLOOP.



  PERFORM REFRESH_ALV_0100.



ENDFORM.






*----------------------------------------------------------------------

* PO ### ##

*----------------------------------------------------------------------






FORM SAVE_PO.



  DATA: LS_EKKO   TYPE ZEDT25_ZEKKO,

        LS_EKPO   TYPE ZEDT25_ZEKPO,

        LT_EKPO   TYPE STANDARD TABLE OF ZEDT25_ZEKPO,

        LV_EBELN  TYPE EBELN,

        LV_ANSWER TYPE C LENGTH 1.



  " ALV #### ##

  IF GO_ALV IS BOUND.

    CALL METHOD GO_ALV->CHECK_CHANGED_DATA.

  ENDIF.



  " ## # ##

  IF GT_EKPO_ALV IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  " ## ## ##

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR              = '## ##'

      TEXT_QUESTION         = '#### ########?'

      TEXT_BUTTON_1         = '#'

      TEXT_BUTTON_2         = '###'

      DISPLAY_CANCEL_BUTTON = ' '

    IMPORTING

      ANSWER                = LV_ANSWER.



  CHECK LV_ANSWER = '1'.



  " ### ## ##

  LOOP AT GT_EKPO_ALV INTO GS_EKPO_ALV.

    CHECK GS_EKPO_ALV-MENGE <= 0.

    MESSAGE '### 0## ## ###.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDLOOP.



  " PO ## ## ## ##

  IF GV_MODE = C_MODE_CREATE.

    " ## PO ## ##

    SELECT SINGLE MAX( EBELN )

      INTO LV_EBELN

      FROM ZEDT25_ZEKKO.



    LV_EBELN = COND #( WHEN LV_EBELN IS INITIAL THEN '4500000001'

                       ELSE LV_EBELN + 1 ).



    GS_EKKO-EBELN = LV_EBELN.



  ELSE.

    " ## PO ## ##

    IF GS_EKKO-EBELN IS INITIAL.

      MESSAGE 'PO ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

      EXIT.

    ENDIF.

  ENDIF.



  " ## ### ##

  CLEAR LS_EKKO.

  MOVE-CORRESPONDING GS_EKKO TO LS_EKKO.

  LS_EKKO-EBELN = GS_EKKO-EBELN.



  MODIFY ZEDT25_ZEKKO FROM LS_EKKO.



  IF SY-SUBRC <> 0.

    MESSAGE '## ## ##' TYPE 'S' DISPLAY LIKE 'E'.

    ROLLBACK WORK.

    EXIT.

  ENDIF.



  " ### ### ##

  CLEAR LT_EKPO.



  LOOP AT GT_EKPO_ALV INTO GS_EKPO_ALV.



    " ## ## ##

    CHECK GS_EKPO_ALV-MATNR IS NOT INITIAL.

    CHECK GS_EKPO_ALV-MENGE IS NOT INITIAL AND GS_EKPO_ALV-MENGE > 0.

    CHECK GS_EKPO_ALV-STPRS IS NOT INITIAL AND GS_EKPO_ALV-STPRS > 0.



    CLEAR LS_EKPO.

    MOVE-CORRESPONDING GS_EKPO_ALV TO LS_EKPO.

    LS_EKPO-EBELN = GS_EKKO-EBELN.



    APPEND LS_EKPO TO LT_EKPO.



  ENDLOOP.



  IF LT_EKPO IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    ROLLBACK WORK.

    EXIT.

  ENDIF.



  " ### ### ##

  DELETE FROM ZEDT25_ZEKPO WHERE EBELN = GS_EKKO-EBELN.

  INSERT ZEDT25_ZEKPO FROM TABLE LT_EKPO.



  IF SY-SUBRC = 0.

    COMMIT WORK AND WAIT.



    " ## ###

    CALL FUNCTION 'POPUP_TO_INFORM'

      EXPORTING

        TITEL = '## ##'

        TXT1  = |PO { GS_EKKO-EBELN } #(#)|

        TXT2  = '##### #######.'.



  ELSE.

    ROLLBACK WORK.

    MESSAGE '## ##' TYPE 'S' DISPLAY LIKE 'E'.

  ENDIF.



ENDFORM.






*----------------------------------------------------------------------

* ### ### ### ##

*----------------------------------------------------------------------






FORM CHECK_VENDOR_VALID.



  DATA: LS_LFA1 TYPE ZEDT25_LFA1,

        LS_LFM1 TYPE ZEDT25_LFM1.



  " ### ## ## ##

  CLEAR LS_LFA1.



  SELECT SINGLE LIFNR

    INTO LS_LFA1-LIFNR

    FROM ZEDT25_LFA1

    WHERE LIFNR = P_LIFNR1.



  IF SY-SUBRC <> 0.

    MESSAGE '#### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    STOP.

  ENDIF.



  " ## ### ##

  IF GS_EKKO-BEDAT IS INITIAL.

    GS_EKKO-BEDAT = P_BEDAT.

  ENDIF.



  IF GS_EKKO-BUKRS IS INITIAL.

    GS_EKKO-BUKRS = P_BUKRS.

  ENDIF.



  IF GS_EKKO-LIFNR IS INITIAL.

    GS_EKKO-LIFNR = P_LIFNR1.

  ENDIF.



  " #### #### ## ##

  CLEAR LS_LFM1.



  SELECT SINGLE EKORG EKGRP WAERS MWSKZ

    INTO (LS_LFM1-EKORG, LS_LFM1-EKGRP, LS_LFM1-WAERS, LS_LFM1-MWSKZ)

    FROM ZEDT25_LFM1

    WHERE LIFNR = P_LIFNR1.



  IF SY-SUBRC = 0.

    " #### ## ##

    GS_EKKO-EKORG = LS_LFM1-EKORG.

    GS_EKKO-EKGRP = LS_LFM1-EKGRP.

    GS_EKKO-WAERS = LS_LFM1-WAERS.



    " ### ### ##

    CHECK LS_LFM1-MWSKZ IS NOT INITIAL.

    LOOP AT GT_EKPO_ALV INTO GS_EKPO_ALV.

      GS_EKPO_ALV-MWSKZ = LS_LFM1-MWSKZ.

      MODIFY GT_EKPO_ALV FROM GS_EKPO_ALV INDEX SY-TABIX.

    ENDLOOP.

  ENDIF.



ENDFORM.






*----------------------------------------------------------------------

* ## ## ## ## ####

*----------------------------------------------------------------------






FORM DISABLE_HEADER_FIELDS.



  LOOP AT SCREEN.

    CHECK SCREEN-GROUP1 = 'H1'.

    SCREEN-INPUT = '0'.

    MODIFY SCREEN.

  ENDLOOP.



ENDFORM.






*----------------------------------------------------------------------

* ALV # ### ## ### ###

*----------------------------------------------------------------------






FORM ALV_HANDLE_DATA_CHANGED USING ER_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.



  DATA: LS_MODI  TYPE LVC_S_MODI,

        LS_MARA  TYPE ZMARA25,

        LV_PRDAT TYPE DATS,

        LV_MATNR TYPE ZMARA25-ZMATNR,

        LV_WERKS TYPE WERKS_D,

        LV_LGORT TYPE LGORT_D.



  LOOP AT ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.



    " ### # ### ##

    CLEAR GS_EKPO_ALV.

    READ TABLE GT_EKPO_ALV INTO GS_EKPO_ALV INDEX LS_MODI-ROW_ID.

    CHECK SY-SUBRC = 0.



    CASE LS_MODI-FIELDNAME.



      WHEN 'MATNR'.

        " #### ## # ## ### ##



        GS_EKPO_ALV-MATNR = LS_MODI-VALUE.

        MODIFY GT_EKPO_ALV FROM GS_EKPO_ALV INDEX LS_MODI-ROW_ID.



        " ## ### ##

        CLEAR LS_MARA.

        SELECT SINGLE *

          INTO LS_MARA

          FROM ZMARA25

          WHERE ZMATNR = GS_EKPO_ALV-MATNR.



        IF SY-SUBRC <> 0.

          " ## #### ## - ## ###

          CALL METHOD ER_DATA_CHANGED->ADD_PROTOCOL_ENTRY

            EXPORTING

              I_MSGID     = 'ZMED25'

              I_MSGNO     = '008'

              I_MSGTY     = 'E'

              I_MSGV1     = '### #### ####.'

              I_FIELDNAME = LS_MODI-FIELDNAME

              I_ROW_ID    = LS_MODI-ROW_ID.

        ELSE.

          " ## ## ## ##



          " ## ## ####

          CALL METHOD ER_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MODI-ROW_ID

              I_FIELDNAME = 'MAKTX'

              I_VALUE     = LS_MARA-ZMATNAME.



          CALL METHOD ER_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MODI-ROW_ID

              I_FIELDNAME = 'MEINS'

              I_VALUE     = LS_MARA-MEINS.



          CALL METHOD ER_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MODI-ROW_ID

              I_FIELDNAME = 'BPRME'

              I_VALUE     = LS_MARA-MEINS.



          CALL METHOD ER_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MODI-ROW_ID

              I_FIELDNAME = 'STPRS'

              I_VALUE     = LS_MARA-STPRS.



          CALL METHOD ER_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MODI-ROW_ID

              I_FIELDNAME = 'WAERS'

              I_VALUE     = LS_MARA-WAERS.



          " ###/#### ####

          IF LS_MARA-WERKS IS NOT INITIAL.

            CALL METHOD ER_DATA_CHANGED->MODIFY_CELL

              EXPORTING

                I_ROW_ID    = LS_MODI-ROW_ID

                I_FIELDNAME = 'WERKS'

                I_VALUE     = LS_MARA-WERKS.

          ENDIF.



          IF LS_MARA-LGORT IS NOT INITIAL.

            CALL METHOD ER_DATA_CHANGED->MODIFY_CELL

              EXPORTING

                I_ROW_ID    = LS_MODI-ROW_ID

                I_FIELDNAME = 'LGORT'

                I_VALUE     = LS_MARA-LGORT.

          ENDIF.



          " ## ### ####

          GS_EKPO_ALV-MAKTX = LS_MARA-ZMATNAME.

          GS_EKPO_ALV-MEINS = LS_MARA-MEINS.

          GS_EKPO_ALV-BPRME = LS_MARA-MEINS.

          GS_EKPO_ALV-STPRS = LS_MARA-STPRS.

          GS_EKPO_ALV-WAERS = LS_MARA-WAERS.

          GS_EKPO_ALV-WERKS = LS_MARA-WERKS.

          GS_EKPO_ALV-LGORT = LS_MARA-LGORT.



          MODIFY GT_EKPO_ALV FROM GS_EKPO_ALV INDEX LS_MODI-ROW_ID.



        ENDIF.



      WHEN 'MENGE'.

        " ## ## # ##



        DATA LV_MENGE TYPE ZEDT25_ZEKPO-MENGE.

        LV_MENGE = LS_MODI-VALUE.



        IF LV_MENGE <= 0.

          CALL METHOD ER_DATA_CHANGED->ADD_PROTOCOL_ENTRY

            EXPORTING

              I_MSGID     = 'ZMED25'

              I_MSGNO     = '012'

              I_MSGTY     = 'E'

              I_MSGV1     = '### 1 ##### ###.'

              I_FIELDNAME = 'MENGE'

              I_ROW_ID    = LS_MODI-ROW_ID.

        ENDIF.



      WHEN 'PRDAT'.

        " ### ## # ##



        LV_PRDAT = LS_MODI-VALUE.



        IF LV_PRDAT < GS_EKKO-BEDAT.

          CALL METHOD ER_DATA_CHANGED->ADD_PROTOCOL_ENTRY

            EXPORTING

              I_MSGID     = 'ZMED25'

              I_MSGNO     = '009'

              I_MSGTY     = 'E'

              I_MSGV1     = '#### ### #### ###.'

              I_FIELDNAME = LS_MODI-FIELDNAME

              I_ROW_ID    = LS_MODI-ROW_ID.

        ELSE.

          GS_EKPO_ALV-PRDAT = LV_PRDAT.

          MODIFY GT_EKPO_ALV FROM GS_EKPO_ALV INDEX LS_MODI-ROW_ID.

        ENDIF.



      WHEN 'WERKS' OR 'LGORT'.

        " ###/#### ## # ##



        " ### ## ####

        CASE LS_MODI-FIELDNAME.

          WHEN 'WERKS'.

            GS_EKPO_ALV-WERKS = LS_MODI-VALUE.

          WHEN 'LGORT'.

            GS_EKPO_ALV-LGORT = LS_MODI-VALUE.

        ENDCASE.

        MODIFY GT_EKPO_ALV FROM GS_EKPO_ALV INDEX LS_MODI-ROW_ID.



        " #### ##### ## ### ## ## ##

        CHECK GS_EKPO_ALV-WERKS IS NOT INITIAL.

        CHECK GS_EKPO_ALV-LGORT IS NOT INITIAL.

        CHECK GS_EKPO_ALV-MATNR IS NOT INITIAL.



        " ##/###/#### ## ##

        CLEAR LS_MARA.

        SELECT SINGLE ZMATNR

          INTO LS_MARA-ZMATNR

          FROM ZMARA25

          WHERE ZMATNR = GS_EKPO_ALV-MATNR

            AND WERKS = GS_EKPO_ALV-WERKS

            AND LGORT = GS_EKPO_ALV-LGORT.



        IF SY-SUBRC <> 0.

          CALL METHOD ER_DATA_CHANGED->ADD_PROTOCOL_ENTRY

            EXPORTING

              I_MSGID     = 'ZMED25'

              I_MSGNO     = '010'

              I_MSGTY     = 'E'

              I_MSGV1     = '##/###/#### ### #### ####.'

              I_FIELDNAME = LS_MODI-FIELDNAME

              I_ROW_ID    = LS_MODI-ROW_ID.

        ENDIF.



    ENDCASE.



  ENDLOOP.



ENDFORM.






*----------------------------------------------------------------------

* PO #### ALV ### ### ##

*----------------------------------------------------------------------






FORM CONVERT_ITEM_TO_ALV.



  REFRESH GT_EKPO_ALV.

  CLEAR GS_EKPO_ALV.



  LOOP AT GT_EKPO INTO GS_EKPO.



    CLEAR GS_EKPO_ALV.

    MOVE-CORRESPONDING GS_EKPO TO GS_EKPO_ALV.



    " ## ### ##

    IF GS_EKPO_ALV-WAERS IS INITIAL.

      GS_EKPO_ALV-WAERS = GS_EKKO-WAERS.

    ENDIF.



    APPEND GS_EKPO_ALV TO GT_EKPO_ALV.



  ENDLOOP.



ENDFORM.






*----------------------------------------------------------------------

* PO ## ### ### ##

*----------------------------------------------------------------------






FORM DISPLAY_HEADER_TO_SCREEN USING P_EBELN TYPE EBELN.



  P_EBELN  = GS_EKKO-EBELN.

  P_BUKRS2 = GS_EKKO-BUKRS.

  P_LIFNR2 = GS_EKKO-LIFNR.

  P_BEDAT  = GS_EKKO-BEDAT.



ENDFORM.