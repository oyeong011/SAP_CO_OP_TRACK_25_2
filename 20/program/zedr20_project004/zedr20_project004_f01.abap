
*&---------------------------------------------------------------------*

*&  Include           ZEDR20_PROJECT004_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SELECTION_SCREEN_OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SELECTION_SCREEN_OUTPUT .

  LOOP AT SCREEN.

    SCREEN-REQUIRED = 2.

    IF P_R2 = 'X'.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_DEFAULT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DEFAULT .

  P_DATE = SY-DATUM.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INPUT .

  IF P_EBELN = '' OR P_WERKS = ''.

    MESSAGE S000 DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

  CHECK P_R1 = 'X'.

  IF P_DATE IS INITIAL.

    MESSAGE S000 DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

  DATA: LV_EBELN TYPE ZEDT20_EKKO-EBELN.

  SELECT

    SINGLE EBELN

    FROM ZEDT20_EKPO

    INTO LV_EBELN

    WHERE EBELN = P_EBELN

    AND WERKS = P_WERKS.

  IF SY-SUBRC <> 0.

    MESSAGE '##### #### #### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_INVOICING_DATA .

  SELECT

    *

    FROM ZEDT20_EKPO AS A

    INNER JOIN ZEDT20_EKKO AS B ON A~EBELN = B~EBELN

    INNER JOIN ZEDT20_MARA AS C ON A~MATNR = C~MATNR

    INTO CORRESPONDING FIELDS OF TABLE GT_INVOICING

    WHERE A~EBELN = P_EBELN

    AND A~WERKS = P_WERKS.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_INVOICE_HEADER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_COMMON_HEADER .

  SELECT

    *

    FROM ZEDT20_EKKO AS A

    INNER JOIN ZEDT20_LFA1 AS B ON A~LIFNR = B~LIFNR

    INTO CORRESPONDING FIELDS OF TABLE GT_COMMON_HEADER

    WHERE A~EBELN = P_EBELN.

  READ TABLE GT_COMMON_HEADER INTO GS_COMMON_HEADER INDEX 1.

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

CREATE OBJECT GC_CUSTOM

  EXPORTING




*    PARENT                      =




    CONTAINER_NAME              = 'CUSTOM1'




*    STYLE                       =

*    LIFETIME                    = lifetime_default

*    REPID                       =

*    DYNNR                       =

*    NO_AUTODEF_PROGID_DYNNR     =

*  EXCEPTIONS

*    CNTL_ERROR                  = 1

*    CNTL_SYSTEM_ERROR           = 2

*    CREATE_ERROR                = 3

*    LIFETIME_ERROR              = 4

*    LIFETIME_DYNPRO_DYNPRO_LINK = 5

*    others                      = 6




    .

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




ENDIF.

CREATE OBJECT GC_GRID

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_CUSTOM




*    I_APPL_EVENTS     = space

*    I_PARENTDBG       =

*    I_APPLOGPARENT    =

*    I_GRAPHICSPARENT  =

*    I_NAME            =

*    I_FCAT_COMPLETE   = SPACE

*  EXCEPTIONS

*    ERROR_CNTL_CREATE = 1

*    ERROR_CNTL_INIT   = 2

*    ERROR_CNTL_LINK   = 3

*    ERROR_DP_CREATE   = 4

*    others            = 5




    .

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




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

  IF P_R1 = 'X'.

    PERFORM INVOICING_FIELD_CATALOG.

  ELSEIF P_R2 = 'X'.

    PERFORM INVOICED_FIELD_CATALOG.

  ENDIF.

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

  GS_LAYOUT-NO_TOOLBAR = 'X'.

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

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_INVOICING_ALV .

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

    IT_OUTTAB                     = GT_INVOICING

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




FORM REFRESH .

  DATA: LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.

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

*&      Form  MODIFY_INVOICING_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_INVOICING_DATA .

  DATA: LS_INVOICED_MENGE LIKE GS_INVOICING-MENGE.

  PERFORM GET_INVOICED_EBELN.

  READ TABLE GT_EBELN INTO GS_EBELN WITH KEY EBELN = P_EBELN.

  IF SY-SUBRC <> 0.   " ###### ## PO## # ##

    LOOP AT GT_INVOICING INTO GS_INVOICING.

      GS_INVOICING-POMENGE = GS_INVOICING-MENGE.

      GS_INVOICING-REMENGE = GS_INVOICING-MENGE.

      PERFORM MODIFY_BY_MENGE USING SY-TABIX.

    ENDLOOP.

  ELSE.

    LOOP AT GT_INVOICING INTO GS_INVOICING.

      DATA: LV_INDEX LIKE SY-TABIX.

      LV_INDEX = SY-TABIX.

      GS_INVOICING-POMENGE = GS_INVOICING-MENGE.

      CLEAR: LS_INVOICED_MENGE.

      PERFORM GET_MENGE USING GS_INVOICING-POMENGE GS_INVOICING-MATNR GS_INVOICING-LGORT

                       CHANGING LS_INVOICED_MENGE.

      GS_INVOICING-MENGE = GS_INVOICING-POMENGE - LS_INVOICED_MENGE.    " ### - ### ##

      GS_INVOICING-REMENGE = GS_INVOICING-MENGE.

      PERFORM MODIFY_BY_MENGE USING LV_INDEX.

    ENDLOOP.

    DELETE GT_INVOICING WHERE REMENGE LE 0.

  ENDIF.

  IF GT_INVOICING IS INITIAL.

    MESSAGE '##### #### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_AMOUNT_HEADER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_AMOUNT_HEADER .

  CLEAR: GV_TAX_RATE.

  SELECT

    *

    FROM ZEDT20_LFM1 AS A

    INNER JOIN ZEDT20_LFB1 AS B ON A~LIFNR = B~LIFNR

    INTO CORRESPONDING FIELDS OF TABLE GT_AMOUNT_HEADER

    WHERE A~LIFNR = GS_COMMON_HEADER-LIFNR.

  READ TABLE GT_AMOUNT_HEADER INTO GS_AMOUNT_HEADER INDEX 1.

  GS_AMOUNT_HEADER-ZCOLOR = C_YELLO.

  GV_TEMP_MWSKZ = GS_AMOUNT_HEADER-MWSKZ.

  PERFORM GET_TAX_RATE USING GS_AMOUNT_HEADER-MWSKZ.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL    " ALV## ### ### ###### ## ##

                                       P_ONF4

                                       P_ONF4_BEFORE

                                       P_ONF4_AFTER

                                       P_UCOMM.

  DATA: LS_MODI TYPE LVC_S_MODI.

  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    CASE LS_MODI-FIELDNAME.

      WHEN 'MENGE'." ## ## ## ### ##

        READ TABLE GT_INVOICING INTO GS_INVOICING INDEX LS_MODI-ROW_ID.

        PERFORM CHECK_MENGE USING P_DATA_CHANGED LS_MODI.

        GS_INVOICING-MENGE = LS_MODI-VALUE.

        PERFORM MODIFY_BY_MENGE USING LS_MODI-ROW_ID.

        PERFORM CALCLUATE_ZBALANCE.

      WHEN 'ZCHECK'.

        IF P_R1 = 'X'.    " ## ## ##

          READ TABLE GT_INVOICING INTO GS_INVOICING INDEX LS_MODI-ROW_ID.

          GS_INVOICING-ZCHECK = LS_MODI-VALUE.

          MODIFY GT_INVOICING FROM GS_INVOICING INDEX LS_MODI-ROW_ID TRANSPORTING ZCHECK.

          PERFORM CALCLUATE_ZBALANCE.

        ELSE.   " ### ### ## ##

          PERFORM CHECK_CANCLED USING P_DATA_CHANGED LS_MODI.

        ENDIF.

      ENDCASE.

  ENDLOOP.

  PERFORM REFRESH.    " ALV## ####

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ERROR_MESSAGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_P_DATA_CHANGED  text

