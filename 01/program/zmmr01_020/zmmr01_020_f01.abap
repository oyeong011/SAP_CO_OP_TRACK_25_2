
*&---------------------------------------------------------------------*

*&  INCLUDE           ZMMR01_020_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      FORM  INITIALIZATION

*&---------------------------------------------------------------------*




FORM INITIALIZATION .

  P_BLDAT = SY-DATUM.

  P_EBELN = 4500000001.

  P_WERKS = 1000.

  GS_HEADER-WIDTH     = 30.

  GS_HEADER-WIDTH_PIX = ''.

  GS_HEADER-HEADING   = 'MY DOCUMENTS'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  SELECTION_SCREEN_OUTPUT

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*  -->  P1        TEXT

*  <--  P2        TEXT

*----------------------------------------------------------------------*




FORM SELECTION_SCREEN_OUTPUT .

  LOOP AT SCREEN.



    IF SCREEN-GROUP1 = 'M1'.  "###

      IF P_R1 = 'X'.          "##

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R2 = 'X'.      "##

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CHECK_MANDATORY

*&---------------------------------------------------------------------*




FORM CHECK_MANDATORY .

  IF P_R1 = 'X'.



     IF P_EBELN IS INITIAL.

       MESSAGE S008 WITH TEXT-M01 DISPLAY LIKE C_E.

       LEAVE LIST-PROCESSING.

     ENDIF.



     IF P_WERKS IS INITIAL.

       MESSAGE S008 WITH TEXT-M02 DISPLAY LIKE C_E.

       LEAVE LIST-PROCESSING.

     ENDIF.



     IF P_BLDAT IS INITIAL.

       MESSAGE S008 WITH TEXT-M03 DISPLAY LIKE C_E.

       LEAVE LIST-PROCESSING.

     ENDIF.



   ELSEIF P_R2 = 'X'.



     IF P_EBELN IS INITIAL.

       MESSAGE S008 WITH TEXT-M01 DISPLAY LIKE C_E.

       LEAVE LIST-PROCESSING.

     ENDIF.



     IF P_WERKS IS INITIAL.

       MESSAGE S008 WITH TEXT-M02 DISPLAY LIKE C_E.

       LEAVE LIST-PROCESSING.

     ENDIF.



   ELSE.

     LEAVE LIST-PROCESSING.

   ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CHECK_SELECTION_DATA

*&---------------------------------------------------------------------*




FORM CHECK_SELECTION_DATA .

  IF P_R1 = C_X.

    GV_MODE = C_CRUD.

  ELSEIF P_R2 = C_X.

    GV_MODE = C_DISP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CHECK_PURCHASE_ORDER_DATA

*&---------------------------------------------------------------------*




FORM CHECK_PURCHASE_ORDER_DATA .

  SELECT SINGLE *

    INTO GS_EKKO

    FROM ZEKKO01

   WHERE EBELN = P_EBELN.



  IF SY-SUBRC <> 0.

    MESSAGE S007 WITH TEXT-M01 DISPLAY LIKE C_E.

    LEAVE LIST-PROCESSING.

  ENDIF.



  SELECT *

    INTO CORRESPONDING FIELDS OF TABLE GT_EKPO

    FROM ZEKPO01

   WHERE EBELN = P_EBELN

     AND WERKS = P_WERKS.



  IF SY-SUBRC <> 0.

    MESSAGE S007 WITH TEXT-M02 DISPLAY LIKE C_E.

    LEAVE LIST-PROCESSING.

  ENDIF.



  SELECT SINGLE *

    INTO CORRESPONDING FIELDS OF GS_LFA1

    FROM ZLFA1_01

   WHERE LIFNR = GS_EKKO-LIFNR.



  IF SY-SUBRC <> 0.

    MESSAGE S007 WITH TEXT-M04 DISPLAY LIKE C_E.

    LEAVE LIST-PROCESSING.

  ENDIF.



  SELECT SINGLE *

    INTO CORRESPONDING FIELDS OF GS_LFB1

    FROM ZLFB1_01

   WHERE LIFNR = GS_EKKO-LIFNR.



  IF SY-SUBRC <> 0.

    MESSAGE S007 WITH TEXT-M04 DISPLAY LIKE C_E.

    LEAVE LIST-PROCESSING.

  ENDIF.



  SELECT SINGLE *

    INTO CORRESPONDING FIELDS OF GS_LFM1

    FROM ZLFM1_01

   WHERE LIFNR = GS_EKKO-LIFNR.



  IF SY-SUBRC <> 0.

    MESSAGE S007 WITH TEXT-M04 DISPLAY LIKE C_E.

    LEAVE LIST-PROCESSING.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .

  IF GV_MODE = C_CRUD.

    PERFORM GET_PO_DATA.

  ELSEIF GV_MODE = C_DISP.

    PERFORM GET_GR_DATA.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CALL_SCREEN

*&---------------------------------------------------------------------*




FORM CALL_SCREEN .

  IF GV_MODE = C_CRUD.

    CALL SCREEN 200.

  ELSEIF GV_MODE = C_DISP.

    CALL SCREEN 100.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  INIT_DATA

*&---------------------------------------------------------------------*




FORM INIT_DATA .



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  GET_PO_DATA

*&---------------------------------------------------------------------*




FORM GET_PO_DATA .



  REFRESH GT_DISP_100.



  LOOP AT GT_EKPO INTO GS_EKPO.



    CLEAR GS_DISP_100.



    " ## PO ITEM

    MOVE-CORRESPONDING GS_EKPO TO GS_DISP_100.

    GS_DISP_100-WAERS = GS_EKKO-WAERS.



    " #### ##

    PERFORM GET_GR_QTY USING    GS_EKPO-EBELN GS_EKPO-MATNR

                       CHANGING GS_DISP_100-GR_DONE_QTY.



    "####

    GS_DISP_100-REM_QTY = GS_EKPO-MENGE - GS_DISP_100-GR_DONE_QTY.



    APPEND GS_DISP_100 TO GT_DISP_100.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  GET_GR_DATA

*&---------------------------------------------------------------------*




FORM GET_GR_DATA .

  SELECT *

    FROM ZMSEG01

    INTO CORRESPONDING FIELDS OF TABLE @GT_MSEG

    WHERE EBELN = @P_EBELN

    AND WERKS = @P_WERKS.



  IF GT_MSEG IS INITIAL.

    MESSAGE '#### ### #### ## ##### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  SELECT *

    FROM ZMKPF01

    INTO CORRESPONDING FIELDS OF TABLE @GT_MKPF

    FOR ALL ENTRIES IN @GT_MSEG

    WHERE MBLNR = @GT_MSEG-MBLNR

    AND MJAHR = @GT_MSEG-MJAHR.



  IF GT_MKPF IS INITIAL.

    MESSAGE '#### ### #### ## ##### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT USING    PV_CONTAINER_NAME TYPE C

                   CHANGING PV_CUSTOM         TYPE REF TO CL_GUI_CUSTOM_CONTAINER

                            PV_GRID           TYPE REF TO CL_GUI_ALV_GRID.



  " CUSTOM CONTAINER ##

  CREATE OBJECT PV_CUSTOM

    EXPORTING

      CONTAINER_NAME = PV_CONTAINER_NAME.

  IF SY-SUBRC <> 0.

    MESSAGE 'CUSTOM CONTAINER ## ##' TYPE 'E'.

  ENDIF.



  " ALV GRID ##

  CREATE OBJECT PV_GRID

    EXPORTING

      I_PARENT = PV_CUSTOM.

  IF SY-SUBRC <> 0.

    MESSAGE 'ALV GRID ## ##' TYPE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

  CLEAR : GS_FIELDCAT,GT_FIELDCAT.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-FIELDNAME = 'LINE'.

  GS_FIELDCAT-ICON = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 6.

  GS_FIELDCAT-STYLE     = CL_GUI_ALV_GRID=>MC_STYLE_BUTTON.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'L_CHECK'.

  GS_FIELDCAT-SCRTEXT_M = 'OK'.

  GS_FIELDCAT-CHECKBOX   = 'X'.

  GS_FIELDCAT-EDIT       = 'X'.

  GS_FIELDCAT-OUTPUTLEN  = 3.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'COLOR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-SCRTEXT_M = 'PO##'.

  GS_FIELDCAT-OUTPUTLEN = 15.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-NO_ZERO = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 6.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 16.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD = 'WERKS'.

  GS_FIELDCAT-OUTPUTLEN = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD = 'LGORT'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME  = 'GR_QTY'.

  GS_FIELDCAT-COLTEXT    = '####'.

  GS_FIELDCAT-EDIT       = 'X'.

  GS_FIELDCAT-REF_TABLE  = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD  = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'REM_QTY'.

  GS_FIELDCAT-COLTEXT     = '####'.

  GS_FIELDCAT-REF_TABLE   = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD   = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME  = 'MEINS'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " PO ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'MENGE'.

  GS_FIELDCAT-COLTEXT     = 'PO##'.

  GS_FIELDCAT-QFIELDNAME  = 'MEINS'.

  GS_FIELDCAT-REF_TABLE   = 'ZEKPO01'.   " EBAN# ##

  GS_FIELDCAT-REF_FIELD   = 'MENGE'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'GR_DONE_QTY'.

  GS_FIELDCAT-COLTEXT     = '####'.

  GS_FIELDCAT-QFIELDNAME  = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'MEINS'.

  GS_FIELDCAT-COLTEXT     = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'NETPR'.

  GS_FIELDCAT-SCRTEXT_M   = '##'.

  GS_FIELDCAT-CFIELDNAME  = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'DMBTR'.

  GS_FIELDCAT-SCRTEXT_M   = '####'.

  GS_FIELDCAT-CFIELDNAME  = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M   = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'MWSKZ'.

  GS_FIELDCAT-SCRTEXT_M   = '####'.

  GS_FIELDCAT-REF_TABLE   = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD   = 'MWSKZ'.

  GS_FIELDCAT-OUTPUTLEN   = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'PRDAT'.

  GS_FIELDCAT-COLTEXT     = '###'.

  GS_FIELDCAT-REF_TABLE   = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD   = 'PRDAT'.

  GS_FIELDCAT-OUTPUTLEN   = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  FIELD_CATALOG_DISP

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_DISP .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  " 1. ####

  GS_FIELDCAT-FIELDNAME = 'L_CHECK'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CHECKBOX  = 'X'.

  GS_FIELDCAT-EDIT      = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 2. ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'REMARK'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 16.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 3. PO##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-SCRTEXT_M = 'PO##'.

  GS_FIELDCAT-OUTPUTLEN = 15.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 4. ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-NO_ZERO   = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 6.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 5. ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 16.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 6. ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD = 'WERKS'.

  GS_FIELDCAT-OUTPUTLEN = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 7. ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD = 'LGORT'.

  GS_FIELDCAT-OUTPUTLEN = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 8. ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'GR_DONE_QTY'.

  GS_FIELDCAT-COLTEXT     = '####'.

  GS_FIELDCAT-QFIELDNAME  = 'MEINS'.

  GS_FIELDCAT-REF_TABLE   = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD   = 'MENGE'.

  GS_FIELDCAT-OUTPUTLEN   = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 9. ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'MEINS'.

  GS_FIELDCAT-COLTEXT     = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 10. ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'NETPR'.

  GS_FIELDCAT-SCRTEXT_M   = '##'.

  GS_FIELDCAT-CFIELDNAME  = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 11. ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'DMBTR'.

  GS_FIELDCAT-SCRTEXT_M   = '####'.

  GS_FIELDCAT-CFIELDNAME  = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 12. ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M   = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 13. ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'MWSKZ'.

  GS_FIELDCAT-SCRTEXT_M   = '####'.

  GS_FIELDCAT-REF_TABLE   = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD   = 'MWSKZ'.

  GS_FIELDCAT-OUTPUTLEN   = 8.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 14. ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'PRDAT'.

  GS_FIELDCAT-COLTEXT     = '###'.

  GS_FIELDCAT-REF_TABLE   = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD   = 'PRDAT'.

  GS_FIELDCAT-OUTPUTLEN   = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_FIELDCAT_FI

