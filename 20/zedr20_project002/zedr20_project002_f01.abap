
*&---------------------------------------------------------------------*

*&  Include           ZEDR20_PROJECT002_F01

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

    SCREEN-REQUIRED = '2'.

    IF P_R1 = 'X'.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = 1.

      ELSEIF SCREEN-GROUP1 = 'M2'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ELSE.

      IF SCREEN-GROUP1 = 'M2'.

        SCREEN-ACTIVE = 1.

      ELSEIF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

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

  IF P_R1 = 'X'.

    IF P_BUKRS = '' OR S_LIFNR2 IS INITIAL OR P_DATE = ''.

      MESSAGE S000 DISPLAY LIKE 'E'.

      LEAVE LIST-PROCESSING.

    ENDIF.

  ELSE.

    IF S_LIFNR1 IS INITIAL OR P_BUKRS = '' OR P_EBELN = '' .

      MESSAGE S000 DISPLAY LIKE 'E'.

      LEAVE LIST-PROCESSING.

    ENDIF.

  ENDIF.





  PERFORM GET_LIFNR.

  IF GT_LIFNR IS INITIAL.

    MESSAGE '#### ## ######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

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




      CONTAINER_NAME              = 'CUSTOM1'




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

    PERFORM FIELD_CATALOG_EDIT.

  ELSEIF P_R2 = 'X'.

    PERFORM FIELD_CATALOG_NO_EDIT.

  ENDIF.

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

      IT_OUTTAB                     = GT_PO

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

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  SELECT

    *

    FROM ZEDT20_EKKO AS A

    INNER JOIN ZEDT20_EKPO AS B ON A~EBELN = B~EBELN

    INNER JOIN ZEDT20_LFM1 AS C ON A~LIFNR = C~LIFNR

    INTO CORRESPONDING FIELDS OF TABLE GT_PO

    WHERE A~EBELN = P_EBELN

    AND A~LIFNR IN S_LIFNR1

    AND A~BUKRS = P_BUKRS.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_LIFNR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_LIFNR .

  DATA: LV_LIFNR TYPE ZEDT20_LFA1-LIFNR.

  IF P_R1 = 'X'.

    LV_LIFNR = S_LIFNR2-LOW.

  ELSE.

    LV_LIFNR = S_LIFNR1-LOW.

  ENDIF.

  SELECT

    *

    INTO CORRESPONDING FIELDS OF TABLE GT_LIFNR

    FROM ZEDT20_LFB1

    WHERE LIFNR = LV_LIFNR

    AND BUKRS = P_BUKRS.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_TOOLBAR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_OBJECT  text

*      -->P_E_INTERACTIVE  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_TOOLBAR  USING    P_E_OBJECT

                                  P_E_INTERACTIVE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_USER_COMMAND

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_USER_COMMAND  USING    P_E_UCOMM.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  APPEND_LINE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM APPEND_LINE .

  DATA: LV_VALID TYPE C.

    CALL METHOD GC_GRID->CHECK_CHANGED_DATA

      IMPORTING

        E_VALID = LV_VALID.

  DATA: LV_EBELP TYPE N LENGTH 10.

  CLEAR: GS_PO.

  GV_INDEX = GV_INDEX + 1.

  LV_EBELP = GV_INDEX * 10.

  MOVE LV_EBELP TO GS_PO-EBELP.

  APPEND GS_PO TO GT_PO.

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_LINE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DELETE_LINE .

  DELETE GT_PO WHERE ZCHECK = 'X'.

  IF SY-SUBRC = 4.

    MESSAGE '### ### #####.' TYPE 'I'.

    EXIT.

  ENDIF.

  GV_INDEX = LINES( GT_PO ).





  LOOP AT GT_PO INTO GS_PO.   " ## ##

    GS_PO-EBELP = SY-TABIX * 10.

    MODIFY GT_PO FROM GS_PO INDEX SY-TABIX.

  ENDLOOP.

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GENERATE_PO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GENERATE_PO .

  DATA: LV_EBELN TYPE ZEDT20_EKKO-EBELN,

        LV_MSG TYPE STRING.

  SELECT MAX( EBELN ) INTO LV_EBELN FROM ZEDT20_EKKO.

  IF LV_EBELN IS INITIAL.

    LV_EBELN = 4500000001.

  ELSE.

    LV_EBELN = LV_EBELN + 1.

  ENDIF.

  LOOP AT GT_PO INTO GS_PO.

    MOVE-CORRESPONDING GS_PO TO GS_EKKO.

    MOVE-CORRESPONDING GS_PO TO GS_EKPO.

    GS_EKKO-EBELN = LV_EBELN.

    GS_EKPO-EBELN = LV_EBELN.

    GS_EKKO-BEDAT = P_DATE.

    GS_EKKO-BUKRS = P_BUKRS.

    GS_EKKO-LIFNR = S_LIFNR2-LOW.

    PERFORM GET_DATA_FROM_LFM1 USING GS_EKKO-LIFNR

                               CHANGING GS_EKKO-EKGRP GS_EKKO-EKORG.

    APPEND GS_EKKO TO GT_EKKO.

    APPEND GS_EKPO TO GT_EKPO.

  ENDLOOP.

  MODIFY ZEDT20_EKKO FROM TABLE GT_EKKO.

  IF SY-SUBRC = 0.

    MODIFY ZEDT20_EKPO FROM TABLE GT_EKPO.

  ENDIF.

  IF SY-SUBRC = 0.

    CONCATENATE 'PO ### ######. PO## : ' LV_EBELN INTO LV_MSG.

    MESSAGE LV_MSG TYPE 'I'.

    LEAVE TO SCREEN 0.

  ELSE.

    MESSAGE 'PO ### ######.' TYPE 'I'.

    LEAVE TO SCREEN 0.

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

      IS_STABLE = LS_STABLE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_MAX_EBELP

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_GS_PO_EBELP  text

