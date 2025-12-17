
*&---------------------------------------------------------------------*

*&  Include           ZMM15_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SCREEN_CONTROL

*&---------------------------------------------------------------------*

*       #####. ### #### ## #### ##.

*----------------------------------------------------------------------*




FORM SCREEN_CONTROL .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R2 = 'X'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '0'.

      ELSEIF P_R2 = 'X'.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT

*&---------------------------------------------------------------------*

*       ##### ### ##. #### ##. (##### ##### start-of-selection#)

*----------------------------------------------------------------------*




FORM CHECK_INPUT .

  IF P_R1 = 'X'.

    IF P_BUKRS1 = '' OR P_LIFNR1 = '' OR P_BEDAT = ''.

      MESSAGE '## ## ## #####' TYPE 'E'.

    ENDIF.

  ELSEIF P_R2 = 'X'.

    IF P_LIFNR2 = '' OR P_BUKRS2 = '' OR P_EBELN = ''.

      MESSAGE '## ## ## #####' TYPE 'E'.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_LIFNR

*&---------------------------------------------------------------------*

*       ###### ### ### ##

*----------------------------------------------------------------------*




FORM CHECK_LIFNR .

  DATA : LV_LIFNR TYPE LIFNR.



  CHECK P_R1 = 'X'. "##### ### ####

  CHECK P_LIFNR1 IS NOT INITIAL. "## ##### ####



  SELECT SINGLE LIFNR

    FROM ZLFA1_15

    INTO LV_LIFNR

    WHERE LIFNR = P_LIFNR1.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ## ######' TYPE 'E'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_CUSTOM

    EXPORTING

      CONTAINER_NAME = 'CON1'.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT = GC_CUSTOM.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.



  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT = '##'.




*  GS_FIELDCAT-OUTPUTLEN = 5.




  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT = '####'.




*  GS_FIELDCAT-OUTPUTLEN = 10.




  IF P_R1 = 'X'.

    GS_FIELDCAT-EDIT = 'X'.

  ENDIF.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-COLTEXT = '###'.




*  GS_FIELDCAT-OUTPUTLEN = 10.




  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'. "#### ##

  GS_FIELDCAT-REF_TABLE = 'ZEKPO_15'.  "## #### ### # ###..

  GS_FIELDCAT-REF_FIELD = 'MENGE'.




*  GS_FIELDCAT-OUTPUTLEN = 10.




  IF P_R1 = 'X'.

    GS_FIELDCAT-EDIT = 'X'.

  ENDIF.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT = '##'.




*  GS_FIELDCAT-OUTPUTLEN = 4.




  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'STPRS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'. "#### ##

  GS_FIELDCAT-REF_TABLE = 'ZEKPO_15'.

  GS_FIELDCAT-REF_FIELD = 'STPRS'.

  IF P_R1 = 'X'.

    GS_FIELDCAT-EDIT = 'X'.

  ENDIF.




*  GS_FIELDCAT-OUTPUTLEN = 4.




  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT = '##'.




*  GS_FIELDCAT-OUTPUTLEN = 4.




  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-COLTEXT = '####'.




*  GS_FIELDCAT-OUTPUTLEN = 4.




  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-COLTEXT = '###'.




*  GS_FIELDCAT-OUTPUTLEN = 9.




  IF P_R1 = 'X'.

    GS_FIELDCAT-EDIT = 'X'.

  ENDIF.              "##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT = '###'.




*  GS_FIELDCAT-OUTPUTLEN = 5.




  IF P_R1 = 'X'.

    GS_FIELDCAT-EDIT = 'X'.

  ENDIF.             "##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT = '####'.




*  GS_FIELDCAT-OUTPUTLEN = 5.




  IF P_R1 = 'X'.

    GS_FIELDCAT-EDIT = 'X'.

  ENDIF.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       100 ####. ## ## ### ##.

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-NO_TOOLBAR = 'X'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*




FORM CLASS_EVENT .

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED

      .



  CREATE OBJECT GO_EVENT.



  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      I_SAVE                        = 'A'

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*






