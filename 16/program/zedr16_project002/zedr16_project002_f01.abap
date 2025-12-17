
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PROJECT002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  INIT_PARAMETER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INIT_PARAMETER .



  IF P_CRE = 'X'.



    IF P_BUKRS1 IS INITIAL OR P_LIFNR1 IS INITIAL OR P_BEDAT IS INITIAL.

      MESSAGE I000.

      STOP.

    ENDIF.



  ELSEIF P_DIS = 'X'.



    IF P_BUKRS2 IS INITIAL OR P_LIFNR2 IS INITIAL OR P_EBELN IS INITIAL.

      MESSAGE I000.

      STOP.

    ENDIF.



  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_LIFNR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_LIFNR .



  " ZEDT16_LFA1 : #####

  " LIFNR : #####

  " NAME1 : ####

  " LAND1 : ###

  " KTOKK : #####

  " STCD1 : ####

  " STCD2 : #####

  " STRAS : ##



  " ZEDT16_LFB1 : #######

  " LIFNR : #####

  " BUKRS : ####

  " LOEVM : #####

  " AKONT : ##

  " ZTERM : ####



  " ZEDT16_LFM1 : #######

  " LIFNR : #####

  " EKORG : ####

  " EKGRP : ####

  " LOEVM : #####

  " WAERS : ######

  " MWSKZ : ####






*  DATA : BEGIN OF GS_HEADER,

*         EBELN TYPE ZEDT16_EKKO-EBELN, " ######

*         BUKRS TYPE ZEDT16_EKKO-BUKRS, " #### B1

*         EKGRP TYPE ZEDT16_EKKO-EKGRP, " #### M1

*         EKORG TYPE ZEDT16_EKKO-EKORG, " #### M1

*         LIFNR TYPE ZEDT16_EKKO-LIFNR, " ### A1

*         BEDAT TYPE ZEDT16_EKKO-BEDAT, " ###

*         WAERS TYPE ZEDT16_EKKO-WAERS, " ## M1

*       END OF GS_HEADER.

*DATA : GT_HEADER LIKE TABLE OF GS_HEADER.



*PARAMETERS : P_BUKRS1 TYPE ZEDT16_EKKO-BUKRS MODIF ID MD1,

*             P_LIFNR1 TYPE ZEDT16_EKKO-LIFNR MODIF ID MD1,

*             P_BEDAT  TYPE ZEDT16_EKKO-BEDAT MODIF ID MD1.






  " 1. #### ###(LFM1) ## ## ##

  " #### GS_LFM1# #### ## ######.

  CLEAR GS_LFM1.



  " ZEDT16_LFM1 ##### ### ### #### #### ## ### GS_LFM1# ####.

  SELECT SINGLE * INTO GS_LFM1

    FROM ZEDT16_LFM1

   WHERE LIFNR = P_LIFNR1.



  IF SY-SUBRC <> 0.

    " #### ### ## ###(E Type)# ## ##### #####.




*    MESSAGE '#### ###(LFM1)# #### ## ### #####.' TYPE 'E'.




    MESSAGE I001.

    STOP.

  ENDIF.





  " 2. #### ###(LFB1) ## ## ## -> ## #### # ####

  " #### GS_LFB1# #### ## ######.




*  CLEAR GS_LFB1.

*

*  " ZEDT16_LFB1 ##### #### ##### #### ## ### GS_LFB1# ####.

*  SELECT SINGLE * INTO GS_LFB1

*    FROM ZEDT16_LFB1

*   WHERE LIFNR = P_LIFNR1

*     AND BUKRS = P_BUKRS1.

*

*  IF SY-SUBRC <> 0.

*    " #### ### ## ###(E Type)# ## ##### #####.

**    MESSAGE '## ####(LFB1)# #### ## ######.' TYPE 'E'.

*    MESSAGE I001.

*    STOP.