*      -->P_LS_MODI  text

*      -->P_0607   text

*----------------------------------------------------------------------*




FORM ERROR_MESSAGE  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                             P_MODI TYPE LVC_S_MODI

                             P_MSG.

  CALL METHOD P_DATA_CHANGED->ADD_PROTOCOL_ENTRY

    EXPORTING

      I_MSGID     = '00'

      I_MSGTY     = 'E'

      I_MSGNO     = '001'

      I_MSGV1     = P_MSG

      I_FIELDNAME = P_MODI-FIELDNAME

      I_ROW_ID    = P_MODI-ROW_ID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_MENGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_P_DATA_CHANGED  text

*      -->P_LS_MODI  text

*----------------------------------------------------------------------*




FORM CHECK_MENGE  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                           P_MODI TYPE LVC_S_MODI.

  IF P_MODI-VALUE GT GS_INVOICING-REMENGE.

    PERFORM ERROR_MESSAGE USING P_DATA_CHANGED P_MODI '## #### ## ### # ####.'.

  ELSEIF P_MODI-VALUE LE 0.

    PERFORM ERROR_MESSAGE USING P_DATA_CHANGED P_MODI '0## # ## ######.'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_BY_MENGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_P_DATA_CHANGED  text

*      -->P_LS_MODI  text

*----------------------------------------------------------------------*




FORM MODIFY_BY_MENGE USING P_INDEX.

  GS_INVOICING-DMBTR = GS_INVOICING-MENGE * GS_INVOICING-BPRME.

  GS_INVOICING-MWSTS = GS_INVOICING-DMBTR * GV_TAX_RATE.

  GS_INVOICING-ZAMNT = GS_INVOICING-MWSTS + GS_INVOICING-DMBTR.

  MODIFY GT_INVOICING FROM GS_INVOICING INDEX P_INDEX.

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

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT    " #### ### ## ##### ## ##

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED




*    EXCEPTIONS

*      ERROR      = 1

*      others     = 2




          .



  CREATE OBJECT GO_EVENT.

  SET HANDLER GO_EVENT->HANDLE_DATA_CHANGED FOR GC_GRID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_INVOICED_MENGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_INVOICED_EBELN.

  SELECT

    EBELN

    FROM ZEDT20_RSEG

    INTO CORRESPONDING FIELDS OF TABLE GT_EBELN

    WHERE EBELN = P_EBELN.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_MENGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_INVOICING_MENGE  text

*      -->P_GS_INVOICING_MATNR  text

*      <--P_LS_INVOICED_MENGE  text

*----------------------------------------------------------------------*




FORM GET_MENGE  USING    P_MENGE

                         P_MATNR

                         P_LGORT

                CHANGING P_VALUE.

  SELECT

    SUM( MENGE )

    FROM ZEDT20_RSEG

    INTO P_VALUE

    WHERE EBELN = P_EBELN

    AND MATNR = P_MATNR

    AND WERKS = P_WERKS

    AND LGORT = P_LGORT

    AND LOEVM <> 'X'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_HEADER_ICON

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_HEADER_ICON .

  IF GS_AMOUNT_HEADER-ZAMOUNT = 0.

    GS_AMOUNT_HEADER-ZCOLOR = C_YELLO.

  ELSEIF GS_AMOUNT_HEADER-ZBALANCE = 0.

    GS_AMOUNT_HEADER-ZCOLOR = C_GREEN.

  ELSE.

    GS_AMOUNT_HEADER-ZCOLOR = C_RED.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CACLUATE_ZBALANCE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALCLUATE_ZBALANCE.

  "MOVE GS_AMOUNT_HEADER-ZAMOUNT TO GS_AMOUNT_HEADER-ZBALANCE.

  GS_AMOUNT_HEADER-ZBALANCE = 0 - GS_AMOUNT_HEADER-ZAMOUNT.

  LOOP AT GT_INVOICING INTO GS_INVOICING.

    CHECK GS_INVOICING-ZCHECK = 'X'.

    GS_AMOUNT_HEADER-ZBALANCE = GS_AMOUNT_HEADER-ZBALANCE + GS_INVOICING-ZAMNT.

    "GS_AMOUNT_HEADER-ZBALANCE = GS_AMOUNT_HEADER-ZBALANCE - GS_INVOICING-ZAMNT.

  ENDLOOP.



  PERFORM MODIFY_HEADER_ICON.

  CALL METHOD cl_gui_cfw=>set_new_ok_code   " ## ####

    EXPORTING

      new_code = 'DUMMY'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INVOICE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INVOICE .

  PERFORM CHECK_ZBALANCE.

  PERFORM SET_BEARER.    " ####

  PERFORM SET_BSIK.    " ## #### ##

  PERFORM SET_INVOICEMENT.    " #### ##

  PERFORM INSERT_INVOICE_DOCUMENT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SIMULATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SIMULATE . " ## ##### ## ## X

  CLEAR: GT_SIMULATION, GS_SIMULATION, GV_CREDIT, GV_DEBIT.

  PERFORM CHECK_SIMULATE.

  PERFORM SET_SIMULATE_DATA.

  CALL SCREEN 0110 STARTING AT 10 5

                     ENDING   AT 95 20.

  IF GV_EXIT_FROM_POPUP = 'X'.

    LEAVE TO SCREEN 0.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SIMULATE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_SIMULATE_DATA .

  DATA: LV_LINENUM TYPE I VALUE 1,

        LV_SGTXT(14).

  CONCATENATE P_EBELN '####' INTO LV_SGTXT.

  PERFORM SET_CREDIT CHANGING LV_LINENUM LV_SGTXT.   " ##

  PERFORM SET_DEBIT CHANGING LV_LINENUM LV_SGTXT.    " ##

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_PAYMENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_BSIK .

  CLEAR: GS_BSIK.

  GS_BSIK-LIFNR = GS_COMMON_HEADER-LIFNR.

  MOVE-CORRESPONDING GS_BKPF TO GS_BSIK.

  GS_BSIK-SHKZG = 'S'.    " ###

  GS_BSIK-GSBER = P_WERKS.

  GS_BSIK-MWSKZ = GS_AMOUNT_HEADER-MWSKZ.

  PERFORM GET_DMBTR_MWSTS CHANGING GS_BSIK-DMBTR GS_BSIK-MWSTS.

  CONCATENATE P_EBELN '####' INTO GS_BSIK-SGTXT.

  GS_BSIK-EBELN = P_EBELN.

  PERFORM SET_LAST_DAY CHANGING GS_BSIK-ZFBDT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_LAST_DAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_GS_BSIK_ZFBDT  text

