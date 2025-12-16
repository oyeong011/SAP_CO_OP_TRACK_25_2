
*&---------------------------------------------------------------------*

*&  Include           ZMM18_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GO_CUSTOM

    EXPORTING




*     PARENT         =




      CONTAINER_NAME = 'CONT1'




*     STYLE          =

*     LIFETIME       = lifetime_default

*     REPID          =

*     DYNNR          =

*     NO_AUTODEF_PROGID_DYNNR     =

*  EXCEPTIONS

*     CNTL_ERROR     = 1

*     CNTL_SYSTEM_ERROR           = 2

*     CREATE_ERROR   = 3

*     LIFETIME_ERROR = 4

*     LIFETIME_DYNPRO_DYNPRO_LINK = 5

*     OTHERS         = 6




    .

  IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.





  CREATE OBJECT GO_GRID

    EXPORTING




*     I_SHELLSTYLE      = 0

*     I_LIFETIME        =




      I_PARENT = GO_CUSTOM




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




FORM FIELD_CATALOG .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.



  " 1. #### (## ##)

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-OUTPUTLEN = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 2. #### (## ##!)

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT      = 'X'. " ## ##

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 3. ### (## ## - ## ##)

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 4. PO## (## ## + ## ##)

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT = 'PO##'.

  GS_FIELDCAT-EDIT      = 'X'. " ## ##

  GS_FIELDCAT-REF_TABLE  = 'ZEKPO_18'. " DB #### (SE11)

  GS_FIELDCAT-REF_FIELD  = 'MENGE'.    " DB ###

  GS_FIELDCAT-OUTPUTLEN = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 5. ## (## ## + ## ##)

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'NETPR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-EDIT      = 'X'. " ## ##

  GS_FIELDCAT-CFIELDNAME = 'WAERS'. " ## ## ##

  GS_FIELDCAT-REF_TABLE  = 'ZEKPO_18'.

  GS_FIELDCAT-REF_FIELD  = 'NETPR'.

  GS_FIELDCAT-OUTPUTLEN = 11.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 6. ## (## ## or ## ##)

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-OUTPUTLEN = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 7. ## (## # ##### - ## ##)

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-OUTPUTLEN = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 8. #### (## ##)

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EDIT      = 'X'. " ## ##

  GS_FIELDCAT-REF_TABLE  = 'ZEKPO_18'.

  GS_FIELDCAT-REF_FIELD  = 'MWSKZ'.

  GS_FIELDCAT-OUTPUTLEN = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 9. ### (## ##)

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-EDIT      = 'X'. " ## ##

  GS_FIELDCAT-OUTPUTLEN = 13.

  GS_FIELDCAT-REF_TABLE  = 'ZEKPO_18'.

  GS_FIELDCAT-REF_FIELD  = 'PRDAT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 10. ### (## ##)

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-EDIT      = 'X'. " ## ##

  GS_FIELDCAT-REF_TABLE  = 'ZMARA_18'.

  GS_FIELDCAT-REF_FIELD  = 'WERKS'.

  GS_FIELDCAT-OUTPUTLEN = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 11. #### (## ##)

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EDIT      = 'X'. " ## ##

  GS_FIELDCAT-REF_TABLE  = 'ZMARA_18'.

  GS_FIELDCAT-REF_FIELD  = 'LGORT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT .

  CLEAR GS_SORT.

  CLEAR GT_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY .

  CALL METHOD GO_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*     I_BUFFER_ACTIVE =

*     I_BYPASSING_BUFFER            =

*     I_CONSISTENCY_CHECK           =

*     I_STRUCTURE_NAME              =

*     IS_VARIANT      = GS_VARIANT




      I_SAVE          = 'A'




*     I_DEFAULT       = 'X'




      IS_LAYOUT       = GS_LAYOUT




*     IS_PRINT        =

*     IT_SPECIAL_GROUPS             =

*     IT_TOOLBAR_EXCLUDING          =

*     IT_HYPERLINK    =

*     IT_ALV_GRAPHICS =

*     IT_EXCEPT_QINFO =