*----------------------------------------------------------------------*




FORM GET_MAX_EBELP  CHANGING P_EBELP.

  DATA: LS_PO LIKE GS_PO,

        LT_PO LIKE GT_PO.

  MOVE GT_PO[] TO LT_PO[].

  SORT LT_PO BY EBELP DESCENDING.

  READ TABLE LT_PO INTO LS_PO INDEX 1.

  MOVE LS_PO-EBELP TO P_EBELP.

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

      WHEN 'MATNR'.

        PERFORM CHECK_MATNR USING LS_MODI P_DATA_CHANGED.

        CHECK SY-SUBRC = 0.

        PERFORM GET_DATA_BY_MATNR USING LS_MODI P_DATA_CHANGED.

      WHEN 'PRDAT'.

        PERFORM CHECK_PRDAT USING LS_MODI P_DATA_CHANGED.

      WHEN 'WERKS'.

        PERFORM CHECK_WERKS USING LS_MODI P_DATA_CHANGED.

      WHEN 'LGORT'.

        PERFORM CHECK_LGORT USING LS_MODI P_DATA_CHANGED.

      WHEN 'MENGE'.

        PERFORM CHECK_MENGE USING LS_MODI P_DATA_CHANGED.

      ENDCASE.

  ENDLOOP.

  PERFORM REFRESH.    " ALV## ####

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_MATNR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_MATNR USING P_MODI TYPE LVC_S_MODI

                       P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.

  SELECT * FROM ZEDT20_MARA INTO CORRESPONDING FIELDS OF TABLE GT_MARA WHERE MATNR = P_MODI-VALUE.



  IF SY-SUBRC NE 0.

    CALL METHOD P_DATA_CHANGED->ADD_PROTOCOL_ENTRY

    EXPORTING

      I_MSGID     = '00'

      I_MSGTY     = 'E'

      I_MSGNO     = '001'

      I_MSGV1     = '#### ## #### ###.'

      I_FIELDNAME = P_MODI-FIELDNAME

      I_ROW_ID    = P_MODI-ROW_ID.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_PRDAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_PRDAT USING P_MODI TYPE LVC_S_MODI

                       P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.

  IF P_DATE GT P_MODI-VALUE.

    CALL METHOD P_DATA_CHANGED->ADD_PROTOCOL_ENTRY

    EXPORTING

      I_MSGID     = '00'

      I_MSGTY     = 'E'

      I_MSGNO     = '001'

      I_MSGV1     = '#### ##### ### ######.'

      I_FIELDNAME = P_MODI-FIELDNAME

      I_ROW_ID    = P_MODI-ROW_ID.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_WERKS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_WERKS USING P_MODI TYPE LVC_S_MODI

                       P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.

  DATA: LV_MATNR TYPE ZEDT20_MARA-MATNR.

  CALL METHOD P_DATA_CHANGED->GET_CELL_VALUE

          EXPORTING

            I_ROW_ID    = P_MODI-ROW_ID

            I_FIELDNAME = 'MATNR'

          IMPORTING

            E_VALUE     = LV_MATNR.

  SELECT

    *

    FROM ZEDT20_MARD

    INTO CORRESPONDING FIELDS OF TABLE GT_MARD

    WHERE MATNR = LV_MATNR

    AND WERKS = P_MODI-VALUE.

  IF SY-SUBRC NE 0.

    CALL METHOD P_DATA_CHANGED->ADD_PROTOCOL_ENTRY

    EXPORTING

      I_MSGID     = '00'

      I_MSGTY     = 'E'

      I_MSGNO     = '001'

      I_MSGV1     = '#### ## ######.'

      I_FIELDNAME = P_MODI-FIELDNAME

      I_ROW_ID    = P_MODI-ROW_ID.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_LGORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_LGORT USING P_MODI TYPE LVC_S_MODI

                       P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.

  DATA: LV_MATNR TYPE ZEDT20_MARA-MATNR.

  CALL METHOD P_DATA_CHANGED->GET_CELL_VALUE

          EXPORTING

            I_ROW_ID    = P_MODI-ROW_ID

            I_FIELDNAME = 'MATNR'

          IMPORTING

            E_VALUE     = LV_MATNR.

  SELECT

    *

    FROM ZEDT20_MARD

    INTO CORRESPONDING FIELDS OF TABLE GT_MARD

    WHERE MATNR = LV_MATNR

    AND LGORT = P_MODI-VALUE.

  IF SY-SUBRC NE 0.

    CALL METHOD P_DATA_CHANGED->ADD_PROTOCOL_ENTRY

    EXPORTING

      I_MSGID     = '00'

      I_MSGTY     = 'E'

      I_MSGNO     = '001'

      I_MSGV1     = '#### ## #######.'

      I_FIELDNAME = P_MODI-FIELDNAME

      I_ROW_ID    = P_MODI-ROW_ID.

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