*&---------------------------------------------------------------------*




FORM SET_FIELDCAT_FI .

  CLEAR : GS_FIELDCAT , GT_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-FIELDNAME = 'BUZEI'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = 'PK'.

  GS_FIELDCAT-FIELDNAME = 'BSCHL'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '##/#####'.

  GS_FIELDCAT-FIELDNAME = 'SHKZG'.

  GS_FIELDCAT-OUTPUTLEN =  14.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-FIELDNAME = 'HKONT'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-FIELDNAME = 'SGTXT'.

  GS_FIELDCAT-OUTPUTLEN =  30.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '#### ##'.

  GS_FIELDCAT-FIELDNAME = 'WRBTR'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-EDIT_MASK = '==RR'.

  GS_FIELDCAT-DO_SUM    = 'X'.

  GS_FIELDCAT-OUTPUTLEN =  20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '#### ##'.

  GS_FIELDCAT-FIELDNAME = 'DMBTR'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS_D'.

  GS_FIELDCAT-EDIT_MASK = '==RR'.

  GS_FIELDCAT-DO_SUM    = 'X'.

  GS_FIELDCAT-OUTPUTLEN =  20.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-FIELDNAME = 'WAERS_D'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-STYLEFNAME = 'CELLTAB'.

  GS_LAYOUT-ZEBRA = 'X'. " ### ## ###

  GS_LAYOUT-NO_TOOLBAR = 'X'.

  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CLASS_EVENT

*&---------------------------------------------------------------------*




FORM CLASS_EVENT .

  CREATE OBJECT GO_EVENT.

  SET HANDLER GO_EVENT->HANDLER_TOOLBAR FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_USER_COMMAND FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_HOTSPOT_CLICK FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DOUBLE_CLICK FOR GC_GRID.



    CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED




*    EXCEPTIONS

*      ERROR      = 1

*      OTHERS     = 2




  .

  SET HANDLER GO_EVENT->HANDLER_BUTTON_CLICK FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY  USING    PT_TABLE TYPE STANDARD TABLE.

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =




        IS_VARIANT      = GS_VARIANT

        I_SAVE          = 'A'




*      I_DEFAULT                     = 'X'




        IS_LAYOUT       = GS_LAYOUT




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =




        IT_TOOLBAR_EXCLUDING = GT_EXCLUDE




*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




      CHANGING

        IT_OUTTAB       = PT_TABLE

        IT_FIELDCATALOG = GT_FIELDCAT

        IT_SORT         = GT_SORT.




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      OTHERS                        = 4




        .

  IF SY-SUBRC <> 0.




*   IMPLEMENT SUITABLE ERROR HANDLING HERE




  ENDIF.



  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONF4_AFTER

                                        P_UCOMM.

  DATA : LS_MODI TYPE LVC_S_MODI.

  DATA : LS_MAT  TYPE ZMAT01.

  DATA : LV_GR_QTY TYPE ZEKPO01-MENGE.

  DATA : GV_QTY_TEXT TYPE C LENGTH 20 VALUE 'GV_QTY'.

  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.



    IF LS_MODI-FIELDNAME = 'GR_QTY'.

      LV_GR_QTY = LS_MODI-VALUE.  " #### ### ####



      READ TABLE GT_DISP_100 INTO GS_DISP_100 INDEX LS_MODI-ROW_ID.

      IF SY-SUBRC <> 0.

        RETURN.

      ENDIF.



      IF LV_GR_QTY < 0.

        GV_ERROR_FLAG = 1.

        PERFORM RESET_CELL USING P_DATA_CHANGED LS_MODI.

        CONTINUE.

      ELSEIF LV_GR_QTY > GS_DISP_100-REM_QTY.

        GV_ERROR_FLAG = 2.

        PERFORM RESET_CELL USING P_DATA_CHANGED LS_MODI.

        CONTINUE.

      ENDIF.



      READ TABLE GT_DISP_100 INTO GS_DISP_100 INDEX LS_MODI-ROW_ID.



      IF SY-SUBRC = 0.

        GS_DISP_100-GR_QTY = LV_GR_QTY.

        GS_DISP_100-DMBTR = GS_DISP_100-GR_QTY * GS_DISP_100-NETPR.

        MODIFY GT_DISP_100 FROM GS_DISP_100 INDEX LS_MODI-ROW_ID.

        MOVE-CORRESPONDING GS_DISP_100 TO GS_EKPO.

        MODIFY GT_EKPO FROM GS_EKPO INDEX LS_MODI-ROW_ID.

      ENDIF.



    ELSEIF LS_MODI-FIELDNAME = 'L_CHECK'.



      READ TABLE GT_DISP_100 INTO GS_DISP_100 INDEX LS_MODI-ROW_ID.

      IF SY-SUBRC <> 0.

        CONTINUE.

      ENDIF.



      GS_DISP_100-L_CHECK = LS_MODI-VALUE.



      IF GS_DISP_100-L_CHECK IS INITIAL.

        GS_DISP_100-COLOR = ICON_YELLOW_LIGHT.

      ELSE.

        GS_DISP_100-COLOR = ICON_GREEN_LIGHT.

      ENDIF.



      MODIFY GT_DISP_100 FROM GS_DISP_100 INDEX LS_MODI-ROW_ID.

    ENDIF.



  ENDLOOP.

  READ TABLE GT_DISP_100 INTO GS_DISP_100 INDEX GV_CURR_INDEX.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED  USING    P_E_MODIFIED

                                         P_ET_GOOD_CELLS.

  PERFORM REFRESH.

  CASE GV_ERROR_FLAG.

    WHEN '1'. MESSAGE '##### 0## #####' TYPE 'S' DISPLAY LIKE 'E'.

    WHEN '2'. MESSAGE '##### ## ### ### # ####' TYPE 'S' DISPLAY LIKE 'E'.

  ENDCASE.

  GV_ERROR_FLAG = 0.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  GET_HEADER_DATA

*&---------------------------------------------------------------------*




FORM GET_HEADER_DATA .

  MOVE-CORRESPONDING GS_EKKO TO GS_HEADER_100.

  MOVE-CORRESPONDING GS_LFA1 TO GS_HEADER_100.

  MOVE-CORRESPONDING GS_LFB1 TO GS_HEADER_100.

  MOVE-CORRESPONDING GS_LFM1 TO GS_HEADER_100.

  IF GV_MODE = C_CRUD.

    GS_HEADER_100-MODE_TX = '####'.

    GS_HEADER_100-BUDAT = SY-DATUM.

    GS_HEADER_100-BLDAT = P_BLDAT.

    READ TABLE GT_EKPO INTO GS_EKPO INDEX 1.

    IF SY-SUBRC = 0.

      MOVE-CORRESPONDING GS_EKPO TO GS_DISP_100.

    ENDIF.

    GS_DISP_100-BUDAT = SY-DATUM.

    GS_DISP_100-LINE = '@16@'.

    GS_HEADER_100-WERKS = GS_EKPO-WERKS.

    GS_HEADER_100-BWART = '101'.

    GS_HEADER_100-BLART = 'WE'.

  ELSEIF GV_MODE = C_DISP.

    READ TABLE GT_EKPO INTO GS_EKPO INDEX 1.

    IF SY-SUBRC = 0.

      MOVE-CORRESPONDING GS_EKPO TO GS_DISP_100.

    ENDIF.

    GS_HEADER_100-WERKS = GS_EKPO-WERKS.

    GS_HEADER_100-BLDAT = GS_MKPF-BLDAT.

    GS_HEADER_100-BUDAT = GS_MKPF-BUDAT.

    GS_HEADER_100-BWART = 102.

    GS_HEADER_100-MODE_TX = '#### # ##'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  GET_DISPLAY_DATA

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*  -->  P1        TEXT