FORM REFRESH .

  DATA : LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*

*       #### ### ## #### ## ##

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_ER_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_E_ONF4

                                        P_E_ONF4_BEFORE

                                        P_E_ONF4_AFTER

                                        P_E_UCOMM.



  DATA : LS_MOD_CELL TYPE LVC_S_MODI,

        LS_ZMAT TYPE ZMAT_15,

        LV_MATNR TYPE MATNR.





  LOOP AT P_ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MOD_CELL.



    CASE LS_MOD_CELL-FIELDNAME.



    "1. #### ###(### ##, ## ## ###)

      WHEN 'MATNR'.

        SELECT SINGLE * INTO LS_ZMAT

          FROM ZMAT_15

          WHERE ZMATNR = LS_MOD_CELL-VALUE.



        IF SY-SUBRC = 0.

          CALL METHOD P_ER_DATA_CHANGED->MODIFY_CELL "###

            EXPORTING I_ROW_ID = LS_MOD_CELL-ROW_ID

                      I_FIELDNAME = 'MAKTX'

                      I_VALUE = LS_ZMAT-ZMATNAME.



          CALL METHOD P_ER_DATA_CHANGED->MODIFY_CELL "##

            EXPORTING I_ROW_ID = LS_MOD_CELL-ROW_ID

                      I_FIELDNAME = 'MEINS'

                      I_VALUE = LS_ZMAT-MEINS.



          CALL METHOD P_ER_DATA_CHANGED->MODIFY_CELL "##

            EXPORTING I_ROW_ID = LS_MOD_CELL-ROW_ID

                      I_FIELDNAME = 'STPRS'

                      I_VALUE = LS_ZMAT-STPRS.

        ELSE.

          "### ## ## ## ###.

          CALL METHOD P_ER_DATA_CHANGED->ADD_PROTOCOL_ENTRY

            EXPORTING I_MSGID = '00' I_MSGTY = 'E' I_MSGNO = '001'

                      I_MSGV1 = '#### ## #####'

                      I_FIELDNAME = LS_MOD_CELL-FIELDNAME.

        ENDIF.

      WHEN 'PRDAT'.

        "2. ### ### (### ##)

        IF LS_MOD_CELL-VALUE < GV_BEDAT.

          "#### ### ### ## ## ###

          CALL METHOD P_ER_DATA_CHANGED->ADD_PROTOCOL_ENTRY

            EXPORTING I_MSGID = '00' I_MSGTY = 'E' I_MSGNO = '001'

                      I_MSGV1 = '#### ### #### ###'

                      I_FIELDNAME = LS_MOD_CELL-FIELDNAME.

        ENDIF.

      WHEN 'WERKS'.

        "3. ### ### (### ##)

        CALL METHOD P_ER_DATA_CHANGED->GET_CELL_VALUE

          EXPORTING I_ROW_ID = LS_MOD_CELL-ROW_ID

                    I_FIELDNAME = 'MATNR'

          IMPORTING E_VALUE = LV_MATNR.



        SELECT SINGLE ZMATNR

          FROM ZMAT_15

          INTO LV_MATNR

          WHERE ZMATNR = LV_MATNR AND ZWERKS = LS_MOD_CELL-VALUE.



        IF SY-SUBRC <> 0.

          CALL METHOD P_ER_DATA_CHANGED->ADD_PROTOCOL_ENTRY

            EXPORTING I_MSGID = '00' I_MSGTY = 'E' I_MSGNO = '001'

                      I_MSGV1 = '## #### ## ### ####'

                      I_FIELDNAME = LS_MOD_CELL-FIELDNAME.

        ENDIF.



      WHEN 'LGORT'.

        "4. #### ### (### ##)

        CALL METHOD P_ER_DATA_CHANGED->GET_CELL_VALUE

          EXPORTING I_ROW_ID = LS_MOD_CELL-ROW_ID

                    I_FIELDNAME = 'MATNR'

          IMPORTING E_VALUE = LV_MATNR.



        SELECT SINGLE ZMATNR

          FROM ZMAT_15

          INTO LV_MATNR

          WHERE ZMATNR = LV_MATNR AND ZLGORT = LS_MOD_CELL-VALUE.



        IF SY-SUBRC <> 0.

          CALL METHOD P_ER_DATA_CHANGED->ADD_PROTOCOL_ENTRY

            EXPORTING I_MSGID = '00' I_MSGTY = 'E' I_MSGNO = '001'

                      I_MSGV1 = '## ##### ## ### ####'

                      I_FIELDNAME = LS_MOD_CELL-FIELDNAME.

        ENDIF.

      ENDCASE.

    ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_100

