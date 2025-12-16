
*&---------------------------------------------------------------------*

*&  Include           ZMMR01_030_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  INITIALIZATION

*&---------------------------------------------------------------------*




FORM INITIALIZATION .

  P_BUDAT = SY-DATUM.

  P_EBELN = 4500000001.

  P_WERKS = 1000.

  GV_ICON_STATUS = '@0A@'.



  GS_HEADER-WIDTH     = 30.

  GS_HEADER-WIDTH_PIX = ''.

  GS_HEADER-HEADING   = 'MY DOCUMENTS'.

ENDFORM.




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

*&      Form  CHECK_MANDATORY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




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



     IF P_BUDAT IS INITIAL.

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

*&      Form  CHECK_SELECTION_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_SELECTION_DATA .

  IF P_R1 = C_X.

    GV_MODE = C_CRUD.

  ELSEIF P_R2 = C_X.

    GV_MODE = C_DISP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_PURCHASE_ORDER_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




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



  SELECT *

    INTO CORRESPONDING FIELDS OF TABLE GT_ZMAT

    FROM ZMAT01

    WHERE WERKS = P_WERKS.



  IF SY-SUBRC <> 0.

    MESSAGE '## ### #### ###### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .

  PERFORM GET_HEADER_DATA.

  IF GV_MODE = C_CRUD.

    PERFORM GET_ITEM_DATA.

  ENDIF.

  PERFORM GET_GLA_DATA.

  PERFORM GET_MAT_DATA.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_SCREEN .

  IF GV_MODE = C_CRUD.

    CALL SCREEN 0100.

  ELSEIF GV_MODE = C_DISP.

    CALL SCREEN 0300.

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

*&      Form  FIELD_CATALOG_CON1

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_CON1 .

  CLEAR : GS_FIELDCAT , GT_FIELDCAT.



  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-FIELDNAME = 'LINE_NUM'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  GS_FIELDCAT-COLTEXT   = 'OK'.

  GS_FIELDCAT-FIELDNAME = 'L_CHECK'.

  GS_FIELDCAT-CHECKBOX  = 'X'.

  GS_FIELDCAT-EDIT      = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-FIELDNAME = 'NETWR'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-FIELDNAME = 'NETPR'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  GS_FIELDCAT-REF_TABLE = 'ZMAT01'.

  GS_FIELDCAT-REF_FIELD = 'STPRS'.

  GS_FIELDCAT-EDIT      = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'WAERS'.

  GS_FIELDCAT-COLTEXT     = '##'.

  GS_FIELDCAT-OUTPUTLEN   = 4.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT     = '######'.

  GS_FIELDCAT-FIELDNAME   = 'IV_QTY'.

  GS_FIELDCAT-QFIELDNAME  = 'MEINS'.

  GS_FIELDCAT-REF_TABLE   = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD   = 'MENGE'.

  GS_FIELDCAT-EDIT        = 'X'.

  GS_FIELDCAT-OUTPUTLEN   = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT     = 'PO##'.

  GS_FIELDCAT-FIELDNAME   = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME  = 'MEINS'.

  GS_FIELDCAT-REF_TABLE   = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD   = 'MENGE'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'IV_REM_QTY'.

  GS_FIELDCAT-COLTEXT     = '####'.

  GS_FIELDCAT-REF_TABLE   = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD   = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME  = 'MEINS'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'IV_DONE_QTY'.

  GS_FIELDCAT-COLTEXT     = '#####'.

  GS_FIELDCAT-REF_TABLE   = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD   = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME  = 'MEINS'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  GS_FIELDCAT-NO_ZERO   = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-OUTPUTLEN = 30.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_DISP

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_DISP .

  CLEAR : GS_FIELDCAT , GT_FIELDCAT.



  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-FIELDNAME = 'LINE_NUM'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-FIELDNAME = 'MODE_TX'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = 'OK'.

  GS_FIELDCAT-FIELDNAME = 'L_CHECK'.

  GS_FIELDCAT-CHECKBOX  = 'X'.

  GS_FIELDCAT-EDIT      = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-FIELDNAME = 'WRBTR'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-FIELDNAME = 'NETPR'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME   = 'WAERS'.

  GS_FIELDCAT-COLTEXT     = '##'.

  GS_FIELDCAT-OUTPUTLEN   = 4.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT     = '######'.

  GS_FIELDCAT-FIELDNAME   = 'IV_QTY'.

  GS_FIELDCAT-QFIELDNAME  = 'MEINS'.

  GS_FIELDCAT-REF_TABLE   = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD   = 'MENGE'.

  GS_FIELDCAT-OUTPUTLEN   = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT     = 'PO##'.

  GS_FIELDCAT-FIELDNAME   = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME  = 'MEINS'.

  GS_FIELDCAT-REF_TABLE   = 'ZEKPO01'.

  GS_FIELDCAT-REF_FIELD   = 'MENGE'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-FIELDNAME = 'BELNR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  GS_FIELDCAT-NO_ZERO   = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-OUTPUTLEN = 30.

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

*&      Form  FIELD_CATALOG_CON2

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_CON2 .

  CLEAR : GS_FIELDCAT2 , GT_FIELDCAT2.



  GS_FIELDCAT2-COL_POS   = 1.

  GS_FIELDCAT2-COLTEXT   = '####'.

  GS_FIELDCAT2-FIELDNAME = 'MWSKZ'.

  APPEND GS_FIELDCAT2 TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT2.

  GS_FIELDCAT2-COL_POS   = 2.

  GS_FIELDCAT2-COLTEXT   = '##'.

  GS_FIELDCAT2-FIELDNAME = 'TEXT'.

  GS_FIELDCAT2-OUTPUTLEN = 30.

  APPEND GS_FIELDCAT2 TO GT_FIELDCAT2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_FCAT_MAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_FCAT_MAT .

  CLEAR GT_FIELDCAT.

  PERFORM ADD_FCAT USING 'LINE_NUM' '##' '' '' '' ''.

  PERFORM ADD_FCAT USING 'L_CHECK' 'OK'   '' 'X' 'X' ''.

  PERFORM ADD_FCAT USING 'MATNR' '##' '' ' ' 'X' ''.

  PERFORM ADD_FCAT USING 'WERKS' 'Plnt' '' ' ' 'X' ''.

  PERFORM ADD_FCAT USING 'BWKEY' '## ##' '' ' ' 'X' ''.

  PERFORM ADD_FCAT USING 'SHKZG' 'D/C' '' ' ' 'X' '1'.

  PERFORM ADD_FCAT USING 'WRBTR' '##' 'CURR' ' ' 'X' ''.

  PERFORM ADD_FCAT USING 'MENGE' '##' '' ' ' 'X' ''.

  PERFORM ADD_FCAT USING 'MEINS' '## ##' '' ' ' '' ''.

  PERFORM ADD_FCAT USING 'MWSKZ' '## ##' '' ' ' 'X' ''.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_FCAT_GLA

*&---------------------------------------------------------------------*




FORM SET_FCAT_GLA .



  CLEAR GT_FIELDCAT.



  PERFORM ADD_FCAT USING 'LINE_NUM' '##' '' '' '' ''.

  PERFORM ADD_FCAT USING 'L_CHECK'  'OK'   '' 'X' 'X' ''.

  PERFORM ADD_FCAT USING 'HKONT'    'G/L ##' '' '' 'X' ''.

  PERFORM ADD_FCAT USING 'SGTXT'    '##' '' '' 'X' ''.

  PERFORM ADD_FCAT USING 'SHKZG'    'D/C' '' '' 'X' '1'.

  PERFORM ADD_FCAT USING 'WRBTR'    '## ## ##' 'CURR' '' 'X' ''.

  PERFORM ADD_FCAT USING 'DMBTR'    '##(## ##)' 'CURR' '' 'X' ''.

  PERFORM ADD_FCAT USING 'MWSKZ'    '## ##' '' '' 'X' ''.

  PERFORM ADD_FCAT USING 'TXJCD'    '## ## ##' '' '' 'X' ''.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ADD_FCAT

*&---------------------------------------------------------------------*




FORM ADD_FCAT USING PV_FIELD

                    PV_TEXT

                    PV_DATATYPE

                    PV_CHECKBOX

                    PV_EDIT

                    PV_DROPDOWN.      " # ###



  CLEAR GS_FIELDCAT.



  GS_FIELDCAT-FIELDNAME = PV_FIELD.

  GS_FIELDCAT-SCRTEXT_M = PV_TEXT.



  " ## ## ##

  IF PV_DATATYPE = 'CURR'.

    GS_FIELDCAT-OUTPUTLEN = 15.

  ENDIF.



  " ####

  IF PV_CHECKBOX = 'X'.

    GS_FIELDCAT-CHECKBOX = 'X'.

  ENDIF.



  " ## ## ##

  IF PV_EDIT = 'X'.

    GS_FIELDCAT-EDIT = 'X'.

  ENDIF.



  "  #### ## ##

  IF PV_DROPDOWN IS NOT INITIAL.

    GS_FIELDCAT-DRDN_FIELD = 'DROPN'.

  ENDIF.



  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_LAYOUT