*     IR_SALV_ADAPTER =




    CHANGING

      IT_OUTTAB       = GT_EKPO

      IT_FIELDCATALOG = GT_FIELDCAT

      IT_SORT         = GT_SORT




*     IT_FILTER       =

*  EXCEPTIONS

*     INVALID_PARAMETER_COMBINATION = 1

*     PROGRAM_ERROR   = 2

*     TOO_MANY_LINES  = 3

*     OTHERS          = 4




    .

  IF SY-SUBRC <> 0.




* Implement suitable error handling here




  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*




FORM REFRESH .

  DATA: LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GO_GRID->REFRESH_TABLE_DISPLAY

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

*&      Form  SET_SCREEN_OUTPUT

*&---------------------------------------------------------------------*




FORM SET_SCREEN_OUTPUT.

  LOOP AT SCREEN.

    " ## ### # ## ## ####

    IF R_CR = 'X' AND SCREEN-GROUP1 = 'DIS'.

      SCREEN-ACTIVE = '0'.

      " ## ### # ## ## ####

    ELSEIF R_DIS = 'X' AND SCREEN-GROUP1 = 'CR'.

      SCREEN-ACTIVE = '0'.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_SCREEN_INPUT

*&---------------------------------------------------------------------*




FORM CHECK_SCREEN_INPUT.



  " ==========================================================

  " [1] ## ## (R_CR = 'X') ##

  " ==========================================================

  IF R_CR = 'X'.



    " 1. #### (P_BUKRS)

    IF P_BUKRS IS INITIAL.

      SET CURSOR FIELD 'P_BUKRS'. " ### ### ##

      MESSAGE '##### ## ## #####.' TYPE 'E'.

    ELSE.

      SELECT SINGLE BUKRS FROM ZLFB1_18 INTO @DATA(LV_BUKRS)

        WHERE BUKRS = @P_BUKRS.

      IF SY-SUBRC <> 0.

        SET CURSOR FIELD 'P_BUKRS'.

        MESSAGE '#### ## #######.' TYPE 'E'.

      ENDIF.

    ENDIF.



    " 2. ### (P_LIFNR)

    IF P_LIFNR IS INITIAL.

      SET CURSOR FIELD 'P_LIFNR'.

      MESSAGE '#### ## ## #####.' TYPE 'E'.

    ELSE.

      DATA: LV_LIFNR_PAD TYPE ZLFA1_18-LIFNR.

      UNPACK P_LIFNR TO LV_LIFNR_PAD. " 0 ###



      SELECT SINGLE LIFNR FROM ZLFA1_18 INTO @DATA(LV_LIFNR)

        WHERE LIFNR = @LV_LIFNR_PAD.

      IF SY-SUBRC <> 0.

        SET CURSOR FIELD 'P_LIFNR'.

        MESSAGE '#### ## ######.' TYPE 'E'.

      ENDIF.

    ENDIF.



    " 3. ### (P_BEDAT)

    IF P_BEDAT IS INITIAL.

      SET CURSOR FIELD 'P_BEDAT'.

      MESSAGE '#### ## ## #####.' TYPE 'E'.

    ENDIF.



    IF P_BEDAT > SY-DATUM.

      SET CURSOR FIELD 'P_BEDAT'.

      MESSAGE '#### ### # ####.' TYPE 'E'.

    ENDIF.



    " ==========================================================

    " [2] ## ## (R_DIS = 'X') ##

    " ==========================================================

  ELSEIF R_DIS = 'X'.



    " 4. PO ## (P_EBELN)

    IF P_EBELN IS NOT INITIAL.

      DATA: LV_EBELN_PAD TYPE ZEKKO_18-EBELN.

      UNPACK P_EBELN TO LV_EBELN_PAD.



      SELECT SINGLE EBELN FROM ZEKKO_18 INTO @DATA(LV_EBELN)

        WHERE EBELN = @LV_EBELN_PAD.

      IF SY-SUBRC <> 0.

        SET CURSOR FIELD 'P_EBELN'.

        MESSAGE '#### ## #### #####.' TYPE 'E'.

      ENDIF.

    ENDIF.



    " 5. ### ### (P_LIFNR2)

    IF P_LIFNR2 IS NOT INITIAL.

      DATA: LV_LIFNR2_PAD TYPE ZLFA1_18-LIFNR.

      UNPACK P_LIFNR2 TO LV_LIFNR2_PAD.



      SELECT SINGLE LIFNR FROM ZLFA1_18 INTO @DATA(LV_LIFNR2)

        WHERE LIFNR = @LV_LIFNR2_PAD.

      IF SY-SUBRC <> 0.

        SET CURSOR FIELD 'P_LIFNR2'.

        MESSAGE '#### ## ######.' TYPE 'E'.

      ENDIF.

    ENDIF.



    " 6. ### #### (P_BUKRS2)

    IF P_BUKRS2 IS NOT INITIAL.

      SELECT SINGLE BUKRS FROM ZLFB1_18 INTO @DATA(LV_BUKRS2)

        WHERE BUKRS = @P_BUKRS2.

      IF SY-SUBRC <> 0.

        SET CURSOR FIELD 'P_BUKRS2'.

        MESSAGE '#### ## #######.' TYPE 'E'.

      ENDIF.

    ENDIF.



  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INITIALIZE_DATA

