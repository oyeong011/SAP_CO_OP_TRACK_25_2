
*&---------------------------------------------------------------------*

*&  Include           ZMMR13_004_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  INITIALIZATION

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INITIALIZATION.

  P3 = SY-DATUM.

  GV_COLOR = '@0A@'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SCREEN_CHANGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SCREEN_CHANGE.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'.

      IF P_R2 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_MANDATORY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_MANDATORY.

  DATA : LV_EBELN TYPE EBELN,

         LV_WERKS TYPE WERKS.

  IF P_R1 = 'X'.

    IF P1 IS INITIAL OR P2 IS INITIAL OR P3 IS INITIAL.

      MESSAGE S000 DISPLAY LIKE 'E'.

      LEAVE LIST-PROCESSING.

    ENDIF.

  ELSEIF P_R2 = 'X'.

    IF P1 IS INITIAL OR P2 IS INITIAL.

      MESSAGE S000 DISPLAY LIKE 'E'.

      LEAVE LIST-PROCESSING.

    ENDIF.

  ENDIF.

  SELECT SINGLE EBELN FROM ZEKKO_13 "PO ######## ##"

    INTO LV_EBELN

    WHERE EBELN = P1.

  IF SY-SUBRC <> 0.

    MESSAGE '#### ## #######' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  SELECT SINGLE WERKS FROM ZEKPO_13 "### ######### ##"

    INTO LV_WERKS

    WHERE EBELN = P1

      AND WERKS = P2.

  IF SY-SUBRC <> 0.

    MESSAGE '#### ## ######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

  GV_ORDER = P1.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INIT_DATA_0100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INIT_DATA_0100.

  DATA: LV_DUMMY TYPE C.



  SELECT SINGLE * FROM ZEKKO_13

    INTO CORRESPONDING FIELDS OF GS_EKKO  "### ##### ##"

    WHERE EBELN = P1.       "PO##"



  PERFORM GET_HEADER.



  SELECT * FROM ZEKPO_13

    INTO CORRESPONDING FIELDS OF TABLE GT_EKPO "### #### # ##"

    WHERE EBELN = P1        "PO##"

    AND WERKS = P2.         "###"



  CLEAR GT_ITEM.

  LOOP AT GT_EKPO INTO GS_EKPO.

    CLEAR: GS_ITEM, LV_DUMMY.



    SELECT SINGLE LOEKZ

     INTO LV_DUMMY

     FROM ZRSEG_13                "## ### ###(ZRSEG) ##"

    WHERE EBELN = GS_EKPO-EBELN   "## PO ##"

      AND EBELP = GS_EKPO-EBELP   "## PO ##"

      AND LOEKZ <> 'X'.           "##(##)## ## ## ##"



    IF SY-SUBRC = 0.

      CONTINUE.                   "Skip"

    ENDIF.



    GS_ITEM-WAERS = GS_EKKO-WAERS.

    GS_ITEM-EBELN = GS_EKPO-EBELN. "#### ##"

    GS_ITEM-EBELP = GS_EKPO-EBELP. "#### ##"

    GS_ITEM-MATNR = GS_EKPO-MATNR. "## ##"

    GS_ITEM-WERKS = GS_EKPO-WERKS. "###"

    GS_ITEM-MWSKZ = GS_EKPO-MWSKZ. "#### (PO# ## # ###)"

    GS_ITEM-MENGE = GS_EKPO-MENGE. "##"

    GS_ITEM-DMBTR = GS_ITEM-MENGE * GS_EKPO-STPRS. "## * ##"

    GS_ITEM-BELNR = GS_RBKP-BELNR.

    GS_ITEM-GJAHR = GS_RBKP-GJAHR.

    APPEND GS_ITEM TO GT_ITEM.

  ENDLOOP.



  IF GT_ITEM IS INITIAL.

    MESSAGE '### ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_HEADER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_HEADER.



  CLEAR GS_RBKP.

  GS_RBKP-BUDAT = SY-DATUM.           "###(#### #)"

  GS_RBKP-BLDAT = GS_RBKP-BUDAT.      "###"

  GS_RBKP-GJAHR = GS_RBKP-BUDAT+0(4). "####(#### ##)"

  GS_RBKP-BLART = 'RE'.               "####(##)"

  GS_RBKP-BUKRS = GS_EKKO-BUKRS.      "####"

  GS_RBKP-LIFNR = GS_EKKO-LIFNR.      "####"

  GS_RBKP-WAERS = GS_EKKO-WAERS.      "##"

  GS_RBKP-BLDAT = GS_EKKO-BEDAT.      "## ##"



  PERFORM GET_NEXT_BELNR CHANGING GS_RBKP-BELNR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_NEXT_BELNR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_LV_BELNR  text