*&---------------------------------------------------------------------*




FORM SET_LAYOUT CHANGING PS_LAYOUT TYPE LVC_S_LAYO.



  CLEAR PS_LAYOUT.

  PS_LAYOUT-ZEBRA      = 'X'.

  PS_LAYOUT-NO_TOOLBAR = 'X'.

  PS_LAYOUT-STYLEFNAME = 'CELLTAB'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY_CON1

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY USING    PV_GRID      TYPE REF TO CL_GUI_ALV_GRID

                           PS_LAYOUT    TYPE LVC_S_LAYO

                  CHANGING PT_OUTTAB    TYPE STANDARD TABLE

                           PT_FIELDCAT  TYPE LVC_T_FCAT.



  CALL METHOD PV_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT       = PS_LAYOUT

      I_DEFAULT       = 'X'

    CHANGING

      IT_OUTTAB       = PT_OUTTAB

      IT_FIELDCATALOG = PT_FIELDCAT.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ZTERM_TX

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_HEADER_100_ZTERM  text

*----------------------------------------------------------------------*




FORM GET_ZTERM_TX  USING    P_ZTERM

                   CHANGING P_TEXT.

  SELECT SINGLE TEXT

    FROM ZTERM01_01

    INTO P_TEXT

    WHERE ZTERM = P_ZTERM.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_BUKRS_TX

*&---------------------------------------------------------------------*




FORM GET_BUKRS_TX  USING    P_BUKRS

                   CHANGING P_TEXT.

  SELECT SINGLE TEXT

    FROM ZTBUKRS01

    INTO P_TEXT

    WHERE BUKRS = P_BUKRS.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALCULATE_WITH_TAX

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALCULATE_WITH_TAX .

  IF P_LIST IS INITIAL.

    MESSAGE '##### ######' TYPE 'S' DISPLAY LIKE 'E'.

    GV_TAX_CHECK = ' '.

    RETURN.

  ENDIF.



  PERFORM CAL_BALANCE_WITH_TAX USING P_LIST CHANGING GS_HEADER_100-WMWST GS_HEADER_100-PRICE_SUM.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALCULATE_WITHOUT_TAX

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALCULATE_WITHOUT_TAX .

  GS_HEADER_100-WMWST = 0.

  PERFORM REFRESH_BALANCE_DATA.

ENDFORM.




*&---------------------------------------------------------------------*

*&     Form CAL_BALANCE_WITH_TAX

*&---------------------------------------------------------------------*




FORM CAL_BALANCE_WITH_TAX  USING    P_LIST

                           CHANGING P_WMWST P_PRICE_SUM.

  CASE P_LIST.

    WHEN 'V1'.

      P_WMWST = P_PRICE_SUM * '0.1'.

  ENDCASE.

  PERFORM REFRESH_BALANCE_DATA.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH_BALANCE_DATA

*&---------------------------------------------------------------------*




FORM REFRESH_BALANCE_DATA .

  GS_HEADER_100-BALANCE = GS_HEADER_100-AMOUNT - ( GS_HEADER_100-PRICE_SUM + GS_HEADER_100-WMWST + GS_HEADER_100-FRTWR ).

  IF GS_HEADER_100-BALANCE = 0.

    GV_ICON_STATUS = '@08@'.

  ELSE.

    GV_ICON_STATUS = '@0A@'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_HEADER_DATA

*&---------------------------------------------------------------------*




FORM GET_HEADER_DATA .

  GS_HEADER_100-PRICE_SUM = 0.

  GS_HEADER_100-BALANCE = 0.

  GS_HEADER_100-SALE_TX = '###'.

  GS_HEADER_100-BLART = 'RE'.

  IF GS_HEADER_100-WAERS = C_WAERS_D.

    GS_HEADER_100-KURSF = '1.00'.

  ENDIF.

"---------------------------------------------------------

"  ## #### - ##### ####

"---------------------------------------------------------

  MOVE-CORRESPONDING GS_EKKO TO GS_HEADER_100.

  MOVE-CORRESPONDING GS_LFA1 TO GS_HEADER_100.

  MOVE-CORRESPONDING GS_LFB1 TO GS_HEADER_100.

  MOVE-CORRESPONDING GS_LFM1 TO GS_HEADER_100.

"---------------------------------------------------------

"  ## #### - ## ### ####

"---------------------------------------------------------

  SELECT * FROM ZTAXCODE01

    INTO CORRESPONDING FIELDS OF TABLE GT_TAXCODE.



  PERFORM GET_BANK_TX USING    GS_HEADER_100-BANKL

                      CHANGING GS_HEADER_100-BANKL_TX.



"---------------------------------------------------------

"  ## ## TEXT ##

"---------------------------------------------------------

  PERFORM GET_ZTERM_TX USING GS_HEADER_100-ZTERM CHANGING GS_HEADER_100-ZTERM_TX.

  PERFORM GET_BUKRS_TX USING GS_HEADER_100-BUKRS CHANGING GS_HEADER_100-BUKRS_TX.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ITEM_DATA

*&---------------------------------------------------------------------*




FORM GET_ITEM_DATA .

  DATA : LV_NUM TYPE ZEKPO01-EBELP VALUE 1,

         LS_STYLE TYPE LVC_S_STYL.

"---------------------------------------------------------

"  PO - #### ### ####

"---------------------------------------------------------

  LOOP AT GT_EKPO INTO GS_EKPO.

    CLEAR : GS_DISP_100.

    MOVE-CORRESPONDING GS_EKPO TO GS_DISP_100.

    GS_DISP_100-LINE_NUM = LV_NUM.

    GS_DISP_100-WAERS = GS_EKKO-WAERS.

    GS_DISP_100-L_CHECK = 'X'.

    PERFORM GET_IV_QTY   USING    GS_EKPO-EBELN GS_EKPO-EBELP

                         CHANGING GS_DISP_100-IV_DONE_QTY.

    PERFORM GET_BKLAS USING GS_DISP_100-MATNR

                      CHANGING GS_DISP_100-BKLAS.

    GS_DISP_100-IV_REM_QTY = GS_DISP_100-MENGE - GS_DISP_100-IV_DONE_QTY.

    GS_DISP_100-IV_QTY = GS_DISP_100-IV_REM_QTY.

    LV_NUM = LV_NUM + 1.



    IF GS_DISP_100-IV_REM_QTY = 0.



      LS_STYLE-FIELDNAME = 'L_CHECK'.

      LS_STYLE-STYLE = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.

      INSERT LS_STYLE INTO TABLE GS_DISP_100-CELLTAB.



      LS_STYLE-FIELDNAME = 'NETPR'.

      LS_STYLE-STYLE = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.

      INSERT LS_STYLE INTO TABLE GS_DISP_100-CELLTAB.



      LS_STYLE-FIELDNAME = 'IV_QTY'.

      LS_STYLE-STYLE = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.

      INSERT LS_STYLE INTO TABLE GS_DISP_100-CELLTAB.



      GS_DISP_100-L_CHECK = ' '.

    ELSE.

      GS_HEADER_100-PRICE_SUM = GS_HEADER_100-PRICE_SUM + GS_EKPO-NETWR.

    ENDIF.



    APPEND GS_DISP_100 TO GT_DISP_100.

  ENDLOOP.

"---------------------------------------------------------

"  #### ##### ####

"---------------------------------------------------------

  GS_HEADER_100-BUDAT = P_BUDAT.

  GS_HEADER_100-BLDAT = P_BUDAT.

"---------------------------------------------------------

"  ##(Balance) ##

"---------------------------------------------------------

  GS_HEADER_100-BALANCE = GS_HEADER_100-BALANCE - GS_HEADER_100-PRICE_SUM.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_GLA_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_GLA_DATA .

  CLEAR GT_GLA.

  DATA : LV_LINE_NUM TYPE CHAR4 VALUE 1.

  DO 10 TIMES.

    CLEAR GS_GLA.   " ## ### ## ###

    GS_GLA-LINE_NUM = LV_LINE_NUM.

    GS_GLA-DROPN = 1.

    APPEND GS_GLA TO GT_GLA.

    LV_LINE_NUM = LV_LINE_NUM + 1.

  ENDDO.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_MAT_DATA

*&---------------------------------------------------------------------*




FORM GET_MAT_DATA .

  CLEAR GT_MAT.

  DATA : LV_LINE_NUM TYPE CHAR4 VALUE 1.

  DO 10 TIMES.

    CLEAR GS_MAT.

    GS_MAT-LINE_NUM = LV_LINE_NUM.

    GS_MAT-SHKZG = 'S'.  " ### ##

    GS_MAT-DROPN = 1.

    APPEND GS_MAT TO GT_MAT.

    LV_LINE_NUM = LV_LINE_NUM + 1.

  ENDDO.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_DROPDOWN_SHKZG

*&---------------------------------------------------------------------*




