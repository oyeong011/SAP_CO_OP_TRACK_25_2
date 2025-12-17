
*&---------------------------------------------------------------------*

*&  Include           ZMM14_002_F01

*&---------------------------------------------------------------------*

*&  ### FORM

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT_100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT_100 .



  CREATE OBJECT GO_CUSTOM_100

    EXPORTING

      CONTAINER_NAME = 'CC_ALV'.



  CREATE OBJECT GO_GRID_100

    EXPORTING

      I_PARENT = GO_CUSTOM_100.



  CREATE OBJECT GO_EVENT_100.

  SET HANDLER GO_EVENT_100->HANDLE_DATA_CHANGED FOR GO_GRID_100.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_100 .



  CLEAR : GT_FCAT, GS_FCAT.



  PERFORM FILL_FCAT USING :

        'EBELP' '##' '' 10 '' CHANGING GT_FCAT,

        'MATNR' '####' 'X' 10 '' CHANGING GT_FCAT,

        'MAKTX' '###' '' 10 '' CHANGING GT_FCAT,

        'MENGE' 'PO##' 'X' 10 'Q' CHANGING GT_FCAT,

        'MEINS' '##' '' 10 '' CHANGING GT_FCAT,

        'STPRS' '##' 'X' 10 'C' CHANGING GT_FCAT,

        'WAERS' '##' '' 10 '' CHANGING GT_FCAT,

        'MWSKZ' '####' 'X' 10 '' CHANGING GT_FCAT,

        'PRDAT' '###' 'X' 10 '' CHANGING GT_FCAT,

        'WERKS' '###' 'X' 10 '' CHANGING GT_FCAT,

        'LGORT' '####' 'X' 10 '' CHANGING GT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT_100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT_100 .



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-NO_TOOLBAR = 'X'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_METHOD_100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CALL_METHOD_100 .



  CALL METHOD GO_GRID_100->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  CALL METHOD GO_GRID_100->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_CREATE

      IT_FIELDCATALOG = GT_FCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_HEADER_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_HEADER_DATA .



  GS_100-LIFNR = P_LIFNR.

  GS_100-BUKRS = P_BUKRS.

  GS_100-BEDAT = P_BEDAT.



  SELECT SINGLE WAERS EKORG EKGRP MWSKZ INTO CORRESPONDING FIELDS OF GS_100

    FROM ZLFM1_14 AS A

    JOIN ZLFB1_14 AS B ON A~LIFNR = B~LIFNR

    WHERE A~LIFNR = P_LIFNR AND B~BUKRS = P_BUKRS.



  IF SY-SUBRC <> 0.

    MESSAGE '## #### ####.' TYPE 'S' DISPLAY LIKE 'W'.

    LEAVE LIST-PROCESSING.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ADD_ITEM

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM ADD_ITEM .



  CLEAR GS_CREATE.



  GS_CREATE-WAERS = GS_100-WAERS.

  GS_CREATE-MWSKZ = GS_100-MWSKZ.



  APPEND GS_CREATE TO GT_CREATE.



  LOOP AT GT_CREATE INTO GS_CREATE.

    GS_CREATE-EBELP = SY-TABIX * 10.

    MODIFY GT_CREATE FROM GS_CREATE.

  ENDLOOP.



  PERFORM REFRESH_ALV_100.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_ITEM

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM DELETE_ITEM .



  DATA: LT_INDEX TYPE LVC_T_ROW,

        LS_INDEX TYPE LVC_S_ROW.



  CALL METHOD GO_GRID_100->GET_SELECTED_ROWS

    IMPORTING ET_INDEX_ROWS = LT_INDEX.



  IF LT_INDEX IS INITIAL.

    MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  SORT LT_INDEX BY INDEX DESCENDING.



  LOOP AT LT_INDEX INTO LS_INDEX.

    DELETE GT_CREATE INDEX LS_INDEX-INDEX.

  ENDLOOP.



  LOOP AT GT_CREATE INTO GS_CREATE.

    GS_CREATE-EBELP = SY-TABIX * 10.

    MODIFY GT_CREATE FROM GS_CREATE.

  ENDLOOP.



  PERFORM REFRESH_ALV_100.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_PO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM SAVE_PO .



  DATA: LS_ZEKKO TYPE ZEKKO_14,

        LS_ZEKPO TYPE ZEKPO_14,

        LT_ZEKPO TYPE TABLE OF ZEKPO_14.

  DATA: LV_NEW_EBELN TYPE EBELN.

  DATA: LV_ERROR TYPE C.



  IF GT_CREATE IS INITIAL.

    MESSAGE '### ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  PERFORM CHECK_DATA CHANGING LV_ERROR.  "### ##



  IF LV_ERROR = 'X'.

    EXIT.

  ENDIF.



  SELECT MAX( EBELN ) INTO LV_NEW_EBELN FROM ZEKKO_14.

  IF LV_NEW_EBELN IS INITIAL.

    LV_NEW_EBELN = '4500000000'.

  ELSE.

    LV_NEW_EBELN = LV_NEW_EBELN + 1.

  ENDIF.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

    EXPORTING INPUT = LV_NEW_EBELN IMPORTING OUTPUT = LV_NEW_EBELN.



  LS_ZEKKO-EBELN = LV_NEW_EBELN.  "######

  LS_ZEKKO-BUKRS = P_BUKRS.       "####

  LS_ZEKKO-LIFNR = P_LIFNR.       "#####

  LS_ZEKKO-BEDAT = P_BEDAT.       "###

  LS_ZEKKO-EKGRP = GS_100-EKGRP.  "####

  LS_ZEKKO-EKORG = GS_100-EKORG.  "####

  LS_ZEKKO-WAERS = GS_100-WAERS.  "##



  LOOP AT GT_CREATE INTO GS_CREATE.

    CLEAR LS_ZEKPO.

    MOVE-CORRESPONDING GS_CREATE TO LS_ZEKPO.

    LS_ZEKPO-EBELN = LV_NEW_EBELN.

    APPEND LS_ZEKPO TO LT_ZEKPO.

  ENDLOOP.



  INSERT ZEKKO_14 FROM LS_ZEKKO.



  IF SY-SUBRC = 0.

    INSERT ZEKPO_14 FROM TABLE LT_ZEKPO.



    IF SY-SUBRC = 0.

      COMMIT WORK.

      MESSAGE '####### #######. ####: ' && LV_NEW_EBELN TYPE 'S'.

      PERFORM REFRESH_ALV_100.

    ELSE.

      ROLLBACK WORK.

      MESSAGE '## ## ##' TYPE 'E'.

    ENDIF.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '## ## ##' TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_DATA_INTEGRITY