*----------------------------------------------------------------------*




FORM GET_NEXT_BELNR  CHANGING P_BELNR.

  DATA : LV_MAX TYPE BELNR_D.

  SELECT MAX( BELNR ) INTO LV_MAX FROM ZRBKP_13.

  IF LV_MAX <> 0.

    P_BELNR = LV_MAX + 1.

  ELSE.

    P_BELNR = '5000000000'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT.

  CREATE OBJECT GO_EVENT.

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED




*    EXCEPTIONS

*      ERROR      = 1

*      others     = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                     P_ONF4

                                     P_ONF4_BEFORE

                                     P_ONF4_AFTER

                                     P_UCOMM.

  DATA : LS_MODI TYPE LVC_S_MODI.

  DATA : LV_MARK TYPE CHAR1,

         LV_MWSKZ TYPE MWSKZ,

         LV_SGTXT TYPE SGTXT.





  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    READ TABLE GT_ITEM INTO GS_ITEM INDEX LS_MODI-ROW_ID.

    IF LS_MODI-FIELDNAME = 'MARK'.

      LV_MARK = LS_MODI-VALUE.

      GS_ITEM-WRBTR = GS_ITEM-MWSTS + GS_ITEM-DMBTR.

      GS_ITEM-MARK = LV_MARK.

      IF LV_MARK = 'X'.

        GV_BALANCE = GV_BALANCE + GS_ITEM-WRBTR.

        GS_RBKP-WMWST1 = GS_RBKP-WMWST1 + GS_ITEM-MWSTS.

      ELSE.

        GV_BALANCE = GV_BALANCE - GS_ITEM-WRBTR.

        GS_RBKP-WMWST1 = GS_RBKP-WMWST1 - GS_ITEM-MWSTS.

      ENDIF.

    ENDIF.



    IF LS_MODI-FIELDNAME = 'MWSKZ'.

      LV_MWSKZ = LS_MODI-VALUE.

      GS_ITEM-MWSKZ = LV_MWSKZ.

    ENDIF.



    IF LS_MODI-FIELDNAME = 'SGTXT'.

      LV_SGTXT = LS_MODI-VALUE.

      GS_ITEM-SGTXT = LV_SGTXT.

    ENDIF.



    MODIFY GT_ITEM FROM GS_ITEM INDEX LS_MODI-ROW_ID.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_MODIFIED  text

*      -->P_ET_GOOD_CELLS  text

*----------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED USING P_MODIFIED

                                     PT_GOOD_CELLS TYPE LVC_T_MODI.

  CALL METHOD CL_GUI_CFW=>SET_NEW_OK_CODE

    EXPORTING NEW_CODE = 'CALL'.

  PERFORM REFRESH.

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




*      PARENT                      =




      CONTAINER_NAME              = 'CON01'




*      STYLE                       =

*      LIFETIME                    = lifetime_default

*      REPID                       =

*      DYNNR                       =

*      NO_AUTODEF_PROGID_DYNNR     =

*    EXCEPTIONS

*      CNTL_ERROR                  = 1

*      CNTL_SYSTEM_ERROR           = 2

*      CREATE_ERROR                = 3

*      LIFETIME_ERROR              = 4

*      LIFETIME_DYNPRO_DYNPRO_LINK = 5

*      others                      = 6




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

  CREATE OBJECT GC_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_CUSTOM




*      I_APPL_EVENTS     = space

*      I_PARENTDBG       =

*      I_APPLOGPARENT    =

*      I_GRAPHICSPARENT  =

*      I_NAME            =

*      I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*      ERROR_CNTL_CREATE = 1

*      ERROR_CNTL_INIT   = 2