*  <--  P2        TEXT

*----------------------------------------------------------------------*




FORM GET_DISPLAY_DATA .

  READ TABLE GT_DISP_100 INTO GS_DISP_100 INDEX GV_CURR_INDEX.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  REFRESH

*&---------------------------------------------------------------------*




FORM REFRESH .

  DATA : LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

     EXPORTING

      IS_STABLE      = LS_STABLE




*      I_SOFT_REFRESH =

*    EXCEPTIONS

*      FINISHED       = 1

*      OTHERS         = 2




          .

  IF SY-SUBRC <> 0.



  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  ALV_BUTTON_CLICK

*&---------------------------------------------------------------------*




FORM ALV_BUTTON_CLICK  USING    PS_COL_ID TYPE LVC_S_COL

                                PS_ROW_NO TYPE LVC_S_ROID.

  IF PS_COL_ID-FIELDNAME = 'LINE'.

    GV_CURR_INDEX = PS_ROW_NO-ROW_ID.

    PERFORM GET_DISPLAY_DATA.

    CALL METHOD CL_GUI_CFW=>FLUSH.

    CALL METHOD CL_GUI_CFW=>UPDATE_VIEW.

    LEAVE SCREEN.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CHECK_SCREEN_VALDATION

*&---------------------------------------------------------------------*




FORM CHECK_SCREEN_VALDATION .

  IF GS_DISP_100-GR_QTY < 0.

    MESSAGE '##### 0## #####' TYPE 'S' DISPLAY LIKE 'E'.

    GS_DISP_100-GR_QTY = 0.

  ENDIF.



  IF GS_DISP_100-GR_QTY > GS_DISP_100-REM_QTY.

    MESSAGE '##### #### #### ### ###' TYPE 'S' DISPLAY LIKE 'E'.

    GS_DISP_100-GR_QTY = 0.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  RESET_CELL

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*      -->P_LS_MODI  TEXT

*----------------------------------------------------------------------*




FORM RESET_CELL USING P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                      PS_MODI        TYPE LVC_S_MODI.



  CALL METHOD P_DATA_CHANGED->MODIFY_CELL

    EXPORTING

      I_ROW_ID    = PS_MODI-ROW_ID

      I_FIELDNAME = PS_MODI-FIELDNAME

      I_VALUE     = ''.



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  MODIFY_DATA

*&---------------------------------------------------------------------*




FORM MODIFY_DATA .

  DATA : LV_NUM TYPE I VALUE 1.

  IF GV_MODE = C_CRUD.

    LOOP AT GT_DISP_100 INTO GS_DISP_100 WHERE REM_QTY <> 0.

      " ##### ####### ## ## ## "

      GS_DISP_100-LINE = LV_NUM.

      IF GS_DISP_100-REM_QTY = 0.

        DELETE GT_DISP_100 INDEX SY-TABIX.

        CONTINUE.

      ENDIF.



      GS_DISP_100-COLOR = ICON_YELLOW_LIGHT.

      GS_DISP_100-WERKS = GS_HEADER_100-WERKS.

      PERFORM GET_WERKS_TEXT USING GS_DISP_100-WERKS

                             CHANGING GS_DISP_100-WERKS_TX.



      PERFORM GET_LGORT_TEXT USING GS_DISP_100-WERKS

                                    GS_DISP_100-LGORT

                             CHANGING GS_DISP_100-LGORT_TX.

      PERFORM GET_MATKL USING GS_DISP_100-MATNR CHANGING GS_DISP_100-MATKL.

      MODIFY GT_DISP_100 FROM GS_DISP_100 INDEX SY-TABIX.

      LV_NUM = LV_NUM + 1.

    ENDLOOP.



    READ TABLE GT_DISP_100 INTO GS_DISP_100 INDEX 1.

  ELSEIF GV_MODE = C_DISP.

    CLEAR : GT_DISP_100, GS_DISP_100.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  POST_GOODS_RECEIPT

*&---------------------------------------------------------------------*




FORM POST_GOODS_RECEIPT .

  DATA LV_ANSWER TYPE C.

  DATA : LV_MBLNR TYPE ZMKPF01-MBLNR.



  CLEAR : GS_MKPF , GT_MKPF , GS_MSEG , GT_MSEG.



  LOOP AT GT_DISP_100 INTO GS_DISP_100.

    IF GS_DISP_100-L_CHECK <> 'X'.

      MESSAGE | ####: { SY-TABIX } ### ##### ## ### ####| TYPE 'S' DISPLAY LIKE 'E'.

      RETURN.

    ENDIF.

  ENDLOOP.





  CALL FUNCTION 'NUMBER_GET_NEXT'

    EXPORTING

      OBJECT       = 'ZMBELN01'

      NR_RANGE_NR  = '01'

    IMPORTING

      NUMBER       = LV_MBLNR

    EXCEPTIONS

      OTHERS       = 1.



  IF SY-SUBRC <> 0.

    MESSAGE '#### ##' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  GS_HEADER_100-MBLNR = LV_MBLNR.

  " ######

  GS_MKPF-MBLNR = GS_HEADER_100-MBLNR.

  GS_MKPF-BLDAT = GS_HEADER_100-BLDAT.

  GS_MKPF-BUDAT = GS_HEADER_100-BUDAT.

  GS_MKPF-BLART = GS_HEADER_100-BLART.

  GS_MKPF-MJAHR = GS_HEADER_100-BUDAT(4).

  GS_MKPF-CRNAME = SY-UNAME.

  GS_MKPF-CRDATE = SY-DATUM.

  GS_MKPF-CRZEIT = SY-UZEIT.





  " #### ##

  LOOP AT GT_DISP_100 INTO GS_DISP_100.

    IF GS_DISP_100-GR_QTY <> 0.

      GS_MSEG-MBLNR = GS_HEADER_100-MBLNR.

      GS_MSEG-MJAHR = GS_HEADER_100-BUDAT(4).

      GS_MSEG-ZEILE = SY-TABIX * 10.

      GS_MSEG-MATNR = GS_DISP_100-MATNR.

      GS_MSEG-WERKS = GS_DISP_100-WERKS.

      GS_MSEG-LGORT = GS_DISP_100-LGORT.

      GS_MSEG-LIFNR = GS_HEADER_100-LIFNR.

      GS_MSEG-WAERS = GS_DISP_100-WAERS.

      GS_MSEG-MENGE = GS_DISP_100-GR_QTY.

      GS_MSEG-DMBTR = GS_DISP_100-DMBTR.

      GS_MSEG-MEINS = GS_DISP_100-MEINS.

      GS_MSEG-EBELN = GS_HEADER_100-EBELN.

      GS_MSEG-BUKRS = GS_HEADER_100-BUKRS.

      GS_MSEG-GJAHR = GS_HEADER_100-BUDAT(4).



      GS_MSEG-SHKZG = GS_HEADER_100-SHKZG.

      GS_MSEG-BWART = GS_HEADER_100-BWART.

      APPEND GS_MSEG TO GT_MSEG.

    ENDIF.



  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  POST_FI_DOCUMENT

*&---------------------------------------------------------------------*




FORM POST_FI_DOCUMENT .



  DATA : LV_BUZEI TYPE ZBSEG01-BUZEI VALUE 1,

         LV_BELNR TYPE ZBSEG01-BELNR.



  DATA:  LS_MAT         TYPE ZMAT01.



  DATA : LV_KTOPL TYPE ZSKA1_01-KTOPL VALUE 'ZCOA',

         LV_KTOSL TYPE ZSKA1_01-KTOSL,

         LV_BKLAS TYPE ZSKA1_01-BKLAS VALUE '3000'.



  DATA : LT_RSEG TYPE TABLE OF ZRSEG01,

         LS_RSEG TYPE ZRSEG01,

         LS_RBKP TYPE ZRBKP01.



DATA : LV_STR_PR   TYPE ZBSEG01-WRBTR, "## ##

       LV_PO_PR    TYPE ZBSEG01-WRBTR, "PO ##

       LV_RATE_IR  TYPE ZRBKP01-KURSF, "## ##

       LV_RATE_GR  TYPE ZRBKP01-KURSF, "## ##

       LV_GR_QTY   TYPE ZMSEG01-MENGE, "## ##

       LV_GRIR_FCY TYPE ZBSEG01-WRBTR, "GR/IR ##

       LV_GRIR_LCY TYPE ZBSEG01-DMBTR, "GR/IR ##

       LV_STD_FCY  TYPE ZBSEG01-WRBTR, "## ##

       LV_STD_LCY  TYPE ZBSEG01-DMBTR, "## ##

       LV_PRD_FCY  TYPE ZBSEG01-WRBTR, "### ##

       LV_PRD_LCY  TYPE ZBSEG01-DMBTR, "### ##



       LV_KDM_LCY  TYPE ZBSEG01-DMBTR. "###




*&---------------------------------------------------------------------*

*       ## PO# #### ##### ### ## ## ##