*&---------------------------------------------------------------------*

*       ## # ### ### ##

*----------------------------------------------------------------------*




FORM CHECK_DATA CHANGING CV_ERROR TYPE C.



  DATA: LV_MATNR TYPE TY_100-MATNR,

        LV_MATNR_IN TYPE TY_100-MATNR,

        LV_WERKS TYPE TY_100-WERKS,

        LV_LGORT TYPE TY_100-LGORT.



  CV_ERROR = ''.



  LOOP AT GT_CREATE INTO GS_CREATE.



    "[####] ## ## ##

    LV_MATNR_IN = GS_CREATE-MATNR.

      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

        EXPORTING

          INPUT  = LV_MATNR_IN

        IMPORTING

          OUTPUT = LV_MATNR_IN.

    IF GS_CREATE-MATNR IS NOT INITIAL.

      SELECT SINGLE MATNR INTO LV_MATNR

        FROM ZMARA_14

        WHERE MATNR = LV_MATNR_IN.



      IF SY-SUBRC <> 0.

        CV_ERROR = 'X'.

        MESSAGE S001(00) WITH '#### ## #####. (##:' SY-TABIX ')' DISPLAY LIKE 'W'.

        EXIT.

      ENDIF.

    ELSE.

      " ##### ##### ### ##

      CV_ERROR = 'X'.

      MESSAGE S001(00) WITH '##### #####. (##:' SY-TABIX ')' DISPLAY LIKE 'W'.

      EXIT.

    ENDIF.



    IF GS_CREATE-MENGE <= 0.

      CV_ERROR = 'X'.

      MESSAGE S001(00) WITH '### 0 #### ###. (##:' SY-TABIX ')' DISPLAY LIKE 'W'.

      EXIT.

    ENDIF.



    IF GS_CREATE-STPRS <= 0.

      CV_ERROR = 'X'.

      MESSAGE S001(00) WITH '### 0 #### ###. (##:' SY-TABIX ')' DISPLAY LIKE 'W'.

      EXIT.

    ENDIF.



    "[###] ###(P_BEDAT)## ### ### #

    IF GS_CREATE-PRDAT < P_BEDAT.

      CV_ERROR = 'X'.

      MESSAGE S001(00) WITH '#### ### #### ###. (##:' SY-TABIX ')' DISPLAY LIKE 'W'.

      EXIT.

    ENDIF.



    "[###] ## ### # ##### ##### ##

    IF GS_CREATE-WERKS IS NOT INITIAL.

      SELECT SINGLE WERKS INTO LV_WERKS

        FROM ZMARA_14

        WHERE MATNR = LV_MATNR_IN

          AND WERKS = GS_CREATE-WERKS.



      IF SY-SUBRC <> 0.

        CV_ERROR = 'X'.

        MESSAGE S001(00) WITH '## ### # #### ####. (##:' SY-TABIX ')' DISPLAY LIKE 'W'.

        EXIT.

      ENDIF.

    ELSE.

      CV_ERROR = 'X'.

      MESSAGE S001(00) WITH '#### #####. (##:' SY-TABIX ')' DISPLAY LIKE 'W'.

      EXIT.

    ENDIF.



    "[####] ## #### # ##### ### ##

    IF GS_CREATE-LGORT IS NOT INITIAL.

      SELECT SINGLE LGORT INTO LV_LGORT

        FROM ZMARA_14

        WHERE MATNR = LV_MATNR_IN

          AND LGORT = GS_CREATE-LGORT.



      IF SY-SUBRC <> 0.

        CV_ERROR = 'X'.

        MESSAGE S001(00) WITH '## ### # ##### ####. (##:' SY-TABIX ')' DISPLAY LIKE 'W'.

        EXIT.

      ENDIF.

    ELSE.

      CV_ERROR = 'X'.

      MESSAGE S001(00) WITH '##### #####. (##:' SY-TABIX ')' DISPLAY LIKE 'W'.

      EXIT.

    ENDIF.



    "[####]

    IF GS_CREATE-MWSKZ IS NOT INITIAL.

      CASE GS_CREATE-MWSKZ.

        WHEN 'V1' OR 'V2' OR 'V3' OR 'V4' OR 'V5'.

        WHEN OTHERS.

          CV_ERROR = 'X'.

          MESSAGE '### ##### #### ###.' TYPE 'S' DISPLAY LIKE 'W'.

          EXIT.

      ENDCASE.

    ELSE.

      CV_ERROR = 'X'.

      MESSAGE S001(00) WITH '##### #####. (##:' SY-TABIX ')' DISPLAY LIKE 'W'.

      EXIT.

    ENDIF.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH_ALV_100