*      ERROR_CNTL_LINK   = 3

*      ERROR_DP_CREATE   = 4

*      others            = 5




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




FORM FIELD_CATALOG.



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'MARK'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-CHECKBOX  = 'X'.

  GS_FIELDCAT-EDIT      = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-OUTPUTLEN = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-NO_ZERO   = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'DMBTR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-OUTPUTLEN = 13.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-EDIT      = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 6.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 7.

  GS_FIELDCAT-FIELDNAME = 'MWSTS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-OUTPUTLEN = 13.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 8.

  GS_FIELDCAT-FIELDNAME = 'WRBTR'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'. " ## ## ##

  GS_FIELDCAT-OUTPUTLEN = 13.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 9.

  GS_FIELDCAT-FIELDNAME = 'SGTXT'.

  GS_FIELDCAT-COLTEXT   = '###(##)'.

  GS_FIELDCAT-EDIT      = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 15.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 10.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-OUTPUTLEN = 7.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT.

  CLEAR GS_LAYOUT.




*  GS_LAYOUT-ZEBRA = 'X'.




  GS_LAYOUT-NO_TOOLBAR = 'X'.

  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

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



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .

CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = GS_VARIANT

    I_SAVE                        = 'A'




*    I_DEFAULT                     = 'X'




    IS_LAYOUT                     = GS_LAYOUT




*    IS_PRINT                      =

*    IT_SPECIAL_GROUPS             =

*    IT_TOOLBAR_EXCLUDING          =

*    IT_HYPERLINK                  =

*    IT_ALV_GRAPHICS               =

*    IT_EXCEPT_QINFO               =

*    IR_SALV_ADAPTER               =




  CHANGING

    IT_OUTTAB                     = GT_ITEM

    IT_FIELDCATALOG               = GT_FIELDCAT

    IT_SORT                       = GT_SORT




*    IT_FILTER                     =

*  EXCEPTIONS

*    INVALID_PARAMETER_COMBINATION = 1

*    PROGRAM_ERROR                 = 2

*    TOO_MANY_LINES                = 3

*    others                        = 4




        .

IF SY-SUBRC <> 0.




* Implement suitable error handling here




ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH.



  DATA : LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'. "#### USERCOMMAND ###### CURSOR#####"



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE




*      I_SOFT_REFRESH =

*    EXCEPTIONS

*      FINISHED       = 1