*----------------------------------------------------------------------*




    SELECT *

      FROM ZRSEG01

      INTO TABLE LT_RSEG

     WHERE EBELN = GS_HEADER_100-EBELN.



    READ TABLE LT_RSEG INTO LS_RSEG INDEX 1.



    SELECT SINGLE KURSF

      FROM ZRBKP01

      INTO LV_RATE_IR

     WHERE BELNR = LS_RSEG-BELNR

       AND GJAHR = LS_RSEG-GJAHR.



   LV_RATE_GR = GS_HEADER_100-KURSF.



   IF LV_RATE_IR = 0.

     LV_RATE_IR = LV_RATE_GR.

   ENDIF.



  IF GS_HEADER_100-WAERS <> C_WAERS_D.

    LV_RATE_GR = LV_RATE_GR * '0.01'.

    LV_RATE_IR = LV_RATE_IR * '0.01'.

  ENDIF.




*&---------------------------------------------------------------------*

*       #### ## 4900000000~ (04)

*----------------------------------------------------------------------*




  PERFORM GET_NEW_BELNR USING C_NR_FI_GR CHANGING LV_BELNR .






*&---------------------------------------------------------------------*

*       ####

*----------------------------------------------------------------------*




  GS_BKPF-BUKRS = GS_HEADER_100-BUKRS.

  GS_BKPF-BELNR = LV_BELNR.

  GS_BKPF-GJAHR = SY-DATUM(4).

  GS_BKPF-BLART = 'WE'.

  GS_BKPF-BLDAT = GS_HEADER_100-BLDAT.

  GS_BKPF-BUDAT = GS_HEADER_100-BUDAT.

  IF GS_HEADER_100-WAERS <> C_WAERS_D.

   GS_BKPF-KURSF = LV_RATE_GR.

  ELSE.

   GS_BKPF-KURSF = C_KURSF_TEMP.

  ENDIF.

  GS_BKPF-WAERS = GS_HEADER_100-WAERS.

  GS_BKPF-TCODE = 'MIGO'.

  GS_BKPF-XBLNR = GS_HEADER_100-MBLNR.

  GS_BKPF-CRNAME = SY-UNAME.

  GS_BKPF-CPUDT = SY-DATUM.

  GS_BKPF-CPUTM = SY-UZEIT.



  CLEAR : LT_RSEG.

  LOOP AT GT_MSEG INTO GS_MSEG.

    CLEAR: LS_MAT .





"---------------------------------------------------------

" ## ## ##

"---------------------------------------------------------

    SELECT SINGLE *

      FROM ZMAT01

      INTO LS_MAT

      WHERE MATNR = GS_MSEG-MATNR.



    LV_STR_PR = LS_MAT-STPRS.



    SELECT SINGLE NETPR

      INTO LV_PO_PR

      FROM ZEKPO01

     WHERE EBELN = GS_HEADER_100-EBELN

       AND MATNR = GS_MSEG-MATNR.

"---------------------------------------------------------

"  #### GR/IR

"---------------------------------------------------------

    LV_GR_QTY = GS_MSEG-MENGE.

    LV_GRIR_FCY = LV_PO_PR * LV_GR_QTY. "## ### ##

    LV_GRIR_LCY = LV_GRIR_FCY * LV_RATE_IR.

    LV_STD_FCY = LV_STR_PR * LV_GR_QTY.

    LV_STD_LCY = LV_STD_FCY * LV_RATE_GR.

    LV_PRD_FCY = ( LV_STR_PR - LV_PO_PR ) * LV_GR_QTY.

    LV_PRD_LCY = LV_PRD_FCY * LV_RATE_GR.

    LV_KDM_LCY = ( LV_GRIR_FCY * LV_RATE_GR )

               - ( LV_GRIR_FCY * LV_RATE_IR ).

"---------------------------------------------------------

" GR/IR Cr (##)

"---------------------------------------------------------

    LV_KTOSL = 'WRX'. "GR/IR CLEARING

"---------------------------------------------------------

" ## ###

"---------------------------------------------------------

    CLEAR GS_BSEG.

    GS_BSEG-BUKRS = GS_HEADER_100-BUKRS.

    GS_BSEG-BELNR = LV_BELNR.

    GS_BSEG-GJAHR = SY-DATUM(4).

    GS_BSEG-BUZEI = LV_BUZEI.

    GS_BSEG-SHKZG = 'H'.

    GS_BSEG-MATNR = GS_MSEG-MATNR.

    PERFORM GET_HKONT USING LV_KTOPL LV_KTOSL LV_BKLAS GS_HEADER_100-BUKRS GS_HEADER_100-LIFNR GS_BSEG-SHKZG

                      CHANGING GS_BSEG-HKONT.

    PERFORM GET_KOART USING GS_BSEG-HKONT CHANGING GS_BSEG-KOART.

    PERFORM GET_BSCHL USING GS_BSEG-HKONT GS_BSEG-SHKZG CHANGING GS_BSEG-BSCHL.

    GS_BSEG-SAKNR = GS_BSEG-HKONT.

    GS_BSEG-SGTXT  = |GR/IR-### : { LS_MAT-MAKTX }|.

    GS_BSEG-WRBTR =  LV_GRIR_FCY.

    GS_BSEG-DMBTR =  LV_GRIR_LCY.



    APPEND GS_BSEG TO GT_BSEG.

    LV_BUZEI = LV_BUZEI + 1.

"---------------------------------------------------------

" #### PRD ## ##

"---------------------------------------------------------

    LV_KTOSL = 'PRD'.



    IF LV_PRD_FCY <> 0.

      CLEAR : GS_BSEG.



      GS_BSEG-BUKRS = GS_HEADER_100-BUKRS.

      GS_BSEG-BELNR = LV_BELNR.

      GS_BSEG-GJAHR = SY-DATUM(4).

      GS_BSEG-BUZEI = LV_BUZEI.

      GS_BSEG-SHKZG = COND #( WHEN LV_PRD_FCY < 0 THEN 'S' ELSE 'H' ).

      PERFORM GET_HKONT USING LV_KTOPL LV_KTOSL LV_BKLAS GS_HEADER_100-BUKRS GS_HEADER_100-LIFNR GS_BSEG-SHKZG

                        CHANGING GS_BSEG-HKONT.

      PERFORM GET_KOART USING GS_BSEG-HKONT CHANGING GS_BSEG-KOART.

      PERFORM GET_BSCHL USING GS_BSEG-HKONT GS_BSEG-SHKZG CHANGING GS_BSEG-BSCHL.

      GS_BSEG-SAKNR = GS_BSEG-HKONT.

      GS_BSEG-SGTXT = '####'.

      GS_BSEG-WRBTR = ABS( LV_PRD_FCY ).

      GS_BSEG-DMBTR = ABS( LV_PRD_LCY ).

      GS_BSEG-MATNR = GS_MSEG-MATNR.

      APPEND GS_BSEG TO GT_BSEG.

      LV_BUZEI = LV_BUZEI + 1.

    ENDIF.

    "---------------------------------------------------------

    " KDM ####

    "---------------------------------------------------------



    IF LV_KDM_LCY <> 0.

      LV_KTOSL = 'KDM'.



      CLEAR GS_BSEG.

      GS_BSEG-BUKRS = GS_HEADER_100-BUKRS.

      GS_BSEG-BELNR = LV_BELNR.

      GS_BSEG-GJAHR = SY-DATUM(4).

      GS_BSEG-BUZEI = LV_BUZEI.

      GS_BSEG-SHKZG = COND #( WHEN LV_KDM_LCY < 0 THEN 'S' ELSE 'H' ).



      PERFORM GET_HKONT USING LV_KTOPL LV_KTOSL LV_BKLAS

                              GS_HEADER_100-BUKRS GS_HEADER_100-LIFNR GS_BSEG-SHKZG

                        CHANGING GS_BSEG-HKONT.

      PERFORM GET_KOART USING GS_BSEG-HKONT CHANGING GS_BSEG-KOART.

      PERFORM GET_BSCHL USING GS_BSEG-HKONT GS_BSEG-SHKZG CHANGING GS_BSEG-BSCHL.

      GS_BSEG-SAKNR = GS_BSEG-HKONT.

      GS_BSEG-DMBTR = ABS( LV_KDM_LCY ).

      GS_BSEG-WRBTR = 0.

      GS_BSEG-SGTXT = COND #( WHEN LV_KDM_LCY < 0 THEN '####' ELSE '####' ).

      GS_BSEG-MATNR = GS_MSEG-MATNR.

      APPEND GS_BSEG TO GT_BSEG.

      LV_BUZEI = LV_BUZEI + 1.

    ENDIF.

"---------------------------------------------------------

" #### Dr (##)

"---------------------------------------------------------

    CLEAR : GS_BSEG.

    LV_KTOSL = 'BSX'. "

    GS_BSEG-BUKRS = GS_HEADER_100-BUKRS.

    GS_BSEG-BELNR = LV_BELNR.

    GS_BSEG-GJAHR = SY-DATUM(4).

    GS_BSEG-BUZEI = LV_BUZEI.

    GS_BSEG-SHKZG = 'S'.

    PERFORM GET_HKONT USING LV_KTOPL LV_KTOSL LV_BKLAS GS_HEADER_100-BUKRS GS_HEADER_100-LIFNR GS_BSEG-SHKZG

                      CHANGING GS_BSEG-HKONT.

    PERFORM GET_KOART USING GS_BSEG-HKONT CHANGING GS_BSEG-KOART.

    PERFORM GET_BSCHL USING GS_BSEG-HKONT GS_BSEG-SHKZG CHANGING GS_BSEG-BSCHL.

    GS_BSEG-SAKNR = GS_BSEG-HKONT.

    GS_BSEG-SGTXT = '###'.

    GS_BSEG-WRBTR = LV_STD_FCY.

    GS_BSEG-DMBTR = LV_STD_LCY.

    GS_BSEG-MATNR = GS_MSEG-MATNR.

    APPEND GS_BSEG TO GT_BSEG.

    LV_BUZEI = LV_BUZEI + 1.

  ENDLOOP.



  INSERT ZMKPF01 FROM GS_MKPF.

  INSERT ZMSEG01 FROM TABLE GT_MSEG.

  INSERT ZBKPF01 FROM GS_BKPF.

  INSERT ZBSEG01 FROM TABLE GT_BSEG.

  MESSAGE | #### { GS_HEADER_100-MBLNR }#(#) ######| TYPE 'S'.

  LEAVE TO SCREEN 0.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CANCEL_GOODS_ITEMS