*&---------------------------------------------------------------------*




FORM INITIALIZE_DATA.

  " [1] ## ##

  IF R_CR = 'X'.

    GV_MODE = 'C'.

    PERFORM SET_INITIAL_DATA. " ### ### ##



    " [2] ## ##

  ELSEIF R_DIS = 'X'.

    GV_MODE = 'D'.

    PERFORM GET_DATA.         " ### ### ##

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_INITIAL_DATA

*&---------------------------------------------------------------------*




FORM SET_INITIAL_DATA.

  " 1. ## ### ## ### ##

  IF GV_MODE = 'C'.

    " (1) ## ####(P_)# ## ##(ZEKKO_18-)# ##

    GS_EKKO-BUKRS = P_BUKRS. " ####

    GS_EKKO-LIFNR = P_LIFNR. " ###

    GS_EKKO-BEDAT = P_BEDAT. " ###



    " (2) ### ### ### '##(WAERS)' ## ##

    "     (#### ### ## # ## ### ##### ###)

    IF ZEKKO_18-LIFNR IS NOT INITIAL.

      SELECT SINGLE WAERS

        FROM ZLFM1_18

        INTO GS_EKKO-WAERS

        WHERE LIFNR = GS_EKKO-LIFNR.

    ENDIF.



  ELSEIF GV_MODE = 'D'.

    " ## ### ## PO### ###

    GS_EKKO-EBELN = P_EBELN.

    " (## DB ## ### START-OF-SELECTION# ### ## ##)

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ADD_ROW

*&---------------------------------------------------------------------*




FORM ADD_ROW .

  DATA: LV_MAX_EBELP TYPE EBELP,

        LV_ERROR     TYPE C.





  IF GS_EKKO-BUKRS IS INITIAL OR  " ####

     GS_EKKO-EKGRP IS INITIAL OR  " ####

     GS_EKKO-EKORG IS INITIAL OR  " ####

     GS_EKKO-LIFNR IS INITIAL OR  " ###

     GS_EKKO-BEDAT IS INITIAL OR  " ###

     GS_EKKO-WAERS IS INITIAL.    " ##



    MESSAGE '### ## ##(##, ##, ##, ###, ###, ##)# ######.'

      TYPE 'S' DISPLAY LIKE 'E'.

    EXIT. " #### ##### ## ## ##

  ENDIF.



  " ## ### ##

  PERFORM CHECK_HEADER_VALIDITY CHANGING LV_ERROR.

  IF LV_ERROR = 'X'.

    EXIT.

  ENDIF.



  " #### #### ## # ## ##

  SORT GT_EKPO BY EBELP DESCENDING.

  READ TABLE GT_EKPO INTO GS_EKPO INDEX 1.



  LV_MAX_EBELP = GS_EKPO-EBELP + 10.

  IF LV_MAX_EBELP IS INITIAL. LV_MAX_EBELP = '00010'. ENDIF.



  CLEAR GS_EKPO.

  GS_EKPO-EBELP = LV_MAX_EBELP.

  GS_EKPO-WAERS = GS_EKKO-WAERS.



  APPEND GS_EKPO TO GT_EKPO.



  " ## #### ## (## ##)

  SORT GT_EKPO BY EBELP ASCENDING.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DEL_ROW