FORM SET_DROPDOWN_SHKZG .

  DATA:

    LT_DROPDOWN TYPE LVC_T_DROP,

    LS_DROPDOWN TYPE LVC_S_DROP.



  "## 1:

  LS_DROPDOWN-HANDLE = '1'.

  LS_DROPDOWN-VALUE = '##'.

  APPEND LS_DROPDOWN TO LT_DROPDOWN.



  LS_DROPDOWN-HANDLE = '1'.

  LS_DROPDOWN-VALUE = '##'.

  APPEND LS_DROPDOWN TO LT_DROPDOWN.





  CALL METHOD GC_GRID->SET_DROP_DOWN_TABLE

   EXPORTING

     IT_DROP_DOWN = LT_DROPDOWN.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONF4_AFTER

                                        P_UCOMM.

  DATA : LS_MODI TYPE LVC_S_MODI.

  DATA : LV_IV_QTY TYPE ZEKPO01-MENGE.

  DATA : LV_NETPR  TYPE ZEKPO01-NETPR.

  DATA : LV_CHECK TYPE CHAR1.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.



    IF LS_MODI-FIELDNAME = 'L_CHECK'.

      LV_CHECK = LS_MODI-VALUE.

      READ TABLE GT_DISP_100 INTO GS_DISP_100 INDEX LS_MODI-ROW_ID.

      IF GV_MODE = C_CRUD.

        IF LV_CHECK = ' '.

          GS_HEADER_100-PRICE_SUM = GS_HEADER_100-PRICE_SUM - GS_DISP_100-NETWR.

        ELSEIF LV_CHECK = 'X'.

          GS_HEADER_100-PRICE_SUM = GS_HEADER_100-PRICE_SUM + GS_DISP_100-NETWR.

        ENDIF.

      ENDIF.



    ELSEIF LS_MODI-FIELDNAME = 'IV_QTY'.

      LV_IV_QTY = LS_MODI-VALUE.

      READ TABLE GT_DISP_100 INTO GS_DISP_100 INDEX LS_MODI-ROW_ID.

      IF GS_DISP_100-L_CHECK = 'X'.

        GS_HEADER_100-PRICE_SUM = GS_HEADER_100-PRICE_SUM - GS_DISP_100-NETWR.

      ENDIF.

      IF LV_IV_QTY < 0.

        PERFORM RESET_CELL USING P_DATA_CHANGED LS_MODI.

        GV_ERROR_FLAG = 1.

        CONTINUE.

      ELSEIF LV_IV_QTY > GS_DISP_100-IV_REM_QTY.

        PERFORM RESET_CELL USING P_DATA_CHANGED LS_MODI.

        GV_ERROR_FLAG = 2.

        CONTINUE.

      ENDIF.

      GS_DISP_100-NETWR = LV_IV_QTY * GS_DISP_100-NETPR.

      IF GS_DISP_100-L_CHECK = 'X'.

        GS_HEADER_100-PRICE_SUM = GS_HEADER_100-PRICE_SUM + GS_DISP_100-NETWR.

      ENDIF.





    ELSEIF LS_MODI-FIELDNAME = 'NETPR'.

      LV_NETPR = LS_MODI-VALUE.

      READ TABLE GT_DISP_100 INTO GS_DISP_100 INDEX LS_MODI-ROW_ID.

      IF GS_DISP_100-L_CHECK = 'X'.

        GS_HEADER_100-PRICE_SUM = GS_HEADER_100-PRICE_SUM - GS_DISP_100-NETWR.

      ENDIF.

      GS_DISP_100-NETWR = GS_DISP_100-IV_QTY * LV_NETPR.

      IF GS_DISP_100-L_CHECK = 'X'.

        GS_HEADER_100-PRICE_SUM = GS_HEADER_100-PRICE_SUM + GS_DISP_100-NETWR.

      ENDIF.

    ENDIF.

    MODIFY GT_DISP_100 FROM GS_DISP_100 INDEX LS_MODI-ROW_ID.

  ENDLOOP.

  IF GV_MODE = C_CRUD.

    PERFORM CAL_BALANCE_WITH_TAX USING P_LIST CHANGING GS_HEADER_100-WMWST GS_HEADER_100-PRICE_SUM.

    PERFORM REFRESH_BALANCE_DATA.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED  USING    P_E_MODIFIED

                                         P_ET_GOOD_CELLS.

  CALL METHOD CL_GUI_CFW=>SET_NEW_OK_CODE

    EXPORTING NEW_CODE = 'REFR'.



  PERFORM REFRESH.

  CASE GV_ERROR_FLAG.

    WHEN '1'. MESSAGE '##### 0## #####' TYPE 'I' DISPLAY LIKE 'E'.

    WHEN '2'. MESSAGE '##### ## ### ### # ####' TYPE 'I' DISPLAY LIKE 'E'.

  ENDCASE.

  GV_ERROR_FLAG = 0.

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

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*




FORM CLASS_EVENT .

  CREATE OBJECT GO_EVENT.

  SET HANDLER GO_EVENT->HANDLER_TOOLBAR FOR GC_GRID.

    CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED




*    EXCEPTIONS

*      ERROR      = 1

*      OTHERS     = 2




  .

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_IV_QTY

*&---------------------------------------------------------------------*




FORM GET_IV_QTY  USING    P_EBELN P_EBELP

                 CHANGING P_DONE_QTY.



  CLEAR P_DONE_QTY.



  DATA: LV_IV_POS TYPE MENGE_D,

        LV_IV_NEG TYPE MENGE_D.



  " ## ##(## IR) ## ##

  SELECT SUM( MENGE )

    INTO LV_IV_POS

    FROM ZRSEG01

   WHERE EBELN = P_EBELN

     AND EBELP = P_EBELP

     AND SHKZG = 'S'.



  IF SY-SUBRC <> 0.

    CLEAR LV_IV_POS.

  ENDIF.



  " ## ## ##(CREDIT MEMO OR IR REVERSAL)

  SELECT SUM( MENGE )

    INTO LV_IV_NEG

    FROM ZRSEG01

   WHERE EBELN = P_EBELN

     AND EBELP = P_EBELP

     AND XREVR = 'X'.  " ## INDICATOR



  IF SY-SUBRC <> 0.

    CLEAR LV_IV_NEG.

  ENDIF.



  " ## ## ## ## ##

  P_DONE_QTY = LV_IV_POS - LV_IV_NEG.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  RESET_CELL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_P_DATA_CHANGED  text

*      -->P_LS_MODI  text

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

*&      Form  CHECK_INVOCE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INVOCE_DATA .

  IF GV_MODE = C_CRUD.

    RETURN.

  ENDIF.



  SELECT * FROM ZRSEG01

    INTO CORRESPONDING FIELDS OF TABLE @GT_RSEG

    WHERE EBELN = @P_EBELN

    AND   WERKS = @P_WERKS.



  IF GT_RSEG IS INITIAL.

    MESSAGE '#####  #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.



  SELECT *

    FROM ZRBKP01

    INTO TABLE @GT_RBKP

    FOR ALL ENTRIES IN @GT_RSEG

   WHERE BELNR = @GT_RSEG-BELNR.



  IF GT_RBKP IS INITIAL.

    MESSAGE '##### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALCULATE_TAX_ITEM

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_HEADER_100_MWSKZ  text

*      <--P_GS_DISP_100_NETWR  text

*----------------------------------------------------------------------*




FORM CALCULATE_TAX_ITEM  USING    P_MWSKZ

                         CHANGING P_NETWR.

  CASE P_MWSKZ.

    WHEN 'V1'. P_NETWR = P_NETWR * '1.1'.

  ENDCASE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  TREE_HANDLER_ITEM_DOUBLE_CLICK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM TREE_HANDLER_ITEM_DOUBLE_CLICK  USING    P_NODE_KEY

                                              P_ITEM_NAME.



  DATA: LT_RSEG TYPE TABLE OF ZRSEG01,

        LS_RSEG TYPE ZRSEG01,

        LS_RSEG2 TYPE ZRSEG01,

        LS_RBKP TYPE ZRBKP01,

        LV_MAKTX TYPE ZMAT01-MAKTX,

        LS_STYLE TYPE LVC_S_STYL.

  DATA: LS_EKPO TYPE ZEKPO01.

  DATA: LV_EDIT_FLAG TYPE ABAP_BOOL VALUE ABAP_TRUE.



  IF P_NODE_KEY = P_EBELN.

    EXIT.

  ENDIF.



  SELECT *

    FROM ZRSEG01

    INTO CORRESPONDING FIELDS OF TABLE LT_RSEG

    WHERE BELNR = P_NODE_KEY.



  SELECT SINGLE *

    FROM ZRBKP01

    INTO CORRESPONDING FIELDS OF LS_RBKP

    WHERE BELNR = P_NODE_KEY.



  IF LT_RSEG IS INITIAL.

    MESSAGE '## ##### ### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.





  MOVE-CORRESPONDING LS_RBKP TO GS_HEADER_100.

  GS_HEADER_100-AMOUNT = LS_RBKP-RMWWR.

  P_LIST = GS_HEADER_100-MWSKZ.

  IF P_LIST = 'V1'.

    GV_TAX_CHECK = 'X'.

  ENDIF.



  CLEAR : GT_DISP_100.



  LOOP AT LT_RSEG INTO LS_RSEG.

    CLEAR: GS_DISP_100, GS_EKPO, GS_ZMAT,LV_EDIT_FLAG.