*----------------------------------------------------------------------*




FORM SET_LAST_DAY  CHANGING P_ZFBDT.

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN                  = P_DATE

   IMPORTING

     LAST_DAY_OF_MONTH       = P_ZFBDT




*   EXCEPTIONS

*     DAY_IN_NO_DATE          = 1

*     OTHERS                  = 2




            .

  IF SY-SUBRC <> 0.




* Implement suitable error handling here




  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_BEARER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_BEARER .

  CLEAR: GS_BKPF, GS_BSEG, GT_BSEG.

  DATA: LV_R_BELNR TYPE ZEDT20_BKPF-BELNR.

  PERFORM GET_MAX_R_BELNR CHANGING LV_R_BELNR.

  LV_R_BELNR = LV_R_BELNR + 1.

  PERFORM SET_BKPF USING LV_R_BELNR.

  PERFORM SET_BSEG.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_MAX_BELNR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_LV_BELNR  text

*----------------------------------------------------------------------*




FORM GET_MAX_B_BELNR  CHANGING P_BELNR.

  SELECT

    MAX( BELNR )

    INTO P_BELNR

    FROM ZEDT20_BKPF.

   IF P_BELNR IS INITIAL.

    P_BELNR = '5000000000'.

   ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_BKPF

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_LV_BELNR  text

*----------------------------------------------------------------------*




FORM SET_BKPF USING P_BELNR.

  DATA: LV_B_BELNR TYPE ZEDT20_BKPF-BELNR.

  PERFORM GET_MAX_B_BELNR CHANGING LV_B_BELNR.

  GS_BKPF-BUKRS = GS_COMMON_HEADER-BUKRS.

  GS_BKPF-BELNR = LV_B_BELNR + 1.

  GS_BKPF-GJAHR = P_DATE+0(4).

  GS_BKPF-BLART = 'RE'.

  GS_BKPF-BLDAT = P_DATE.

  GS_BKPF-BUDAT = P_DATE.

  GS_BKPF-WAERS = GS_AMOUNT_HEADER-WAERS.

  GS_BKPF-AWKEY = P_BELNR.

  APPEND GS_BKPF TO GT_BKPF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_BSEG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_BSEG .

  DATA: LV_BUZEI TYPE ZEDT20_BSEG-BUZEI VALUE 1.

  DATA: LV_INDEX TYPE I VALUE 1.

  LOOP AT GT_SIMULATION INTO GS_SIMULATION.

    CLEAR: GS_BSEG.

    MOVE-CORRESPONDING GS_BKPF TO GS_BSEG.

    GS_BSEG-BUZEI = LV_INDEX.

    LV_INDEX = LV_INDEX + 1.

    MOVE-CORRESPONDING GS_SIMULATION TO GS_BSEG.

    GS_BSEG-HKONT = GS_SIMULATION-AKONT.

    IF GS_SIMULATION-EBELN <> ''.

      PERFORM GET_DATA_BY_EBELP USING GS_SIMULATION-EBELP

                              CHANGING GS_BSEG-MENGE GS_BSEG-MEINS GS_BSEG-MATNR .

      GS_BSEG-MWSKZ = GS_AMOUNT_HEADER-MWSKZ.

      GS_BSEG-WERKS = P_WERKS.

    ENDIF.

    APPEND GS_BSEG TO GT_BSEG.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_DEBIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DEBIT CHANGING P_LINENUM P_SGTXT.

  DATA: LV_MWSTS TYPE ZEDT20_BSEG-DMBTR VALUE 0.

  LOOP AT GT_INVOICING INTO GS_INVOICING.

    CLEAR: GS_SIMULATION.

    CHECK GS_INVOICING-ZCHECK = 'X'.

    GS_SIMULATION-LINENUM = P_LINENUM.

    GS_SIMULATION-SHZKG = 'S'.

    P_LINENUM = P_LINENUM + 1.

    PERFORM GET_GL USING GS_INVOICING-MATNR

                   CHANGING GS_SIMULATION-AKONT GS_SIMULATION-ZMEMO.

    GS_SIMULATION-DMBTR = GS_INVOICING-DMBTR.

    GS_SIMULATION-WAERS = GS_AMOUNT_HEADER-WAERS.

    GS_SIMULATION-EBELN = P_EBELN.

    GS_SIMULATION-EBELP = GS_INVOICING-EBELP.

    GS_SIMULATION-SGTXT = P_SGTXT.

    APPEND GS_SIMULATION TO GT_SIMULATION.

    LV_MWSTS = LV_MWSTS + GS_INVOICING-MWSTS.

    GV_DEBIT = GV_DEBIT + GS_SIMULATION-DMBTR.    " ## #

  ENDLOOP.

  CLEAR: GS_SIMULATION.

  GS_SIMULATION-LINENUM = P_LINENUM.

  GS_SIMULATION-SHZKG = 'S'.

  GS_SIMULATION-AKONT = '1300000010'.

  GS_SIMULATION-ZMEMO = '#####'.

  GS_SIMULATION-DMBTR = LV_MWSTS.

  GS_SIMULATION-WAERS = GS_AMOUNT_HEADER-WAERS.

  GS_SIMULATION-SGTXT = P_SGTXT.

  GV_DEBIT = GV_DEBIT + GS_SIMULATION-DMBTR.    " ## #

  APPEND GS_SIMULATION TO GT_SIMULATION.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_CREDIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_CREDIT CHANGING P_LINENUM P_SGTXT.

  DATA: LV_AKONT TYPE ZEDT20_LFB1-AKONT.

  GS_SIMULATION-LINENUM = P_LINENUM.

  P_LINENUM = P_LINENUM + 1.

  GS_SIMULATION-SHZKG = 'K'.

  GS_SIMULATION-ZMEMO = GS_COMMON_HEADER-NAME1.

  GS_SIMULATION-DMBTR = GS_AMOUNT_HEADER-ZAMOUNT.

  GS_SIMULATION-WAERS = GS_AMOUNT_HEADER-WAERS.

  GS_SIMULATION-SGTXT = P_SGTXT.

  SELECT

    SINGLE AKONT

    INTO LV_AKONT

    FROM ZEDT20_LFB1

    WHERE LIFNR = GS_COMMON_HEADER-LIFNR.

  GS_SIMULATION-AKONT = LV_AKONT.

  APPEND GS_SIMULATION TO GT_SIMULATION.

  GV_CREDIT = GS_SIMULATION-DMBTR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_GL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_INVOICING_MATNR  text