*&---------------------------------------------------------------------*




FORM REFRESH_ALV_100 .



  DATA: LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GO_GRID_100->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  HANDLE_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM HANDLE_DATA_CHANGED USING P_DATA_CHANGED

                         TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.



  DATA: LS_MODI TYPE LVC_S_MODI.



  " DB ### ##

  DATA: LV_MATNR TYPE ZMARA_14-MATNR,

        LV_MAKTX TYPE ZMARA_14-MAKTX,

        LV_MEINS TYPE ZMARA_14-MEINS,

        LV_WAERS TYPE ZMARA_14-WAERS.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.



    CASE LS_MODI-FIELDNAME.

      WHEN 'MATNR'.



        CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

          EXPORTING

            INPUT  = LS_MODI-VALUE

          IMPORTING

            OUTPUT = LV_MATNR.



        CALL METHOD P_DATA_CHANGED->MODIFY_CELL

          EXPORTING

            I_ROW_ID    = LS_MODI-ROW_ID

            I_FIELDNAME = 'MATNR'

            I_VALUE     = LV_MATNR.



        SELECT SINGLE MAKTX MEINS WAERS

          INTO (LV_MAKTX, LV_MEINS, LV_WAERS)

          FROM ZMARA_14

          WHERE MATNR = LV_MATNR.



        IF SY-SUBRC = 0.

          " ###

          CALL METHOD P_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MODI-ROW_ID

              I_FIELDNAME = 'MAKTX'

              I_VALUE     = LV_MAKTX.



          " ##

          CALL METHOD P_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MODI-ROW_ID

              I_FIELDNAME = 'MEINS'

              I_VALUE     = LV_MEINS.



          " ##

          CALL METHOD P_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MODI-ROW_ID

              I_FIELDNAME = 'WAERS'

              I_VALUE     = LV_WAERS.

        ELSE.

           " ## ### ##

           CALL METHOD P_DATA_CHANGED->ADD_PROTOCOL_ENTRY

            EXPORTING

              I_MSGID     = '00'

              I_MSGTY     = 'E'

              I_MSGNO     = '001'

              I_MSGV1     = '#### ## #####.'

              I_FIELDNAME = 'MATNR'

              I_ROW_ID    = LS_MODI-ROW_ID.

        ENDIF.

    ENDCASE.



  ENDLOOP.



ENDFORM.