"-------------------------------------------------------

" ## ## ##

"-------------------------------------------------------

    GS_DISP_100-LINE_NUM = LS_RSEG-BUZEI.

    " 1) #### ## ##



    GS_DISP_100-BELNR  = LS_RSEG-BELNR.

    GS_DISP_100-GJAHR  = LS_RSEG-GJAHR.

    GS_DISP_100-BUZEI  = LS_RSEG-BUZEI.

    GS_DISP_100-EBELN  = LS_RSEG-EBELN.

    GS_DISP_100-EBELP  = LS_RSEG-EBELP.

    GS_DISP_100-WERKS  = LS_RSEG-WERKS.

    GS_DISP_100-LGORT  = LS_RSEG-LGORT.

    GS_DISP_100-IV_QTY = LS_RSEG-MENGE.

    GS_DISP_100-WRBTR  = LS_RSEG-WRBTR.

    GS_DISP_100-MATNR  = LS_RSEG-MATNR.

    GS_DISP_100-MWSKZ  = LS_RSEG-MWSKZ.



    READ TABLE GT_EKPO INTO GS_EKPO

      WITH KEY EBELN = LS_RSEG-EBELN

               EBELP = LS_RSEG-EBELP.

    IF SY-SUBRC = 0.

      GS_DISP_100-WAERS = GS_EKKO-WAERS.

      GS_DISP_100-MENGE = GS_EKPO-MENGE.

      GS_DISP_100-MEINS = GS_EKPO-MEINS.

      GS_DISP_100-NETPR = GS_EKPO-NETPR.

    ENDIF.



    " 3) ## ### ##

    READ TABLE GT_ZMAT INTO GS_ZMAT

      WITH KEY MATNR = LS_RSEG-MATNR.



    IF SY-SUBRC = 0.

      GS_DISP_100-MAKTX = GS_ZMAT-MAKTX.

      GS_DISP_100-BKLAS = GS_ZMAT-BKLAS.

    ENDIF.



    PERFORM GET_IV_QTY   USING    GS_EKPO-EBELN GS_EKPO-EBELP

                         CHANGING GS_DISP_100-IV_DONE_QTY.

    PERFORM GET_BKLAS USING GS_DISP_100-MATNR

                      CHANGING GS_DISP_100-BKLAS.



"-------------------------------------------------------

" ##### ## ### ## ###### ###

"-------------------------------------------------------



  SELECT SINGLE *

    FROM ZRSEG01

    INTO CORRESPONDING FIELDS OF LS_RSEG2

    WHERE STBLG = P_NODE_KEY

    AND   MATNR = LS_RSEG-MATNR.



  IF SY-SUBRC = 0.

    LV_EDIT_FLAG = 'X'.

    GS_DISP_100-MODE_TX = '## ###'.

  ENDIF.



"-------------------------------------------------------

"  #### ## ##

"-------------------------------------------------------



  IF LS_RSEG-XREVR = 'X' AND LV_EDIT_FLAG = ' '.

    LV_EDIT_FLAG = 'X'.

    GS_DISP_100-MODE_TX = '####'.

  ENDIF.

"-------------------------------------------------------

"  ## ## ### ## ##

"-------------------------------------------------------

   IF LV_EDIT_FLAG = ' '.

     GS_DISP_100-MODE_TX = '####'.

   ENDIF.

"-------------------------------------------------------

" ## #### ## ## #### DISABLE ##

"-------------------------------------------------------



   IF LV_EDIT_FLAG = 'X'.

    LS_STYLE-FIELDNAME = 'L_CHECK'.

    LS_STYLE-STYLE = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.

    INSERT LS_STYLE INTO TABLE GS_DISP_100-CELLTAB.

   ENDIF.



  APPEND GS_DISP_100 TO GT_DISP_100.



  ENDLOOP.

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT_DISP

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT_DISP .

  CREATE OBJECT GC_CUSTOM

    EXPORTING




*      PARENT                      =




      CONTAINER_NAME              = 'CON6'




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

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FILL_NODE

*&---------------------------------------------------------------------*




FORM FILL_NODE .

  CLEAR: GT_NODES, GT_ITEMS.



  DATA: LS_NODE TYPE TREEV_NODE,

        LS_ITEM TYPE MTREEITM.



  "---------------------------------------------------------

  " 1) PURCHASE ORDERS

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

  " 2) INVOCE DOCUMENTS

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

  LOOP AT GT_RBKP INTO GS_RBKP.

    IF GS_RBKP-XREVR = ' '.

      PERFORM ADD_DOC USING 'MM_ROOT' GS_RBKP-BELNR.

    ENDIF.

  ENDLOOP.



  "---------------------------------------------------------

  " 3) CANCEL DOCUMENTS

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



  LOOP AT GT_RBKP INTO GS_RBKP.

    IF GS_RBKP-XREVR = 'X'.

      PERFORM ADD_DOC USING 'MM_ROOT2' GS_RBKP-BELNR.

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

*&      Form  CLASS_EVENT_0100

*&---------------------------------------------------------------------*




FORM CLASS_EVENT_0100 .

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

*&      Form  CLEAR_ALV

*&---------------------------------------------------------------------*




FORM CLEAR_ALV .

  CLEAR : GT_DISP_100.

  PERFORM REFRESH.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  POST_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM POST_DATA .

 DATA : LV_CHECK_FLAG TYPE C LENGTH 1,

        LV_BELNR TYPE ZRBKP01-BELNR,

        LV_BUZEI TYPE ZRSEG01-BUZEI VALUE 10.



"---------------------------------------------------------

"  ### ##

"---------------------------------------------------------



 LOOP AT GT_DISP_100 INTO GS_DISP_100.

  IF GS_DISP_100-L_CHECK = 'X'.

    LV_CHECK_FLAG = 'X'.

  ENDIF.

 ENDLOOP.



 IF LV_CHECK_FLAG = ' '.

  MESSAGE '### # #### ### ### ### ###' TYPE 'S' DISPLAY LIKE 'E'.

  RETURN.

 ENDIF.



"---------------------------------------------------------

"  ## ## ##

"---------------------------------------------------------

  PERFORM GET_NEW_BELNR USING C_NR_IV CHANGING LV_BELNR.



"---------------------------------------------------------

"  ## ## ##

"---------------------------------------------------------

  GS_HEADER_100-CRNAME = SY-UNAME.     " ###

  GS_HEADER_100-CRDATE = SY-DATUM.     " ####

  GS_HEADER_100-CRZEIT = SY-UZEIT.     " ####



  GS_HEADER_100-BELNR = LV_BELNR.      "####

  GS_HEADER_100-GJAHR = P_BUDAT(4).    "####

  GS_HEADER_100-BLART = 'RE'.          "####

 "GS_HEADER_100-BLDAT =

 "GS_HEADER_100-BUDAT =



  GS_HEADER_100-RMWWR = GS_HEADER_100-AMOUNT. "# #### = ## ##

 "GS_HEADER_100-WMWST =

  MOVE-CORRESPONDING GS_HEADER_100 TO GS_RBKP.

  INSERT ZRBKP01 FROM GS_RBKP.

"---------------------------------------------------------

"  ## ## ##

"---------------------------------------------------------

  LOOP AT GT_DISP_100 INTO GS_DISP_100.

    IF GS_DISP_100-L_CHECK = ' '.

      CONTINUE.

    ENDIF.

    MOVE-CORRESPONDING GS_DISP_100 TO GS_RSEG.

    GS_RSEG-BELNR = LV_BELNR.

    GS_RSEG-GJAHR = P_BUDAT(4).

    GS_RSEG-BUZEI = LV_BUZEI.

    PERFORM CALCULATE_TAX_ITEM USING    GS_HEADER_100-MWSKZ

                               CHANGING GS_DISP_100-NETWR.

    GS_RSEG-WRBTR = GS_DISP_100-NETWR.

    GS_RSEG-SHKZG = 'S'.

    GS_RSEG-BUKRS = GS_HEADER_100-BUKRS.

    GS_RSEG-MWSKZ = GS_HEADER_100-MWSKZ.

    GS_RSEG-MENGE = GS_DISP_100-IV_QTY.

    GS_RSEG-BSTME = GS_DISP_100-MEINS.

    GS_RSEG-BPMNG = GS_DISP_100-IV_QTY.

    GS_RSEG-BPRME = GS_DISP_100-MEINS.

    GS_RSEG-MEINS = GS_DISP_100-MEINS.

    GS_RSEG-BKLAS = GS_DISP_100-BKLAS.

    APPEND GS_RSEG TO GT_RSEG.

    LV_BUZEI = LV_BUZEI + 10.

  ENDLOOP.



  INSERT ZRSEG01 FROM TABLE GT_RSEG.



  MESSAGE | #### { GS_HEADER_100-BELNR }#(#) ######| TYPE 'S'.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  POST_CANCEL_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM POST_CANCEL_DATA .

  DATA : LV_CHECK_FLAG TYPE CHAR1 VALUE ' ',

         LV_BUZEI TYPE ZRSEG01-BUZEI VALUE 10,

         LV_BELNR TYPE ZRBKP01-BELNR,

         LV_TEMP_BELNR TYPE ZRBKP01-BELNR,

         LS_CANCEL_ITEM TYPE TY_100,

         LT_CANCEL_ITEM LIKE TABLE OF LS_CANCEL_ITEM.