*&---------------------------------------------------------------------*

*       100## ##. ###### ### ## ####(### ## ##).

*----------------------------------------------------------------------*




FORM MODIFY_100 .

  DATA : LV_LINES TYPE I.



  DESCRIBE TABLE GT_ALV LINES LV_LINES.



  LOOP AT SCREEN.

    IF P_R1 = 'X'.

      "#### 1# ## #### ## ## ##

      IF LV_LINES > 0.

        IF SCREEN-NAME = 'GV_BUKRS'

          OR SCREEN-NAME = 'GV_EKGRP'

          OR SCREEN-NAME = 'GV_EKORG'

          OR SCREEN-NAME = 'GV_LIFNR'

          OR SCREEN-NAME = 'GV_BEDAT'.

          SCREEN-INPUT = '0'. "####

          MODIFY SCREEN.

        ENDIF.

      ELSE.

        "#### ### ## ##

        IF SCREEN-NAME = 'GV_BUKRS'

          OR SCREEN-NAME = 'GV_EKGRP'

          OR SCREEN-NAME = 'GV_EKORG'

          OR SCREEN-NAME = 'GV_LIFNR'

          OR SCREEN-NAME = 'GV_BEDAT'.

          SCREEN-INPUT = '1'. "####

          MODIFY SCREEN.

        ENDIF.

      ENDIF.

    ELSEIF P_R2 = 'X'.

      SCREEN-INPUT = '0'. "## ## ##

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ADD_PO

*&---------------------------------------------------------------------*

*       ####

*----------------------------------------------------------------------*






FORM ADD_PO .

  DATA : LV_LINES TYPE I. "#### ###



  "##, #### ####

  SELECT SINGLE WAERS MWSKZ

    INTO (GV_WAERS, GV_MWSKZ)

    FROM ZLFM1_15

    WHERE LIFNR = GV_LIFNR AND EKORG = GV_EKORG.



  IF SY-SUBRC <> 0 .

    MESSAGE '## #### ## ######' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  "## ####

  DESCRIBE TABLE GT_ALV LINES LV_LINES.



  CLEAR GS_ALV.

  GS_ALV-EBELP = ( LV_LINES + 1 ) * 10.

  GS_ALV-WAERS = GV_WAERS.

  GS_ALV-MWSKZ = GV_MWSKZ.



  "####### ## # ## ##

  APPEND GS_ALV TO GT_ALV.



  PERFORM REFRESH.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_PO

*&---------------------------------------------------------------------*

*       ####

*----------------------------------------------------------------------*






FORM DELETE_PO .

  DATA : LT_ROWS TYPE LVC_T_ROW,

        LS_ROW TYPE LVC_S_ROW.



  "ALV## ### ## ### ####

  CALL METHOD GC_GRID->GET_SELECTED_ROWS

    IMPORTING

      ET_INDEX_ROWS = LT_ROWS.



  "#### ### ##

  IF LT_ROWS IS INITIAL.

    MESSAGE '### ### #####' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  "#### ###### ##(### #### ##)

  SORT LT_ROWS BY INDEX DESCENDING.



  "### ### ##

  LOOP AT LT_ROWS INTO LS_ROW.

    DELETE GT_ALV INDEX LS_ROW-INDEX.

  ENDLOOP.



  "#### ###

  LOOP AT GT_ALV ASSIGNING FIELD-SYMBOL(<LS_ALV>).

    <LS_ALV>-EBELP = SY-TABIX * 10.

  ENDLOOP.



  "####

  PERFORM REFRESH.



  "###

  MESSAGE '### ### #######' TYPE 'S'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_PO

