
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PROJECT003_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INPUT_DATA .



  " ## #### ### ## ## (### ### ### ##)

  DATA: LV_CHECK_EBELN TYPE ZEDT16_EKKO-EBELN.

  DATA: LV_CHECK_WERKS TYPE ZEDT16_EKPO-WERKS.



  " 0. P_DATE(##) ## ##

  IF P_DATE IS INITIAL.

    MESSAGE '###(##)# ######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  " 1. P_EBELN1(####) ## ##

  IF P_EBELN1 IS INITIAL.

    MESSAGE '#### ### ######.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  " 2. ZEDT16_EKKO ## ## ##

  CLEAR LV_CHECK_EBELN.

  SELECT SINGLE EBELN

    INTO LV_CHECK_EBELN

    FROM ZEDT16_EKKO

    WHERE EBELN = P_EBELN1.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ## #### #####.' TYPE 'I'.

    STOP.

  ENDIF.



  " 3. P_WERKS1(###) ## ## ## ##

  IF P_WERKS1 IS NOT INITIAL.

    CLEAR LV_CHECK_WERKS.



    SELECT SINGLE WERKS

      INTO LV_CHECK_WERKS

      FROM ZEDT16_EKPO

      WHERE EBELN = P_EBELN1

        AND WERKS = P_WERKS1.



    IF SY-SUBRC <> 0.

      MESSAGE '## ##### #### ## ######.' TYPE 'I'.

      STOP.

    ENDIF.

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



  " 1. ###

  CLEAR : GS_PO_HEADER, GS_MKPF, GS_MSEG, GS_ALV.

  REFRESH : GT_PO_ITEM, GT_MSEG, GT_ALV.



  " 2. #### ## ## ## (ZEDT16_EKKO)

  SELECT SINGLE *

    INTO GS_PO_HEADER

    FROM ZEDT16_EKKO

    WHERE EBELN = P_EBELN1.



  " ## #### ### ## ##

  IF SY-SUBRC <> 0.

    MESSAGE '## #### ### ## # ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  " 3. #### ### ## ## (ZEDT16_EKPO)

  "    P_WERKS1 ## ### ### ##, ### ## ##

  IF P_WERKS1 IS NOT INITIAL.

    SELECT *

      INTO TABLE GT_PO_ITEM

      FROM ZEDT16_EKPO

      WHERE EBELN = P_EBELN1

        AND WERKS = P_WERKS1.

  ELSE.

    SELECT *

      INTO TABLE GT_PO_ITEM

      FROM ZEDT16_EKPO

      WHERE EBELN = P_EBELN1.

  ENDIF.



  " ### #### ### ## ##

  IF GT_PO_ITEM[] IS INITIAL.

    MESSAGE '### ## #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.





  " 4. ## ##(GT_MKPF) ### ##

  " -----------------------------------------------------------

  " - MBLNR : ## X (### ##)

  " - MJAHR : P_DATE# ## 4##

  " - BLART : 'WE' ##

  " - BLDAT : PO ### BEDAT

  " - BUDAT : P_DATE

  " -----------------------------------------------------------

  GS_MKPF-MJAHR = P_DATE(4).          " P_DATE# # 4##(##) ##

  GS_MKPF-BLART = 'WE'.               " #### ##

  GS_MKPF-BLDAT = GS_PO_HEADER-BEDAT. " ### (PO###)

  GS_MKPF-BUDAT = P_DATE.             " ### (### ###)



  " #### ##