"---------------------------------------------------------

" ## ## # ### ## ##

"---------------------------------------------------------

  CLEAR : GS_HEADER_100-RMWWR , GS_HEADER_100-WMWST,GT_RSEG,GS_RSEG,GT_RBKP,GS_RBKP.



  LOOP AT GT_DISP_100 INTO GS_DISP_100.

    IF GS_DISP_100-L_CHECK = 'X'.

      LV_CHECK_FLAG = 'X'.

      GS_HEADER_100-RMWWR = GS_HEADER_100-RMWWR + GS_DISP_100-WRBTR.

      IF P_LIST = 'V1'.

        GS_HEADER_100-WMWST = GS_HEADER_100-WMWST + GS_DISP_100-WRBTR * '0.1'.

      ENDIF.

      MOVE-CORRESPONDING GS_DISP_100 TO LS_CANCEL_ITEM.

      APPEND LS_CANCEL_ITEM TO LT_CANCEL_ITEM.

    ENDIF.

  ENDLOOP.



  IF LV_CHECK_FLAG = ' '.

    MESSAGE '### ### ####' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.

"---------------------------------------------------------

" ###### ## 5300000000~ (06)

"---------------------------------------------------------

  PERFORM GET_NEW_BELNR USING C_NR_IV_CANC CHANGING LV_BELNR .

"---------------------------------------------------------

" ## # ##

"---------------------------------------------------------

  LV_TEMP_BELNR = GS_HEADER_100-BELNR.



  GS_HEADER_100-STBLG = LV_TEMP_BELNR.

  GS_HEADER_100-STJAH = SY-DATUM(4).

  GS_HEADER_100-XREVR = 'X'.



  GS_HEADER_100-CRNAME = SY-UNAME.     " ###

  GS_HEADER_100-CRDATE = SY-DATUM.     " ####

  GS_HEADER_100-CRZEIT = SY-UZEIT.     " ####



  GS_HEADER_100-BELNR = LV_BELNR.      "####

  GS_HEADER_100-GJAHR = P_BUDAT(4).    "####

  GS_HEADER_100-BLART = 'RE'.          "####



  MOVE-CORRESPONDING GS_HEADER_100 TO GS_RBKP.



"---------------------------------------------------------

" ## # ##

"---------------------------------------------------------



  LOOP AT LT_CANCEL_ITEM INTO LS_CANCEL_ITEM.

    MOVE-CORRESPONDING LS_CANCEL_ITEM TO GS_RSEG.

    GS_RSEG-BELNR = LV_BELNR.

    GS_RSEG-GJAHR = P_BUDAT(4).

    GS_RSEG-BUZEI = LV_BUZEI.



    GS_RSEG-WRBTR = LS_CANCEL_ITEM-WRBTR.

    GS_RSEG-SHKZG = 'H'.

    GS_RSEG-BUKRS = GS_HEADER_100-BUKRS.

    GS_RSEG-WERKS = LS_CANCEL_ITEM-WERKS.

    GS_RSEG-LGORT = LS_CANCEL_ITEM-LGORT.

    GS_RSEG-MWSKZ = GS_HEADER_100-MWSKZ.

    GS_RSEG-MENGE = LS_CANCEL_ITEM-IV_QTY.

    GS_RSEG-BSTME = LS_CANCEL_ITEM-MEINS.

    GS_RSEG-BPMNG = LS_CANCEL_ITEM-IV_QTY.

    GS_RSEG-BPRME = LS_CANCEL_ITEM-MEINS.

    GS_RSEG-MEINS = LS_CANCEL_ITEM-MEINS.

    GS_RSEG-BKLAS = LS_CANCEL_ITEM-BKLAS.



    GS_RSEG-STBLG = LV_TEMP_BELNR.

    GS_RSEG-STJAH = SY-DATUM(4).

    GS_RSEG-XREVR = 'X'.

    APPEND GS_RSEG TO GT_RSEG.

    LV_BUZEI = LV_BUZEI + 10.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_SIMU_DATA

*&---------------------------------------------------------------------*