*  ENDIF.








  " 3. GS_HEADER #### ### ##

  " ### ####### ## #### #####.

  CLEAR GS_HEADER.



  " 3-1. ### ###(Parameter) ##

  GS_HEADER-LIFNR = P_LIFNR1.

  GS_HEADER-BUKRS = P_BUKRS1.

  GS_HEADER-BEDAT = P_BEDAT.



  " 3-2. LFM1 ## ### ##

  " (## 1# #### GS_LFM1# ## #### ###### ### #####)

  GS_HEADER-EKORG = GS_LFM1-EKORG.

  GS_HEADER-EKGRP = GS_LFM1-EKGRP.

  GS_HEADER-WAERS = GS_LFM1-WAERS.



  CLEAR GS_ITEM.

  CLEAR GT_ITEM.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .



  CREATE OBJECT GC_CUSTOM

    EXPORTING




*     PARENT         =




      CONTAINER_NAME = 'CC_ALV'




*     STYLE          =

*     LIFETIME       = lifetime_default

*     REPID          =

*     DYNNR          =

*     NO_AUTODEF_PROGID_DYNNR     =

*    EXCEPTIONS

*     CNTL_ERROR     = 1

*     CNTL_SYSTEM_ERROR           = 2

*     CREATE_ERROR   = 3

*     LIFETIME_ERROR = 4

*     LIFETIME_DYNPRO_DYNPRO_LINK = 5

*     OTHERS         = 6




    .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT GC_GRID

    EXPORTING




*     I_SHELLSTYLE      = 0

*     I_LIFETIME        =




      I_PARENT = GC_CUSTOM




*     I_APPL_EVENTS     = space

*     I_PARENTDBG       =

*     I_APPLOGPARENT    =

*     I_GRAPHICSPARENT  =

*     I_NAME   =

*     I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*     ERROR_CNTL_CREATE = 1

*     ERROR_CNTL_INIT   = 2

*     ERROR_CNTL_LINK   = 3

*     ERROR_DP_CREATE   = 4

*     OTHERS   = 5




    .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




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



  " ##### ## # : ##, ##, ####



  DATA : LV_EDIT TYPE CHAR1.



  " 1. ## ## ## ##

  IF P_CRE = 'X'.

    LV_EDIT = 'X'.

  ELSE.

    LV_EDIT = ' '.

  ENDIF.



  CLEAR : GT_FIELDCAT, GS_FIELDCAT.



  " ====================================================================

  " ## #### ## (PERFORM ##)

  " ##: ##, ####, ###, PO##, ##, ##, ##, ####, ###, ###, ####

  " ====================================================================



  " 0. ## ### (ICON) - # ## ##

  IF P_CRE = 'X'.

    CLEAR GS_FIELDCAT.

    GS_FIELDCAT-FIELDNAME = 'ICON'.

    GS_FIELDCAT-COLTEXT   = '### ##'.

    GS_FIELDCAT-EDIT      = ' '.    " #### ## ##

    GS_FIELDCAT-KEY       = 'X'.    " ##

    GS_FIELDCAT-JUST      = 'C'.

    GS_FIELDCAT-OUTPUTLEN = 10.      " ### ##

    GS_FIELDCAT-ICON      = 'X'.    " # ### ##### ## [##!]

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.

  " PERFORM FILL_FIELDCAT USING [###] [###] [####] [###].



  " 1. ## (EBELP) - # ##, ## ##

  PERFORM FILL_FIELDCAT USING 'EBELP' '##'     ' '      'X'.



  " 2. #### (MATNR)

  PERFORM FILL_FIELDCAT USING 'MATNR' '####' LV_EDIT  ' '.



  " 3. ### (MAKTX)

  PERFORM FILL_FIELDCAT USING 'MAKTX' '###'   LV_EDIT  ' '.



  " 4. PO## (MENGE) - ## ## ### ## FORM## ##

  PERFORM FILL_FIELDCAT USING 'MENGE' 'PO##'   LV_EDIT  ' '.



  " 5. ## (BPRME) - ## ## ### ## FORM## ##

  PERFORM FILL_FIELDCAT USING 'BPRME' '##'     LV_EDIT  ' '.



  " 6. ## (MEINS)

  PERFORM FILL_FIELDCAT USING 'MEINS' '##'     LV_EDIT  ' '.



  " 7. ## (WAERS)

  PERFORM FILL_FIELDCAT USING 'WAERS' '##'     ' '      ' '.



  " 8. #### (MWSKZ)

  PERFORM FILL_FIELDCAT USING 'MWSKZ' '####' ' '      ' '.



  " 9. ### (PRDAT)

  PERFORM FILL_FIELDCAT USING 'PRDAT' '###'   LV_EDIT  ' '.



  " 10. ### (WERKS)

  PERFORM FILL_FIELDCAT USING 'WERKS' '###'   LV_EDIT  ' '.



  " 11. #### (LGORT)

  PERFORM FILL_FIELDCAT USING 'LGORT' '####' LV_EDIT  ' '.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT .



  " 1. ### ## ##(Receiver) ##

  " ## #### ### ## # ## (## ## ##)

  IF GO_EVENT_RECEIVER IS INITIAL.

    CREATE OBJECT GO_EVENT_RECEIVER.

  ENDIF.



  " 2. ### ### ##

  " LCL_EVENT_RECEIVER# HANDLE_DATA_CHANGED #### GC_GRID# #### ##

  SET HANDLER GO_EVENT_RECEIVER->HANDLE_DATA_CHANGED FOR GC_GRID.



  " 3. ## ### ## (## ##!)

  " # ### ### ### ## DATA_CHANGED #### ## #### ####.



  " 3-1. ##(Enter) ## ### # ### ##

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_ENTER.



  " 3-2. (####) ### ## # ### ## ### #### ## ###### ## ## ##

  " CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

  "   EXPORTING

  "     I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FILL_FIELDCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_0145   text