*      others         = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALCULATE_TAX

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALCULATE_TAX.

  GV_BALANCE = 0.

  GS_RBKP-WMWST1 = 0.

  LOOP AT GT_ITEM INTO GS_ITEM WHERE MARK = 'X'.

    CASE GS_ITEM-MWSKZ.            "### ##, V1: #### 10%, V4: ##### ## 10% ## X"

      WHEN 'V1' OR 'V4' OR 'V5'.   "V5: ###### (### 10% ##)"

        GS_ITEM-MWSTS = GS_ITEM-DMBTR * '0.1'.

      WHEN OTHERS. "V2: #####(## 0%), V3: #### (### 0%)"

        GS_ITEM-MWSTS = 0.

    ENDCASE.

    GS_RBKP-WMWST1 = GS_RBKP-WMWST1 + GS_ITEM-MWSTS.

    GS_ITEM-WRBTR = GS_ITEM-DMBTR + GS_ITEM-MWSTS. "# ## ### (### + ##)"

    GV_BALANCE = GV_BALANCE + GS_ITEM-WRBTR.

    MODIFY GT_ITEM FROM GS_ITEM.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  UNCALCULATE_TAX

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM UNCALCULATE_TAX.

  GV_BALANCE = 0.

  GS_RBKP-WMWST1 = 0.

  LOOP AT GT_ITEM INTO GS_ITEM WHERE MARK = 'X'.

    GS_ITEM-MWSTS = 0.

    GS_ITEM-WRBTR = GS_ITEM-DMBTR.

    GV_BALANCE = GV_BALANCE + GS_ITEM-WRBTR.

    MODIFY GT_ITEM FROM GS_ITEM.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CACULATE_BALANCE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CACULATE_BALANCE.

  GV_BALANCE = GV_BALANCE - GS_RBKP-RMWWR.

  IF GV_BALANCE = 0.

    GV_COLOR = '@08@'.

  ELSE.

    GV_COLOR = '@0A@'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INVOICE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INVOICE.

  DATA: LV_BUZEI TYPE N LENGTH 4.

  IF GV_BALANCE <> 0.

    MESSAGE '## ### 0# ### ###' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  INSERT ZRBKP_13 FROM GS_RBKP.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ### ## ##' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  LV_BUZEI = 0.

  LOOP AT GT_ITEM INTO GS_ITEM WHERE MARK = 'X'.

    MOVE-CORRESPONDING GS_ITEM TO GS_RSEG.

    LV_BUZEI = LV_BUZEI + 1.

    GS_RSEG-BUZEI = LV_BUZEI.

    APPEND GS_RSEG TO GT_RSEG.

  ENDLOOP.



  INSERT ZRSEG_13 FROM TABLE GT_RSEG.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ### ## ##' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  COMMIT WORK.

  MESSAGE |## ###(#)## { GS_RBKP-BELNR } ## ######| TYPE 'S'.

  LEAVE TO SCREEN 0.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INIT_DATA_0200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INIT_DATA_0200.

  CLEAR : GS_RBKP, GS_RSEG, GT_RSEG.



  SELECT * FROM ZRSEG_13  "## ### ### ##"

    INTO TABLE GT_RSEG

    WHERE EBELN = P1

    AND WERKS = P2

    AND LOEKZ <> 'X'.



  IF GT_RSEG IS INITIAL.

    MESSAGE '### ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  SELECT * FROM ZRBKP_13    "## ## ### ##"

    INTO TABLE GT_RBKP

    FOR ALL ENTRIES IN GT_RSEG

      WHERE BELNR = GT_RSEG-BELNR  "## #### ## ####(BELNR)# #### ##(ZRBKP)# ##.

      AND GJAHR = GT_RSEG-GJAHR

      AND LOEKZ <> 'X'.



  SORT GT_RBKP BY BELNR GJAHR.      "### ## ##"

  SORT GT_RSEG BY BELNR GJAHR BUZEI.



  REFRESH GT_DISPLAY. " ## ### ### ###



  LOOP AT GT_RSEG INTO GS_RSEG.

    CLEAR GS_DISPLAY.



    MOVE-CORRESPONDING GS_RSEG TO GS_DISPLAY.  "### ## ## ##"



    READ TABLE GT_RBKP INTO GS_RBKP      "#### ## ## ### ##"

         WITH KEY BELNR = GS_RSEG-BELNR

                  GJAHR = GS_RSEG-GJAHR

         BINARY SEARCH.

    IF SY-SUBRC = 0.

      GS_DISPLAY-MARK = ' '.

      GS_DISPLAY-LIFNR = GS_RBKP-LIFNR.   "####"

      GS_DISPLAY-BUDAT = GS_RBKP-BUDAT.   "### (#####)"

      GS_DISPLAY-BLDAT = GS_RBKP-BLDAT.   "###"

      GS_DISPLAY-BUKRS = GS_RBKP-BUKRS.   "####"

      GS_DISPLAY-RMWWR = GS_RBKP-RMWWR.   "##"

      GS_DISPLAY-WMWST1 = GS_RBKP-WMWST1. "##"

      GS_DISPLAY-BLART = GS_RBKP-BLART.   "####"

    ENDIF.



    APPEND GS_DISPLAY TO GT_DISPLAY.

  ENDLOOP.

ENDFORM.

FORM CREATE_OBJECT2.

  CREATE OBJECT GC_DOCKING

    EXPORTING




*      PARENT                      =




      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR




*      SIDE                        = DOCK_AT_LEFT




      EXTENSION                   = 2000




*      STYLE                       =

*      LIFETIME                    = lifetime_default

*      CAPTION                     =

*      METRIC                      = 0

*      RATIO                       =

*      NO_AUTODEF_PROGID_DYNNR     =

*      NAME                        =

*    EXCEPTIONS

*      CNTL_ERROR                  = 1

*      CNTL_SYSTEM_ERROR           = 2

*      CREATE_ERROR                = 3

*      LIFETIME_ERROR              = 4