*&---------------------------------------------------------------------*

*       PO##

*----------------------------------------------------------------------*




FORM SAVE_PO .

  DATA : LV_EBELN TYPE ZEKPO_15-EBELN,

        LS_EKKO TYPE ZEKKO_15,

        LS_EKPO TYPE ZEKPO_15,

        LT_EKPO TYPE TABLE OF ZEKPO_15.



  "#### ### ## ### #### ## ##(### # ## # ##### ## ####)

  CALL METHOD GC_GRID->CHECK_CHANGED_DATA.



  "### ##

  "#### ### ### ## ##

  IF GT_ALV IS INITIAL.

    MESSAGE '### #### ####' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  "PO## ## (SNRO #### ##)

  SELECT SINGLE MAX( EBELN )

    INTO LV_EBELN

    FROM ZEKPO_15.



  IF LV_EBELN IS INITIAL.

    LV_EBELN = '4500000001'.

  ELSE.

    LV_EBELN = LV_EBELN + 1.

  ENDIF.



  "DB## ##

  CLEAR LS_EKKO.

  LS_EKKO-EBELN = LV_EBELN.

  LS_EKKO-BUKRS = GV_BUKRS.

  LS_EKKO-EKGRP = GV_EKGRP.

  LS_EKKO-EKORG = GV_EKORG.

  LS_EKKO-LIFNR = GV_LIFNR.

  LS_EKKO-BEDAT = GV_BEDAT.

  LS_EKKO-WAERS = GV_WAERS.



  REFRESH LT_EKPO.



  LOOP AT GT_ALV INTO GS_ALV.

    CLEAR LS_EKPO.



    MOVE-CORRESPONDING GS_ALV TO LS_EKPO.



    LS_EKPO-EBELN = LV_EBELN.

    LS_EKPO-EBELP = GS_ALV-EBELP.

    LS_EKPO-WEMNG = '0'. "#### ##### # ### 0



    APPEND LS_EKPO TO LT_EKPO.

  ENDLOOP.



  "####

  INSERT ZEKKO_15 FROM LS_EKKO.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ## # ## ##' TYPE 'E'.

    EXIT.

  ENDIF.



  "### ##

  INSERT ZEKPO_15 FROM TABLE LT_EKPO.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '### ## # ## ##' TYPE 'E'.

    EXIT.

  ENDIF.



  "####

  COMMIT WORK AND WAIT.

  MESSAGE |#### { LV_EBELN }## #######| TYPE 'S'.



  "## ###

  PERFORM CLEAR_ALL.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLEAR_ALL

*&---------------------------------------------------------------------*




FORM CLEAR_ALL .

  "### ###

  CLEAR : GV_BUKRS, GV_EKGRP, GV_EKORG, GV_LIFNR, GV_BEDAT, GV_WAERS.

  CLEAR : GT_ALV, GS_ALV.



  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       ### ###

*----------------------------------------------------------------------*




FORM GET_DATA .



  "##### ##

  SELECT SINGLE BUKRS EKGRP EKORG LIFNR BEDAT

    INTO (GV_BUKRS, GV_EKGRP, GV_EKORG, GV_LIFNR, GV_BEDAT)

    FROM ZEKKO_15

    WHERE EBELN = P_EBELN.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ## PO#####' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  "### ### ##

  SELECT *

    INTO CORRESPONDING FIELDS OF TABLE GT_ALV

    FROM ZEKPO_15

    WHERE EBELN = P_EBELN.



  "## #### ####

   SELECT SINGLE WAERS MWSKZ

    INTO (GV_WAERS, GV_MWSKZ)

    FROM ZLFM1_15

    WHERE LIFNR = GV_LIFNR AND EKORG = GV_EKORG.



    LOOP AT GT_ALV ASSIGNING FIELD-SYMBOL(<LS_ALV>).

      <LS_ALV>-WAERS = GV_WAERS.

      <LS_ALV>-MWSKZ = GV_MWSKZ.

    ENDLOOP.



ENDFORM.