FORM GET_SIMU_DATA .



  IF GS_HEADER_100-BALANCE <> 0.

    MESSAGE '### ## 0### ###' TYPE 'S' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  IF GS_HEADER_100-WAERS <> C_WAERS_D.

    IF GS_HEADER_100-KURSF = 0.

      MESSAGE '##### ### #### ### #######.' TYPE 'S' DISPLAY LIKE 'E'.

      RETURN.

    ENDIF.

  ENDIF.



  IF GS_HEADER_100-WAERS <> C_WAERS_D.

    PERFORM CHECK_INCO USING GS_HEADER_100-INCO1 GS_HEADER_100-FRTWR.

    IF GV_CHECK_FLAG = 'X'.

      RETURN.

    ENDIF.

  ENDIF.



  DATA:   LV_PO_PR         TYPE ZBSEG01-WRBTR, "PO ##

          LV_INV_PR        TYPE ZBSEG01-WRBTR, "IV ##



          LV_NET_FCY       TYPE ZBSEG01-WRBTR, "IV * MENGE (## ###)

          LV_GRIR_FCY      TYPE ZBSEG01-WRBTR, "## GR/IR (##)

          LV_PRD_FCY       TYPE ZBSEG01-WRBTR, "## PRD (##)



          LV_GRIR_LCY      TYPE ZBSEG01-DMBTR, "## GR/IR (##)

          LV_PRD_LCY       TYPE ZBSEG01-DMBTR, "## PRD (##)

          LV_KDM_LCY       TYPE ZBSEG01-DMBTR, "## KDM (##)



          "### ##/##

          LV_FRT_FCY       TYPE ZBSEG01-WRBTR, "###(##) - ## ###

          LV_FRT_LCY       TYPE ZBSEG01-DMBTR, "###(##)



          LV_MWS_FCY       TYPE ZBSEG01-DMBTR, "##(##)

          LV_MWS_LCY       TYPE ZBSEG01-DMBTR, "##(##)



          LV_AP_FCY        TYPE ZBSEG01-WRBTR, "AP(##)

          LV_AP_LCY        TYPE ZBSEG01-DMBTR, "AP(##)



          LV_RATE_GR       TYPE BKPF-KURSF,    "GR## ##

          LV_RATE_IR       TYPE BKPF-KURSF,    "IR## ##

          LV_RATE_TAX      TYPE BKPF-KURSF.    "##



  "## ##(## ##)

  DATA:   LV_TOTAL_NET_FCY   TYPE ZBSEG01-WRBTR VALUE 0,

          LV_TOTAL_GRIR_FCY  TYPE ZBSEG01-WRBTR VALUE 0.



  DATA : LV_BUZEI TYPE ZBSEG01-BUZEI VALUE 1.



  DATA : LV_KTOPL TYPE ZSKA1_01-KTOPL VALUE 'ZCOA',

         LV_KTOSL TYPE ZSKA1_01-KTOSL,

         LV_BKLAS TYPE ZSKA1_01-BKLAS VALUE '3000'.



  DATA : LV_MBLNR TYPE ZMSEG01-MBLNR.

  CLEAR GT_SIMU.



  "---------------------------------------------------------

  " ## ##/##

  "---------------------------------------------------------

  LV_RATE_IR = GS_HEADER_100-KURSF.



  SELECT SINGLE MBLNR

    FROM ZMSEG01

    INTO LV_MBLNR

    WHERE EBELN = GS_HEADER_100-EBELN.



  SELECT SINGLE KURSF

    FROM ZBKPF01

    INTO LV_RATE_GR

    WHERE XBLNR = LV_MBLNR.



  IF LV_RATE_GR = 0.

    LV_RATE_GR = LV_RATE_IR.

  ENDIF.



  IF GS_HEADER_100-WAERS <> C_WAERS_D.

    LV_RATE_GR = LV_RATE_GR * '0.01'.

    LV_RATE_IR = LV_RATE_IR * '0.01'.

  ENDIF.



  PERFORM GET_TAX_RATE USING P_LIST CHANGING LV_RATE_TAX.



  "---------------------------------------------------------

  " ## LOOP: WRX / PRD / KDM

  "---------------------------------------------------------

  LOOP AT GT_DISP_100 INTO GS_DISP_100.

    IF GS_DISP_100-L_CHECK <> 'X'.

      CONTINUE.

    ENDIF.



    CLEAR: GS_SIMU, LV_PO_PR, LV_INV_PR,

           LV_NET_FCY, LV_GRIR_FCY, LV_PRD_FCY,

           LV_GRIR_LCY, LV_PRD_LCY, LV_KDM_LCY.



    "PO ##

    SELECT SINGLE NETPR

      FROM ZEKPO01

      INTO LV_PO_PR

      WHERE EBELN = GS_HEADER_100-EBELN

      AND   MATNR = GS_DISP_100-MATNR.



    "## ##(### ##)

    LV_INV_PR = GS_DISP_100-NETPR.



    "## ####

    LV_NET_FCY  = LV_INV_PR * GS_DISP_100-IV_QTY.

    LV_GRIR_FCY = LV_PO_PR  * GS_DISP_100-IV_QTY.

    LV_PRD_FCY  = ( LV_INV_PR - LV_PO_PR ) * GS_DISP_100-IV_QTY.



    "## ## ##(##/AP ###)

    LV_TOTAL_NET_FCY  = LV_TOTAL_NET_FCY  + LV_NET_FCY.

    LV_TOTAL_GRIR_FCY = LV_TOTAL_GRIR_FCY + LV_GRIR_FCY.



    "#### ##

    IF GS_HEADER_100-WAERS <> C_WAERS_D.

      LV_GRIR_LCY = LV_GRIR_FCY * LV_RATE_GR.

      LV_PRD_LCY  = LV_PRD_FCY  * LV_RATE_IR.

      LV_KDM_LCY = ( LV_GRIR_FCY * LV_RATE_GR ) - ( LV_GRIR_FCY * LV_RATE_IR ).

    ELSE.

      LV_GRIR_LCY = LV_GRIR_FCY.

      LV_PRD_LCY  = LV_PRD_FCY.

      LV_KDM_LCY  = 0.

    ENDIF.



    "---------------------------------------------------------

    " WRX (##)

    "---------------------------------------------------------

    LV_KTOSL = 'WRX'.

    CLEAR GS_SIMU.

    GS_SIMU-BUZEI = LV_BUZEI.

    GS_SIMU-SHKZG = 'S'.



    PERFORM GET_HKONT USING LV_KTOPL LV_KTOSL LV_BKLAS

                            GS_HEADER_100-BUKRS GS_HEADER_100-LIFNR GS_SIMU-SHKZG

                      CHANGING GS_SIMU-HKONT.

    PERFORM GET_KOART USING GS_SIMU-HKONT CHANGING GS_SIMU-KOART.

    PERFORM GET_BSCHL USING GS_SIMU-HKONT GS_SIMU-SHKZG CHANGING GS_SIMU-BSCHL.

    GS_SIMU-SAKNR = GS_SIMU-HKONT.



    GS_SIMU-SGTXT  = |GR/IR : { GS_DISP_100-MAKTX }|.

    GS_SIMU-WRBTR  = LV_GRIR_FCY.

    GS_SIMU-DMBTR  = LV_GRIR_LCY.

    GS_SIMU-WAERS  = GS_HEADER_100-WAERS.

    GS_SIMU-WAERS_D = C_WAERS_D.

    GS_SIMU-MWSKZ  = GS_HEADER_100-MWSKZ.

    GS_SIMU-EBELN  = GS_HEADER_100-EBELN.

    GS_SIMU-EBELP  = GS_DISP_100-EBELP.

    GS_SIMU-MATNR  = GS_DISP_100-MATNR.

    GS_SIMU-MAKTX  = GS_DISP_100-MAKTX.



    APPEND GS_SIMU TO GT_SIMU.

    LV_BUZEI = LV_BUZEI + 1.



    "---------------------------------------------------------

    " PRD (####) - ###

    "---------------------------------------------------------

    IF LV_PRD_FCY <> 0.

      LV_KTOSL = 'PRD'.

      CLEAR GS_SIMU.

      GS_SIMU-BUZEI = LV_BUZEI.



      "PRD: (+)# ##, (-)# ##

      GS_SIMU-SHKZG = COND #( WHEN LV_PRD_LCY > 0 THEN 'S' ELSE 'H' ).



      PERFORM GET_HKONT USING LV_KTOPL LV_KTOSL LV_BKLAS

                              GS_HEADER_100-BUKRS GS_HEADER_100-LIFNR GS_SIMU-SHKZG

                        CHANGING GS_SIMU-HKONT.

      PERFORM GET_KOART USING GS_SIMU-HKONT CHANGING GS_SIMU-KOART.

      PERFORM GET_BSCHL USING GS_SIMU-HKONT GS_SIMU-SHKZG CHANGING GS_SIMU-BSCHL.

      GS_SIMU-SAKNR = GS_SIMU-HKONT.



      GS_SIMU-SGTXT  = '####'.

      GS_SIMU-WRBTR  = ABS( LV_PRD_FCY ).

      GS_SIMU-DMBTR  = ABS( LV_PRD_LCY ).

      GS_SIMU-WAERS  = GS_HEADER_100-WAERS.

      GS_SIMU-WAERS_D = C_WAERS_D.



      GS_SIMU-MATNR  = GS_DISP_100-MATNR.

      APPEND GS_SIMU TO GT_SIMU.

      LV_BUZEI = LV_BUZEI + 1.

    ENDIF.



    "---------------------------------------------------------

    " KDM ####

    "---------------------------------------------------------

    IF LV_KDM_LCY <> 0.

      LV_KTOSL = 'KDM'.

      CLEAR GS_SIMU.

      GS_SIMU-BUZEI = LV_BUZEI.

      GS_SIMU-SHKZG = COND #( WHEN LV_KDM_LCY < 0 THEN 'S' ELSE 'H' ).



      PERFORM GET_HKONT USING LV_KTOPL LV_KTOSL LV_BKLAS

                              GS_HEADER_100-BUKRS GS_HEADER_100-LIFNR GS_SIMU-SHKZG

                        CHANGING GS_SIMU-HKONT.

      PERFORM GET_KOART USING GS_SIMU-HKONT CHANGING GS_SIMU-KOART.

      PERFORM GET_BSCHL USING GS_SIMU-HKONT GS_SIMU-SHKZG CHANGING GS_SIMU-BSCHL.



      GS_SIMU-SGTXT  = COND #( WHEN LV_KDM_LCY < 0 THEN '####' ELSE '####' ).

      GS_SIMU-WRBTR  = 0.

      GS_SIMU-DMBTR  = ABS( LV_KDM_LCY ).

      GS_SIMU-WAERS  = GS_HEADER_100-WAERS.

      GS_SIMU-WAERS_D = C_WAERS_D.



      GS_SIMU-MATNR  = GS_DISP_100-MATNR.

      APPEND GS_SIMU TO GT_SIMU.

      LV_BUZEI = LV_BUZEI + 1.

    ENDIF.



  ENDLOOP.



  "---------------------------------------------------------

  " ## ## ##: MWS / FRT / AP

  "---------------------------------------------------------

  "## (## 1#)

  LV_MWS_FCY = LV_TOTAL_NET_FCY * LV_RATE_TAX.

  LV_FRT_FCY = GS_HEADER_100-FRTWR.

  "AP ## = ### # + ### + ##

  LV_AP_FCY  = LV_TOTAL_NET_FCY + LV_FRT_FCY + LV_MWS_FCY.



  IF GS_HEADER_100-WAERS <> C_WAERS_D.

    LV_MWS_LCY = LV_MWS_FCY * LV_RATE_IR.

    LV_FRT_LCY = LV_FRT_FCY * LV_RATE_IR.

    LV_AP_LCY  = LV_AP_FCY  * LV_RATE_IR.

  ELSE.

    LV_MWS_LCY = LV_MWS_FCY.

    LV_FRT_LCY = LV_FRT_FCY.

    LV_AP_LCY  = LV_AP_FCY.

  ENDIF.



  "---------------------------------------------------------

  " MWS (##)

  "---------------------------------------------------------

  IF GV_TAX_CHECK = 'X' AND LV_MWS_LCY <> 0.

    LV_KTOSL = 'MWS'.

    CLEAR GS_SIMU.

    GS_SIMU-BUZEI = LV_BUZEI.

    GS_SIMU-SHKZG = 'S'.



    PERFORM GET_HKONT USING LV_KTOPL LV_KTOSL LV_BKLAS

                            GS_HEADER_100-BUKRS GS_HEADER_100-LIFNR GS_SIMU-SHKZG

                      CHANGING GS_SIMU-HKONT.

    PERFORM GET_KOART USING GS_SIMU-HKONT CHANGING GS_SIMU-KOART.

    PERFORM GET_BSCHL USING GS_SIMU-HKONT GS_SIMU-SHKZG CHANGING GS_SIMU-BSCHL.

    GS_SIMU-SAKNR = GS_SIMU-HKONT.

    PERFORM GET_MWSKZ_TX USING GS_HEADER_100-MWSKZ CHANGING GS_SIMU-SGTXT.



    GS_SIMU-WRBTR  = LV_MWS_FCY.

    GS_SIMU-DMBTR  = LV_MWS_LCY.

    GS_SIMU-WAERS  = GS_HEADER_100-WAERS.

    GS_SIMU-WAERS_D = C_WAERS_D.



    APPEND GS_SIMU TO GT_SIMU.

    LV_BUZEI = LV_BUZEI + 1.

  ENDIF.



  "---------------------------------------------------------

  " FR1 ### (##)

  "---------------------------------------------------------

  IF LV_FRT_LCY <> 0.

    LV_KTOSL = 'FR1'.

    CLEAR GS_SIMU.

    GS_SIMU-BUZEI = LV_BUZEI.

    GS_SIMU-SHKZG = 'S'.



    PERFORM GET_HKONT USING LV_KTOPL LV_KTOSL LV_BKLAS

                            GS_HEADER_100-BUKRS GS_HEADER_100-LIFNR GS_SIMU-SHKZG

                      CHANGING GS_SIMU-HKONT.

    PERFORM GET_KOART USING GS_SIMU-HKONT CHANGING GS_SIMU-KOART.

    PERFORM GET_BSCHL USING GS_SIMU-HKONT GS_SIMU-SHKZG CHANGING GS_SIMU-BSCHL.



    GS_SIMU-SGTXT  = '###'.

    GS_SIMU-WRBTR  = LV_FRT_FCY.

    GS_SIMU-DMBTR  = LV_FRT_LCY.

    GS_SIMU-WAERS  = GS_HEADER_100-WAERS.

    GS_SIMU-WAERS_D = C_WAERS_D.



    APPEND GS_SIMU TO GT_SIMU.

    LV_BUZEI = LV_BUZEI + 1.

  ENDIF.





  "---------------------------------------------------------

  " KBS #####(AP) (##)

  "---------------------------------------------------------

  LV_KTOSL = 'KBS'.

  CLEAR GS_SIMU.

  GS_SIMU-BUZEI = LV_BUZEI.

  GS_SIMU-SHKZG = 'H'.



  PERFORM GET_HKONT USING LV_KTOPL LV_KTOSL LV_BKLAS

                          GS_HEADER_100-BUKRS GS_HEADER_100-LIFNR GS_SIMU-SHKZG

                    CHANGING GS_SIMU-HKONT.

  PERFORM GET_KOART USING GS_SIMU-HKONT CHANGING GS_SIMU-KOART.

  PERFORM GET_BSCHL USING GS_SIMU-HKONT GS_SIMU-SHKZG CHANGING GS_SIMU-BSCHL.

  GS_SIMU-SAKNR = GS_SIMU-HKONT.



  GS_SIMU-LIFNR = GS_HEADER_100-LIFNR.

  GS_SIMU-SGTXT = GS_HEADER_100-NAME1.

  GS_SIMU-WRBTR = LV_AP_FCY.

  GS_SIMU-DMBTR = LV_AP_LCY.

  GS_SIMU-WAERS = GS_HEADER_100-WAERS.

  GS_SIMU-WAERS_D = C_WAERS_D.



  APPEND GS_SIMU TO GT_SIMU.

  LV_BUZEI = LV_BUZEI + 1.



  "---------------------------------------------------------

  " #/# ## # ##

  "---------------------------------------------------------

  CLEAR: GS_SIMU_HEADER-DR_SUM, GS_SIMU_HEADER-CR_SUM, GS_SIMU_HEADER-BALANCE.

  LOOP AT GT_SIMU INTO GS_SIMU.

    IF GS_SIMU-SHKZG = 'S'.

      GS_SIMU_HEADER-DR_SUM = GS_SIMU_HEADER-DR_SUM + GS_SIMU-DMBTR.

    ELSEIF GS_SIMU-SHKZG = 'H'.

      GS_SIMU_HEADER-CR_SUM = GS_SIMU_HEADER-CR_SUM + GS_SIMU-DMBTR.

    ENDIF.

  ENDLOOP.



  GS_SIMU_HEADER-BALANCE = GS_SIMU_HEADER-DR_SUM - GS_SIMU_HEADER-CR_SUM.

  CALL SCREEN 0400 STARTING AT 10 5 ENDING AT 125 30.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  POST_FI_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM POST_FI_DATA .

  DATA : LV_BELNR TYPE ZBKPF01-BELNR.

  CLEAR : GT_BKPF , GS_BKPF , GT_BSEG , GS_BSEG.