*&---------------------------------------------------------------------*




FORM CANCEL_GOODS_ITEMS .

  DATA : LV_CHECK TYPE ABAP_BOOL VALUE ABAP_FALSE.

  DATA : LT_SELECTED TYPE TABLE OF TY_100,

         LS_ROW      TYPE TY_100.

  DATA LV_ZEILE TYPE MSEG-ZEILE VALUE 10.

  DATA LV_ANSWER TYPE C.





  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR              = '####'

      TEXT_QUESTION         = '###### ######?'

      TEXT_BUTTON_1         = 'YES'

      TEXT_BUTTON_2         = 'NO'

      DISPLAY_CANCEL_BUTTON = ' '

    IMPORTING

      ANSWER                = LV_ANSWER.



  IF LV_ANSWER = '2'.

    " NO ### #

    MESSAGE '#######.' TYPE 'S'.

    RETURN.

  ENDIF.



  IF GT_DISP_100 IS INITIAL.

    MESSAGE '##### #### ####### ######' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  READ TABLE GT_DISP_100 WITH KEY L_CHECK = 'X' TRANSPORTING NO FIELDS.

  IF SY-SUBRC <> 0.

    MESSAGE '### ### #####' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  CLEAR : GT_MSEG ,GS_MSEG, GT_MKPF , GS_MKPF.



"-------------------------------------------------------------

" ### ## ###

"-------------------------------------------------------------

  LOOP AT GT_DISP_100 INTO LS_ROW WHERE L_CHECK = 'X'.

    APPEND LS_ROW TO LT_SELECTED.

  ENDLOOP.



"-------------------------------------------------------------

" MKPF

"-------------------------------------------------------------

  CLEAR GS_MKPF.

  GS_MKPF-BLART = 'WE'.

  GS_MKPF-BLDAT = SY-DATUM.

  GS_MKPF-BUDAT = SY-DATUM.

  GS_MKPF-MJAHR = SY-DATUM+0(4).

  GS_MKPF-STORN = 'X'.

  GS_MKPF-CRNAME = SY-UNAME.

  GS_MKPF-CRDATE = SY-DATUM.

  GS_MKPF-CRZEIT = SY-UZEIT.

  PERFORM GET_NEW_MBLNR CHANGING GS_MKPF-MBLNR.



  APPEND GS_MKPF TO GT_MKPF.



"-------------------------------------------------------------

" ### #### ## MSEG# ## (# ### ####)

"-------------------------------------------------------------



  LOOP AT LT_SELECTED INTO LS_ROW.

"-------------------------------------------------------------

" ## MSEG ## ## SELECT

"-------------------------------------------------------------



    CLEAR GS_MSEG.

    GS_MSEG-MBLNR = GS_MKPF-MBLNR.

    GS_MSEG-MJAHR = GS_MKPF-MJAHR.

    GS_MSEG-LIFNR = LS_ROW-LIFNR.

    GS_MSEG-ZEILE = LV_ZEILE.

    GS_MSEG-BUKRS = LS_ROW-BUKRS.

    GS_MSEG-EBELN = LS_ROW-EBELN.



    GS_MSEG-MATNR = LS_ROW-MATNR.

    GS_MSEG-WERKS = LS_ROW-WERKS.

    GS_MSEG-LGORT = LS_ROW-LGORT.



    GS_MSEG-BWART = '102'.

    GS_MSEG-SHKZG = 'H'.

    GS_MSEG-MENGE = LS_ROW-GR_DONE_QTY.



    GS_MSEG-DMBTR = LS_ROW-DMBTR.

    GS_MSEG-WAERS = LS_ROW-WAERS.

    GS_MSEG-MEINS = LS_ROW-MEINS.



    GS_MSEG-STBLG = LS_ROW-MBLNR.

    GS_MSEG-STJAH = LS_ROW-MJAHR.

    GS_MSEG-STORN = 'X'.



    LV_ZEILE = LV_ZEILE + 10.



    APPEND GS_MSEG TO GT_MSEG.



  ENDLOOP.



  "-------------------------------------------------------------

  " DB ##

  "-------------------------------------------------------------

  INSERT ZMKPF01 FROM TABLE GT_MKPF.

  INSERT ZMSEG01 FROM TABLE GT_MSEG.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CANCEL_FI_DOCUMENT

*&---------------------------------------------------------------------*




FORM CANCEL_FI_DOCUMENT .

  DATA : LS_BKPF TYPE ZBKPF01,

         LS_BSEG TYPE ZBSEG01,

         LT_BSEG LIKE TABLE OF LS_BSEG,

         LS_TEMP_BSEG TYPE ZBSEG01,

         LT_TEMP_BSEG LIKE TABLE OF LS_BSEG.



  DATA : LV_BUZEI TYPE ZBSEG01-BUZEI VALUE 1,

         LV_BELNR TYPE ZBSEG01-BELNR,

         LV_PRICE_SUM  TYPE ZBSEG01-DMBTR.



  DATA : LV_KTOPL TYPE ZSKA1_01-KTOPL VALUE 'ZCOA',

         LV_KTOSL TYPE ZSKA1_01-KTOSL,

         LV_BKLAS TYPE ZSKA1_01-BKLAS VALUE '3000'.







  CLEAR : GT_BKPF , GS_BKPF , GT_BSEG , GS_BSEG.




*&---------------------------------------------------------------------*

*       ## #### ## 4800000000~ (05)

*----------------------------------------------------------------------*




  PERFORM GET_NEW_BELNR USING C_NR_FI_GR_CANC CHANGING LV_BELNR .




*&---------------------------------------------------------------------*

*       ## ## ## ( ##### )

*----------------------------------------------------------------------*




  SELECT SINGLE *

    FROM ZBKPF01

    INTO CORRESPONDING FIELDS OF LS_BKPF

    WHERE XBLNR = GS_MSEG-STBLG

       AND BUKRS = GS_HEADER_100-BUKRS.



  LOOP AT GT_MSEG INTO GS_MSEG.

    CLEAR : LT_TEMP_BSEG.

    SELECT *

      FROM ZBSEG01

      INTO CORRESPONDING FIELDS OF TABLE LT_TEMP_BSEG

      WHERE BELNR = LS_BKPF-BELNR

      AND  MATNR = GS_MSEG-MATNR.

    LOOP AT LT_TEMP_BSEG INTO LS_TEMP_BSEG.

      APPEND LS_TEMP_BSEG TO LT_BSEG.

    ENDLOOP.

  ENDLOOP.




*&---------------------------------------------------------------------*

*       ## ##  ###

*----------------------------------------------------------------------*




  GS_BKPF-BUKRS = LS_BKPF-BUKRS.

  GS_BKPF-BELNR = LV_BELNR.

  GS_BKPF-GJAHR = LS_BKPF-GJAHR.

  GS_BKPF-BLART = 'WE'.

  GS_BKPF-BLDAT = LS_BKPF-BLDAT.

  GS_BKPF-BUDAT = LS_BKPF-BUDAT.

  GS_BKPF-KURSF = LS_BKPF-KURSF.

  GS_BKPF-WAERS = LS_BKPF-WAERS.

  GS_BKPF-TCODE = 'MIGO'.

  GS_BKPF-XBLNR = GS_MKPF-MBLNR.

  GS_BKPF-XSTOV = 'X'.

  GS_BKPF-CPUDT = SY-DATUM.

  GS_BKPF-CPUTM = SY-UZEIT.

  GS_BKPF-CRNAME = SY-UNAME.




*&---------------------------------------------------------------------*

*       ## ## ###

*----------------------------------------------------------------------*




  LOOP AT LT_BSEG INTO LS_BSEG.

    CLEAR GS_BSEG.

    GS_BSEG-BUKRS = LS_BSEG-BUKRS.

    GS_BSEG-BELNR = LV_BELNR.

    GS_BSEG-GJAHR = LS_BSEG-GJAHR.

    GS_BSEG-BUZEI = LV_BUZEI.

    IF LS_BSEG-SHKZG = 'S'.

      GS_BSEG-SHKZG = 'H'.

    ELSE.

      GS_BSEG-SHKZG = 'S'.

    ENDIF.

    GS_BSEG-MATNR = LS_BSEG-MATNR.

    GS_BSEG-HKONT = LS_BSEG-HKONT.

    GS_BSEG-KOART = LS_BSEG-KOART.

    PERFORM GET_BSCHL USING GS_BSEG-HKONT GS_BSEG-SHKZG CHANGING GS_BSEG-BSCHL.

    GS_BSEG-SAKNR = LS_BSEG-SAKNR.

    GS_BSEG-SGTXT  = |#### : { LS_BSEG-SGTXT }|.

    GS_BSEG-WRBTR = ABS( LS_BSEG-WRBTR ).

    GS_BSEG-DMBTR = ABS( LS_BSEG-DMBTR ).



    APPEND GS_BSEG TO GT_BSEG.

    LV_BUZEI = LV_BUZEI + 1.

  ENDLOOP.



  INSERT ZBKPF01 FROM GS_BKPF.

  INSERT ZBSEG01 FROM TABLE GT_BSEG.

  MESSAGE | #### { GS_MKPF-MBLNR }#(#) ######| TYPE 'S'.

  LEAVE TO SCREEN 0.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  SET_ITEM_OK_TO_GREEN