*&---------------------------------------------------------------------*




FORM DEL_ROW .

  DATA: LT_ROW_NO TYPE LVC_T_ROW.

  DATA: LS_ROW_NO TYPE LVC_S_ROW.

  DATA: LV_INDEX  TYPE I.



  " ALV## ### # ### ####

  CALL METHOD GO_GRID->GET_SELECTED_ROWS

    IMPORTING

      ET_INDEX_ROWS = LT_ROW_NO.



  IF LT_ROW_NO IS INITIAL.

    MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  " ##### ### #### # ##

  SORT LT_ROW_NO BY INDEX DESCENDING.



  LOOP AT LT_ROW_NO INTO LS_ROW_NO.

    READ TABLE GT_EKPO INTO GS_EKPO INDEX LS_ROW_NO-INDEX.

    IF SY-SUBRC = 0.

      " DB ### ## ## (## #### #### ## ##)

      APPEND GS_EKPO TO GT_DEL_EKPO.

      " ### ##### ##

      DELETE GT_EKPO INDEX LS_ROW_NO-INDEX.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_PO

*&---------------------------------------------------------------------*




FORM SAVE_PO .

  DATA: LV_ERROR TYPE C.

  DATA: LS_DB_EKPO TYPE ZEKPO_18.

  DATA: LV_MAX_EBELN TYPE ZEKKO_18-EBELN.

  DATA: LS_CHECK_MARA TYPE ZMARA_18.



  " 1. ALV ### ## (### -> ######)

  CALL METHOD GO_GRID->CHECK_CHANGED_DATA.



  " -----------------------------------------------------------

  " 2. ## ### ## (## # ## ##)

  " -----------------------------------------------------------

  IF GS_EKKO-BUKRS IS INITIAL OR

     GS_EKKO-EKGRP IS INITIAL OR

     GS_EKKO-EKORG IS INITIAL OR

     GS_EKKO-LIFNR IS INITIAL OR

     GS_EKKO-BEDAT IS INITIAL OR

     GS_EKKO-WAERS IS INITIAL.



    MESSAGE '### ## ## ##(##, ##, ##, ###, ###, ##)# #####.'

      TYPE 'S' DISPLAY LIKE 'E'.

    LV_ERROR = 'X'.

    EXIT. " ### #### ##

  ENDIF.



  " -----------------------------------------------------------

  " 3. ## ### ### (GS -> DB ###)

  " -----------------------------------------------------------

  MOVE-CORRESPONDING GS_EKKO TO ZEKKO_18.





  " -----------------------------------------------------------

  " 4. ### ### ## (Validation)

  " -----------------------------------------------------------

  CLEAR LV_ERROR. " ###

  LOOP AT GT_EKPO INTO GS_EKPO.



    " (1) #### ## ##

    IF GS_EKPO-MATNR IS INITIAL.

      MESSAGE '##### ## ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

      LV_ERROR = 'X'.

      EXIT.

    ENDIF.



    " (2) ## ##: ###(PRDAT) >= ###(BEDAT)

    IF GS_EKPO-PRDAT IS NOT INITIAL.

      IF GS_EKPO-PRDAT < ZEKKO_18-BEDAT.

        MESSAGE |###({ ZEKKO_18-BEDAT }) #### ###.|

          TYPE 'S' DISPLAY LIKE 'E'.

        LV_ERROR = 'X'.

        EXIT.

      ENDIF.

    ELSE.

      MESSAGE '#### ## ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

      LV_ERROR = 'X'.

      EXIT.

    ENDIF.



    " (3) ## ##

    IF GS_EKPO-MENGE <= 0.

      MESSAGE '### 0## ## ###.' TYPE 'S' DISPLAY LIKE 'E'.

      LV_ERROR = 'X'.

      EXIT.

    ENDIF.



    " (4) ### # #### ### ## (ZMARA_18 ##)

    " Case 3: ### ## ##

    IF GS_EKPO-WERKS IS INITIAL.

      MESSAGE '#### ## ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

      LV_ERROR = 'X'.

      EXIT.

    ENDIF.



    CLEAR LS_CHECK_MARA.



    IF GS_EKPO-LGORT IS NOT INITIAL.

      " Case 1: (## + ### + ####) ## ##

      SELECT SINGLE * FROM ZMARA_18 INTO LS_CHECK_MARA

        WHERE MATNR = GS_EKPO-MATNR

          AND WERKS = GS_EKPO-WERKS

          AND LGORT = GS_EKPO-LGORT.



      IF SY-SUBRC <> 0.

        MESSAGE |## { GS_EKPO-EBELP }: ## #### ##### ### #### ####.|

          TYPE 'S' DISPLAY LIKE 'E'.

        LV_ERROR = 'X'.

        EXIT.

      ENDIF.



    ELSE.

      " Case 2: (## + ###) ## ## (#### ## #### ######)

      SELECT SINGLE * FROM ZMARA_18 INTO LS_CHECK_MARA

        WHERE MATNR = GS_EKPO-MATNR

          AND WERKS = GS_EKPO-WERKS.



      IF SY-SUBRC <> 0.

        MESSAGE |## { GS_EKPO-EBELP }: ## #### ### #### ####.|

          TYPE 'S' DISPLAY LIKE 'E'.

        LV_ERROR = 'X'.

        EXIT.

      ENDIF.

    ENDIF.



  ENDLOOP.



  IF LV_ERROR = 'X'.

    EXIT. " ## ### ###

  ENDIF.

  " -----------------------------------------------------------

  " 5. PO ## ## # ## (## ## # ##)

  " -----------------------------------------------------------



  " (1) PO ## ##

  IF GV_MODE = 'C'.

    PERFORM GENERATE_PO_NUMBER CHANGING GS_EKKO-EBELN.

    " ### ### DB ##### ##

    ZEKKO_18-EBELN = GS_EKKO-EBELN.

  ENDIF.



  " (2) ## ##

  MODIFY ZEKKO_18.



  " (3) ### ## (PO## ##)

  LOOP AT GT_EKPO ASSIGNING FIELD-SYMBOL(<FS_EKPO>).

    <FS_EKPO>-EBELN = GS_EKKO-EBELN. " ## ## ##



    CLEAR LS_DB_EKPO.

    MOVE-CORRESPONDING <FS_EKPO> TO LS_DB_EKPO.



    MODIFY ZEKPO_18 FROM LS_DB_EKPO.

  ENDLOOP.



  " (4) ### ### DB ##

  IF GT_DEL_EKPO IS NOT INITIAL.

    DATA: LT_DB_DEL TYPE TABLE OF ZEKPO_18.



    LOOP AT GT_DEL_EKPO INTO GS_EKPO.

      CLEAR LS_DB_EKPO.

      MOVE-CORRESPONDING GS_EKPO TO LS_DB_EKPO.

      APPEND LS_DB_EKPO TO LT_DB_DEL.

    ENDLOOP.



    DELETE ZEKPO_18 FROM TABLE LT_DB_DEL.

  ENDIF.



  COMMIT WORK.



  MESSAGE |##### #######. ##: { ZEKKO_18-EBELN }| TYPE 'S'.



  " ## # ## ### ##

  GV_MODE = 'D'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GENERATE_PO_NUMBER