*      -->P_0146   text

*      -->P_0147   text

*      -->P_0148   text

*----------------------------------------------------------------------*




FORM FILL_FIELDCAT USING P_FNAME TYPE C

                         P_TEXT  TYPE C

                         P_EDIT  TYPE C

                         P_KEY   TYPE C.



  CLEAR GS_FIELDCAT.



  GS_FIELDCAT-FIELDNAME = P_FNAME.

  GS_FIELDCAT-COLTEXT   = P_TEXT.

  GS_FIELDCAT-EDIT      = P_EDIT.

  GS_FIELDCAT-KEY       = P_KEY.

  GS_FIELDCAT-JUST      = 'C'.



  CASE P_FNAME.

    WHEN 'MENGE'.

      GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKPO'.

      GS_FIELDCAT-REF_FIELD = 'MENGE'.

      GS_FIELDCAT-QFIELDNAME = 'MEINS'.

    WHEN 'EBELP'.

      GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKPO'.

      GS_FIELDCAT-REF_FIELD = 'EBELP'.

      GS_FIELDCAT-OUTPUTLEN = 5.

    WHEN 'BPRME'.

      GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKPO'.

      GS_FIELDCAT-REF_FIELD = 'BPRME'.

      GS_FIELDCAT-DATATYPE = 'CURR'.

    WHEN 'PRDAT'.

      GS_FIELDCAT-DATATYPE = 'DATS'.

  ENDCASE.



  APPEND GS_FIELDCAT TO GT_FIELDCAT.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV .



  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT      = GS_VARIANT

      I_SAVE          = 'A'

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_ITEM

      IT_FIELDCATALOG = GT_FIELDCAT




*     IT_SORT         = GT_SORT




    .



  CALL METHOD GC_GRID->SET_READY_FOR_INPUT

    EXPORTING

      I_READY_FOR_INPUT = 1.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH .



  DATA : LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE




*     I_SOFT_REFRESH =

*    EXCEPTIONS

*     FINISHED  = 1