*&---------------------------------------------------------------------*




FORM SET_ITEM_OK_TO_GREEN .



  DATA LS_ROW TYPE TY_100.

  IF GS_DISP_100-L_CHECK = 'X'.

    " ## INDEX ##

    READ TABLE GT_DISP_100 INTO LS_ROW INDEX GV_CURR_INDEX.

    IF SY-SUBRC = 0.



      LS_ROW-COLOR = ICON_GREEN_LIGHT.   " # ###

      LS_ROW-L_CHECK = 'X'.



      MODIFY GT_DISP_100 FROM LS_ROW INDEX GV_CURR_INDEX.

    ENDIF.

  ELSE.

    "## INDEX ##

    READ TABLE GT_DISP_100 INTO LS_ROW INDEX GV_CURR_INDEX.

    IF SY-SUBRC = 0.



      LS_ROW-COLOR = ICON_YELLOW_LIGHT.   " # ###

      LS_ROW-L_CHECK = ' '.



      MODIFY GT_DISP_100 FROM LS_ROW INDEX GV_CURR_INDEX.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  UPDATE_SCREEN

*&---------------------------------------------------------------------*




FORM UPDATE_SCREEN .

  GS_DISP_100-DMBTR = GS_DISP_100-GR_QTY * GS_DISP_100-NETPR.

  MODIFY GT_DISP_100 FROM GS_DISP_100 INDEX GV_CURR_INDEX.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  SORT_LINE_UP

*&---------------------------------------------------------------------*




FORM SORT_LINE_UP .

  SORT GT_DISP_100 BY EBELP ASCENDING.

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  SORT_LINE_DOWN

*&---------------------------------------------------------------------*




FORM SORT_LINE_DOWN .

  SORT GT_DISP_100 BY EBELP DESCENDING.

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CREATE_OBJECT_DISP

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT_DISP .



  CREATE OBJECT GC_CUSTOM

    EXPORTING




*      PARENT                      =




      CONTAINER_NAME              = 'CON1'




*      STYLE                       =

*      LIFETIME                    = LIFETIME_DEFAULT

*      REPID                       =

*      DYNNR                       =

*      NO_AUTODEF_PROGID_DYNNR     =

*    EXCEPTIONS

*      CNTL_ERROR                  = 1

*      CNTL_SYSTEM_ERROR           = 2

*      CREATE_ERROR                = 3

*      LIFETIME_ERROR              = 4

*      LIFETIME_DYNPRO_DYNPRO_LINK = 5

*      OTHERS                      = 6




      .

  CREATE OBJECT GC_CUSTOM2

    EXPORTING




*      PARENT                      =




      CONTAINER_NAME              = 'CON2'




*      STYLE                       =

*      LIFETIME                    = LIFETIME_DEFAULT

*      REPID                       =

*      DYNNR                       =

*      NO_AUTODEF_PROGID_DYNNR     =

*    EXCEPTIONS

*      CNTL_ERROR                  = 1

*      CNTL_SYSTEM_ERROR           = 2

*      CREATE_ERROR                = 3

*      LIFETIME_ERROR              = 4

*      LIFETIME_DYNPRO_DYNPRO_LINK = 5

*      OTHERS                      = 6




      .

  CREATE OBJECT GO_TREE

    EXPORTING

      PARENT                = GC_CUSTOM

      NODE_SELECTION_MODE   = CL_GUI_COLUMN_TREE=>NODE_SEL_MODE_SINGLE

      ITEM_SELECTION        = 'X'

      HIERARCHY_COLUMN_NAME = GV_HCOL

      HIERARCHY_HEADER      = GS_HEADER

    EXCEPTIONS

      LIFETIME_ERROR              = 1

      CNTL_SYSTEM_ERROR           = 2

      CREATE_ERROR                = 3

      ILLEGAL_NODE_SELECTION_MODE = 4

      FAILED                      = 5

      ILLEGAL_COLUMN_NAME         = 6

      OTHERS                      = 7.



  CREATE OBJECT GC_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_CUSTOM2.




*      I_APPL_EVENTS     = SPACE

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

*      OTHERS            = 5




      .

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  ALV_DISPLAY_DISP

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*




FORM ALV_DISPLAY_DISP  USING  PT_ALV_DATA.





  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT      = GS_VARIANT

      I_SAVE          = 'A'

      IS_LAYOUT       = GS_LAYOUT

    CHANGING

      IT_OUTTAB       = PT_ALV_DATA

      IT_FIELDCATALOG = GT_FIELDCAT

      IT_SORT         = GT_SORT.




*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      OTHERS                        = 4




          .

  IF SY-SUBRC <> 0.




*   IMPLEMENT SUITABLE ERROR HANDLING HERE




  ENDIF.





  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  FILL_NODE

*&---------------------------------------------------------------------*




FORM FILL_NODE .

  CLEAR: GT_NODES, GT_ITEMS.



  DATA: LS_NODE TYPE TREEV_NODE,

        LS_ITEM TYPE MTREEITM.



  "---------------------------------------------------------

  " 1) PURCHASE ORDERS (### ##)

  "---------------------------------------------------------

  CLEAR LS_NODE.

  LS_NODE-NODE_KEY  = 'PO_ROOT'.

  LS_NODE-ISFOLDER  = 'X'.

  LS_NODE-N_IMAGE  = C_ICON_NONE.

  LS_NODE-EXP_IMAGE = C_ICON_NONE.

  APPEND LS_NODE TO GT_NODES.



  CLEAR LS_ITEM.

  LS_ITEM-NODE_KEY  = 'PO_ROOT'.

  LS_ITEM-ITEM_NAME = GV_HCOL.

  LS_ITEM-TEXT      = '####'.

  APPEND LS_ITEM TO GT_ITEMS.





  " PURCHASE ORDER ## ##



  PERFORM ADD_DOC USING 'PO_ROOT' P_EBELN.



  "---------------------------------------------------------

  " 2) MATERIAL DOCUMENTS

  "---------------------------------------------------------

  CLEAR LS_NODE.

  LS_NODE-NODE_KEY  = 'MM_ROOT'.

  LS_NODE-ISFOLDER  = 'X'.

  LS_NODE-N_IMAGE  = C_ICON_NONE.

  LS_NODE-EXP_IMAGE = C_ICON_NONE.

  APPEND LS_NODE TO GT_NODES.



  CLEAR LS_ITEM.

  LS_ITEM-NODE_KEY  = 'MM_ROOT'.

  LS_ITEM-ITEM_NAME = GV_HCOL.

  LS_ITEM-TEXT      = '####'.

  APPEND LS_ITEM TO GT_ITEMS.





  " MATERIAL DOCUMENTS

   LOOP AT GT_MKPF INTO GS_MKPF.

     IF GS_MKPF-STORN = ' '.

       PERFORM ADD_DOC USING 'MM_ROOT' GS_MKPF-MBLNR.

     ENDIF.

   ENDLOOP.



  "---------------------------------------------------------

  " 2) MATERIAL DOCUMENTS

  "---------------------------------------------------------

  CLEAR LS_NODE.

  LS_NODE-NODE_KEY  = 'MM_ROOT2'.

  LS_NODE-ISFOLDER  = 'X'.

  LS_NODE-N_IMAGE  = C_ICON_NONE.

  LS_NODE-EXP_IMAGE = C_ICON_NONE.

  APPEND LS_NODE TO GT_NODES.



  CLEAR LS_ITEM.

  LS_ITEM-NODE_KEY  = 'MM_ROOT2'.

  LS_ITEM-ITEM_NAME = GV_HCOL.

  LS_ITEM-TEXT      = '####'.

  APPEND LS_ITEM TO GT_ITEMS.





  " MATERIAL DOCUMENTS

   LOOP AT GT_MKPF INTO GS_MKPF.

     IF GS_MKPF-STORN = 'X'.

       PERFORM ADD_DOC USING 'MM_ROOT2' GS_MKPF-MBLNR.

     ENDIF.

   ENDLOOP.



  GO_TREE->ADD_NODES_AND_ITEMS(

    EXPORTING

      NODE_TABLE                = GT_NODES

      ITEM_TABLE                = GT_ITEMS

      ITEM_TABLE_STRUCTURE_NAME = 'MTREEITM'

  ).





  GO_TREE->EXPAND_ROOT_NODES( LEVEL_COUNT = 1 ).

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  ADD_DOC

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*




FORM ADD_DOC USING PV_PARENT PV_DOC.

  DATA: LS_NODE TYPE TREEV_NODE,

        LS_ITEM TYPE MTREEITM.



  "## ## (##)

  CLEAR LS_NODE.

  LS_NODE-NODE_KEY  = PV_DOC.

  LS_NODE-RELATKEY  = PV_PARENT.

  LS_NODE-RELATSHIP = CL_GUI_COLUMN_TREE=>RELAT_LAST_CHILD.

  LS_NODE-ISFOLDER  = ''.   "##

  LS_NODE-N_IMAGE  = C_ICON_NONE.

  LS_NODE-EXP_IMAGE = C_ICON_NONE.

  APPEND LS_NODE TO GT_NODES.



  "### ## (## ## ##)

  CLEAR LS_ITEM.

  LS_ITEM-NODE_KEY  = PV_DOC.

  LS_ITEM-ITEM_NAME = GV_HCOL.

  LS_ITEM-TEXT      = PV_DOC.

  APPEND LS_ITEM TO GT_ITEMS.



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  CLASS_EVENT_0100

