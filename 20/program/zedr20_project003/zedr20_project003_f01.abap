
*&---------------------------------------------------------------------*

*&  Include           ZEDR20_PROJECT003_F01

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

      ENDIF.

    ELSE.

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

  S_BLDAT-LOW = SY-DATUM.

  APPEND S_BLDAT.

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

  IF P_R1 = 'X' AND S_BLDAT IS INITIAL.

    MESSAGE S000 DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

  PERFORM CHECK_AVAILABLE_EBELN.

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

    INNER JOIN ZEDT20_MARA AS C ON B~MATNR = C~MATNR

    INTO CORRESPONDING FIELDS OF TABLE GT_MIGO

    WHERE A~EBELN = P_EBELN

    AND B~WERKS = P_WERKS.

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

    PERFORM FIELD_CATALOG_PROCESSING.

  ELSE.

    PERFORM FIELD_CATALOG_SELECTING.

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

  IF P_R2 = 'X'.

    CLEAR GS_SORT.

    GS_SORT-FIELDNAME = 'EBELP'. " ### ### (##)

    GS_SORT-UP        = 'X'.     " #### (ASCENDING)

    APPEND GS_SORT TO GT_SORT.

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

  GS_LAYOUT-NO_TOOLBAR  = ABAP_TRUE.

  IF P_R2 = 'X'.

    GS_LAYOUT-NO_MERGING = SPACE.

    GS_LAYOUT-NO_MERGING  = ABAP_TRUE.

  ENDIF.

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

    PERFORM CALL_ALV_PROCESSING.

  ELSE.

    PERFORM CALL_ALV_WAREHOUSED.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_AVAILABLE_EBELN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_AVAILABLE_EBELN .

  SELECT

    *

    FROM ZEDT20_EKKO

    INTO CORRESPONDING FIELDS OF TABLE GT_EKKO

    WHERE EBELN = P_EBELN.

  IF SY-SUBRC <> 0.

    MESSAGE '#### #### ### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_PROCESSING

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_PROCESSING .

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

 GS_FIELDCAT-FIELDNAME = 'EBELN'.

 GS_FIELDCAT-SCRTEXT_M = '######'.

 GS_FIELDCAT-NO_OUT = 'X'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 3.

 GS_FIELDCAT-FIELDNAME = 'EBELP'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 4.

 GS_FIELDCAT-FIELDNAME = 'LIFNR'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 GS_FIELDCAT-NO_OUT = 'X'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 5.

 GS_FIELDCAT-FIELDNAME = 'BEDAT'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 GS_FIELDCAT-OUTPUTLEN = 11.

 GS_FIELDCAT-NO_OUT = 'X'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 6.

 GS_FIELDCAT-FIELDNAME = 'MATNR'.

 GS_FIELDCAT-SCRTEXT_M = '####'.

 GS_FIELDCAT-OUTPUTLEN = 10.

 GS_FIELDCAT-NO_ZERO = 'X'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 7.

 GS_FIELDCAT-FIELDNAME = 'MAKTX'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 GS_FIELDCAT-OUTPUTLEN = 20.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 8.

 GS_FIELDCAT-FIELDNAME = 'POMENGE'.

 GS_FIELDCAT-SCRTEXT_M = 'PO##'.

 GS_FIELDCAT-QFIELDNAME = 'MEINS'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 9.

 GS_FIELDCAT-FIELDNAME = 'MENGE'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 GS_FIELDCAT-QFIELDNAME = 'MEINS'.

 GS_FIELDCAT-EDIT = 'X'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 10.

 GS_FIELDCAT-FIELDNAME = 'MEINS'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 11.

 GS_FIELDCAT-FIELDNAME = 'BPRME'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 GS_FIELDCAT-CFIELDNAME = 'WAERS'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 12.

 GS_FIELDCAT-FIELDNAME = 'WAERS'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 13.

 GS_FIELDCAT-FIELDNAME = 'PRDAT'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 GS_FIELDCAT-OUTPUTLEN = 11.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 14.

 GS_FIELDCAT-FIELDNAME = 'WERKS'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 GS_FIELDCAT-NO_OUT = 'X'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 15.

 GS_FIELDCAT-FIELDNAME = 'LGORT'.

 GS_FIELDCAT-SCRTEXT_M = '####'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_SELECTING

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_SELECTING .

 CLEAR: GS_FIELDCAT, GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

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

 GS_FIELDCAT-KEY = 'X'.

 GS_FIELDCAT-NO_MERGING = SPACE.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 3.

 GS_FIELDCAT-FIELDNAME = 'MAKTX'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 GS_FIELDCAT-OUTPUTLEN = 20.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 4.

 GS_FIELDCAT-FIELDNAME = 'MBLNR'.

 GS_FIELDCAT-SCRTEXT_M = '######'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 5.

 GS_FIELDCAT-FIELDNAME = 'ZEILE'.

 GS_FIELDCAT-SCRTEXT_M = '#####'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 6.

 GS_FIELDCAT-FIELDNAME = 'POMENGE'.

 GS_FIELDCAT-SCRTEXT_M = 'PO##'.

 GS_FIELDCAT-QFIELDNAME = 'MEINS'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 7.

 GS_FIELDCAT-FIELDNAME = 'MENGE'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 GS_FIELDCAT-QFIELDNAME = 'MEINS'.

 "GS_FIELDCAT-DO_SUM = 'x'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 8.

 GS_FIELDCAT-FIELDNAME = 'MEINS'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 9.

 GS_FIELDCAT-FIELDNAME = 'ZLSTATUS'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 10.

 GS_FIELDCAT-FIELDNAME = 'BLDAT'.

 GS_FIELDCAT-SCRTEXT_M = '###'.

 GS_FIELDCAT-OUTPUTLEN = 11.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



 CLEAR: GS_FIELDCAT.

 GS_FIELDCAT-COL_POS = 11.

 GS_FIELDCAT-FIELDNAME = 'LGORT'.

 GS_FIELDCAT-SCRTEXT_M = '####'.

 APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_WAREHOUSED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA_WAREHOUSED .

  PERFORM GET_WAREHOUSED_HEADER.

  PERFORM GET_WAREHOUSED_ALV.

  PERFORM MODIFY_WAREHOUSED_ALV.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_WAREHOUSED_EBELN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_WAREHOUSED_HEADER.

  SELECT

    *

    FROM ZEDT20_EKKO AS A

    INNER JOIN ZEDT20_LFA1 AS B ON A~LIFNR = B~LIFNR

    INTO CORRESPONDING FIELDS OF TABLE GT_WAREHOUSED_HEADER

    WHERE EBELN = P_EBELN.

  READ TABLE GT_WAREHOUSED_HEADER INTO GS_WAREHOUSED_HEADER INDEX 1.

  GS_WAREHOUSED_HEADER-WERKS = P_WERKS.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_WAREHOUSED_EXTRA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_WAREHOUSED_ALV .

  SELECT

    A~EBELN

    A~EBELP

    B~MBLNR

    B~ZEILE

    A~MAKTX

    A~MENGE AS POMENGE

    B~MENGE

    B~MEINS

    C~BLDAT

    B~LGORT

    B~LOEVM

    FROM ZEDT20_EKPO AS A

    INNER JOIN ZEDT20_MSEG AS B ON A~EBELN = B~EBELN AND A~MATNR = B~MATNR AND A~WERKS = B~WERKS AND A~LGORT = B~LGORT

    INNER JOIN ZEDT20_MKPF AS C ON B~MBLNR = C~MBLNR

    INTO CORRESPONDING FIELDS OF TABLE GT_WAREHOUSED_ALV

    WHERE A~EBELN IN ( SELECT

                        EBELN

                        FROM ZEDT20_MSEG

                        WHERE EBELN = P_EBELN )

    AND A~WERKS = P_WERKS.

    IF SY-SUBRC <> 0.

      MESSAGE '#### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

      LEAVE LIST-PROCESSING.

    ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA .

  DATA: LS_WAREHOUSED_MENGE LIKE GS_MIGO-MENGE.

  PERFORM GET_WAREHOUSED_EBELN.

  IF SY-SUBRC = 0.    " ## ##### ##### # # ###

   LOOP AT GT_MIGO INTO GS_MIGO.

     GS_MIGO-POMENGE = GS_MIGO-MENGE.

     GS_MIGO-REMENGE = GS_MIGO-MENGE.

     READ TABLE GT_EBELN INTO GS_EBELN WITH KEY EBELN = GS_MIGO-EBELN.

     CHECK SY-SUBRC = 0.    " ## ### #### # # ###

     CLEAR: LS_WAREHOUSED_MENGE.

     PERFORM GET_MENGE USING GS_MIGO-EBELN GS_MIGO-MATNR GS_MIGO-LGORT

                       CHANGING LS_WAREHOUSED_MENGE.



     GS_MIGO-MENGE = GS_MIGO-MENGE - LS_WAREHOUSED_MENGE.

     GS_MIGO-REMENGE = GS_MIGO-MENGE.

     MODIFY GT_MIGO FROM GS_MIGO TRANSPORTING POMENGE REMENGE MENGE WHERE MATNR = GS_MIGO-MATNR AND LGORT = GS_MIGO-LGORT.

   ENDLOOP.

   DELETE GT_MIGO WHERE REMENGE LE 0.

  ELSE.   " ###

    LOOP AT GT_MIGO INTO GS_MIGO.

      GS_MIGO-POMENGE = GS_MIGO-MENGE.

      GS_MIGO-REMENGE = GS_MIGO-MENGE.

      MODIFY GT_MIGO FROM GS_MIGO TRANSPORTING POMENGE REMENGE MENGE WHERE MATNR = GS_MIGO-MATNR AND LGORT = GS_MIGO-LGORT.

    ENDLOOP.

  ENDIF.

  IF GT_MIGO IS INITIAL.

    MESSAGE '#### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV_PROCESSING

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV_PROCESSING .

CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

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

      IT_OUTTAB                     = GT_MIGO

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

*&      Form  CALL_ALV_WAREHOUSED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV_WAREHOUSED .

CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

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

      IT_OUTTAB                     = GT_WAREHOUSED_ALV

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

*&      Form  WAREHOUSING_ITEMS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM WAREHOUSING_ITEMS .

  DATA: LV_MBLNR TYPE ZEDT20_MSEG-MBLNR.

  DATA: LV_ZEILE TYPE I VALUE 1.

  PERFORM GET_MBLNR CHANGING LV_MBLNR.

  CLEAR: GS_MKPF.

  GS_MKPF-MBLNR = LV_MBLNR.

  GS_MKPF-MJAHR = S_BLDAT-LOW+0(4).

  GS_MKPF-BLART = 'WE'.

  GS_MKPF-BLDAT = S_BLDAT-LOW.

  GS_MKPF-BUDAT = S_BLDAT-LOW.

  LOOP AT GT_MIGO INTO GS_MIGO.

    CHECK GS_MIGO-ZCHECK = 'X'.



    CLEAR: GS_MSEG.

    MOVE-CORRESPONDING GS_MIGO TO GS_MSEG.

    MOVE-CORRESPONDING GS_MKPF TO GS_MSEG.

    GS_MSEG-ZEILE = LV_ZEILE.

    LV_ZEILE = LV_ZEILE + 1.

    APPEND GS_MSEG TO GT_MSEG.

  ENDLOOP.

  PERFORM INSERT_WAREHOUSING_ITMES.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_MENGE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_MIGO_EBELN  text