*     OTHERS    = 2




    .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ADD_BUTTON

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ADD_BUTTON .



  DATA : LV_NEW_EBELP TYPE ZEDT16_EKPO-EBELP,

         LV_ICON      TYPE ICON_D.



  " 1. ## ## ## #### ## (## # ### # ## ###)

  SORT GT_ITEM BY EBELP DESCENDING.



  " 2. # ##(## # ##) ## ##

  READ TABLE GT_ITEM INTO GS_ITEM INDEX 1.



  IF SY-SUBRC = 0.

    " #### ## ##: ## # ## + 10

    LV_NEW_EBELP = GS_ITEM-EBELP + 10.

  ELSE.

    " #### ## ##(# ##): ### 10 ##

    LV_NEW_EBELP = '10'.

  ENDIF.



  " 3. ## ### ## ## #### ## (10, 20, 30...)

  SORT GT_ITEM BY EBELP ASCENDING.



  " 4. ### ## # ##

  CLEAR GS_ITEM.

  GS_ITEM-EBELP = LV_NEW_EBELP. " ### ## ##



  " ### ##(GS_HEADER)## ###

  GS_ITEM-WAERS = GS_HEADER-WAERS.



  " ##### #######(GS_LFM1)## ### (CHECK_LIFNR## #### ####)

  GS_ITEM-MWSKZ = GS_LFM1-MWSKZ.

  " -----------------------------------------------------------



  " [##] #### ## ### ## ##

  PERFORM CHECK_VALIDITY USING GS_ITEM

                                 ' '       " <--- ### ##

                        CHANGING LV_ICON.

  GS_ITEM-ICON = LV_ICON.



  APPEND GS_ITEM TO GT_ITEM.



  " 5. ## ##

  PERFORM REFRESH.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REMOVE_BUTTON

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REMOVE_BUTTON .



  DATA : LT_ROWS TYPE LVC_T_ROW, " ### ## ### ###

         LS_ROW  TYPE LVC_S_ROW.



  " 1. ALV ###(GC_GRID)## ### # ## ####

  CALL METHOD GC_GRID->GET_SELECTED_ROWS

    IMPORTING

      ET_INDEX_ROWS = LT_ROWS.



  " 2. ### ## ## ## ### ##

  IF LT_ROWS IS INITIAL.

    MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  " 3. ### ##

  " [##] #### ### ### ####(# ## -> ## ##) ## # #### #

  SORT LT_ROWS BY INDEX DESCENDING.



  LOOP AT LT_ROWS INTO LS_ROW.

    " ### #### #### GT_ITEM ### ##

    DELETE GT_ITEM INDEX LS_ROW-INDEX.

  ENDLOOP.



  " 4. ALV #### (##### FORM ##)

  PERFORM REFRESH.



  " 5. ## ###

  MESSAGE '### ### #######.' TYPE 'S'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_BUTTON

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_BUTTON.



  " DB ### ## ## ##

  DATA: LS_EKKO TYPE ZEDT16_EKKO.

  DATA: LT_EKPO TYPE TABLE OF ZEDT16_EKPO,

        LS_EKPO TYPE ZEDT16_EKPO.



  DATA: LV_MAX_EBELN TYPE ZEDT16_EKKO-EBELN,

        LV_NEW_EBELN TYPE ZEDT16_EKKO-EBELN.



  DATA: LV_ANSWER TYPE CHAR1.



  " [##] ### #### ## ##

  DATA: LV_MSG_TEXT TYPE STRING.



  " ---------------------------------------------------------

  " 0. ### ## ##

  " ---------------------------------------------------------

  IF GT_ITEM IS INITIAL.

    MESSAGE '### ## #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  " ---------------------------------------------------------

  " 1. ## ## ## (## ##)

  " ---------------------------------------------------------

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR              = '## ##'

      TEXT_QUESTION         = '##### ########?'

      TEXT_BUTTON_1         = '#'

      ICON_BUTTON_1         = 'ICON_CHECKED'

      TEXT_BUTTON_2         = '###'

      ICON_BUTTON_2         = 'ICON_CANCEL'

      DISPLAY_CANCEL_BUTTON = ' '

    IMPORTING

      ANSWER                = LV_ANSWER

    EXCEPTIONS

      TEXT_NOT_FOUND        = 1

      OTHERS                = 2.



  IF LV_ANSWER <> '1'.

    MESSAGE '### #######.' TYPE 'S'.

    EXIT.

  ENDIF.



  " ---------------------------------------------------------

  " 2. ### ## (### ##)

  " ---------------------------------------------------------

  READ TABLE GT_ITEM TRANSPORTING NO FIELDS WITH KEY ICON = ICON_RED_LIGHT.



  IF SY-SUBRC = 0.

    MESSAGE '##(###) ### ### ## ### # ####. #### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  " =========================================================

  " 3. ## ## ##

  " =========================================================



  " 3-1. ##

  SELECT SINGLE MAX( EBELN ) INTO LV_MAX_EBELN

    FROM ZEDT16_EKKO.



  IF LV_MAX_EBELN IS INITIAL.

    LV_NEW_EBELN = '4500000001'.

  ELSE.

    LV_NEW_EBELN = LV_MAX_EBELN + 1.

  ENDIF.



  " 3-2. ## ##

  CLEAR LS_EKKO.

  MOVE-CORRESPONDING GS_HEADER TO LS_EKKO.

  LS_EKKO-EBELN = LV_NEW_EBELN.



  " 3-3. ### ##

  CLEAR LT_EKPO.

  LOOP AT GT_ITEM INTO GS_ITEM.

    CLEAR LS_EKPO.

    MOVE-CORRESPONDING GS_ITEM TO LS_EKPO.

    LS_EKPO-EBELN = LV_NEW_EBELN.

    LS_EKPO-MANDT = SY-MANDT.

    APPEND LS_EKPO TO LT_EKPO.

  ENDLOOP.



  " 3-4. DB ##

  INSERT ZEDT16_EKKO FROM LS_EKKO.



  IF SY-SUBRC = 0.

    INSERT ZEDT16_EKPO FROM TABLE LT_EKPO.



    IF SY-SUBRC = 0.

      COMMIT WORK AND WAIT.



      " =========================================================

      " [##] ## ### ## # ## ###

      " =========================================================



      " 1. ### ### ## (### + ##)

      CONCATENATE '##### #######. ######:' LV_NEW_EBELN

             INTO LV_MSG_TEXT SEPARATED BY SPACE.



      " 2. ## ### ## (TYPE 'S')

      " TYPE 'S'# #### ## ### ###,

      " ### ## ##(Selection Screen #)# ## #### #### #####.

      MESSAGE LV_MSG_TEXT TYPE 'S'.



      " 3. ### ### (### ##)

      CLEAR : GS_HEADER, GS_ITEM.

      REFRESH : GT_ITEM.



      " 4. ## 100# ##### (## #### ##)

      LEAVE TO SCREEN 0.



    ELSE.

      ROLLBACK WORK.

      MESSAGE '## ### ## # ### ######.' TYPE 'E'.

    ENDIF.



  ELSE.

    ROLLBACK WORK.

    MESSAGE '## ### ## # ### ######.' TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_ALV_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*----------------------------------------------------------------------*