*&---------------------------------------------------------------------*




FORM CLASS_EVENT_0100 .

  CREATE OBJECT GO_EVENT.

  SET HANDLER GO_EVENT->HANDLER_TOOLBAR FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_USER_COMMAND FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_HOTSPOT_CLICK FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DOUBLE_CLICK FOR GC_GRID.



    CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED




*    EXCEPTIONS

*      ERROR      = 1

*      OTHERS     = 2




  .

  SET HANDLER GO_EVENT->HANDLER_BUTTON_CLICK FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.



  DATA LT_EVENTS TYPE CNTL_SIMPLE_EVENTS.

  LT_EVENTS = VALUE #(

  ( EVENTID = CL_GUI_COLUMN_TREE=>EVENTID_NODE_DOUBLE_CLICK APPL_EVENT = 'X' )

  ( EVENTID = CL_GUI_COLUMN_TREE=>EVENTID_ITEM_DOUBLE_CLICK APPL_EVENT = 'X' )

  ).



  GO_TREE->SET_REGISTERED_EVENTS( EXPORTING EVENTS = LT_EVENTS ).



  CREATE OBJECT GO_TREE_EVENT.

  SET HANDLER GO_TREE_EVENT->ON_ITEM_DOUBLE_CLICK FOR GO_TREE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  TREE_HANDLER_ITEM_DOUBLE_CLICK

*&---------------------------------------------------------------------*




FORM TREE_HANDLER_ITEM_DOUBLE_CLICK  USING    P_NODE_KEY

                                              P_ITEM_NAME.

  DATA: LT_MSEG TYPE TABLE OF ZMSEG01,

        LS_MSEG TYPE ZMSEG01,

        LS_MKPF TYPE ZMKPF01,

        LV_MAKTX TYPE ZMAT01-MAKTX.

  DATA: LS_EKPO TYPE ZEKPO01.

  DATA: LV_CANCELED TYPE ABAP_BOOL VALUE ABAP_TRUE.

  DATA : LV_KURSF TYPE ZBKPF01-KURSF.



  IF P_NODE_KEY = P_EBELN.

    EXIT.

  ENDIF.



  SELECT *

    FROM ZMSEG01

    INTO CORRESPONDING FIELDS OF TABLE LT_MSEG

    WHERE MBLNR = P_NODE_KEY.



  SELECT SINGLE *

    FROM ZMKPF01

    INTO CORRESPONDING FIELDS OF LS_MKPF

    WHERE MBLNR = P_NODE_KEY.



  SELECT SINGLE KURSF

    FROM ZBKPF01

    INTO LV_KURSF

    WHERE XBLNR = P_NODE_KEY.



  GS_HEADER_100-WERKS = P_WERKS.

  GS_HEADER_100-BLDAT = LS_MKPF-BLDAT.

  GS_HEADER_100-BUDAT = LS_MKPF-BUDAT.

  GS_HEADER_100-INCO1 = GS_EKKO-INCO1.

  GS_HEADER_100-BWART = 102.

  GS_HEADER_100-MODE_TX = '#### # ##'.

  GS_HEADER_100-KURSF = LV_KURSF.

  GS_HEADER_100-MBLNR  = LS_MKPF-MBLNR.

  GS_HEADER_100-CRNAME = LS_MKPF-CRNAME.

  GS_HEADER_100-CRDATE = LS_MKPF-CRDATE.

  GS_HEADER_100-CRZEIT = LS_MKPF-CRZEIT.

  GS_HEADER_100-TCODE = 'MIGO'.



  IF LS_MKPF IS INITIAL.

    MESSAGE '## ##### ### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  CLEAR : GT_DISP_100.



  LOOP AT LT_MSEG INTO LS_MSEG.



    CLEAR : GS_DISP_100 , LS_EKPO , LV_MAKTX.



    "-------------------------------------------------------

    " 1) ###, #### ##

    "-------------------------------------------------------

    SELECT SINGLE MAKTX

      INTO LV_MAKTX

      FROM ZMAT01

      WHERE MATNR = LS_MSEG-MATNR.



    SELECT SINGLE MWSKZ PRDAT

      INTO CORRESPONDING FIELDS OF LS_EKPO

      FROM ZEKPO01

      WHERE MATNR = LS_MSEG-MATNR

        AND EBELN = P_EBELN.



    "-------------------------------------------------------

    " 2) ## ## ##

    "-------------------------------------------------------

    MOVE-CORRESPONDING LS_MSEG TO GS_DISP_100.

    GS_DISP_100-MAKTX = LV_MAKTX.

    GS_DISP_100-MWSKZ = LS_EKPO-MWSKZ.

    GS_DISP_100-PRDAT = LS_EKPO-PRDAT.

    GS_DISP_100-GR_DONE_QTY = LS_MSEG-MENGE.

    SELECT SINGLE NETPR

      INTO GS_DISP_100-NETPR

      FROM ZEKPO01

      WHERE MATNR = LS_MSEG-MATNR

        AND EBELN = P_EBELN.



    SELECT SINGLE MENGE

      INTO GS_DISP_100-MENGE

      FROM ZEKPO01

      WHERE MATNR = LS_MSEG-MATNR

        AND EBELN = P_EBELN.



    SELECT SINGLE MEINS

      INTO GS_DISP_100-MEINS

      FROM ZEKPO01

      WHERE MATNR = LS_MSEG-MATNR

        AND EBELN = P_EBELN.



    PERFORM GET_WERKS_TEXT USING GS_DISP_100-WERKS

                           CHANGING GS_DISP_100-WERKS_TX.



    PERFORM GET_LGORT_TEXT USING GS_DISP_100-WERKS

                                  GS_DISP_100-LGORT

                           CHANGING GS_DISP_100-LGORT_TX.

    "-------------------------------------------------------

    " 3) ##### ## ### ## ###### ###

    "-------------------------------------------------------

    LV_CANCELED = ABAP_FALSE.



    SELECT SINGLE MBLNR

      FROM ZMSEG01

      INTO @DATA(LV_DUMMY)

      WHERE BWART = '102'               " ## ##

        AND STBLG = @LS_MSEG-MBLNR      " #### ##

        AND STJAH = @LS_MSEG-MJAHR

        AND MATNR = @LS_MSEG-MATNR.



    IF SY-SUBRC = 0.

      LV_CANCELED = ABAP_TRUE.

    ENDIF.



    IF LV_CANCELED = ABAP_TRUE.

      GS_DISP_100-REMARK  = '## ###'.

      GS_DISP_100-NO_EDIT = 'X'.

    ENDIF.



    "-------------------------------------------------------

    " 4) #### ## ## (BWART = 102)

    "-------------------------------------------------------

    IF LS_MSEG-BWART = '102'.

      GS_DISP_100-REMARK  = '####'.

      GS_DISP_100-NO_EDIT = 'X'.

    ENDIF.



    "-------------------------------------------------------

    " 5) ## #### ## ## #### DISABLE ##

    "-------------------------------------------------------

    IF GS_DISP_100-NO_EDIT = 'X'.



      DATA(LS_STYLE) = VALUE LVC_S_STYL(

                          FIELDNAME = 'L_CHECK'

                          STYLE     = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED ).



      INSERT LS_STYLE INTO TABLE GS_DISP_100-CELLTAB.



    ELSE.

      GS_DISP_100-REMARK  = '####'.

    ENDIF.



    APPEND GS_DISP_100 TO GT_DISP_100.



  ENDLOOP.

  READ TABLE GT_DISP_100 INTO GS_DISP_100 INDEX GV_CURR_INDEX.

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DELETE_ALV_ITEMS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DELETE_ALV_ITEMS .

  CLEAR : GT_DISP_100.

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  EXCLUDE_TOOLBAR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM EXCLUDE_TOOLBAR .

  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_INSERT_ROW.

  APPEND GS_EXCLUDE TO GT_EXCLUDE.



  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_DELETE_ROW.

  APPEND GS_EXCLUDE TO GT_EXCLUDE.



  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_APPEND_ROW.

  APPEND GS_EXCLUDE TO GT_EXCLUDE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  GET_GR_QTY

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*




FORM GET_GR_QTY  USING    P_EBELN P_MATNR

                 CHANGING P_DONE_QTY.

  CLEAR P_DONE_QTY.



  DATA: LV_GR101 TYPE MENGE_D,

        LV_GR102 TYPE MENGE_D.



  " 101 ## ##

  SELECT SUM( MENGE )

    INTO LV_GR101

    FROM ZMSEG01

   WHERE EBELN = P_EBELN

     AND MATNR = P_MATNR

     AND BWART = '101'.



  IF SY-SUBRC <> 0.

    CLEAR LV_GR101.

  ENDIF.



  " 102 #### ##

  SELECT SUM( MENGE )

    INTO LV_GR102

    FROM ZMSEG01

   WHERE EBELN = P_EBELN

     AND MATNR = P_MATNR

     AND BWART = '102'.



  IF SY-SUBRC <> 0.

    CLEAR LV_GR102.

  ENDIF.



  " ## ####

  P_DONE_QTY = LV_GR101 - LV_GR102.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  GET_HKONT

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*