*----------------------------------------------------------------------*




FORM GET_GL  USING    P_MATNR

             CHANGING P_AKONT P_ZMEMO.

  DATA: LV_MTART TYPE ZEDT20_MARA-MTART.

  SELECT

    SINGLE MTART

    INTO LV_MTART

    FROM ZEDT20_MARA

    WHERE MATNR = P_MATNR.

  CASE LV_MTART.

    WHEN 'ROH'.

      P_AKONT = '2110001010'.

      P_ZMEMO = 'GR/IR-###(#,##)'.

    WHEN 'FERT'.

      P_AKONT = '2110001020'.

      P_ZMEMO = 'GR/IR-###(#,##)'.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_POPUP_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_POPUP_OBJECT .

  CREATE OBJECT GC_POPUP

    EXPORTING




*      PARENT                      =




      CONTAINER_NAME              = 'POPUP1'




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

  CREATE OBJECT GC_POPUP_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_POPUP




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

*&      Form  POPUP_FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM POPUP_FIELD_CATALOG .

  CLEAR: GT_POPUP_FIELDCAT, GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'LINENUM'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-OUTPUTLEN = 5.

  APPEND GS_FIELDCAT TO GT_POPUP_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'SHZKG'.

  GS_FIELDCAT-SCRTEXT_M = '#'.

  GS_FIELDCAT-OUTPUTLEN = 2.

  APPEND GS_FIELDCAT TO GT_POPUP_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'AKONT'.

  GS_FIELDCAT-SCRTEXT_M = 'G/L'.

  APPEND GS_FIELDCAT TO GT_POPUP_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMEMO'.

  GS_FIELDCAT-SCRTEXT_M = 'ACT/MAT/AST/VNDR'.

  GS_FIELDCAT-OUTPUTLEN = 15.

  APPEND GS_FIELDCAT TO GT_POPUP_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DMBTR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_POPUP_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_POPUP_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_POPUP_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_POPUP_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'SGTXT'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-OUTPUTLEN = 18.

  APPEND GS_FIELDCAT TO GT_POPUP_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_POPUP_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_POPUP_ALV .

CALL METHOD GC_POPUP_GRID->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =

*    IS_VARIANT                    =

*    I_SAVE                        =

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

    IT_OUTTAB                     = GT_SIMULATION

    IT_FIELDCATALOG               = GT_POPUP_FIELDCAT




*    IT_SORT                       =

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

*&      Form  REFRESH_POPUP

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH_POPUP .

DATA: LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.

  CALL METHOD GC_POPUP_GRID->REFRESH_TABLE_DISPLAY

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

*&      Form  CHECK_SIMULATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_SIMULATE .

  IF GS_AMOUNT_HEADER-ZAMOUNT = ''.

    MESSAGE '### ######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE TO SCREEN sy-dynnr.

  ENDIF.

  READ TABLE GT_INVOICING INTO GS_INVOICING WITH KEY ZCHECK = 'X'.

  IF SY-SUBRC <> 0.

    MESSAGE '### #### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE TO SCREEN sy-dynnr.

  ELSE.

    LOOP AT GT_INVOICING INTO GS_INVOICING.

      IF GS_INVOICING-ZCHECK = 'X' AND GS_INVOICING-MENGE LE 0.

        MESSAGE '### 0## #####.' TYPE 'S' DISPLAY LIKE 'E'.

        LEAVE TO SCREEN SY-DYNNR.

      ENDIF.

    ENDLOOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_ZBALANCE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_ZBALANCE .

  IF GS_AMOUNT_HEADER-ZBALANCE <> 0.

    MESSAGE '### 0## #####.' TYPE 'E'.

    LEAVE TO SCREEN SY-DYNNR.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_BY_EBELP

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_EBELN  text

*      -->P_EBELP  text

*      <--P_GS_BSEG_MENGE  text

*      <--P_GS_BSEG_MEINS  text

*      <--P_GS_BSEG_MATNR  text

*----------------------------------------------------------------------*




FORM GET_DATA_BY_EBELP  USING    P_EBELP

                        CHANGING P_MENGE

                                 P_MEINS

                                 P_MATNR.

  READ TABLE GT_INVOICING INTO GS_INVOICING WITH KEY EBELP = P_EBELP.

  P_MENGE = GS_INVOICING-MENGE.

  P_MEINS = GS_INVOICING-MEINS.

  P_MATNR = GS_INVOICING-MATNR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DMBTR_MWSTS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_GS_BSIK_DMBTR  text

*      <--P_GS_BSIK_MWSTS  text