*----------------------------------------------------------------------*




FORM GET_MENGE  USING    P_EBELN P_MATNR P_LGORT

                CHANGING P_VALUE.

  SELECT    " ## ### ## # #### ### ### ### #

    SUM( MENGE )

    FROM ZEDT20_MSEG

    INTO P_VALUE

    WHERE EBELN = P_EBELN

    AND MATNR = P_MATNR

    AND WERKS = P_WERKS

    AND LGORT = P_LGORT

    AND LOEVM <> 'X'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_MBLNR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_LV_MBLNR  text

*----------------------------------------------------------------------*




FORM GET_MBLNR  CHANGING P_MBLNR.

  SELECT

    MAX( MBLNR )

    FROM ZEDT20_MKPF

    INTO P_MBLNR.



  IF P_MBLNR IS INITIAL.

    P_MBLNR = 5000000001.

  ELSE.

    P_MBLNR = P_MBLNR + 1.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INSERT_WAREHOUSING_ITMES

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INSERT_WAREHOUSING_ITMES .

  DATA: LV_MSG TYPE STRING.

  INSERT ZEDT20_MKPF FROM GS_MKPF.

  IF SY-SUBRC = 0.

    INSERT ZEDT20_MSEG FROM TABLE GT_MSEG.

  ENDIF.

  IF SY-SUBRC = 0.

    CONCATENATE '## ## #####. ######:' GS_MKPF-MBLNR INTO LV_MSG.

    MESSAGE LV_MSG TYPE 'I'.

    LEAVE TO SCREEN 0.

  ELSE.

    MESSAGE '##### #######.' TYPE 'I'.

    EXIT.

  ENDIF.

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

      WHEN 'MENGE'.

        READ TABLE GT_MIGO INTO GS_MIGO INDEX LS_MODI-ROW_ID.

        IF LS_MODI-VALUE GT GS_MIGO-REMENGE.

          PERFORM ERROR_MESSAGE USING P_DATA_CHANGED LS_MODI '## PO#### ## ### # ####.'.

        ELSEIF LS_MODI-VALUE LE 0.

          PERFORM ERROR_MESSAGE USING P_DATA_CHANGED LS_MODI '0## # ## ######.'.

        ENDIF.

      WHEN 'ZCHECK'.

        CHECK P_R2 = 'X'.

        PERFORM CHECK_CANCLED USING P_DATA_CHANGED LS_MODI.

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