*&---------------------------------------------------------------------*




FORM GENERATE_PO_NUMBER CHANGING CV_EBELN TYPE ZEKKO_18-EBELN.

  DATA: LV_MAX_EBELN TYPE ZEKKO_18-EBELN.



  " 1. DB## ## # ## ####

  SELECT MAX( EBELN ) FROM ZEKKO_18 INTO LV_MAX_EBELN.



  " 2. ## ## ##

  IF LV_MAX_EBELN IS INITIAL.

    " DB# # ### # (## ##)

    CV_EBELN = '4500000001'.

  ELSE.

    " ### ## + 1

    CV_EBELN = LV_MAX_EBELN + 1.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*




FORM CLASS_EVENT .

  "REGISTER_EDIT : SCREEN# ITAB ###

  CALL METHOD GO_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED




*    EXCEPTIONS

*     ERROR      = 1

*     OTHERS     = 2




    .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

  CALL METHOD GO_GRID->SET_READY_FOR_INPUT

    EXPORTING

      I_READY_FOR_INPUT = 1.





  CREATE OBJECT GO_EVENT.



  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GO_GRID.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  HANDLE_DATA_CHANGED

*&---------------------------------------------------------------------*




FORM HANDLE_DATA_CHANGED USING P_DATA_CHANGED TYPE ANY.



  " 1. ALV ## ###

  DATA: LO_PROTOCOL TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.



  TRY.

      LO_PROTOCOL ?= P_DATA_CHANGED.

    CATCH CX_SY_MOVE_CAST_ERROR.

      EXIT.

  ENDTRY.



  DATA: LS_MODI  TYPE LVC_S_MODI,

        LS_ZMARA TYPE ZMARA_18,

        LV_MATNR TYPE ZMARA_18-MATNR.



  " -----------------------------------------------------------------

  " ### # ## ##

  " -----------------------------------------------------------------

  LOOP AT LO_PROTOCOL->MT_GOOD_CELLS INTO LS_MODI.



    " ===============================================================

    " [Case 1] ####(MATNR)# ##### #

    " ===============================================================

    IF LS_MODI-FIELDNAME = 'MATNR'.



      READ TABLE GT_EKPO INTO GS_EKPO INDEX LS_MODI-ROW_ID.



      " #### ## (0 ###)

      UNPACK LS_MODI-VALUE TO LV_MATNR.

      GS_EKPO-MATNR = LV_MATNR.



      IF GS_EKPO-MATNR IS NOT INITIAL.

        SELECT SINGLE * FROM ZMARA_18 INTO LS_ZMARA WHERE MATNR = GS_EKPO-MATNR.



        IF SY-SUBRC = 0.

          GS_EKPO-MAKTX = LS_ZMARA-MAKTX.

          GS_EKPO-MEINS = LS_ZMARA-MEINS.

          GS_EKPO-BPRME = LS_ZMARA-MEINS.

          GS_EKPO-NETPR = LS_ZMARA-STPRS.



          " ## ## (Protocol)

          CALL METHOD LO_PROTOCOL->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MODI-ROW_ID

              I_FIELDNAME = 'MAKTX'

              I_VALUE     = LS_ZMARA-MAKTX.

          CALL METHOD LO_PROTOCOL->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MODI-ROW_ID

              I_FIELDNAME = 'MEINS'

              I_VALUE     = LS_ZMARA-MEINS.

          CALL METHOD LO_PROTOCOL->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MODI-ROW_ID

              I_FIELDNAME = 'BPRME'

              I_VALUE     = LS_ZMARA-MEINS.



          " ## ## # ## ##

          IF ZEKKO_18-WAERS IS NOT INITIAL.

            PERFORM CONVERT_CURRENCY USING    LS_ZMARA-STPRS

                                              'KRW'

                                              GS_EKKO-WAERS

                                              SY-DATUM

                                     CHANGING GS_EKPO-NETPR.

          ELSE.

            GS_EKPO-NETPR = LS_ZMARA-STPRS.

          ENDIF.



          CALL METHOD LO_PROTOCOL->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MODI-ROW_ID

              I_FIELDNAME = 'NETPR'

              I_VALUE     = GS_EKPO-NETPR.



        ELSE.

          CLEAR: GS_EKPO-MAKTX, GS_EKPO-MEINS, GS_EKPO-BPRME, GS_EKPO-NETPR.

          MESSAGE '### ##### ## #######.' TYPE 'S' DISPLAY LIKE 'E'.

        ENDIF.

      ELSE.

        CLEAR: GS_EKPO-MAKTX, GS_EKPO-MEINS, GS_EKPO-BPRME, GS_EKPO-NETPR.

      ENDIF.



      MODIFY GT_EKPO FROM GS_EKPO INDEX LS_MODI-ROW_ID.



      " ===============================================================

      " [Case 2] ###(PRDAT)# ##### #

      " ===============================================================

    ELSEIF LS_MODI-FIELDNAME = 'PRDAT'.



      READ TABLE GT_EKPO INTO GS_EKPO INDEX LS_MODI-ROW_ID.



      " #### ### ## ##

      GS_EKPO-PRDAT = LS_MODI-VALUE.



      " ### ##: ###(BEDAT)## #### ##

      IF GS_EKKO-BEDAT IS NOT INITIAL AND GS_EKPO-PRDAT < GS_EKKO-BEDAT.



        MESSAGE '#### ### #### ###.' TYPE 'S' DISPLAY LIKE 'E'.



      ENDIF.



      " ### ##(## ## or ##) ##

      MODIFY GT_EKPO FROM GS_EKPO INDEX LS_MODI-ROW_ID.



      " ===============================================================

      " [Case 3] ####(MWSKZ)# ##### #

      " ===============================================================

    ELSEIF LS_MODI-FIELDNAME = 'MWSKZ'.



    ENDIF.



  ENDLOOP.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONVERT_CURRENCY