*----------------------------------------------------------------------*




FORM GET_DMBTR_MWSTS  CHANGING P_DMBTR

                               P_MWSTS.

  DATA: LV_DMBTR TYPE ZEDT20_BSIK-DMBTR VALUE 0,

        LV_MWSTS TYPE ZEDT20_BSIK-DMBTR VALUE 0.

  LOOP AT GT_INVOICING INTO GS_INVOICING.

    CHECK GS_INVOICING-ZCHECK = 'X'.

    LV_DMBTR = LV_DMBTR + GS_INVOICING-DMBTR.

    LV_MWSTS = LV_MWSTS + GS_INVOICING-MWSTS.

  ENDLOOP.

  P_DMBTR = LV_DMBTR.

  P_MWSTS = LV_MWSTS.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_INVOICEMENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_INVOICEMENT .

  CLEAR: GS_RBKP, GT_RBKP, GS_RSEG, GT_RSEG.

  PERFORM SET_RBKP.

  PERFORM SET_RSEG.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_RBKP

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_RBKP .




*  MOVE-CORRESPONDING GS_BKPF TO GS_RBKP.DATA: LV_BELNR TYPE ZEDT20_BKPF-BELNR.




  DATA: LV_BELNR TYPE ZEDT20_RBKP-BELNR.

  PERFORM GET_MAX_R_BELNR CHANGING LV_BELNR .

  GS_RBKP-BELNR = LV_BELNR + 1.

  GS_RBKP-BUKRS = GS_COMMON_HEADER-BUKRS.

  GS_RBKP-GJAHR = P_DATE+0(4).

  GS_RBKP-BLART = 'RE'.

  GS_RBKP-BLDAT = P_DATE.

  GS_RBKP-BUDAT = P_DATE.

  GS_RBKP-LIFNR = GS_COMMON_HEADER-LIFNR.

  GS_RBKP-WAERS = GS_AMOUNT_HEADER-WAERS.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_RSEG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_RSEG .

  DATA: LV_INDEX TYPE I VALUE 1.

  LOOP AT GT_INVOICING INTO GS_INVOICING.

    CHECK GS_INVOICING-ZCHECK = 'X'.

    MOVE-CORRESPONDING GS_INVOICING TO GS_RSEG.

    MOVE-CORRESPONDING GS_RBKP TO GS_RSEG.

    GS_RSEG-BUZEI = LV_INDEX.

    LV_INDEX = LV_INDEX + 1.

    GS_RSEG-EBELN = P_EBELN.

    GS_RSEG-WERKS = P_WERKS.

    GS_RSEG-WRBTR = GS_INVOICING-ZAMNT.

    GS_RSEG-MWSKZ = GS_AMOUNT_HEADER-MWSKZ.

    APPEND GS_RSEG TO GT_RSEG.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INSERT_INVOICE_DOCUMENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INSERT_INVOICE_DOCUMENT .

  INSERT ZEDT20_BKPF FROM GS_BKPF.

  CHECK SY-SUBRC = 0.

  INSERT ZEDT20_BSEG FROM TABLE GT_BSEG.

  CHECK SY-SUBRC = 0.

  INSERT ZEDT20_BSIK FROM GS_BSIK.

  CHECK SY-SUBRC = 0.

  INSERT ZEDT20_RBKP FROM GS_RBKP.

  CHECK SY-SUBRC = 0.

  INSERT ZEDT20_RSEG FROM TABLE GT_RSEG.

  IF SY-SUBRC <> 0.

    MESSAGE '## ### #######.' TYPE 'E'.

    LEAVE TO SCREEN 0.

  ELSE.

    DATA: LV_MSG TYPE STRING.

    CONCATENATE '## ### #######. ######:' GS_RBKP-BELNR ' / ####:' GS_BKPF-BELNR INTO LV_MSG.

    MESSAGE LV_MSG TYPE 'I'.

    GV_EXIT_FROM_POPUP = 'X'.

    LEAVE TO SCREEN 0.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_INVOICED_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_INVOICED_DATA .

  SELECT

    *

    FROM ZEDT20_RSEG AS A

    INNER JOIN ZEDT20_RBKP AS B ON A~BELNR = B~BELNR

    INNER JOIN ZEDT20_MARA AS C ON A~MATNR = C~MATNR

    INTO CORRESPONDING FIELDS OF TABLE GT_INVOICED

    WHERE A~EBELN = P_EBELN

    AND A~WERKS = P_WERKS.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_INVOICED_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_INVOICED_DATA .

  LOOP AT GT_INVOICED INTO GS_INVOICED.

    PERFORM GET_POMENGE USING P_EBELN GS_INVOICED-MATNR GS_INVOICED-LGORT

                        CHANGING GS_INVOICED-POMENGE.

    PERFORM GET_TAX_RATE USING GS_INVOICED-MWSKZ.

    GS_INVOICED-DMBTR = GS_INVOICED-BPRME * GS_INVOICED-MENGE.

    GS_INVOICED-MWSTS = GS_INVOICED-DMBTR * GV_TAX_RATE.

    IF GS_INVOICED-LOEVM = 'X'.

      GS_INVOICED-ZSTATUS = '##'.

    ENDIF.

    MODIFY GT_INVOICED FROM GS_INVOICED TRANSPORTING DMBTR MWSTS POMENGE ZSTATUS

                                        WHERE BELNR = GS_INVOICED-BELNR

                                        AND BUZEI = GS_INVOICED-BUZEI.

  ENDLOOP.

  SORT GT_INVOICED BY EBELP BELNR BUZEI.

  IF GT_INVOICED IS INITIAL.

    MESSAGE '#### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_POMENGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_POMENGE USING P_EBELN P_MATNR P_LGORT

                 CHANGING P_VALUE.

  SELECT

    SINGLE MENGE

    INTO P_VALUE

    FROM ZEDT20_EKPO

    WHERE EBELN = P_EBELN

    AND MATNR = P_MATNR

    AND LGORT = P_LGORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_TAX_RATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_AMOUNT_HEADER_MWSKZ  text

*----------------------------------------------------------------------*