FORM CHECK_ALV_DATA_CHANGED USING ER_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.



  DATA : LS_MOD_CELL TYPE LVC_S_MODI,

         LS_ITEM     LIKE LINE OF GT_ITEM,

         LV_ICON     TYPE ICON_D.



  " [##] 10## ## ### ## ## ## ##

  DATA : LV_MATNR_10(10) TYPE C.



  LOOP AT ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MOD_CELL.



    READ TABLE GT_ITEM INTO LS_ITEM INDEX LS_MOD_CELL-ROW_ID.

    IF SY-SUBRC <> 0.

      CONTINUE.

    ENDIF.



    CASE LS_MOD_CELL-FIELDNAME.

      WHEN 'MATNR'.

        " -----------------------------------------------------------

        " 10## ## ### #### UNPACK ##

        " -----------------------------------------------------------

        UNPACK LS_MOD_CELL-VALUE TO LV_MATNR_10.

        LS_ITEM-MATNR = LV_MATNR_10.



        " -----------------------------------------------------------

        " #####(ZEDT16_200)## ## ## ###

        " -----------------------------------------------------------

        " ##: ZMATNR = ### ####(10##)

        SELECT SINGLE ZMATNAME STPRS MEINS WERKS LGORT

          INTO (LS_ITEM-MAKTX, LS_ITEM-BPRME, LS_ITEM-MEINS, LS_ITEM-WERKS, LS_ITEM-LGORT)

          FROM ZEDT16_200

          WHERE ZMATNR = LV_MATNR_10.



        IF SY-SUBRC = 0.

          " #### #### ##(ALV Grid)# ## ### ## ##### #



          " 1. ### (MAKTX) ##

          CALL METHOD ER_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MOD_CELL-ROW_ID

              I_FIELDNAME = 'MAKTX'

              I_VALUE     = LS_ITEM-MAKTX.



          " 2. ## (BPRME <- STPRS) ##

          CALL METHOD ER_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MOD_CELL-ROW_ID

              I_FIELDNAME = 'BPRME'

              I_VALUE     = LS_ITEM-BPRME.



          " 3. ## (MEINS) ## (DB# ## ### MEINS## ##)

          CALL METHOD ER_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MOD_CELL-ROW_ID

              I_FIELDNAME = 'MEINS'

              I_VALUE     = LS_ITEM-MEINS.



          " 4. ### (WERKS) ##

          CALL METHOD ER_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MOD_CELL-ROW_ID

              I_FIELDNAME = 'WERKS'

              I_VALUE     = LS_ITEM-WERKS.



          " 5. #### (LGORT) ##

          CALL METHOD ER_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MOD_CELL-ROW_ID

              I_FIELDNAME = 'LGORT'

              I_VALUE     = LS_ITEM-LGORT.

        ELSE.

          " (####) ## ### ## ##, ## ## ### ###### ## ## ##

          " CLEAR: LS_ITEM-MAKTX, LS_ITEM-BPRME, LS_ITEM-MEINS, LS_ITEM-WERKS, LS_ITEM-LGORT.

          " ## #### MODIFY_CELL# # ## #### #### ###.

        ENDIF.



      WHEN 'PRDAT'.

        LS_ITEM-PRDAT = LS_MOD_CELL-VALUE.

      WHEN 'WERKS'.

        LS_ITEM-WERKS = LS_MOD_CELL-VALUE.

      WHEN 'LGORT'.

        LS_ITEM-LGORT = LS_MOD_CELL-VALUE.

    ENDCASE.



    " -----------------------------------------------------------

    " [## ## ##] ## ## ## # ### ##

    " -----------------------------------------------------------

    PERFORM CHECK_VALIDITY USING LS_ITEM

                                 'X'

                           CHANGING LV_ICON.



    " ### ##

    CALL METHOD ER_DATA_CHANGED->MODIFY_CELL

      EXPORTING

        I_ROW_ID    = LS_MOD_CELL-ROW_ID

        I_FIELDNAME = 'ICON'

        I_VALUE     = LV_ICON.



    IF LS_MOD_CELL-FIELDNAME = 'MATNR'.

      CALL METHOD ER_DATA_CHANGED->MODIFY_CELL

        EXPORTING

          I_ROW_ID    = LS_MOD_CELL-ROW_ID

          I_FIELDNAME = 'MATNR'

          I_VALUE     = LS_ITEM-MATNR. " 0000000007

    ENDIF.



    " GT_ITEM ###

    MODIFY GT_ITEM FROM LS_ITEM INDEX LS_MOD_CELL-ROW_ID.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_VALIDITY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_LS_ITEM  text