*&---------------------------------------------------------------------*




FORM CONVERT_CURRENCY USING    P_AMOUNT      TYPE ZEKPO_18-NETPR " ## ##

                               P_SOURCE_CURR TYPE WAERS          " ## ## (#: KRW)

                               P_TARGET_CURR TYPE WAERS          " ## ## (#: USD)

                               P_DATE        TYPE DATUM          " ## ###

                      CHANGING P_RESULT      TYPE ZEKPO_18-NETPR." ### ##



  DATA: LV_FOREIGN_AMOUNT TYPE P DECIMALS 2. " ### # ## ##



  " 1. ### ### ### 0## ## # #

  IF P_SOURCE_CURR IS INITIAL OR P_TARGET_CURR IS INITIAL OR P_AMOUNT IS INITIAL.

    P_RESULT = P_AMOUNT.

    EXIT.

  ENDIF.



  " 2. ### ### ## # #

  IF P_SOURCE_CURR = P_TARGET_CURR.

    P_RESULT = P_AMOUNT.

    EXIT.

  ENDIF.



  " 3. SAP ## ## ## ## ##

  CALL FUNCTION 'CONVERT_TO_FOREIGN_CURRENCY'

    EXPORTING

      DATE             = P_DATE           " ### (## ## or ###)

      FOREIGN_CURRENCY = P_TARGET_CURR    " ## ## (## ##)

      LOCAL_CURRENCY   = P_SOURCE_CURR    " ## ## (## ##)

      LOCAL_AMOUNT     = P_AMOUNT         " ## ##

    IMPORTING

      FOREIGN_AMOUNT   = LV_FOREIGN_AMOUNT

    EXCEPTIONS

      NO_RATE_FOUND    = 1

      OVERFLOW         = 2

      NO_FACTORS_FOUND = 3

      NO_SPREAD_FOUND  = 4

      DERIVED_2_TIMES  = 5

      OTHERS           = 6.



  IF SY-SUBRC = 0.

    P_RESULT = LV_FOREIGN_AMOUNT. " ## # ## ##

  ELSE.

    " ## ### ## ## # ## ##

    P_RESULT = 0.

    MESSAGE '## ### ## # ####.' TYPE 'S' DISPLAY LIKE 'W'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .

  " 1. ## ### ## (ZEKKO_18 -> GS_EKKO)

  SELECT SINGLE *

    FROM ZEKKO_18

    INTO CORRESPONDING FIELDS OF GS_EKKO

    WHERE EBELN = P_EBELN.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ## #### #####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING. " ## #### ###

  ENDIF.



  " 2. ### ### ## (ZEKPO_18 -> GT_EKPO)

  SELECT *

    FROM ZEKPO_18

    INTO CORRESPONDING FIELDS OF TABLE GT_EKPO

    WHERE EBELN = P_EBELN.



  " 3. ## ## ## ### (###)

  LOOP AT GT_EKPO ASSIGNING FIELD-SYMBOL(<FS_EKPO>).



    " (1) ##(WAERS) ###

    <FS_EKPO>-WAERS = GS_EKKO-WAERS.



  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_SCREEN_0100