FORM GET_HKONT USING    P_KTOPL

                         P_KTOSL

                         P_BKLAS

                         P_BUKRS

                         P_LIFNR

                         P_SHKZG

                CHANGING P_HKONT.



  "-----------------------------------------------------

  " ##### (KBS)

  "-----------------------------------------------------

  IF P_KTOSL = 'KBS'.

    SELECT SINGLE AKONT

      INTO P_HKONT

      FROM LFB1

     WHERE LIFNR = P_LIFNR

       AND BUKRS = P_BUKRS.



    RETURN.

  ENDIF.



  IF P_KTOSL = 'KDM'.

    IF P_SHKZG = 'S'.

      SELECT SINGLE SAKNR

        INTO P_HKONT

        FROM ZSKA1_01

       WHERE KTOPL = P_KTOPL

         AND KTOSL = P_KTOSL

         AND BKLAS = P_BKLAS

         AND KTOKS = 'REV1'.

    ELSE.

      SELECT SINGLE SAKNR

        INTO P_HKONT

        FROM ZSKA1_01

       WHERE KTOPL = P_KTOPL

         AND KTOSL = P_KTOSL

         AND BKLAS = P_BKLAS

         AND KTOKS = 'EXP1'.

    ENDIF.

    RETURN.

  ENDIF.

  "-----------------------------------------------------

  " WRX, PRD, BSX, MWS # # ZSKA1_01 ##### ##

  "-----------------------------------------------------

  SELECT SINGLE SAKNR

    INTO P_HKONT

    FROM ZSKA1_01

   WHERE KTOPL = P_KTOPL

     AND KTOSL = P_KTOSL

     AND BKLAS = P_BKLAS.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_BSCHL

*&---------------------------------------------------------------------*




FORM GET_BSCHL  USING    P_HKONT

                         P_SHKZG

                CHANGING P_BSCHL.

DATA : P_KTOSL TYPE ZSKA1_01-KTOSL.



  SELECT SINGLE KTOSL

    FROM ZSKA1_01

    INTO P_KTOSL

    WHERE SAKNR = P_HKONT.



  CASE P_KTOSL.



    WHEN 'WRX'.      "GR/IR Clearing

      IF P_SHKZG = 'S'.

        P_BSCHL = '96'.   "##

      ELSE.

        P_BSCHL = '86'.   "##

      ENDIF.



    WHEN 'BSX'.      "####

      IF P_SHKZG = 'S'.

        P_BSCHL = '40'.

      ELSE.

        P_BSCHL = '50'.

      ENDIF.



    WHEN 'PRD'.      "####

      IF P_SHKZG = 'S'.

        P_BSCHL = '40'.

      ELSE.

        P_BSCHL = '50'.

      ENDIF.



    WHEN 'MWS'.      "###

      IF P_SHKZG = 'S'.

        P_BSCHL = '40'.

      ELSE.

        P_BSCHL = '50'.

      ENDIF.



    WHEN 'MWS'.      "Vender

      IF P_SHKZG = 'S'.

        P_BSCHL = '21'.

      ELSE.

        P_BSCHL = '31'.

      ENDIF.



    WHEN OTHERS.     "## ##

      IF P_SHKZG = 'S'.

        P_BSCHL = '40'.

      ELSE.

        P_BSCHL = '50'.

      ENDIF.



  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_KOART

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_KOART  USING    P_HKONT

                CHANGING P_KOART.

  SELECT SINGLE KOART

    FROM ZSKA1_01

    INTO P_KOART

    WHERE SAKNR = P_HKONT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  GET_WERKS_TEXT

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*  -->  P1        TEXT

*  <--  P2        TEXT

*----------------------------------------------------------------------*




FORM GET_WERKS_TEXT  USING    P_WERKS

                     CHANGING P_WERKS_TX.

  CLEAR P_WERKS_TX.



  SELECT SINGLE TEXT

    INTO P_WERKS_TX

    FROM ZTWERKS01

   WHERE WERKS = P_WERKS.



  IF SY-SUBRC <> 0.

    P_WERKS_TX = '## ###'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  GET_LGORT_TEXT

*&---------------------------------------------------------------------*




FORM GET_LGORT_TEXT  USING    P_WERKS

                              P_LGORT

                     CHANGING P_LGORT_TX.



  CLEAR P_LGORT_TX.



  SELECT SINGLE TEXT

    INTO P_LGORT_TX

    FROM ZTLGORT01

   WHERE WERKS = P_WERKS

     AND LGORT = P_LGORT.



  IF SY-SUBRC <> 0.

    P_LGORT_TX = '## ####'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_NEW_BELNR

*&---------------------------------------------------------------------*




FORM GET_NEW_BELNR  USING P_NR CHANGING P_BELNR.

  CALL FUNCTION 'NUMBER_GET_NEXT'

    EXPORTING

      OBJECT       = 'ZBELNR01'

      NR_RANGE_NR  = P_NR

    IMPORTING

      NUMBER       = P_BELNR

    EXCEPTIONS

      OTHERS       = 1.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  GET_NEW_MBLNR

*&---------------------------------------------------------------------*




FORM GET_NEW_MBLNR  CHANGING PS_MKPF_MBLNR.

  CALL FUNCTION 'NUMBER_GET_NEXT'

    EXPORTING

      OBJECT       = 'ZMBELN01'

      NR_RANGE_NR  = '01'

    IMPORTING

      NUMBER       = PS_MKPF_MBLNR

    EXCEPTIONS

      OTHERS       = 1.

ENDFORM.






*&---------------------------------------------------------------------*

*&      FORM  GET_NEXT_ITEM

*&---------------------------------------------------------------------*




FORM GET_NEXT_ITEM .

    GV_CURR_INDEX = GV_CURR_INDEX + 1.

    IF GV_CURR_INDEX > LINES( GT_EKPO ).

      GV_CURR_INDEX = LINES( GT_EKPO ).

    ENDIF.

    PERFORM GET_DISPLAY_DATA.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  GET_PERV_ITEM

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*

*  -->  P1        TEXT

*  <--  P2        TEXT

*----------------------------------------------------------------------*




FORM GET_PERV_ITEM .

    GV_CURR_INDEX = GV_CURR_INDEX - 1.

    IF GV_CURR_INDEX < 1.

      GV_CURR_INDEX = 1.

    ENDIF.

    PERFORM GET_DISPLAY_DATA.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ITEM_PRICE

*&---------------------------------------------------------------------*




FORM GET_ITEM_PRICE  USING    P_MATNR

                     CHANGING P_PRICE.

  DATA : LS_MAT TYPE ZMAT01.



  SELECT SINGLE * FROM ZMAT01

    INTO CORRESPONDING FIELDS OF LS_MAT

    WHERE MATNR = P_MATNR.



  IF LS_MAT-VPRSV = 'S'.

    P_PRICE = LS_MAT-STPRS.

  ELSEIF LS_MAT-VPRSV = 'V'.

    P_PRICE = LS_MAT-VERPR.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_FI_DATA

*&---------------------------------------------------------------------*




FORM GET_FI_DATA .

  CLEAR : GS_BKPF , GT_BSEG , GS_FI_ALV , GT_FI_ALV , GT_FI_SUM , GS_FI_SUM.



  SELECT SINGLE *

    FROM ZBKPF01

    INTO GS_BKPF

    WHERE XBLNR = GS_HEADER_100-MBLNR.



  SELECT *

    FROM ZBSEG01

    INTO CORRESPONDING FIELDS OF TABLE GT_BSEG

    WHERE BELNR = GS_BKPF-BELNR.



  IF GS_BKPF IS INITIAL.

    MESSAGE '## #### ## ## ####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  GV_PERIOD = GS_BKPF-BUDAT+4(2).

  LOOP AT GT_BSEG INTO GS_BSEG.

    MOVE-CORRESPONDING GS_BSEG TO GS_FI_ALV.

    GS_FI_ALV-WAERS = GS_BKPF-WAERS.

    APPEND GS_FI_ALV TO GT_FI_ALV.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_FI_DATA

*&---------------------------------------------------------------------*




FORM MODIFY_FI_DATA .

  DATA : LV_BUZEI TYPE ZBSEG01-BUZEI VALUE 1.

  LOOP AT GT_FI_ALV INTO GS_FI_ALV.

    GS_FI_ALV-WAERS_D = 'KRW'.

    IF GS_FI_ALV-SHKZG = 'H'.

      GS_FI_ALV-DMBTR = - GS_FI_ALV-DMBTR .

      GS_FI_ALV-WRBTR = - GS_FI_ALV-WRBTR .

    ENDIF.



    CLEAR GS_FI_SUM.

    MOVE-CORRESPONDING GS_FI_ALV TO GS_FI_SUM.

    "## ## ##

    COLLECT GS_FI_SUM INTO GT_FI_SUM.

    MODIFY GT_FI_ALV FROM GS_FI_ALV.

  ENDLOOP.



  CLEAR GT_FI_ALV.

  LOOP AT GT_FI_SUM INTO GS_FI_SUM.

    MOVE-CORRESPONDING GS_FI_SUM TO GS_FI_ALV.

    GS_FI_ALV-BUZEI = LV_BUZEI.

    LV_BUZEI = LV_BUZEI + 1.

    APPEND GS_FI_ALV TO GT_FI_ALV.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_MATKL

*&---------------------------------------------------------------------*




FORM GET_MATKL  USING    P_MATNR

                CHANGING P_MATKL.

  SELECT SINGLE MATKL

    FROM ZMAT01

    INTO P_MATKL

    WHERE MATNR = P_MATNR.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_MANDOTORY

*&---------------------------------------------------------------------*




FORM CHECK_MANDOTORY .

  CLEAR : GV_CHECK_FLAG.

  GV_CHECK_FLAG = ABAP_TRUE.



  IF GS_HEADER_100-WAERS <> C_WAERS_D.

    IF GS_HEADER_100-KURSF = 0.

      GV_CHECK_FLAG = ABAP_FALSE.

    ENDIF.

  ENDIF.





ENDFORM.