*      <--P_LV_ICON  text

*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CHECK_VALIDITY

*&---------------------------------------------------------------------*




FORM CHECK_VALIDITY USING PS_ITEM    LIKE GS_ITEM

                          P_SHOW_MSG TYPE CHAR1

                 CHANGING PV_ICON    TYPE ICON_D.



  DATA : LS_MARA LIKE GS_MARA.



  " ## ##: ### (##)

  PV_ICON = ICON_RED_LIGHT.



  " ---------------------------------------------------------

  " 1. #### ## ##

  " ---------------------------------------------------------

  IF PS_ITEM-MATNR IS INITIAL.

    IF P_SHOW_MSG = 'X'.

      MESSAGE '##### #### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    ENDIF.

    RETURN. " ##

  ENDIF.



  " ---------------------------------------------------------

  " 2. ##### ## ## (ZEDT16_200)

  " ---------------------------------------------------------

  SELECT SINGLE * INTO LS_MARA

    FROM ZEDT16_200

   WHERE ZMATNR = PS_ITEM-MATNR.



  IF SY-SUBRC <> 0.

    IF P_SHOW_MSG = 'X'.

      MESSAGE '#### ## #######.' TYPE 'S' DISPLAY LIKE 'E'.

    ENDIF.

    RETURN. " ##

  ENDIF.



  " ---------------------------------------------------------

  " 3. ### ## (### P_BEDAT ## ### ## #)

  " ---------------------------------------------------------

  IF PS_ITEM-PRDAT < P_BEDAT.

    IF P_SHOW_MSG = 'X'.

      MESSAGE '#### #### ### #### ###.' TYPE 'S' DISPLAY LIKE 'E'.

    ENDIF.

    RETURN. " ##

  ENDIF.



  " ---------------------------------------------------------

  " 4. ###, #### ### ##

  " ---------------------------------------------------------

  IF PS_ITEM-WERKS <> LS_MARA-WERKS.

    IF P_SHOW_MSG = 'X'.

      MESSAGE '### ### ###### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    ENDIF.

    RETURN. " ##

  ENDIF.



  IF PS_ITEM-LGORT <> LS_MARA-LGORT.

    IF P_SHOW_MSG = 'X'.

      MESSAGE '#### ### ###### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    ENDIF.

    RETURN. " ##

  ENDIF.







  " ---------------------------------------------------------

  " ## ## ## # ###

  " ---------------------------------------------------------

  PV_ICON = ICON_GREEN_LIGHT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .



  CLEAR : GS_HEADER, GS_ITEM.

  REFRESH : GT_ITEM.



  DATA : LV_MWSKZ TYPE ZEDT16_LFM1-MWSKZ.