*      LIFETIME_DYNPRO_DYNPRO_LINK = 5

*      others                      = 6




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

  CREATE OBJECT GC_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_DOCKING




*      I_APPL_EVENTS     = space

*      I_PARENTDBG       =

*      I_APPLOGPARENT    =

*      I_GRAPHICSPARENT  =

*      I_NAME            =

*      I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*      ERROR_CNTL_CREATE = 1

*      ERROR_CNTL_INIT   = 2

*      ERROR_CNTL_LINK   = 3

*      ERROR_DP_CREATE   = 4

*      others            = 5




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




FORM FIELD_CATALOG2.

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'MARK'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-CHECKBOX  = 'X'.

  GS_FIELDCAT-EDIT      = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'BELNR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  GS_FIELDCAT-KEY       = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'RMWWR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'BUZEI'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'BUDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 7.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 8.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-OUTPUTLEN = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 9.

  GS_FIELDCAT-FIELDNAME = 'DMBTR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-OUTPUTLEN = 13.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 10.

  GS_FIELDCAT-FIELDNAME = 'MWSTS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-OUTPUTLEN = 13.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 11.

  GS_FIELDCAT-FIELDNAME = 'WRBTR'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-OUTPUTLEN = 13.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 12.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-OUTPUTLEN = 4.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 13.

  GS_FIELDCAT-FIELDNAME = 'SGTXT'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 14.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-OUTPUTLEN = 5.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY2.

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =




      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'




*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = GS_LAYOUT




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = GT_DISPLAY

      IT_FIELDCATALOG               = GT_FIELDCAT

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CANCEL_INVOICE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CANCEL_INVOICE.

  DATA: LV_BELNR TYPE ZRBKP_13-BELNR.

  DATA: LV_GJAHR TYPE ZRBKP_13-GJAHR.

  DATA: LV_CHANGED TYPE C.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY.



  READ TABLE GT_DISPLAY INTO GS_DISPLAY WITH KEY MARK = 'X'.

  IF SY-SUBRC <> 0.

    MESSAGE '### ### #####.' TYPE 'S' DISPLAY LIKE 'W'.

    RETURN.

  ENDIF.



  "### ### ## '## ###(LOEKZ) ####"

  LOOP AT GT_DISPLAY INTO GS_DISPLAY WHERE MARK = 'X'.



    UPDATE ZRSEG_13

       SET LOEKZ = 'X'          " ###### ##

     WHERE BELNR = GS_DISPLAY-BELNR

       AND GJAHR = GS_DISPLAY-GJAHR

       AND BUZEI = GS_DISPLAY-BUZEI.



    UPDATE ZRBKP_13

       SET RMWWR  = RMWWR  - GS_DISPLAY-WRBTR   " ### ##

           WMWST1 = WMWST1 - GS_DISPLAY-MWSTS   " ## ##

     WHERE BELNR  = GS_DISPLAY-BELNR

       AND GJAHR  = GS_DISPLAY-GJAHR.



    "## ### ## # # ##"

    LV_BELNR = GS_DISPLAY-BELNR.

    LV_GJAHR = GS_DISPLAY-GJAHR.

    LV_CHANGED = 'X'.

  ENDLOOP.

  IF LV_CHANGED = 'X'.

    SELECT SINGLE BELNR

      FROM ZRSEG_13

      INTO @DATA(LV_CHECK)

     WHERE BELNR = @LV_BELNR

       AND GJAHR = @LV_GJAHR

       AND LOEKZ = ' '.  " # ## ### ##



    "## ###### -> ### ##"

    IF SY-SUBRC <> 0.

      UPDATE ZRBKP_13

         SET LOEKZ = 'X'

       WHERE BELNR = LV_BELNR

         AND GJAHR = LV_GJAHR.

    ENDIF.



    COMMIT WORK.

    MESSAGE '### ## ### ## #######.' TYPE 'S'.



    PERFORM INIT_DATA_0200.

    CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY.



    " (##) #### ## ## ## ### ### ##

    CALL METHOD CL_GUI_CFW=>FLUSH.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT2.

  CREATE OBJECT GO_EVENT.

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED




*    EXCEPTIONS

*      ERROR      = 1

*      others     = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

ENDFORM.