*&---------------------------------------------------------------------*




FORM MODIFY_SCREEN_0100 .

  LOOP AT SCREEN.



    " =========================================================

    " [Case 1] ## ## (GV_MODE = 'D')

    " =========================================================

    IF GV_MODE = 'D'.

      " PO## #### #### ## ##

      IF SCREEN-NAME <> 'GS_EKKO-EBELN'.

        SCREEN-INPUT = '0'.

      ENDIF.



      " =========================================================

      " [Case 2] ## ## (GV_MODE = 'C')

      " =========================================================

    ELSEIF GV_MODE = 'C'.



      " 1. Selection Screen## ### ## ## ## (LOK ##)

      "    (####, ###, ###)

      IF SCREEN-GROUP1 = 'LOK'.

        SCREEN-INPUT = '0'.

      ENDIF.



      " 2. PO ### ## ##### ##

      IF SCREEN-NAME = 'GS_EKKO-EBELN'.

        SCREEN-INPUT = '0'.

      ENDIF.



      " 3. (##) ### #### ### -> ### ## ### ##!

      "    (####, ####, ## # LOK ### ## ## ##)

      IF GT_EKPO IS NOT INITIAL.



        " LOK ### ###, EBELN# ## ### ## #### ##

        IF SCREEN-NAME CP 'GS_EKKO-*'

           AND SCREEN-GROUP1 <> 'LOK'

           AND SCREEN-NAME <> 'GS_EKKO-EBELN'.



          SCREEN-INPUT = '0'.

        ENDIF.



      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_HEADER_VALIDITY