*&---------------------------------------------------------------------*

*       #### ## 5100000000~ (02)

*----------------------------------------------------------------------*




  PERFORM GET_NEW_BELNR USING C_NR_FI CHANGING LV_BELNR .






*&---------------------------------------------------------------------*

*       ####

*----------------------------------------------------------------------*




  GS_BKPF-BUKRS = GS_HEADER_100-BUKRS.

  GS_BKPF-BELNR = LV_BELNR.

  GS_BKPF-GJAHR = SY-DATUM(4).

  GS_BKPF-BLART = 'RE'.

  GS_BKPF-BLDAT = GS_HEADER_100-BLDAT.

  GS_BKPF-BUDAT = GS_HEADER_100-BUDAT.

  GS_BKPF-CPUDT = SY-DATUM.

  GS_BKPF-CPUTM = SY-UZEIT.

  GS_BKPF-KURSF = GS_HEADER_100-KURSF.

  GS_BKPF-WAERS = GS_HEADER_100-WAERS.

  GS_BKPF-TCODE = 'MIRO'.

  GS_BKPF-XBLNR = GS_HEADER_100-BELNR.

  GS_BKPF-CRNAME = SY-UNAME.



  INSERT ZBKPF01 FROM GS_BKPF.




*&---------------------------------------------------------------------*

*       ####

*----------------------------------------------------------------------*




  LOOP AT GT_SIMU INTO GS_SIMU.

    CLEAR : GS_BSEG.

    MOVE-CORRESPONDING GS_SIMU TO GS_BSEG.

    GS_BSEG-BUKRS = GS_HEADER_100-BUKRS.

    GS_BSEG-BELNR = LV_BELNR.

    GS_BSEG-GJAHR = SY-DATUM(4).

    GS_BSEG-BUZEI = GS_SIMU-BUZEI.

    APPEND GS_BSEG TO GT_BSEG.

  ENDLOOP.



  INSERT ZBSEG01 FROM TABLE GT_BSEG.

  LEAVE TO SCREEN 0.

  LEAVE TO SCREEN 0.

ENDFORM.




*&---------------------------------------------------------------------*

*&      FORM  POST_CANCEL_FI_DATA

*&---------------------------------------------------------------------*




FORM POST_CANCEL_FI_DATA .

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



  DATA:  LV_MWS_FCY       TYPE ZBSEG01-DMBTR, "##(##)

         LV_MWS_LCY       TYPE ZBSEG01-DMBTR, "##(##)



         LV_AP_FCY        TYPE ZBSEG01-WRBTR, "AP(##)

         LV_AP_LCY        TYPE ZBSEG01-DMBTR, "AP(##)



         LV_RATE_GR       TYPE BKPF-KURSF,    "GR## ##

         LV_RATE_IR       TYPE BKPF-KURSF,    "IR## ##

         LV_RATE_TAX      TYPE BKPF-KURSF.    "##

  DATA : LV_MBLNR TYPE ZMSEG01-MBLNR.

"---------------------------------------------------------

" ## ##/##

"---------------------------------------------------------

  LV_RATE_IR = GS_HEADER_100-KURSF.



  SELECT SINGLE MBLNR

    FROM ZMSEG01

    INTO LV_MBLNR

    WHERE EBELN = GS_HEADER_100-EBELN.



  SELECT SINGLE KURSF

    FROM ZBKPF01

    INTO LV_RATE_GR

    WHERE XBLNR = LV_MBLNR.



  IF LV_RATE_GR = 0.

    LV_RATE_GR = LV_RATE_IR.

  ENDIF.



  IF GS_HEADER_100-WAERS <> C_WAERS_D.

    LV_RATE_GR = LV_RATE_GR * '0.01'.

    LV_RATE_IR = LV_RATE_IR * '0.01'.

  ENDIF.



  PERFORM GET_TAX_RATE USING GS_HEADER_100-MWSKZ CHANGING LV_RATE_TAX.



  CLEAR : GT_BKPF , GS_BKPF , GT_BSEG , GS_BSEG.




*&---------------------------------------------------------------------*

*       ## #### ## 5000000000~ (03)

*----------------------------------------------------------------------*




  PERFORM GET_NEW_BELNR USING C_NR_FI_CANC CHANGING LV_BELNR .








*&---------------------------------------------------------------------*

*       ## ## ## ( ##### )

*----------------------------------------------------------------------*




  SELECT SINGLE *

    FROM ZBKPF01

    INTO CORRESPONDING FIELDS OF LS_BKPF

    WHERE XBLNR = GS_HEADER_100-STBLG

       AND BUKRS = GS_HEADER_100-BUKRS.



  LOOP AT GT_RSEG INTO GS_RSEG.

    CLEAR : LT_TEMP_BSEG.

    SELECT *

      FROM ZBSEG01

      INTO CORRESPONDING FIELDS OF TABLE LT_TEMP_BSEG

      WHERE BELNR = LS_BKPF-BELNR

      AND  MATNR = GS_RSEG-MATNR.

    LOOP AT LT_TEMP_BSEG INTO LS_TEMP_BSEG.

      APPEND LS_TEMP_BSEG TO LT_BSEG.

    ENDLOOP.

  ENDLOOP.






*&---------------------------------------------------------------------*

*       ####