*      -->P_P_MODI  text

*      -->P_0987   text

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

*&      Form  GET_WAREHOUSED_EBELN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_WAREHOUSED_EBELN .

  SELECT

    EBELN

    FROM ZEDT20_MSEG

    INTO CORRESPONDING FIELDS OF TABLE GT_EBELN

    WHERE EBELN = P_EBELN

    AND WERKS = P_WERKS.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_WAREHOUSED_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_WAREHOUSED_ALV .

  SORT GT_WAREHOUSED_ALV BY EBELP MBLNR.

  LOOP AT GT_WAREHOUSED_ALV INTO GS_WAREHOUSED_ALV.

    CASE GS_WAREHOUSED_ALV-LOEVM.

      WHEN 'X'.

        GS_WAREHOUSED_ALV-ZLSTATUS = '##'.

      ENDCASE.

    MODIFY GT_WAREHOUSED_ALV FROM GS_WAREHOUSED_ALV TRANSPORTING ZLSTATUS.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_WAREHOUSED_ITEMS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DELETE_WAREHOUSED_ITEMS .

  DATA: LT_MSEG LIKE GT_MSEG.

  CLEAR: GT_MSEG, GS_MSEG.

  PERFORM GET_DATA_MSEG.

  LOOP AT GT_WAREHOUSED_ALV INTO GS_WAREHOUSED_ALV.

    CHECK GS_WAREHOUSED_ALV-ZCHECK = 'X'.



    READ TABLE GT_MSEG INTO GS_MSEG WITH KEY MBLNR = GS_WAREHOUSED_ALV-MBLNR

                                             ZEILE = GS_WAREHOUSED_ALV-ZEILE.

    GS_MSEG-LOEVM = 'X'.

    APPEND GS_MSEG TO LT_MSEG.

    GS_WAREHOUSED_ALV-LOEVM = 'X'.

    GS_WAREHOUSED_ALV-ZLSTATUS = '##'.

    GS_WAREHOUSED_ALV-ZCHECK = ''.

    MODIFY GT_WAREHOUSED_ALV FROM GS_WAREHOUSED_ALV TRANSPORTING ZLSTATUS LOEVM ZCHECK.

  ENDLOOP.

  MODIFY ZEDT20_MSEG FROM TABLE LT_MSEG.

  IF SY-SUBRC = 0.

    MESSAGE '##### #######.' TYPE 'I'.

  ELSE.

    MESSAGE '### #######.' TYPE 'S' DISPLAY LIKE 'E'.

  ENDIF.

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_MSEG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA_MSEG .

  SELECT

    *

    FROM ZEDT20_MSEG

    INTO CORRESPONDING FIELDS OF TABLE GT_MSEG.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_HEADER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA_HEADER .

  SELECT

    *

    FROM ZEDT20_EKKO AS A

    INNER JOIN ZEDT20_LFA1 AS B ON A~LIFNR = B~LIFNR

    INTO CORRESPONDING FIELDS OF TABLE GT_WAREHOUSED_HEADER

    WHERE A~EBELN = P_EBELN.

  READ TABLE GT_WAREHOUSED_HEADER INTO GS_WAREHOUSED_HEADER INDEX 1.

  GS_WAREHOUSED_HEADER-WERKS = P_WERKS.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_CANCLED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_CANCLED USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                         P_MODI TYPE LVC_S_MODI.

  DATA: LV_ZLSTATUS LIKE GS_WAREHOUSED_ALV-ZLSTATUS.

  CALL METHOD P_DATA_CHANGED->GET_CELL_VALUE

          EXPORTING

            I_ROW_ID    = P_MODI-ROW_ID

            I_FIELDNAME = 'ZLSTATUS'

          IMPORTING

            E_VALUE     = LV_ZLSTATUS.

  IF LV_ZLSTATUS = '##'.

    PERFORM ERROR_MESSAGE USING P_DATA_CHANGED P_MODI '## ### #### #### # ####.'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_ZCHECK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_ZCHECK .

  READ TABLE GT_MIGO INTO GS_MIGO WITH KEY ZCHECK = 'X'.

  IF SY-SUBRC <> 0.

    MESSAGE '##### #### ####.' TYPE 'E'.

    EXIT.

  ENDIF.

ENDFORM.