*  " -----------------------------------------------------------------------

*  " 1. ### ## (Conversion Exit)

*  " -----------------------------------------------------------------------

*  " #### '1'# #### '0000000001'# #### DB ## #### #

*  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

*    EXPORTING

*      INPUT  = P_EBELN

*    IMPORTING

*      OUTPUT = P_EBELN.






  " -----------------------------------------------------------------------

  " 2. ## ### ## (ZEDT16_EKKO)

  " -----------------------------------------------------------------------

  " #### ###, ####, ####### ## #### # ##

  SELECT SINGLE * INTO CORRESPONDING FIELDS OF GS_HEADER

    FROM ZEDT16_EKKO

   WHERE EBELN = P_EBELN

     AND LIFNR = P_LIFNR2

     AND BUKRS = P_BUKRS2.



  IF SY-SUBRC <> 0.

    " #### ### ## ### ## # ## #### ## (STOP)

    MESSAGE '### #### #### ## ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  " -----------------------------------------------------------------------

  " 3. ### ### ## (ZEDT16_EKPO)

  " -----------------------------------------------------------------------

  " ### ##### ## EBELN## ## ##

  SELECT * INTO CORRESPONDING FIELDS OF TABLE GT_ITEM

    FROM ZEDT16_EKPO

   WHERE EBELN = P_EBELN.



  IF SY-SUBRC <> 0.

    " ### ### ### ## ## (### ### #)

    MESSAGE '### #### #### ## ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  CLEAR LV_MWSKZ.



  SELECT SINGLE MWSKZ INTO LV_MWSKZ

    FROM ZEDT16_LFM1

   WHERE LIFNR = P_LIFNR2.



  " -----------------------------------------------------------------------

  " 4. ## ### ## ### ## (Loop)

  " -----------------------------------------------------------------------

  " DB## ##(WAERS)# ###(ICON) ### ## # #### #####.

  LOOP AT GT_ITEM INTO GS_ITEM.



    " 4-1. ## ### #### #### ## (## ###)

    GS_ITEM-WAERS = GS_HEADER-WAERS.



    GS_ITEM-MWSKZ = LV_MWSKZ.



    " ### ### ### #### ##

    MODIFY GT_ITEM FROM GS_ITEM.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_INIT .



  P_BUKRS1 = '1000'.

  P_LIFNR1 = '1000000005'.

  P_BEDAT = '20240501'.



  P_BUKRS2 = '1000'.

  P_LIFNR2 = '1000000005'.

  P_EBELN = '4500000001'.



ENDFORM.