*----------------------------------------------------------------------*




  GS_BKPF-BUKRS = LS_BKPF-BUKRS..

  GS_BKPF-BELNR = LV_BELNR.

  GS_BKPF-GJAHR = SY-DATUM(4).

  GS_BKPF-BLART = 'ST'.

  GS_BKPF-BLDAT = SY-DATUM.

  GS_BKPF-BUDAT = SY-DATUM.

  GS_BKPF-CPUDT = SY-DATUM.

  GS_BKPF-CPUTM = SY-UZEIT.

  GS_BKPF-KURSF = LS_BKPF-KURSF.

  GS_BKPF-WAERS = LS_BKPF-WAERS.

  GS_BKPF-TCODE = 'MIRO'.

  GS_BKPF-XBLNR = GS_HEADER_100-BELNR.

  GS_BKPF-STJAH = SY-DATUM(4).

  GS_BKPF-XSTOV = 'X'.

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



    SELECT SINGLE KTOSL

      FROM ZSKA1_01

      INTO LV_KTOSL

      WHERE SAKNR = GS_BSEG-SAKNR.

    IF GS_BSEG-SHKZG = 'H'.

      LV_PRICE_SUM = LV_PRICE_SUM + LS_BSEG-WRBTR.

    ENDIF.



    IF GS_BSEG-SHKZG = 'S'.

      LV_PRICE_SUM = LV_PRICE_SUM - LS_BSEG-WRBTR.

    ENDIF.

  ENDLOOP.





  IF GS_BKPF-WAERS = C_WAERS_D.

   LV_MWS_FCY = LV_PRICE_SUM * LV_RATE_TAX.

   LV_MWS_LCY = LV_MWS_FCY.



   LV_AP_FCY  = LV_PRICE_SUM + LV_MWS_FCY.

   LV_AP_LCY  = LV_AP_FCY.

  ELSE.

   LV_MWS_FCY = 0.

   LV_MWS_LCY = LV_PRICE_SUM * LV_RATE_TAX * LV_RATE_IR.



   LV_AP_FCY  = LV_PRICE_SUM.

   LV_AP_LCY  = LV_AP_FCY * LV_RATE_IR + LV_MWS_LCY.

  ENDIF.

"---------------------------------------------------------

" ##### MWS

"---------------------------------------------------------

  LV_KTOSL = 'MWS'. "#####

  CLEAR : GS_BSEG.



  GS_BSEG-BUKRS = GS_HEADER_100-BUKRS.

  GS_BSEG-BELNR = LV_BELNR.

  GS_BSEG-GJAHR = SY-DATUM(4).

  GS_BSEG-BUZEI = LV_BUZEI.

  GS_BSEG-SHKZG = 'H'.

  PERFORM GET_HKONT USING LV_KTOPL LV_KTOSL LV_BKLAS GS_HEADER_100-BUKRS GS_HEADER_100-LIFNR GS_BSEG-SHKZG

                    CHANGING GS_BSEG-HKONT.

  PERFORM GET_KOART USING GS_BSEG-HKONT CHANGING GS_BSEG-KOART.

  PERFORM GET_BSCHL USING GS_BSEG-HKONT GS_BSEG-SHKZG CHANGING GS_BSEG-BSCHL.

  GS_BSEG-WRBTR = LV_MWS_FCY.

  GS_BSEG-DMBTR = LV_MWS_LCY.

  GS_BSEG-SGTXT = |#### : #####|.

  APPEND GS_BSEG TO GT_BSEG.

  LV_BUZEI = LV_BUZEI + 1.




*&---------------------------------------------------------------------*

*      ##### (##)

*----------------------------------------------------------------------*




  LV_KTOSL = 'KBS'. "VENDOR



  CLEAR : GS_BSEG.

  GS_BSEG-BUKRS = GS_HEADER_100-BUKRS.

  GS_BSEG-BELNR = LV_BELNR.

  GS_BSEG-GJAHR = SY-DATUM(4).

  GS_BSEG-BUZEI = LV_BUZEI.

  GS_BSEG-SHKZG = 'S'.

  GS_BSEG-LIFNR = GS_HEADER_100-LIFNR.



  PERFORM GET_HKONT USING LV_KTOPL LV_KTOSL LV_BKLAS

                          GS_HEADER_100-BUKRS GS_HEADER_100-LIFNR GS_BSEG-SHKZG

                    CHANGING GS_BSEG-HKONT.

  PERFORM GET_KOART USING GS_BSEG-HKONT CHANGING GS_BSEG-KOART.

  PERFORM GET_BSCHL USING GS_BSEG-HKONT GS_BSEG-SHKZG CHANGING GS_BSEG-BSCHL.

  GS_BSEG-SAKNR = GS_BSEG-HKONT.



  GS_BSEG-WRBTR = LV_AP_FCY.

  GS_BSEG-DMBTR = LV_AP_LCY.

  GS_BSEG-SGTXT = |#### : { GS_HEADER_100-NAME1 }|.

  APPEND GS_BSEG TO GT_BSEG.



  INSERT ZRBKP01 FROM GS_RBKP.

  INSERT ZRSEG01 FROM TABLE GT_RSEG.

  INSERT ZBKPF01 FROM GS_BKPF.

  INSERT ZBSEG01 FROM TABLE GT_BSEG.

  MESSAGE | #### { GS_HEADER_100-BELNR }#(#) ######| TYPE 'S'.

  LEAVE TO SCREEN 0.

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

*&      Form  GET_BKLAS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_BKLAS  USING    P_MATNR

                CHANGING P_BKLAS.

SELECT SINGLE BKLAS

  FROM ZMAT01

  INTO P_BKLAS

 WHERE MATNR = GS_DISP_100-MATNR.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_BANK_TX

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_BANK_TX  USING    P_BANKL

                  CHANGING P_BANKL_TX.

  SELECT SINGLE TEXT

    FROM ZTBANKCODE01

    INTO P_BANKL_TX

    WHERE BANKL = P_BANKL.

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



    WHEN 'KBS'.      "Vender

      IF P_SHKZG = 'S'.

        P_BSCHL = '21'.

      ELSE.

        P_BSCHL = '31'.

      ENDIF.



    WHEN 'KDM'.      "##

      IF P_SHKZG = 'S'.

        P_BSCHL = '40'.

      ELSE.

        P_BSCHL = '50'.

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

*&      Form  GET_FI_DATA

*&---------------------------------------------------------------------*




FORM GET_FI_DATA .

  CLEAR : GS_BKPF , GT_BSEG , GS_FI_ALV , GT_FI_ALV , GT_FI_SUM , GS_FI_SUM.



  SELECT SINGLE *

    FROM ZBKPF01

    INTO GS_BKPF

    WHERE XBLNR = GS_HEADER_100-BELNR.



  SELECT *

    FROM ZBSEG01

    INTO CORRESPONDING FIELDS OF TABLE GT_BSEG

    WHERE BELNR = GS_BKPF-BELNR.



  LOOP AT GT_BSEG INTO GS_BSEG.

    MOVE-CORRESPONDING GS_BSEG TO GS_FI_ALV.

    GS_FI_ALV-WAERS = GS_BKPF-WAERS.

    APPEND GS_FI_ALV TO GT_FI_ALV.

  ENDLOOP.

  GV_PERIOD = GS_BKPF-BUDAT+4(2).

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_MWSKZ_TX

*&---------------------------------------------------------------------*




FORM GET_MWSKZ_TX  USING    P_MWSKZ

                   CHANGING P_TEXT.

  SELECT SINGLE TEXT

    FROM ZTAXCODE01

    INTO P_TEXT

    WHERE MWSKZ = P_MWSKZ.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  EXCLUDE_TOOLBAR

*&---------------------------------------------------------------------*




FORM EXCLUDE_TOOLBAR .

  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_INSERT_ROW.

  APPEND GS_EXCLUDE TO GT_EXCLUDE.



  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_DELETE_ROW.

  APPEND GS_EXCLUDE TO GT_EXCLUDE.



  GS_EXCLUDE = CL_GUI_ALV_GRID=>MC_FC_LOC_APPEND_ROW.

  APPEND GS_EXCLUDE TO GT_EXCLUDE.

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

*&      Form  GET_TAX_RATE

*&---------------------------------------------------------------------*




FORM GET_TAX_RATE  USING    P_MWSKZ

                   CHANGING P_RATE_TAX.

  CASE P_MWSKZ.

    WHEN 'V1'. P_RATE_TAX = '0.1'.

    WHEN OTHERS. P_RATE_TAX = '0'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INCO

*&---------------------------------------------------------------------*




FORM CHECK_INCO  USING    P_INCO1 P_FRTWR.



  CASE P_INCO1.



    WHEN 'EXW' OR 'FOB' OR 'FCA' OR 'FAS'.

      IF P_FRTWR IS INITIAL OR P_FRTWR = 0.

        MESSAGE |####({ P_INCO1 })# ### ##### #### #### ###|

          TYPE 'S' DISPLAY LIKE 'E'.

        GV_CHECK_FLAG = 'X'.

      ENDIF.

  ENDCASE.



ENDFORM.