*  APPEND GS_MKPF TO GT_MKPF.








  " 5. ALV ## ###(GT_ALV) ##

  " 5. ALV ###(GT_ALV) # ## ###(GT_MSEG) ##

  LOOP AT GT_PO_ITEM INTO GS_PO_ITEM.



    " --- [A] ALV ### ## ---

    CLEAR GS_ALV.

    GS_ALV-LIFNR = GS_PO_HEADER-LIFNR.

    GS_ALV-BEDAT = GS_PO_HEADER-BEDAT.

    GS_ALV-WAERS = GS_PO_HEADER-WAERS.



    GS_ALV-EBELN = GS_PO_ITEM-EBELN.

    GS_ALV-EBELP = GS_PO_ITEM-EBELP.

    GS_ALV-MATNR = GS_PO_ITEM-MATNR.

    GS_ALV-MAKTX = GS_PO_ITEM-MAKTX.

    GS_ALV-MENGE = GS_PO_ITEM-MENGE.

    GS_ALV-MEINS = GS_PO_ITEM-MEINS.

    GS_ALV-BPRME = GS_PO_ITEM-BPRME.

    GS_ALV-PRDAT = GS_PO_ITEM-PRDAT.

    GS_ALV-WERKS = GS_PO_ITEM-WERKS.

    GS_ALV-LGORT = GS_PO_ITEM-LGORT.



    " ## ## (### ### ###)

    GS_ALV-OPEN_QTY = GS_PO_ITEM-MENGE.

    GS_ALV-ERFMG    = GS_PO_ITEM-MENGE.



    APPEND GS_ALV TO GT_ALV.



  ENDLOOP.



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



  " ## ##



  "         MENGE    TYPE ZEDT16_EKPO-MENGE, " [## ##] # ##(PO) ##




*           WEMNG    TYPE ZEDT16_EKPO-MENGE, " [## ##] ### ## (## ### #) -> ZEDT16_MSEG## ###



*           OPEN_QTY TYPE ZEDT16_EKPO-MENGE, " [##] ## ## ## (##) -> (MENGE - WEMNG)

*           ERFMG    TYPE ZEDT16_EKPO-MENGE, " [##] ## ## ## (### / Edit)






  DATA : LV_WEMNG TYPE ZEDT16_EKPO-MENGE.



  " ALV #### ### #### ##### #####.

  LOOP AT GT_ALV INTO GS_ALV.



    CLEAR LV_WEMNG.



    " 1. ### ##(WEMNG) ####

    SELECT SUM( MENGE )

      INTO LV_WEMNG

      FROM ZEDT16_MSEG

      WHERE EBELN = GS_ALV-EBELN

        AND MATNR = GS_ALV-MATNR

        AND WERKS = GS_ALV-WERKS

        AND LGORT = GS_ALV-LGORT.



    " ## ### ### #### ## 0## ## (## ## ##)

    IF SY-SUBRC <> 0 OR LV_WEMNG IS INITIAL.

      LV_WEMNG = 0.

    ENDIF.



    " ### ## #### ##

    GS_ALV-WEMNG = LV_WEMNG.





    " 2. ## ## ##(OPEN_QTY) ##

    GS_ALV-OPEN_QTY = GS_ALV-MENGE - GS_ALV-WEMNG.





    " 3. [##] ## ### ### #(## 0 ##)# #### ##

    IF GS_ALV-OPEN_QTY <= 0.

      DELETE GT_ALV. " ## ## ## ## # ### ###

      CONTINUE.      " ###### ## MODIFY ### # ## ## ## ### ###

    ENDIF.





    " 4. ## ## ##(ERFMG) ###

    "    #### ### # ### # #(0)## #

    GS_ALV-ERFMG = GS_ALV-OPEN_QTY.





    " 5. ### ### ##

    "    (### DELETE ## ## #### #### ### #)

    MODIFY GT_ALV FROM GS_ALV.



  ENDLOOP.



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



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.



  " 1. L_CHECK : ## (####, ## ##)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'L_CHECK'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-CHECKBOX  = 'X'.      " ##### ##

  GS_FIELDCAT-EDIT      = 'X'.      " ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 2. EBELN : ######

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT   = '######'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'EBELN'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 3. EBELP : ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'EBELP'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 4. LIFNR : ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKKO'.

  GS_FIELDCAT-REF_FIELD = 'LIFNR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 5. BEDAT : ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'BEDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKKO'.

  GS_FIELDCAT-REF_FIELD = 'BEDAT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 6. MATNR : ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'MATNR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 7. MAKTX : ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 7.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'MAKTX'.

  GS_FIELDCAT-OUTPUTLEN = 20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ------------------------------------------------------------------

  " [## ## Start]

  " ------------------------------------------------------------------



  " 8. MENGE : # PO ## (## ##)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 8.

  GS_FIELDCAT-FIELDNAME  = 'MENGE'.

  GS_FIELDCAT-COLTEXT    = '# PO##'.

  GS_FIELDCAT-REF_TABLE  = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD  = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.      " ## ## ## (##)

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 9. WEMNG : ### ## (## ##)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 9.

  GS_FIELDCAT-FIELDNAME  = 'WEMNG'.

  GS_FIELDCAT-COLTEXT    = '### ##'.

  GS_FIELDCAT-REF_TABLE  = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD  = 'MENGE'.      " ## ### MENGE ##

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.      " ## ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 10. OPEN_QTY : ## ## ## / ## (## ##)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 10.

  GS_FIELDCAT-FIELDNAME  = 'OPEN_QTY'.

  GS_FIELDCAT-COLTEXT    = '######'.

  GS_FIELDCAT-REF_TABLE  = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD  = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.      " ## ## ##

  GS_FIELDCAT-EMPHASIZE  = 'C500'.       " (##) ### ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 11. ERFMG : ## ## ## (# ## ## #)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 11.

  GS_FIELDCAT-FIELDNAME  = 'ERFMG'.

  GS_FIELDCAT-COLTEXT    = '######'. " ###

  GS_FIELDCAT-REF_TABLE  = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD  = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.      " ## ## ##

  GS_FIELDCAT-EDIT       = 'X'.          " # ## ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ------------------------------------------------------------------

  " [## ## End]

  " ------------------------------------------------------------------



  " 12. MEINS : ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 12.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 13. BPRME : ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS    = 13.

  GS_FIELDCAT-FIELDNAME  = 'BPRME'.

  GS_FIELDCAT-COLTEXT    = '##'.

  GS_FIELDCAT-REF_TABLE  = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD  = 'BPRME'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.      " ## ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 14. WAERS : ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 14.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKKO'.

  GS_FIELDCAT-REF_FIELD = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 15. PRDAT : ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 15.

  GS_FIELDCAT-FIELDNAME = 'PRDAT'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'PRDAT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 16. WERKS : ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 16.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'WERKS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 17. LGORT : ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 17.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT16_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'LGORT'.

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



  " 1. ### ### ## (## ## ###)

  CREATE OBJECT GO_EVENT_RECEIVER.

  SET HANDLER GO_EVENT_RECEIVER->HANDLE_DATA_CHANGED FOR GC_GRID.



  " 2. ## ## # #### ##### ## (## ## #)

  "    ## # ## ## ## ##### ##### #### ##

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_ENTER. " ## # ### ##



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

      IT_OUTTAB       = GT_ALV

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

*&      Form  CHECK_ALV_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*----------------------------------------------------------------------*




FORM CHECK_ALV_DATA_CHANGED USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.



  DATA : LS_MOD_CELL TYPE LVC_S_MODI,

         LS_ALV      LIKE LINE OF GT_ALV.



  LOOP AT P_DATA_CHANGED->MT_MOD_CELLS INTO LS_MOD_CELL.



    CASE LS_MOD_CELL-FIELDNAME.

      WHEN 'ERFMG'. " ######



        " ## ### ## (## ###)

        READ TABLE GT_ALV INTO LS_ALV INDEX LS_MOD_CELL-ROW_ID.



        IF SY-SUBRC = 0.



          " 1. ## ## ##

          IF LS_MOD_CELL-VALUE > LS_ALV-OPEN_QTY.



            " (1) ### ### (##)

            MESSAGE '## ### ### ######.' TYPE 'I' DISPLAY LIKE 'E'.



            " (2) ### ## #### ## ####(## ####) ####

            "     ## # ## ## #### ### ## ### #### ###.

            CALL METHOD P_DATA_CHANGED->MODIFY_CELL

              EXPORTING

                I_ROW_ID    = LS_MOD_CELL-ROW_ID

                I_FIELDNAME = LS_MOD_CELL-FIELDNAME

                I_VALUE     = LS_ALV-OPEN_QTY. " ##### ## ## (## 0)



          ENDIF.



          " 2. ## ## ##

          IF LS_MOD_CELL-VALUE < 0.



            MESSAGE '### 0## ## # ####.' TYPE 'I' DISPLAY LIKE 'E'.



            " ## 0## ## ##

            CALL METHOD P_DATA_CHANGED->MODIFY_CELL

              EXPORTING

                I_ROW_ID    = LS_MOD_CELL-ROW_ID

                I_FIELDNAME = LS_MOD_CELL-FIELDNAME

                I_VALUE     = 0.

          ENDIF.



        ENDIF.



    ENDCASE.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_BUTTON

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_BUTTON .



  DATA : LV_MAX_MBLNR TYPE ZEDT16_MKPF-MBLNR, " ## # ####

         LV_NEW_MBLNR TYPE ZEDT16_MKPF-MBLNR, " ## ### ##

         LV_ZEILE     TYPE ZEDT16_MSEG-ZEILE, " ### ## ###

         LV_FLAG      TYPE C,                 " ### ## ## ##

         LV_ANSWER    TYPE C.                 " ## ## (1=Yes, 2=No)



  CALL METHOD GC_GRID->CHECK_CHANGED_DATA.



  " -----------------------------------------------------------

  " 1. ### ## (### ### ##)

  " -----------------------------------------------------------

  CLEAR : LV_FLAG.



  LOOP AT GT_ALV INTO GS_ALV WHERE L_CHECK = 'X'.

    LV_FLAG = 'X'.



    " (1) ## ### 0 #### ##

    IF GS_ALV-ERFMG <= 0.

      MESSAGE '## ### 0## ## ###.' TYPE 'S' DISPLAY LIKE 'E'.

      RETURN.

    ENDIF.



    " (2) ## ### ### ##### ##

    IF GS_ALV-ERFMG > GS_ALV-OPEN_QTY.

      MESSAGE '## ### ### ######.' TYPE 'S' DISPLAY LIKE 'E'.

      RETURN.

    ENDIF.

  ENDLOOP.



  " ### ### ### ### ##

  IF LV_FLAG IS INITIAL.

    MESSAGE '### ### ##(##)####.' TYPE 'S' DISPLAY LIKE 'W'.

    RETURN.

  ENDIF.





  " -----------------------------------------------------------

  " [##] 2. ## ## ## (POPUP_TO_CONFIRM)

  " -----------------------------------------------------------

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR              = '## ## ##'               " ### ##

      TEXT_QUESTION         = '### ### ##(##) ######?' " ## ##

      TEXT_BUTTON_1         = '#'

      ICON_BUTTON_1         = 'ICON_OKAY'

      TEXT_BUTTON_2         = '###'

      ICON_BUTTON_2         = 'ICON_CANCEL'

      DISPLAY_CANCEL_BUTTON = ' '           " ## ## ## (Yes/No# ##)

      POPUP_TYPE            = 'ICON_MESSAGE_QUESTION'

    IMPORTING

      ANSWER                = LV_ANSWER.    " #### ## # (1:#, 2:###)



  " '#(1)'# ### #### ## ##

  IF LV_ANSWER <> '1'.

    MESSAGE '### #######.' TYPE 'S'.

    RETURN.

  ENDIF.





  " -----------------------------------------------------------

  " 3. ######(MBLNR) ##

  " -----------------------------------------------------------

  SELECT SINGLE MAX( MBLNR )

    INTO LV_MAX_MBLNR

    FROM ZEDT16_MKPF.



  IF LV_MAX_MBLNR IS INITIAL.

    LV_NEW_MBLNR = '5000000000'.

  ELSE.

    LV_NEW_MBLNR = LV_MAX_MBLNR + 1.

  ENDIF.





  " -----------------------------------------------------------

  " 4. ### ## # DB ## (MKPF, MSEG)

  " -----------------------------------------------------------



  " (A) ## ### ##

  GS_MKPF-MBLNR = LV_NEW_MBLNR.

  " ### ### GET_DATA## ## ###



  " (B) ### ### ##

  REFRESH GT_MSEG.

  CLEAR LV_ZEILE.



  LOOP AT GT_ALV INTO GS_ALV WHERE L_CHECK = 'X'.



    CLEAR GS_MSEG.

    LV_ZEILE = LV_ZEILE + 1.



    GS_MSEG-MBLNR = LV_NEW_MBLNR.

    GS_MSEG-MJAHR = GS_MKPF-MJAHR.

    GS_MSEG-ZEILE = LV_ZEILE.



    GS_MSEG-MATNR = GS_ALV-MATNR.

    GS_MSEG-WERKS = GS_ALV-WERKS.

    GS_MSEG-LGORT = GS_ALV-LGORT.

    GS_MSEG-LIFNR = GS_ALV-LIFNR.

    GS_MSEG-WAERS = GS_ALV-WAERS.

    GS_MSEG-MENGE = GS_ALV-ERFMG.    " ### ## ##

    GS_MSEG-MEINS = GS_ALV-MEINS.

    GS_MSEG-EBELN = GS_ALV-EBELN.

    GS_MSEG-BUKRS = GS_PO_HEADER-BUKRS.



    APPEND GS_MSEG TO GT_MSEG.

  ENDLOOP.



  " (C) DB ## ##

  INSERT ZEDT16_MKPF FROM GS_MKPF.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ### ## ##' TYPE 'E'.

    RETURN.

  ENDIF.



  INSERT ZEDT16_MSEG FROM TABLE GT_MSEG.

  IF SY-SUBRC <> 0.

    ROLLBACK WORK.

    MESSAGE '## ### ## ##' TYPE 'E'.

    RETURN.

  ENDIF.



  " (D) ## ##

  COMMIT WORK AND WAIT.



  MESSAGE '## ### ##### #######. (##: ' && LV_NEW_MBLNR && ')' TYPE 'S'.



  " -----------------------------------------------------------

  " [## # ##]

  " -----------------------------------------------------------

  " 1. ## ### #### #### ### ## ####,

  "    ### 0# # ## ##### #####.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



  " 2. ### ##(### # ##)## ## ####

  PERFORM REFRESH.





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



  P_DATE = SY-DATUM.

  P_EBELN1 = '4500000001'.

  P_WERKS1 = '1000'.



  P_EBELN2 = '4500000001'.

  P_WERKS2 = '1000'.



ENDFORM.