*&---------------------------------------------------------------------*




FORM CHECK_HEADER_VALIDITY CHANGING CV_ERROR TYPE C.



  DATA: LV_DUMMY TYPE C.



  CLEAR CV_ERROR.



  " ###, ####, #### ## ### ## ### ### ### ###.

  " #### ## (ZLFM1_18: ###-#### ## ##)

  "    => "# #### # ##### ### ####?" # ##

  IF GS_EKKO-EKORG IS NOT INITIAL AND GS_EKKO-LIFNR IS NOT INITIAL.



    SELECT SINGLE EKORG INTO LV_DUMMY FROM ZLFM1_18

      WHERE LIFNR = GS_EKKO-LIFNR

        AND EKORG = GS_EKKO-EKORG.



    IF SY-SUBRC <> 0.

      MESSAGE '## #### #### ##### #### #####.'

        TYPE 'S' DISPLAY LIKE 'E'.

      CV_ERROR = 'X'. EXIT.

    ENDIF.

  ENDIF.



  " 4. #### ## (T024: #### ###)

  IF GS_EKKO-EKGRP IS NOT INITIAL.

    SELECT SINGLE EKGRP INTO LV_DUMMY FROM T024

      WHERE EKGRP = GS_EKKO-EKGRP.

    IF SY-SUBRC <> 0.

      MESSAGE '#### ## #######.' TYPE 'S' DISPLAY LIKE 'E'.

      CV_ERROR = 'X'. EXIT.

    ENDIF.

  ENDIF.



  " 5. ## ## (TCURC: ## ## ###)

  "    => ###(ZLFM1_18)# ### ###, ### ## ### # ### ##

  IF GS_EKKO-WAERS IS NOT INITIAL.

    SELECT SINGLE WAERS INTO LV_DUMMY FROM TCURC

      WHERE WAERS = GS_EKKO-WAERS.

    IF SY-SUBRC <> 0.

      MESSAGE '#### ## ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

      CV_ERROR = 'X'. EXIT.

    ENDIF.

  ENDIF.



ENDFORM.