FORM GET_TAX_RATE  USING    P_MWSKZ.

  CASE P_MWSKZ.

    WHEN 'V1'.

      GV_TEMP_MWSKZ = GS_AMOUNT_HEADER-MWSKZ.

      GS_AMOUNT_HEADER-ZMEMO = '####10%'.

      GV_TAX_RATE = '0.1'.

    WHEN 'V2'.

      GV_TEMP_MWSKZ = GS_AMOUNT_HEADER-MWSKZ.

      GS_AMOUNT_HEADER-ZMEMO = '####0%'.

      GV_TAX_RATE = '0'.

    WHEN 'V3'.

      GV_TEMP_MWSKZ = GS_AMOUNT_HEADER-MWSKZ.

      GS_AMOUNT_HEADER-ZMEMO = '####0%'.

      GV_TAX_RATE = '0'.

    WHEN 'V4'.

      GV_TEMP_MWSKZ = GS_AMOUNT_HEADER-MWSKZ.

      GS_AMOUNT_HEADER-ZMEMO = '#####'.

      GV_TAX_RATE = '0.1'.

    WHEN 'V5'.

      GV_TEMP_MWSKZ = GS_AMOUNT_HEADER-MWSKZ.

      GS_AMOUNT_HEADER-ZMEMO = '######'.

      GV_TAX_RATE = '0.1'.

    WHEN OTHERS.

      MESSAGE '#### ## #######.' TYPE 'S' DISPLAY LIKE 'E'.

      GS_AMOUNT_HEADER-MWSKZ = GV_TEMP_MWSKZ.

      PERFORM REFRESH.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INVOICING_FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INVOICING_FIELD_CATALOG .

CLEAR: GS_FIELDCAT, GT_FIELDCAT.

 GS_FIELDCAT-COL_POS = 1.

 GS_FIELDCAT-FIELDNAME = 'ZCHECK'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 GS_FIELDCAT-CHECKBOX = 'X'.

 GS_FIELDCAT-EDIT = 'X'.

 GS_FIELDCAT-OUTPUTLEN = 4.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 2.

 GS_FIELDCAT-FIELDNAME = 'EBELP'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 3.

 GS_FIELDCAT-FIELDNAME = 'MATNR'.

 GS_FIELDCAT-SCRTEXT_M = '####'.

 GS_FIELDCAT-OUTPUTLEN = 10.

 GS_FIELDCAT-NO_ZERO = 'X'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 4.

 GS_FIELDCAT-FIELDNAME = 'MAKTX'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 GS_FIELDCAT-OUTPUTLEN = 20.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 5.

 GS_FIELDCAT-FIELDNAME = 'POMENGE'.

 GS_FIELDCAT-SCRTEXT_M = 'PO##'.

 GS_FIELDCAT-QFIELDNAME = 'MEINS'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 6.

 GS_FIELDCAT-FIELDNAME = 'MENGE'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 GS_FIELDCAT-QFIELDNAME = 'MEINS'.

 GS_FIELDCAT-EDIT = 'X'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 7.

 GS_FIELDCAT-FIELDNAME = 'MEINS'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 8.

 GS_FIELDCAT-FIELDNAME = 'BPRME'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 GS_FIELDCAT-CFIELDNAME = 'WAERS'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 9.

 GS_FIELDCAT-FIELDNAME = 'WAERS'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 10.

 GS_FIELDCAT-FIELDNAME = 'DMBTR'.

 GS_FIELDCAT-SCRTEXT_M = '####'.

 GS_FIELDCAT-CFIELDNAME = 'WAERS'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 11.

 GS_FIELDCAT-FIELDNAME = 'MWSTS'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 GS_FIELDCAT-CFIELDNAME = 'WAERS'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 12.

 GS_FIELDCAT-FIELDNAME = 'ZAMNT'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 GS_FIELDCAT-CFIELDNAME = 'WAERS'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 13.

 GS_FIELDCAT-FIELDNAME = 'LGORT'.

 GS_FIELDCAT-SCRTEXT_M = '####'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INVOICED_FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INVOICED_FIELD_CATALOG .

CLEAR: GS_FIELDCAT, GT_FIELDCAT.

 GS_FIELDCAT-COL_POS = 1.

 GS_FIELDCAT-FIELDNAME = 'ZCHECK'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 GS_FIELDCAT-CHECKBOX = 'X'.

 GS_FIELDCAT-EDIT = 'X'.

 GS_FIELDCAT-OUTPUTLEN = 4.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 2.

 GS_FIELDCAT-FIELDNAME = 'EBELP'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 GS_FIELDCAT-OUTPUTLEN = 5.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 3.

 GS_FIELDCAT-FIELDNAME = 'MAKTX'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 GS_FIELDCAT-OUTPUTLEN = 20.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 4.

 GS_FIELDCAT-FIELDNAME = 'BELNR'.

 GS_FIELDCAT-SCRTEXT_M = '######'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 5.

 GS_FIELDCAT-FIELDNAME = 'BUZEI'.

 GS_FIELDCAT-SCRTEXT_M = '#####'.

 GS_FIELDCAT-OUTPUTLEN = 8.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.





 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 6.

 GS_FIELDCAT-FIELDNAME = 'POMENGE'.

 GS_FIELDCAT-SCRTEXT_M = 'PO##'.

 GS_FIELDCAT-QFIELDNAME = 'MEINS'.

 GS_FIELDCAT-OUTPUTLEN = 8.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 7.

 GS_FIELDCAT-FIELDNAME = 'MENGE'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 GS_FIELDCAT-QFIELDNAME = 'MEINS'.

 GS_FIELDCAT-OUTPUTLEN = 8.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 8.

 GS_FIELDCAT-FIELDNAME = 'MEINS'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 GS_FIELDCAT-OUTPUTLEN = 4.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 9.

 GS_FIELDCAT-FIELDNAME = 'BPRME'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 GS_FIELDCAT-CFIELDNAME = 'WAERS'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 10.

 GS_FIELDCAT-FIELDNAME = 'WAERS'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 GS_FIELDCAT-OUTPUTLEN = 4.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 11.

 GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

 GS_FIELDCAT-SCRTEXT_M = '####'.

 GS_FIELDCAT-OUTPUTLEN = 3.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 12.

 GS_FIELDCAT-FIELDNAME = 'DMBTR'.

 GS_FIELDCAT-SCRTEXT_M = '####'.

 GS_FIELDCAT-CFIELDNAME = 'WAERS'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 13.

 GS_FIELDCAT-FIELDNAME = 'MWSTS'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 GS_FIELDCAT-CFIELDNAME = 'WAERS'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 14.

 GS_FIELDCAT-FIELDNAME = 'WRBTR'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 GS_FIELDCAT-CFIELDNAME = 'WAERS'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 15.

 GS_FIELDCAT-FIELDNAME = 'LGORT'.

 GS_FIELDCAT-SCRTEXT_M = '####'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 16.

 GS_FIELDCAT-FIELDNAME = 'ZSTATUS'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 GS_FIELDCAT-OUTPUTLEN = 4.

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

  IF P_R1 = 'X'.

    PERFORM CALL_INVOICING_ALV.

  ELSE.

    PERFORM CALL_INVOICED_ALV.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_INVOICED_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_INVOICED_ALV .

CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =

*    IS_VARIANT                    =

*    I_SAVE                        =

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

    IT_OUTTAB                     = GT_INVOICED

    IT_FIELDCATALOG               = GT_FIELDCAT




*    IT_SORT                       =

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

*&      Form  DELETE_INVOICED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DELETE_INVOICED .

  LOOP AT GT_INVOICED INTO GS_INVOICED.

    CHECK GS_INVOICED-ZCHECK = 'X'.

    GS_INVOICED-LOEVM = 'X'.

    GS_INVOICED-ZSTATUS = '##'.

    "GS_INVOICED-ZCHECK = ''.

    MODIFY GT_INVOICED FROM GS_INVOICED INDEX SY-TABIX.

    CLEAR: GS_RSEG, GS_BSEG.

    PERFORM SET_RSEG_CANCLED USING GS_INVOICED-BELNR GS_INVOICED-BUZEI.



  ENDLOOP.

  MODIFY ZEDT20_RSEG FROM TABLE GT_RSEG.

  IF SY-SUBRC <> 0.

    MESSAGE '### #######.' TYPE 'E'.

  ELSE.

    MESSAGE '#### #####.' TYPE 'I'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_RSEG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_INVOICED_BELNR  text

*      -->P_GS_INVOICED_BUZEI  text

*----------------------------------------------------------------------*




FORM SET_RSEG_CANCLED  USING    P_BELNR

                        P_BUZEI.

  SELECT

    SINGLE *

    INTO GS_RSEG

    FROM ZEDT20_RSEG

    WHERE BELNR = P_BELNR

    AND BUZEI = P_BUZEI.

  GS_RSEG-LOEVM = 'X'.

  APPEND GS_RSEG TO GT_RSEG.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_BSEG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_BSEG USING P_BELNR.

  SELECT

    *

    FROM ZEDT20_BSEG

    INTO CORRESPONDING FIELDS OF TABLE GT_BSEG

    WHERE BELNR = P_BELNR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_BSIK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_P_BELNR  text

*----------------------------------------------------------------------*




FORM GET_BSIK  USING    P_BELNR.

  SELECT

    SINGLE *

    INTO GS_BSIK

    FROM ZEDT20_BSIK

    WHERE BELNR = P_BELNR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_MAX_R_BELNR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_GS_RBKP_BELNR  text

*----------------------------------------------------------------------*




FORM GET_MAX_R_BELNR  CHANGING P_BELNR.

  SELECT

    MAX( BELNR )

    INTO P_BELNR

    FROM ZEDT20_RBKP.

   IF P_BELNR IS INITIAL.

    P_BELNR = '5100000000'.

   ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REVERSAL_ENTRY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REVERSAL_ENTRY .   " ####### ## # #####... ## ## #### ####

  CLEAR: GT_RSEG, GT_BSEG, GS_BSEG, GS_BSIK.

  DATA: LV_DEBIT TYPE ZEDT20_BSEG-DMBTR,

        LV_MWSTS TYPE ZEDT20_BSEG-DMBTR,

        LV_INDEX TYPE I VALUE 2,

        LV_WAERS TYPE ZEDT20_EKKO-WAERS.

  DATA: LT_INVOICED LIKE GT_INVOICED.

  LOOP AT GT_INVOICED INTO GS_INVOICED.   " ##### ## LT_INVOICED# ###

    CHECK GS_INVOICED-ZCHECK = 'X'.

    APPEND GS_INVOICED TO LT_INVOICED.

  ENDLOOP.

  SORT LT_INVOICED BY BELNR BUZEI.    " ###### ### ###### ### ###### ##

  DATA: LV_INVOICED_BELNR LIKE GS_INVOICED-BELNR.



  LOOP AT LT_INVOICED INTO GS_INVOICED.

    DATA: LS_INVOICED LIKE GS_INVOICED.

    IF LV_INVOICED_BELNR IS INITIAL.

      " ### ### ## ## ####### ## ### ## ##

      PERFORM SET_BKPF_CANCLED USING GS_INVOICED-BELNR.   " ###### AWKEY# ## ####### ### ## AWKEY# ##

      INSERT ZEDT20_BKPF FROM GS_BKPF.

    ELSEIF LV_INVOICED_BELNR <> GS_INVOICED-BELNR.

      PERFORM SET_BSEG_CANCLED_EXTRA USING LS_INVOICED LV_INDEX LV_DEBIT LV_MWSTS.   " ##, ##### ### ##

      INSERT ZEDT20_BSEG FROM TABLE GT_BSEG.    " ## ##

      PERFORM SET_BSIK_CANCLED USING LS_INVOICED-BELNR.   " ### ## ###### ### ### ##

      INSERT ZEDT20_BSIK FROM GS_BSIK.

      CLEAR: GS_BSIK, GT_BSEG.

      " #### ##, ##### ###, ### ####.

      LV_DEBIT = 0.

      LV_MWSTS = 0.

      LV_INDEX = 2.

      PERFORM SET_BKPF_CANCLED USING GS_INVOICED-BELNR.   " ####### ## ## ## ## ###

      INSERT ZEDT20_BKPF FROM GS_BKPF.    " #### ##

    ENDIF.

    MOVE-CORRESPONDING GS_BKPF TO GS_BSEG.

    PERFORM SET_BSEG_CANCLED USING GS_INVOICED LV_INDEX.    " ### #### ## ### ### ##

    LV_DEBIT = LV_DEBIT + GS_INVOICED-DMBTR + GS_INVOICED-MWSTS.    " ### ### GRIR + ### #

    LV_MWSTS = LV_MWSTS + GS_INVOICED-MWSTS.    " ### ###

    LV_INDEX = LV_INDEX + 1.

    LV_INVOICED_BELNR = GS_INVOICED-BELNR.    " ## ### ## ###### ##

    MOVE-CORRESPONDING GS_INVOICED TO LS_INVOICED.

  ENDLOOP.

  PERFORM SET_BSEG_CANCLED_EXTRA USING GS_INVOICED LV_INDEX LV_DEBIT LV_MWSTS.   " ##, ##### ### ##

  INSERT ZEDT20_BSEG FROM TABLE GT_BSEG.    " ## ##

  PERFORM SET_BSIK_CANCLED USING GS_INVOICED-BELNR.   " ### ## ###### ### ### ##

  INSERT ZEDT20_BSIK FROM GS_BSIK.     " ### ### ##

  " ## ###

  MESSAGE '### ##' TYPE 'I'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_BSEG_CANCLED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_INVOICED  text