*&      Form  GET_DATA_FROM_LFM1

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EKKO_LIFNR  text

*      <--P_GS_EKKO_EKGRP  text

*      <--P_GS_EKKO_EKORG  text

*----------------------------------------------------------------------*




FORM GET_DATA_FROM_LFM1  USING    P_LIFNR

                         CHANGING P_EKGRP

                                  P_EKORG.

  SELECT

    *

    FROM ZEDT20_LFM1

    INTO CORRESPONDING FIELDS OF TABLE GT_LFM1

    WHERE LIFNR = P_LIFNR.

  READ TABLE GT_LFM1 INTO GS_LFM1 INDEX 1.



  P_EKGRP = GS_LFM1-EKGRP.

  P_EKORG = GS_LFM1-EKORG.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_MAKTX

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_LS_MODI  text

*----------------------------------------------------------------------*




FORM GET_DATA_BY_MATNR  USING P_MODI TYPE LVC_S_MODI

                      P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.

  READ TABLE GT_PO INTO GS_PO INDEX P_MODI-ROW_ID.

  SELECT

    *

    FROM ZEDT20_MARA

    INTO CORRESPONDING FIELDS OF TABLE GT_MARA

    WHERE MATNR = P_MODI-VALUE.

  SELECT

    *

    FROM ZEDT20_LFM1

    INTO CORRESPONDING FIELDS OF TABLE GT_LFM1

    WHERE LIFNR = S_LIFNR2-LOW.



  READ TABLE GT_MARA INTO GS_MARA INDEX 1.

  READ TABLE GT_LFM1 INTO GS_LFM1 INDEX 1.



  GS_PO-MAKTX = GS_MARA-MAKTX.

  GS_PO-BPRME = GS_MARA-BPRME.

  GS_PO-MEINS = GS_MARA-MEINS.

  GS_PO-WAERS = GS_MARA-WAERS.

  GS_PO-MWSKZ = GS_LFM1-MWSKZ.

  MODIFY GT_PO FROM GS_PO INDEX P_MODI-ROW_ID.

  CLEAR: GS_PO.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_BLANK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_BLANK.

  LOOP AT GT_PO INTO GS_PO.

    IF GS_PO-MATNR = '' OR GS_PO-MAKTX = '' OR GS_PO-BPRME = ''

      OR GS_PO-MEINS = '' OR GS_PO-WAERS = '' OR GS_PO-MWSKZ = '' OR GS_PO-PRDAT = ''

      OR GS_PO-WERKS = '' OR GS_PO-LGORT = ''.

      MESSAGE '### #####' TYPE 'E'.

    ELSEIF GS_PO-MENGE LE 0.

      MESSAGE 'PO ### 0## #####.' TYPE 'E'.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_EDIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_EDIT .

  CLEAR: GS_FIELDCAT, GT_FIELDCAT.

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

 GS_FIELDCAT-EDIT = 'X'.

 GS_FIELDCAT-NO_ZERO = 'X'.

 GS_FIELDCAT-OUTPUTLEN = 10.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 4.

 GS_FIELDCAT-FIELDNAME = 'MAKTX'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 GS_FIELDCAT-OUTPUTLEN = 20.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 5.

 GS_FIELDCAT-FIELDNAME = 'MENGE'.

 GS_FIELDCAT-SCRTEXT_M = 'PO##'.

 GS_FIELDCAT-EDIT = 'X'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 6.

 GS_FIELDCAT-FIELDNAME = 'BPRME'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 GS_FIELDCAT-CFIELDNAME = 'WAERS'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 7.

 GS_FIELDCAT-FIELDNAME = 'WAERS'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 8.

 GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

 GS_FIELDCAT-SCRTEXT_M = '####'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 9.

 GS_FIELDCAT-FIELDNAME = 'PRDAT'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 GS_FIELDCAT-OUTPUTLEN = 12.

 GS_FIELDCAT-EDIT = 'X'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 10.

 GS_FIELDCAT-FIELDNAME = 'WERKS'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 GS_FIELDCAT-EDIT = 'X'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.CLEAR: GS_FIELDCAT.



 GS_FIELDCAT-COL_POS = 11.

 GS_FIELDCAT-FIELDNAME = 'LGORT'.

 GS_FIELDCAT-SCRTEXT_M = '####'.

 GS_FIELDCAT-EDIT = 'X'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_NO_EDIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_NO_EDIT .

  CLEAR: GS_FIELDCAT, GT_FIELDCAT.

 GS_FIELDCAT-COL_POS = 1.

 GS_FIELDCAT-FIELDNAME = 'EBELP'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 2.

 GS_FIELDCAT-FIELDNAME = 'MATNR'.

 GS_FIELDCAT-SCRTEXT_M = '####'.

 GS_FIELDCAT-OUTPUTLEN = 10.

 GS_FIELDCAT-NO_ZERO = 'X'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 3.

 GS_FIELDCAT-FIELDNAME = 'MAKTX'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 GS_FIELDCAT-OUTPUTLEN = 20.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 4.

 GS_FIELDCAT-FIELDNAME = 'MENGE'.

 GS_FIELDCAT-SCRTEXT_M = 'PO##'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 5.

 GS_FIELDCAT-FIELDNAME = 'BPRME'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 GS_FIELDCAT-CFIELDNAME = 'WAERS'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 6.

 GS_FIELDCAT-FIELDNAME = 'WAERS'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 7.

 GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

 GS_FIELDCAT-SCRTEXT_M = '####'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 8.

 GS_FIELDCAT-FIELDNAME = 'PRDAT'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 GS_FIELDCAT-OUTPUTLEN = 12.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 9.

 GS_FIELDCAT-FIELDNAME = 'WERKS'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.CLEAR: GS_FIELDCAT.



 GS_FIELDCAT-COL_POS = 10.

 GS_FIELDCAT-FIELDNAME = 'LGORT'.

 GS_FIELDCAT-SCRTEXT_M = '####'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_MENGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_LS_MODI  text

*      -->P_P_DATA_CHANGED  text

*----------------------------------------------------------------------*




FORM CHECK_MENGE  USING P_MODI TYPE LVC_S_MODI

                       P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.

  IF P_MODI-VALUE LE 0.

    CALL METHOD P_DATA_CHANGED->ADD_PROTOCOL_ENTRY

    EXPORTING

      I_MSGID     = '00'

      I_MSGTY     = 'E'

      I_MSGNO     = '001'

      I_MSGV1     = 'PO ### 0## #####.'

      I_FIELDNAME = P_MODI-FIELDNAME

      I_ROW_ID    = P_MODI-ROW_ID.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_LIFNAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_LIFNAME .

  DATA: LV_LIFNR TYPE ZEDT20_LFA1-LIFNR.

  IF P_R1 = 'X'.

    LV_LIFNR = S_LIFNR2-LOW.

  ELSE.

    LV_LIFNR = S_LIFNR1-LOW.

  ENDIF.

  SELECT

    SINGLE NAME1

    INTO GV_LIFNAME

    FROM ZEDT20_LFA1

    WHERE LIFNR = LV_LIFNR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_AVAILABLE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_AVAILABLE_DATA .

  IF GT_PO IS INITIAL.

    MESSAGE '#### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.