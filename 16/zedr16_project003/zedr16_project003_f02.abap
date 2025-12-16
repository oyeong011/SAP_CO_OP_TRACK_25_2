
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PROJECT003_F02

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT_DATA_DIS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INPUT_DATA_DIS .






*PARAMETERS : P_EBELN2 TYPE ZEDT16_EKKO-EBELN MODIF ID MD2,

*             P_WERKS2 TYPE ZEDT16_EKPO-WERKS MODIF ID MD2.






  DATA : LV_MBLNR TYPE ZEDT16_MSEG-MBLNR,

         LV_MJAHR TYPE ZEDT16_MSEG-MJAHR.



  " 1. #### ##(P_EBELN2) ## ##

  IF P_EBELN2 IS INITIAL.

    MESSAGE '### #### ### ######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  " 2. [##] ###(P_WERKS2) ## ## ##

  IF P_WERKS2 IS INITIAL.

    MESSAGE '### #### ######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  " 3. ZEDT16_MSEG(###) ### ## ## ##

  "    (# # ###### IF ## ## #### ## AND ##)

  CLEAR: LV_MBLNR, LV_MJAHR.



  SELECT SINGLE MBLNR MJAHR

    INTO (LV_MBLNR, LV_MJAHR)

    FROM ZEDT16_MSEG

    WHERE EBELN = P_EBELN2

      AND WERKS = P_WERKS2.



  IF SY-SUBRC <> 0.

    MESSAGE '### ## ## ##(MSEG)# #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  " 4. ##(MKPF) ### ## (## ##)

  SELECT SINGLE MBLNR

    INTO LV_MBLNR

    FROM ZEDT16_MKPF

    WHERE MBLNR = LV_MBLNR

      AND MJAHR = LV_MJAHR.



  IF SY-SUBRC <> 0.

    MESSAGE '## ## ##(MKPF) ### ## # ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_DIS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA_DIS .



  " 1. ###

  REFRESH : GT_MSEG, GT_ALV_DIS.

  CLEAR   : GS_MKPF, GS_MSEG, GS_ALV_DIS.



  " 2. ## ###(ZEDT16_MSEG) ##

  IF P_WERKS2 IS NOT INITIAL.

    SELECT *

      INTO TABLE GT_MSEG

      FROM ZEDT16_MSEG

      WHERE EBELN = P_EBELN2

        AND WERKS = P_WERKS2.

  ELSE.

    SELECT *

      INTO TABLE GT_MSEG

      FROM ZEDT16_MSEG

      WHERE EBELN = P_EBELN2.

  ENDIF.



  IF GT_MSEG[] IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  " 3. ## ### ## ## ## # ALV ### ##

  LOOP AT GT_MSEG INTO GS_MSEG.



    CLEAR : GS_MKPF, GS_ALV_DIS.



    " (1) ## ###(MSEG)# #### ##(MKPF) ##

    SELECT SINGLE *

      INTO GS_MKPF

      FROM ZEDT16_MKPF

      WHERE MBLNR = GS_MSEG-MBLNR

        AND MJAHR = GS_MSEG-MJAHR.



    " ### ### #### ALV# ##

    IF SY-SUBRC = 0.



      " --- [## ## ##] ---

      GS_ALV_DIS-MBLNR = GS_MKPF-MBLNR. " ######

      GS_ALV_DIS-MJAHR = GS_MKPF-MJAHR. " ####

      GS_ALV_DIS-BLART = GS_MKPF-BLART. " ####

      GS_ALV_DIS-BLDAT = GS_MKPF-BLDAT. " ###

      GS_ALV_DIS-BUDAT = GS_MKPF-BUDAT. " ###



      " --- [### ## ##] ---

      GS_ALV_DIS-ZEILE = GS_MSEG-ZEILE. " #####

      GS_ALV_DIS-MATNR = GS_MSEG-MATNR. " ####

      GS_ALV_DIS-WERKS = GS_MSEG-WERKS. " ###

      GS_ALV_DIS-LGORT = GS_MSEG-LGORT. " ####

      GS_ALV_DIS-LIFNR = GS_MSEG-LIFNR. " #####

      GS_ALV_DIS-WAERS = GS_MSEG-WAERS. " ###

      GS_ALV_DIS-MENGE = GS_MSEG-MENGE. " ##

      GS_ALV_DIS-MEINS = GS_MSEG-MEINS. " ##

      GS_ALV_DIS-EBELN = GS_MSEG-EBELN. " ######

      GS_ALV_DIS-BUKRS = GS_MSEG-BUKRS. " ####

      GS_ALV_DIS-GJAHR = GS_MSEG-GJAHR. " ####

      GS_ALV_DIS-BELNR = GS_MSEG-BELNR. " ####

      GS_ALV_DIS-SHKZG = GS_MSEG-SHKZG. " ###

      GS_ALV_DIS-DMBTR = GS_MSEG-DMBTR. " ##



      " ALV #### ##

      APPEND GS_ALV_DIS TO GT_ALV_DIS.



    ENDIF.



  ENDLOOP.



  " 4. ## ## ## (####, #### #)

  SORT GT_ALV_DIS BY MBLNR ZEILE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT_200 .



  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID     = SY-REPID

      DYNNR     = '0200'

      SIDE      = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_LEFT

      EXTENSION = 3000. " ## #### ### ## ##



  " 2. ### ## (### ## ####)

  CREATE OBJECT GC_GRID_200

    EXPORTING

      I_PARENT = GC_DOCKING.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_200 .



  DATA : LV_POS TYPE I.



  CLEAR : GS_FIELDCAT, GT_FIELDCAT, LV_POS.



  " 1. MBLNR : ######

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'MBLNR'.

  GS_FIELDCAT-COLTEXT   = '######'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_MKPF'.

  GS_FIELDCAT-REF_FIELD = 'MBLNR'.

  GS_FIELDCAT-EMPHASIZE = 'C500'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 2. MJAHR : ####

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'MJAHR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_MKPF'.

  GS_FIELDCAT-REF_FIELD = 'MJAHR'.

  GS_FIELDCAT-EMPHASIZE = 'C500'.

  GS_FIELDCAT-OUTPUTLEN = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 3. BLART : ####

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'BLART'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_MKPF'.

  GS_FIELDCAT-REF_FIELD = 'BLART'.

  GS_FIELDCAT-EMPHASIZE = 'C500'.

  GS_FIELDCAT-OUTPUTLEN = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 4. BLDAT : ###

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'BLDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_MKPF'.

  GS_FIELDCAT-REF_FIELD = 'BLDAT'.

  GS_FIELDCAT-EMPHASIZE = 'C500'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 5. BUDAT : ###

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'BUDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_MKPF'.

  GS_FIELDCAT-REF_FIELD = 'BUDAT'.

  GS_FIELDCAT-EMPHASIZE = 'C500'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 6. ZEILE : #####

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'ZEILE'.

  GS_FIELDCAT-COLTEXT   = '#####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_MSEG'.

  GS_FIELDCAT-REF_FIELD = 'ZEILE'.

  GS_FIELDCAT-EMPHASIZE = 'C500'.

  GS_FIELDCAT-OUTPUTLEN = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 7. MATNR : ####

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_MSEG'.

  GS_FIELDCAT-REF_FIELD = 'MATNR'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 8. WERKS : ###

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_MSEG'.

  GS_FIELDCAT-REF_FIELD = 'WERKS'.

  GS_FIELDCAT-OUTPUTLEN = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 9. LGORT : ####

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_MSEG'.

  GS_FIELDCAT-REF_FIELD = 'LGORT'.

  GS_FIELDCAT-OUTPUTLEN = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 10. LIFNR : #####

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_MSEG'.

  GS_FIELDCAT-REF_FIELD = 'LIFNR'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 11. [##] MENGE : ##

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = LV_POS.

  GS_FIELDCAT-FIELDNAME  = 'MENGE'.

  GS_FIELDCAT-COLTEXT    = '##'.

  GS_FIELDCAT-REF_TABLE  = 'ZEDT16_MSEG'.

  GS_FIELDCAT-REF_FIELD  = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-EMPHASIZE  = 'C500'.

  GS_FIELDCAT-OUTPUTLEN  = 15.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 12. MEINS : ##

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_MSEG'.

  GS_FIELDCAT-REF_FIELD = 'MEINS'.

  GS_FIELDCAT-OUTPUTLEN = 6.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 13. WAERS : ###

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_MSEG'.

  GS_FIELDCAT-REF_FIELD = 'WAERS'.

  GS_FIELDCAT-OUTPUTLEN = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 14. EBELN : ######

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT   = '######'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_MSEG'.

  GS_FIELDCAT-REF_FIELD = 'EBELN'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 15. BUKRS : ####

  LV_POS = LV_POS + 1.

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = LV_POS.

  GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_MSEG'.

  GS_FIELDCAT-REF_FIELD = 'BUKRS'.

  GS_FIELDCAT-OUTPUTLEN = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.






*  " 16. GJAHR : #### (##)

*  LV_POS = LV_POS + 1.

*  CLEAR GS_FIELDCAT.

*  GS_FIELDCAT-COL_POS   = LV_POS.

*  GS_FIELDCAT-FIELDNAME = 'GJAHR'.

*  GS_FIELDCAT-COLTEXT   = '####(##)'.

*  GS_FIELDCAT-REF_TABLE = 'ZEDT16_MSEG'.

*  GS_FIELDCAT-REF_FIELD = 'GJAHR'.

*  GS_FIELDCAT-OUTPUTLEN = 10.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.

*

*  " 17. BELNR : ####

*  LV_POS = LV_POS + 1.

*  CLEAR GS_FIELDCAT.

*  GS_FIELDCAT-COL_POS   = LV_POS.

*  GS_FIELDCAT-FIELDNAME = 'BELNR'.

*  GS_FIELDCAT-COLTEXT   = '####'.

*  GS_FIELDCAT-REF_TABLE = 'ZEDT16_MSEG'.

*  GS_FIELDCAT-REF_FIELD = 'BELNR'.

*  GS_FIELDCAT-OUTPUTLEN = 12.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.

*

*  " 18. SHKZG : ###

*  LV_POS = LV_POS + 1.

*  CLEAR GS_FIELDCAT.

*  GS_FIELDCAT-COL_POS   = LV_POS.

*  GS_FIELDCAT-FIELDNAME = 'SHKZG'.

*  GS_FIELDCAT-COLTEXT   = '###'.

*  GS_FIELDCAT-REF_TABLE = 'ZEDT16_MSEG'.

*  GS_FIELDCAT-REF_FIELD = 'SHKZG'.

*  GS_FIELDCAT-OUTPUTLEN = 6.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.

*

*  " 19. DMBTR : ##

*  LV_POS = LV_POS + 1.

*  CLEAR GS_FIELDCAT.

*  GS_FIELDCAT-COL_POS    = LV_POS.

*  GS_FIELDCAT-FIELDNAME  = 'DMBTR'.

*  GS_FIELDCAT-COLTEXT    = '##'.

*  GS_FIELDCAT-REF_TABLE  = 'ZEDT16_MSEG'.

*  GS_FIELDCAT-REF_FIELD  = 'DMBTR'.

*  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

*  GS_FIELDCAT-OUTPUTLEN  = 18.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.








ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV_200 .



  CALL METHOD GC_GRID_200->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = GT_ALV_DIS

      IT_FIELDCATALOG = GT_FIELDCAT.



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






*  DATA : LT_ROWS  TYPE LVC_T_ROW,      " ### # ###

*         LS_ROW   TYPE LVC_S_ROW,

*         LS_ALV   LIKE GS_ALV_DIS,     " ### ### (####)

*         LV_LINES TYPE I,              " ### ## #

*         LV_ANS   TYPE C,              " ## ##

*         LV_DUMMY TYPE C.              " ## ## ###

*

*  DATA : LV_CHECK_MBLNR TYPE ZEDT16_MSEG-MBLNR.

*

*  " 1. ALV## ### # ####

*  CALL METHOD GC_GRID_200->GET_SELECTED_ROWS

*    IMPORTING

*      ET_INDEX_ROWS = LT_ROWS.

*

*  " 2. ## ## ## (## ## ##)

*  DESCRIBE TABLE LT_ROWS LINES LV_LINES.

*

*  IF LV_LINES = 0.

*    MESSAGE '### ### ######.' TYPE 'S' DISPLAY LIKE 'W'.

*    RETURN.

*  ELSEIF LV_LINES > 1.

*    MESSAGE '### # ### #####.' TYPE 'S' DISPLAY LIKE 'W'.

*    RETURN.

*  ENDIF.

*

*  " 3. ### 1## # ### ##

*  READ TABLE LT_ROWS INTO LS_ROW INDEX 1.

*  READ TABLE GT_ALV_DIS INTO LS_ALV INDEX LS_ROW-INDEX.

*

*  IF SY-SUBRC <> 0.

*    RETURN.

*  ENDIF.

*

*  " 4. ## ## ##

*  CALL FUNCTION 'POPUP_TO_CONFIRM'

*    EXPORTING

*      TITLEBAR              = '## ##'

*      TEXT_QUESTION         = '### ### ## ########? (DB### #####)'

*      TEXT_BUTTON_1         = '##'

*      ICON_BUTTON_1         = 'ICON_DELETE'

*      TEXT_BUTTON_2         = '##'

*      ICON_BUTTON_2         = 'ICON_CANCEL'

*      DISPLAY_CANCEL_BUTTON = ' '

*      POPUP_TYPE            = 'ICON_MESSAGE_QUESTION'

*    IMPORTING

*      ANSWER                = LV_ANS.

*

*  " '##(1)'# ### ####(### #### '2'# ###) ## ##

*  IF LV_ANS <> '1'.

*    MESSAGE '### #######.' TYPE 'S'.

*    RETURN.

*  ENDIF.

*

*  " 5. DB ## ## (MSEG)

*  DELETE FROM ZEDT16_MSEG

*    WHERE MBLNR = LS_ALV-MBLNR

*      AND MJAHR = LS_ALV-MJAHR

*      AND ZEILE = LS_ALV-ZEILE.

*

*  IF SY-SUBRC = 0.

*    " (1) DB ## ## # -> ##(MKPF) ## ##

*    "     ## ####(MBLNR)# ## #### ### ##

*    CLEAR LV_CHECK_MBLNR.

*

*    SELECT SINGLE MBLNR

*      INTO LV_CHECK_MBLNR

*      FROM ZEDT16_MSEG

*      WHERE MBLNR = LS_ALV-MBLNR

*        AND MJAHR = LS_ALV-MJAHR.

*

*    " ## ##(SY-SUBRC <> 0) = ## #### ## -> ## ##

*    IF SY-SUBRC <> 0.

*      DELETE FROM ZEDT16_MKPF

*        WHERE MBLNR = LS_ALV-MBLNR

*          AND MJAHR = LS_ALV-MJAHR.

*    ENDIF.

*

*    " (2) ## ###(### ###)### ##

*    DELETE GT_ALV_DIS INDEX LS_ROW-INDEX.

*

*    COMMIT WORK.

*    MESSAGE '##### #######.' TYPE 'S'.

*

*    " (3) ## ####

*    PERFORM REFRESH_200.

*

*  ELSE.

*    ROLLBACK WORK.

*    MESSAGE 'DB ## # ### ######.' TYPE 'E'.

*  ENDIF.






  DATA : LT_ROWS  TYPE LVC_T_ROW,        " ### # ###

         LS_ROW   TYPE LVC_S_ROW,

         LS_ALV   LIKE GS_ALV_DIS,       " ### ### (####)

         LV_LINES TYPE I,                " ### ## #

         LV_ANS   TYPE C.                " ## ##



  " ### DB ## ### ### (## ####)

  DATA : LT_DEL_DB      TYPE TABLE OF ZEDT16_MSEG,

         LS_DEL_DB      TYPE ZEDT16_MSEG,

         LV_CHECK_MBLNR TYPE ZEDT16_MSEG-MBLNR. " ## ## ###



  " 1. ALV## ### # ####

  CALL METHOD GC_GRID_200->GET_SELECTED_ROWS

    IMPORTING

      ET_INDEX_ROWS = LT_ROWS.



  " 2. ## ## ##

  DESCRIBE TABLE LT_ROWS LINES LV_LINES.



  IF LV_LINES = 0.

    MESSAGE '### ### ######.' TYPE 'S' DISPLAY LIKE 'W'.

    RETURN.

  ENDIF.



  " 3. ## ## ## (# ### #### # ####)

  DATA : LV_MSG TYPE STRING.

  LV_MSG = |### { LV_LINES }## ### ## ########? (DB### #####)|.



  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR              = '## ## ##'

      TEXT_QUESTION         = LV_MSG

      TEXT_BUTTON_1         = '##'

      ICON_BUTTON_1         = 'ICON_DELETE'

      TEXT_BUTTON_2         = '##'

      ICON_BUTTON_2         = 'ICON_CANCEL'

      DISPLAY_CANCEL_BUTTON = ' '

      POPUP_TYPE            = 'ICON_MESSAGE_QUESTION'

    IMPORTING

      ANSWER                = LV_ANS.



  IF LV_ANS <> '1'.

    MESSAGE '### #######.' TYPE 'S'.

    RETURN.

  ENDIF.



  " 4. ### #### #### ## (# ##: ## ## # ### ## ##)

  SORT LT_ROWS BY INDEX DESCENDING.



  " 5. ## ## ### ## # ##(### ###) ##

  "    (DB ### ## ### # ## ###, ## ### ##)



  LOOP AT LT_ROWS INTO LS_ROW.



    " (1) ### ### ### ## (DB ## ## ##)

    READ TABLE GT_ALV_DIS INTO LS_ALV INDEX LS_ROW-INDEX.



    IF SY-SUBRC = 0.

      " DB ### ## ##

      CLEAR LS_DEL_DB.

      LS_DEL_DB-MBLNR = LS_ALV-MBLNR.

      LS_DEL_DB-MJAHR = LS_ALV-MJAHR.

      LS_DEL_DB-ZEILE = LS_ALV-ZEILE.

      APPEND LS_DEL_DB TO LT_DEL_DB.



      " (2) ## ###(GT_ALV_DIS)## ## ##

      DELETE GT_ALV_DIS INDEX LS_ROW-INDEX.

    ENDIF.



  ENDLOOP.



  " 6. DB ## ## ##

  IF LT_DEL_DB IS NOT INITIAL.



    " (1) ##(MSEG) ## ##

    DELETE ZEDT16_MSEG FROM TABLE LT_DEL_DB.



    IF SY-SUBRC = 0.



      " (2) ##(MKPF) ## ##

      "     ### ### ##### ###, ## ### ## ### ### ##

      "     (### #### ## # #### ## ##)

      SORT LT_DEL_DB BY MBLNR MJAHR.

      DELETE ADJACENT DUPLICATES FROM LT_DEL_DB COMPARING MBLNR MJAHR.



      LOOP AT LT_DEL_DB INTO LS_DEL_DB.



        CLEAR LV_CHECK_MBLNR.



        " ## ## ### ## #### ### ##

        SELECT SINGLE MBLNR

          INTO LV_CHECK_MBLNR

          FROM ZEDT16_MSEG

          WHERE MBLNR = LS_DEL_DB-MBLNR

            AND MJAHR = LS_DEL_DB-MJAHR.



        " ## #### ###(SY-SUBRC <> 0) -> ## #### ##

        IF SY-SUBRC <> 0.

          DELETE FROM ZEDT16_MKPF

            WHERE MBLNR = LS_DEL_DB-MBLNR

              AND MJAHR = LS_DEL_DB-MJAHR.

        ENDIF.



      ENDLOOP.



      COMMIT WORK.

      MESSAGE '### #### ##### #######.' TYPE 'S'.



      " (3) ## ####

      PERFORM REFRESH_200.



    ELSE.

      ROLLBACK WORK.

      MESSAGE 'DB ## # ### ######.' TYPE 'E'.



    ENDIF.



  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH_200 .





  DATA : LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID_200->REFRESH_TABLE_DISPLAY

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

*&      Form  ALV_LAYOUT_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT_200 .



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-SEL_MODE   = 'D'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.



ENDFORM.