*----------------------------------------------------------------------*




FORM SET_BSEG_CANCLED  USING    PS_INVOICED LIKE GS_INVOICED

                                P_INDEX.

  MOVE-CORRESPONDING GS_INVOICED TO GS_BSEG.

  PERFORM SET_BSEG_COMMON.

  GS_BSEG-BUZEI = P_INDEX.

  GS_BSEG-SHZKG = 'K'.

  APPEND GS_BSEG TO GT_BSEG.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_BSEG_CANCLED_EXTRA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_LV_DEBIT  text

*      -->P_LV_MWSTS  text

*----------------------------------------------------------------------*




FORM SET_BSEG_CANCLED_EXTRA  USING    PS_INVOICED LIKE GS_INVOICED

                                      P_INDEX

                                      P_DEBIT

                                      P_MWSTS.

  CLEAR: GS_BSEG.

  PERFORM SET_BSEG_COMMON.

 GS_BSEG-DMBTR = P_MWSTS.

 GS_BSEG-MWSKZ = PS_INVOICED-MWSKZ.

 GS_BSEG-BUZEI = P_INDEX.

 GS_BSEG-SHZKG = 'K'.

 APPEND GS_BSEG TO GT_BSEG.



 GS_BSEG-DMBTR = P_DEBIT.

 GS_BSEG-SHZKG = 'S'.

 GS_BSEG-BUZEI = 1.

 INSERT GS_BSEG INTO GT_BSEG INDEX 1.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_BSEG_COMMON

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_BSEG_COMMON .

  SELECT

    SINGLE AKONT

    INTO GS_BSEG-HKONT

    FROM ZEDT20_LFB1

    WHERE LIFNR = GS_COMMON_HEADER-LIFNR.

  GS_BSEG-BUKRS = GS_COMMON_HEADER-BUKRS.

  MOVE-CORRESPONDING GS_BKPF TO GS_BSEG.

  GS_BSEG-EBELN = P_EBELN.

  GS_BSEG-WERKS = P_WERKS.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_BSIK_CANCLED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_BSIK_CANCLED USING P_BELNR.

  DATA: LV_DMBTR TYPE ZEDT20_BSEG-DMBTR.

  CLEAR: GS_BSIK.

  MOVE-CORRESPONDING GS_BKPF TO GS_BSIK.

 LOOP AT GT_BSEG INTO GS_BSEG.

   CHECK GS_BSEG-EBELN <> ''.

   MOVE-CORRESPONDING GS_BSEG TO GS_BSIK.

   GS_BSIK-DMBTR = GS_BSIK-DMBTR + GS_BSEG-DMBTR.

 ENDLOOP.

 GS_BSIK-SHKZG = 'K'.

 GS_BSIK-MWSTS = GS_BSEG-DMBTR.

 GS_BSIK-GSBER = P_WERKS.

 GS_BSIK-LIFNR = GS_COMMON_HEADER-LIFNR.

 CONCATENATE P_BELNR '####' INTO GS_BSIK-SGTXT.

 PERFORM SET_LAST_DAY CHANGING GS_BSIK-ZFBDT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_BKPF_CANCLED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_INVOICED_BELNR  text

*----------------------------------------------------------------------*




FORM SET_BKPF_CANCLED  USING    P_BELNR.

  DATA: LV_AWKEY TYPE ZEDT20_BKPF-AWKEY.

  PERFORM GET_AWKEY USING P_BELNR

                    CHANGING LV_AWKEY.

  DATA: LV_B_BELNR TYPE ZEDT20_BKPF-BELNR.

  PERFORM GET_MAX_B_BELNR CHANGING LV_B_BELNR.

  GS_BKPF-BUKRS = GS_COMMON_HEADER-BUKRS.

  GS_BKPF-BELNR = LV_B_BELNR + 1.

  GS_BKPF-GJAHR = SY-DATUM+0(4).    " ####, ###, #### ### ##

  GS_BKPF-BLART = 'KG'.   " ####

  GS_BKPF-BLDAT = SY-DATUM.

  GS_BKPF-BUDAT = SY-DATUM.

  GS_BKPF-WAERS = GS_INVOICED-WAERS.

  GS_BKPF-AWKEY = LV_AWKEY.

  APPEND GS_BKPF TO GT_BKPF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_AWKEY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_P_BELNR  text

*      <--P_LV_AWKEY  text

*----------------------------------------------------------------------*




FORM GET_AWKEY  USING    P_BELNR

                CHANGING P_AWKEY.

  SELECT

    SINGLE BELNR

    INTO P_AWKEY

    FROM ZEDT20_BKPF

    WHERE AWKEY = P_BELNR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_CANCLED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_P_DATA_CHANGED  text

*      -->P_LS_MODI  text

*----------------------------------------------------------------------*




FORM CHECK_CANCLED USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                         P_MODI TYPE LVC_S_MODI.

  DATA: LV_ZSTATUS LIKE GS_INVOICED-ZSTATUS.

  CALL METHOD P_DATA_CHANGED->GET_CELL_VALUE

          EXPORTING

            I_ROW_ID    = P_MODI-ROW_ID

            I_FIELDNAME = 'ZSTATUS'

          IMPORTING

            E_VALUE     = LV_ZSTATUS.

  IF LV_ZSTATUS = '##'.

    PERFORM ERROR_MESSAGE USING P_DATA_CHANGED P_MODI '## ### #### #### # ####.'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_BY_CHANGED_TAX_RATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_BY_CHANGED_TAX_RATE .

  LOOP AT GT_INVOICING INTO GS_INVOICING.

    PERFORM MODIFY_BY_MENGE USING SY-TABIX.

  ENDLOOP.

ENDFORM.