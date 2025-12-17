
*&---------------------------------------------------------------------*

*&  Include           ZMM09_004_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CONTROL_SCREEN

*&---------------------------------------------------------------------*






FORM CONTROL_SCREEN .

  LOOP AT SCREEN.

    IF P_R1 = 'X'. "####

      IF SCREEN-GROUP1 = 'C'.

        SCREEN-ACTIVE = 1.

      ELSEIF SCREEN-GROUP1 = 'S'.

        SCREEN-ACTIVE = 0.

      ENDIF.



    ELSEIF P_R2 = 'X'. "####

      IF SCREEN-GROUP1 = 'C'.

        SCREEN-ACTIVE = 0.

      ELSEIF SCREEN-GROUP1 = 'S'.

        SCREEN-ACTIVE = 1.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*




FORM SET_SCREEN .

  IF P_R1 = 'X'.

    P_BLDAT = SY-DATUM.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  VALID_INPUT_ALL

*&---------------------------------------------------------------------*




FORM VALID_INPUT_ALL .

  IF P_R1 = 'X'.

    IF ( P_EBELNC IS INITIAL ) OR ( P_WERKSC IS INITIAL ) OR ( P_BLDAT  IS INITIAL ).

      MESSAGE '####, ###, ###### ########' TYPE 'I'.

      STOP.

    ENDIF.

  ELSEIF P_R2 = 'X'.

    IF ( P_EBELNS IS INITIAL ) OR ( P_WERKSS IS INITIAL ).

      MESSAGE '####, #### ########' TYPE 'I'.

      STOP.

    ENDIF.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  VALID_INPUT

*&---------------------------------------------------------------------*




FORM VALID_INPUT .

  DATA : LV_EBELN LIKE ZEKKO_09-EBELN,

         LV_WERKS LIKE ZEKPO_09-WERKS.



  IF P_R1 = 'X'.

    SELECT SINGLE EBELN WERKS

    FROM ZEKPO_09

    INTO ( LV_EBELN, LV_WERKS )

    WHERE EBELN = P_EBELNC

    AND   WERKS = P_WERKSC.





  IF SY-SUBRC <> 0.

     MESSAGE '## ##### #### ## ##### #### ####.' TYPE 'I'.

      STOP.

  ENDIF.



  ELSEIF P_R2 = 'X'.

    SELECT SINGLE EBELN WERKS

    FROM ZEKPO_09

    INTO ( LV_EBELN, LV_WERKS )

    WHERE EBELN = P_EBELNS

    AND   WERKS = P_WERKSS.



    IF SY-SUBRC <> 0.

      MESSAGE '## ##### ### #### ####.' TYPE 'I'.

      STOP.

    ENDIF.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_DROPDOWN_TAX

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DROPDOWN_TAX .

  DATA : LT_DROPLIST TYPE VRM_VALUES,

         LS_DROPLIST TYPE VRM_VALUE.



  CLEAR : LS_DROPLIST, LT_DROPLIST.



  LS_DROPLIST-KEY = 'V1'.

  LS_DROPLIST-TEXT = '####10%'.

  APPEND LS_DROPLIST TO LT_DROPLIST.



  CLEAR : LS_DROPLIST.

  LS_DROPLIST-KEY = 'V2'.

  LS_DROPLIST-TEXT = '####0%'.

  APPEND LS_DROPLIST TO LT_DROPLIST.



  CLEAR : LS_DROPLIST.

  LS_DROPLIST-KEY = 'V3'.

  LS_DROPLIST-TEXT = '####0%'.

  APPEND LS_DROPLIST TO LT_DROPLIST.



  CLEAR : LS_DROPLIST.

  LS_DROPLIST-KEY = 'V4'.

  LS_DROPLIST-TEXT = '#####10%'.

  APPEND LS_DROPLIST TO LT_DROPLIST.



  CLEAR : LS_DROPLIST.

  LS_DROPLIST-KEY = 'V5'.

  LS_DROPLIST-TEXT = '######10%'.

  APPEND LS_DROPLIST TO LT_DROPLIST.



  CALL FUNCTION 'VRM_SET_VALUES'

    EXPORTING

      ID = 'GF_MWSKZ'

      VALUES = LT_DROPLIST.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_DROPDOWN_ZTERM

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DROPDOWN_ZTERM .

  DATA : LT_DROPLIST TYPE VRM_VALUES,

         LS_DROPLIST TYPE VRM_VALUE.

  "####

  CLEAR : LS_DROPLIST, LT_DROPLIST.



  LS_DROPLIST-KEY = 'M001'.

  LS_DROPLIST-TEXT = '##10###'.

  APPEND LS_DROPLIST TO LT_DROPLIST.



  CLEAR : LS_DROPLIST.

  LS_DROPLIST-KEY = 'M002'.

  LS_DROPLIST-TEXT = '##25###'.

  APPEND LS_DROPLIST TO LT_DROPLIST.



  CLEAR : LS_DROPLIST.

  LS_DROPLIST-KEY = 'M003'.

  LS_DROPLIST-TEXT = '##10###'.

  APPEND LS_DROPLIST TO LT_DROPLIST.



  CLEAR : LS_DROPLIST.

  LS_DROPLIST-KEY = 'M004'.

  LS_DROPLIST-TEXT = '##25###'.

  APPEND LS_DROPLIST TO LT_DROPLIST.



  CLEAR : LS_DROPLIST.

  LS_DROPLIST-KEY = 'M005'.

  LS_DROPLIST-TEXT = '###10###'.

  APPEND LS_DROPLIST TO LT_DROPLIST.



  CLEAR : LS_DROPLIST.

  LS_DROPLIST-KEY = 'M006'.

  LS_DROPLIST-TEXT = '###25###'.

  APPEND LS_DROPLIST TO LT_DROPLIST.



  CLEAR : LS_DROPLIST.

  LS_DROPLIST-KEY = 'P010'.

  LS_DROPLIST-TEXT = '10# ## ##'.

  APPEND LS_DROPLIST TO LT_DROPLIST.



  CLEAR : LS_DROPLIST.

  LS_DROPLIST-KEY = 'P015'.

  LS_DROPLIST-TEXT = '15# ## ##'.

  APPEND LS_DROPLIST TO LT_DROPLIST.



  CLEAR : LS_DROPLIST.

  LS_DROPLIST-KEY = 'P020'.

  LS_DROPLIST-TEXT = '20# ## ##'.

  APPEND LS_DROPLIST TO LT_DROPLIST.



  CLEAR : LS_DROPLIST.

  LS_DROPLIST-KEY = 'P030'.

  LS_DROPLIST-TEXT = '30# ## ##'.

  APPEND LS_DROPLIST TO LT_DROPLIST.



  CLEAR : LS_DROPLIST.

  LS_DROPLIST-KEY = 'P060'.

  LS_DROPLIST-TEXT = '60# ## ##'.

  APPEND LS_DROPLIST TO LT_DROPLIST.



  CLEAR : LS_DROPLIST.

  LS_DROPLIST-KEY = 'P090'.

  LS_DROPLIST-TEXT = '90# ## ##'.

  APPEND LS_DROPLIST TO LT_DROPLIST.





  CALL FUNCTION 'VRM_SET_VALUES'

    EXPORTING

      ID = 'GF_ZTERM'

      VALUES = LT_DROPLIST.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_HEADER

*&---------------------------------------------------------------------*




FORM SET_HEADER .



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_ITEMS

*&---------------------------------------------------------------------*




FORM SET_ITEMS .

  IF GC_CUSTOM IS INITIAL.

    PERFORM CREATE_OBJECTS.

    PERFORM FIELD_CATALOG.

    PERFORM DELETE_TOOLBAR.

    PERFORM CLASS_EVENT.

    PERFORM CALL_ALV.

  ELSE.

    GC_GRID->REFRESH_TABLE_DISPLAY( ).

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECTS

*&---------------------------------------------------------------------*




FORM CREATE_OBJECTS .

  CREATE OBJECT GC_CUSTOM

    EXPORTING

      CONTAINER_NAME = 'CON1'.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT = GC_CUSTOM.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'LV_CHECK'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CHECKBOX = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'BUZEI'. "##### ##

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'NETPR'. "##

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT = '## ######'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  GS_FIELDCAT-DATATYPE = 'INT'.

  GS_FIELDCAT-OUTPUTLEN = '15'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'WRBTR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT = '##'. "#### ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'MWSKZ_S'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'WMWST'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 15.

  GS_FIELDCAT-FIELDNAME = 'DBMTR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 16.

  GS_FIELDCAT-FIELDNAME = 'SGTXT'.

  GS_FIELDCAT-COLTEXT = '###'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DELETE_TOOLBAR

*&---------------------------------------------------------------------*




FORM DELETE_TOOLBAR .

  APPEND CL_GUI_ALV_GRID=>MC_FC_EXCL_ALL TO GT_TOOLBAR.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*




FORM CALL_ALV .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IT_TOOLBAR_EXCLUDING = GT_TOOLBAR

    CHANGING

      IT_OUTTAB                     = GT_ITEM_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*




FORM GET_DATA .

  PERFORM GET_HEADER.

  PERFORM GET_ITEMS.

  PERFORM SET_HEADER_DEFAULT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_HEADER

*&---------------------------------------------------------------------*




FORM GET_HEADER .

  "#####-####

   GF_BLDAT = P_BLDAT.



  "###-#####

   GF_BUDAT = SY-DATUM.



  "####

   SELECT SINGLE WAERS

   FROM ZEKKO_09

   INTO GF_WAERS

   WHERE EBELN = P_EBELNC.

   GF_WAERS2 = GF_WAERS.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_ITEMS

*&---------------------------------------------------------------------*




FORM GET_ITEMS .

  DATA : LS_PO TYPE ZEKPO_09,        "#####

         LT_PO LIKE TABLE OF LS_PO,




*         LV_H_MENGE TYPE MENGE_D, "#####(H)

*         LV_S_MENGE TYPE MENGE_D. "#####(S)




         LV_PO_MENGE TYPE MENGE_D, "PO####

         LV_IV_MENGE TYPE MENGE_D. "####### ##



  CLEAR : GT_ITEM_ALV, GS_ITEM_ALV.



  "EKPO## ### ####

  SELECT *

  FROM ZEKPO_09

  INTO CORRESPONDING FIELDS OF TABLE LT_PO

  WHERE EBELN = P_EBELNC "####

  AND   WERKS = P_WERKSC."###



  LOOP AT LT_PO INTO LS_PO.

    CLEAR : GS_ITEM_ALV, LV_PO_MENGE, LV_IV_MENGE.



    "PO##

    LV_PO_MENGE = LS_PO-MENGE.



    "## ##### ##

    SELECT SUM( MENGE )

    FROM ZRSEG09

    INTO LV_IV_MENGE

    WHERE EBELN = LS_PO-EBELN

    AND   EBELP = LS_PO-EBELP

    AND   MATNR = LS_PO-MATNR.



    IF LV_IV_MENGE IS INITIAL.

      LV_IV_MENGE = 0.

    ENDIF.



    GS_ITEM_ALV-MENGE = LV_PO_MENGE - LV_IV_MENGE.








*    "##### (H)

*    SELECT SUM( MENGE )

*    FROM ZRSEG09

*    INTO LV_H_MENGE

*    WHERE EBELN = LS_PO-EBELN

*    AND   EBELP = LS_PO-EBELP

*    AND   SHKZG = 'H'.

*

*    IF LV_H_MENGE IS INITIAL.

*      LV_H_MENGE = 0.

*    ENDIF.

*

*    "##### (S)

*    SELECT SUM( MENGE )

*    FROM ZRSEG09

*    INTO LV_S_MENGE

*    WHERE EBELN = LS_PO-EBELN

*    AND   EBELP = LS_PO-EBELP

*    AND   SHKZG = 'S'.

*

*    IF LV_S_MENGE IS INITIAL.

*      LV_S_MENGE = 0.

*    ENDIF.

*    "###### : PO## - (H - S)

*    GS_ITEM_ALV-MENGE = LS_PO-MENGE - ( LV_H_MENGE - LV_S_MENGE ).






    IF GS_ITEM_ALV-MENGE <= 0.

      CONTINUE. "## ####### #

    ENDIF.



    "### ##

    GS_ITEM_ALV-LV_CHECK = ''.

    GS_ITEM_ALV-BUZEI = SY-TABIX * 1.

    GS_ITEM_ALV-NETPR = LS_PO-STPRS. "##

    GS_ITEM_ALV-MEINS = LS_PO-MEINS.

    GS_ITEM_ALV-EBELN = LS_PO-EBELN.

    GS_ITEM_ALV-EBELP = LS_PO-EBELP.

    GS_ITEM_ALV-MATNR = LS_PO-MATNR.

    GS_ITEM_ALV-ZMATNAME = LS_PO-MAKTX.

    GS_ITEM_ALV-WERKS = LS_PO-WERKS.

    GS_ITEM_ALV-MWSKZ_S = C_V1.   "### #### v1

    GS_ITEM_ALV-WAERS = GF_WAERS.





    "#### (## * ######)

    GS_ITEM_ALV-WRBTR = GS_ITEM_ALV-NETPR * GS_ITEM_ALV-MENGE.

    GS_ITEM_ALV-WMWST = GS_ITEM_ALV-WRBTR * C_TAX_V1. "## (#### * v1), #### #### v1



    GS_ITEM_ALV-DBMTR = GS_ITEM_ALV-WRBTR + GS_ITEM_ALV-WMWST.



    APPEND GS_ITEM_ALV TO GT_ITEM_ALV.

  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_HEADER_DEFAULT

*&---------------------------------------------------------------------*




FORM SET_HEADER_DEFAULT .

  GF_WMWST1 = 0.



  "#####

  "#### #### (m001, ##10###)

  DATA : LV_DATE TYPE D.



  LV_DATE = GF_BUDAT.

  LV_DATE+6(2) = 10.

  GF_ZFBDT = LV_DATE.



  "##, ####, #### ####

 GF_BALANCE = 0.

 GF_MWSKZ = 'V1'.

 GF_ZTERM = 'M001'.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  RECALCULATE_ITEMS_BY_TAXCODE

*&---------------------------------------------------------------------*




FORM RECALCULATE_ITEMS_BY_TAXCODE .

  DATA : LV_RATE TYPE P DECIMALS 2,

         LV_SUM_TAX TYPE P DECIMALS 2,

         LV_SUM_TOTAL TYPE P DECIMALS 2.



  "##

  CASE GF_MWSKZ.

    WHEN 'V1'. LV_RATE = C_TAX_V1.

    WHEN 'V2'. LV_RATE = C_TAX_V2.

    WHEN 'V3'. LV_RATE = C_TAX_V3.

    WHEN 'V4'. LV_RATE = C_TAX_V4.

    WHEN 'V5'. LV_RATE = C_TAX_V5.

  ENDCASE.



  "####, ####, ##

  LOOP AT GT_ITEM_ALV INTO GS_ITEM_ALV.

    PERFORM CHANGE_MWSKZS USING    GF_MWSKZ

                          CHANGING GS_ITEM_ALV-MWSKZ_S.

    GS_ITEM_ALV-WMWST = GS_ITEM_ALV-WRBTR * LV_RATE.

    GS_ITEM_ALV-DBMTR = GS_ITEM_ALV-WRBTR + GS_ITEM_ALV-WMWST.



    LV_SUM_TAX = LV_SUM_TAX + GS_ITEM_ALV-WMWST.

    LV_SUM_TOTAL = LV_SUM_TOTAL + GS_ITEM_ALV-DBMTR.



    MODIFY GT_ITEM_ALV FROM GS_ITEM_ALV INDEX SY-TABIX.

  ENDLOOP.



  GF_WMWST1 = LV_SUM_TAX.

  GF_BALANCE = GF_RMWWR - LV_SUM_TOTAL.





ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHANGE_MWSKZS

*&---------------------------------------------------------------------*




FORM CHANGE_MWSKZS  USING    P_MWSKZ

                    CHANGING P_MWSKZ_S.

  CASE P_MWSKZ.

    WHEN 'V1'.

      P_MWSKZ_S = C_V1.

    WHEN 'V2'.

      P_MWSKZ_S = C_V2.

    WHEN 'V3'.

      P_MWSKZ_S = C_V3.

    WHEN 'V4'.

      P_MWSKZ_S = C_V4.

    WHEN 'V5'.

      P_MWSKZ_S = C_V5.

  ENDCASE.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  RECALCULATE_DUE_DATE

*&---------------------------------------------------------------------*




FORM RECALCULATE_DUE_DATE .

  DATA : LV_BASE TYPE D,

         LV_YEAR TYPE N LENGTH 4,

         LV_MONTH TYPE N LENGTH 2,

         LV_DAY TYPE N LENGTH 2,

         LV_MONTH_ADD TYPE I.



  LV_BASE = GF_BUDAT.

  LV_YEAR = LV_BASE+0(4).

  LV_MONTH = LV_BASE+4(2).

  LV_DAY = LV_BASE+6(2).



  CASE GF_ZTERM.

    WHEN 'M001'. LV_MONTH_ADD = 0. LV_DAY = '10'.

    WHEN 'M002'. LV_MONTH_ADD = 0. LV_DAY = '25'.

    WHEN 'M003'. LV_MONTH_ADD = 1. LV_DAY = '10'.

    WHEN 'M004'. LV_MONTH_ADD = 1. LV_DAY = '25'.

    WHEN 'M005'. LV_MONTH_ADD = 2. LV_DAY = '10'.

    WHEN 'M006'. LV_MONTH_ADD = 2. LV_DAY = '25'.

    WHEN 'P010'. GF_ZFBDT = LV_BASE + 10. RETURN.

    WHEN 'P015'. GF_ZFBDT = LV_BASE + 15. RETURN.

    WHEN 'P020'. GF_ZFBDT = LV_BASE + 20. RETURN.

    WHEN 'P030'. GF_ZFBDT = LV_BASE + 30. RETURN.

    WHEN 'P060'. GF_ZFBDT = LV_BASE + 60. RETURN.

    WHEN 'P090'. GF_ZFBDT = LV_BASE + 90. RETURN.



  ENDCASE.



  LV_MONTH = LV_MONTH + LV_MONTH_ADD.

  IF LV_MONTH > 12.

    LV_MONTH = LV_MONTH - 12.

    LV_YEAR = LV_YEAR + 1.

  ENDIF.



  CONCATENATE LV_YEAR LV_MONTH LV_DAY INTO GF_ZFBDT.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_ER_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_E_ONF4

                                        P_E_ONF4_BEFORE

                                        P_E_ONF4_AFTER

                                        P_E_UCOMM.



  DATA : LS_MODI TYPE LVC_S_MODI,

         LV_NEW_MENGE  TYPE MENGE_D,

         LV_PO_MENGE TYPE MENGE_D,

         LV_IV_MENGE TYPE MENGE_D, "## ##### ##




*         LV_H_MENGE TYPE MENGE_D, "#####(H)

*         LV_S_MENGE TYPE MENGE_D, "#####(S)




         LV_MAX_MENGE TYPE MENGE_D,

         LV_RATE TYPE P DECIMALS 2.



  "##

  CASE GF_MWSKZ.

    WHEN 'V1'. LV_RATE = C_TAX_V1.

    WHEN 'V2'. LV_RATE = C_TAX_V2.

    WHEN 'V3'. LV_RATE = C_TAX_V3.

    WHEN 'V4'. LV_RATE = C_TAX_V4.

    WHEN 'V5'. LV_RATE = C_TAX_V5.

  ENDCASE.





  LOOP AT P_ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    READ TABLE GT_ITEM_ALV INTO GS_ITEM_ALV INDEX LS_MODI-ROW_ID.

    IF SY-SUBRC <> 0.

      CONTINUE.

    ENDIF.



    IF LS_MODI-FIELDNAME = 'MENGE'.

      LV_NEW_MENGE = LS_MODI-VALUE.



      SELECT SINGLE MENGE

      FROM ZEKPO_09

      INTO LV_PO_MENGE "#### ##

      WHERE EBELN = GS_ITEM_ALV-EBELN

        AND EBELP = GS_ITEM_ALV-EBELP.



      SELECT SUM( MENGE )

      FROM ZRSEG09

      INTO LV_IV_MENGE

      WHERE EBELN = GS_ITEM_ALV-EBELN

      AND   EBELP = GS_ITEM_ALV-EBELP

      AND   MATNR = GS_ITEM_ALV-MATNR.



      LV_MAX_MENGE = LV_PO_MENGE - LV_IV_MENGE.








*      "##### (H)

*      SELECT SUM( MENGE )

*      FROM ZRSEG09

*      INTO LV_H_MENGE

*      WHERE EBELN = GS_ITEM_ALV-EBELN

*      AND   EBELP = GS_ITEM_ALV-EBELP

*      AND   SHKZG = 'H'.

*

*      IF LV_H_MENGE IS INITIAL.

*        LV_H_MENGE = 0.

*      ENDIF.

*

*      "##### (S)

*      SELECT SUM( MENGE )

*      FROM ZRSEG09

*      INTO LV_S_MENGE

*      WHERE EBELN = GS_ITEM_ALV-EBELN

*      AND   EBELP = GS_ITEM_ALV-EBELP

*      AND   SHKZG = 'S'.

*

*      IF LV_S_MENGE IS INITIAL.

*        LV_S_MENGE = 0.

*      ENDIF.

*

*      LV_MAX_MENGE = LV_PO_MENGE - ( LV_H_MENGE - LV_S_MENGE ).






      IF LV_NEW_MENGE > LV_MAX_MENGE.

        CALL METHOD P_ER_DATA_CHANGED->ADD_PROTOCOL_ENTRY

          EXPORTING

            I_MSGID = 'ZMED09'

            I_MSGNO = '021'

            I_MSGTY = 'E'

            I_MSGV1 = LV_MAX_MENGE

            I_FIELDNAME = 'MENGE'

            I_ROW_ID = LS_MODI-ROW_ID.

      ELSE. "PO#### ### ## #### #



        "####, ##, ## ##

        GS_ITEM_ALV-MENGE = LV_NEW_MENGE.

        GS_ITEM_ALV-WRBTR = GS_ITEM_ALV-MENGE * GS_ITEM_ALV-NETPR.

        GS_ITEM_ALV-WMWST = GS_ITEM_ALV-WRBTR * LV_RATE.

        GS_ITEM_ALV-DBMTR = GS_ITEM_ALV-WRBTR + GS_ITEM_ALV-WMWST.



        MODIFY GT_ITEM_ALV FROM GS_ITEM_ALV INDEX SY-TABIX.



        PERFORM REFRESH.

        GV_FLAG_EVENT = ABAP_TRUE.

      ENDIF.



    ELSEIF LS_MODI-FIELDNAME = 'NETPR'. "##

       "##, ####, ##, ## ####

      GS_ITEM_ALV-NETPR = LS_MODI-VALUE.

      GS_ITEM_ALV-WRBTR = GS_ITEM_ALV-NETPR * GS_ITEM_ALV-MENGE.

      GS_ITEM_ALV-WMWST = GS_ITEM_ALV-WRBTR * LV_RATE.

      GS_ITEM_ALV-DBMTR = GS_ITEM_ALV-WRBTR + GS_ITEM_ALV-WMWST.



      MODIFY GT_ITEM_ALV FROM GS_ITEM_ALV INDEX SY-TABIX.

      PERFORM REFRESH.

      GV_FLAG_EVENT = ABAP_TRUE.



    ELSEIF LS_MODI-FIELDNAME = 'LV_CHECK'. "####

      GS_ITEM_ALV-LV_CHECK = LS_MODI-VALUE.

      MODIFY GT_ITEM_ALV FROM GS_ITEM_ALV INDEX SY-TABIX.

      GV_FLAG_EVENT = ABAP_TRUE.



    ELSEIF LS_MODI-FIELDNAME = 'SGTXT'. "###

      GS_ITEM_ALV-SGTXT = LS_MODI-VALUE.

      MODIFY GT_ITEM_ALV FROM GS_ITEM_ALV INDEX SY-TABIX.

    ENDIF.



  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*




FORM CLASS_EVENT .

  CREATE OBJECT GO_EVENT.



  "### ###

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  "### ##

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*




FORM REFRESH .

  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED  USING    P_E_MODIFIED

                                         P_ET_GOOD_CELLS TYPE LVC_T_MODI.



  IF GV_FLAG_EVENT = ABAP_TRUE.

    DATA : LV_SUM_TAX TYPE P DECIMALS 2,

           LV_TOTAL_SUM TYPE P DECIMALS 2.



    "### #### ###, ## ####

    LOOP AT GT_ITEM_ALV INTO GS_ITEM_ALV WHERE LV_CHECK = 'X'.

      LV_SUM_TAX = LV_SUM_TAX + GS_ITEM_ALV-WMWST.

      LV_TOTAL_SUM = LV_TOTAL_SUM + GS_ITEM_ALV-DBMTR.

    ENDLOOP.



    GF_WMWST1 = LV_SUM_TAX.

    GF_BALANCE = GF_RMWWR - LV_TOTAL_SUM.



    CALL SCREEN 100.

  ENDIF.



  GV_FLAG_EVENT = ABAP_FALSE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHECK_BALANCE_STATUS

*&---------------------------------------------------------------------*




FORM CHECK_BALANCE_STATUS CHANGING P_LV_ICON_TEXT.

  "## ##/## ##

   IF GF_BALANCE EQ 0.

     P_LV_ICON_TEXT = 'ICON_GREEN_LIGHT'.

   ELSEIF GF_BALANCE NE 0.

     P_LV_ICON_TEXT = 'ICON_RED_LIGHT'.

   ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SIMULATION_BALANCE

*&---------------------------------------------------------------------*




FORM SIMULATION_BALANCE .

  IF GF_BALANCE NE 0.

    MESSAGE '### 0# ####. ### ## # ## #####.' TYPE 'I'.

    EXIT.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SAVE_INVOICE

*&---------------------------------------------------------------------*




FORM SAVE_INVOICE .

  DATA : LV_CNT TYPE I VALUE 0.



  IF GF_BALANCE NE 0.

    MESSAGE '### 0# #### ### # ####. ###### ## #####.' TYPE 'I'.

    EXIT.

  ENDIF.



  "##### #### ##

  LOOP AT GT_ITEM_ALV INTO GS_ITEM_ALV WHERE LV_CHECK = 'X'.

    LV_CNT = LV_CNT + 1.

  ENDLOOP.



  IF LV_CNT = 0.

    MESSAGE '#### ## ## #####.' TYPE 'I'.

    EXIT.

  ENDIF.



  "#### ##

  PERFORM GET_BELNR CHANGING GV_BELNR.



  "## ##

  PERFORM SAVE_HEADER.



  "### ##

  LOOP AT GT_ITEM_ALV INTO GS_ITEM_ALV WHERE LV_CHECK = 'X'.

    PERFORM INSERT_ITEM USING GS_ITEM_ALV.

  ENDLOOP.



  IF SY-SUBRC EQ 0.

    MESSAGE |#### { GV_BELNR }(#) ###### | TYPE 'S'.

  ENDIF.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  GET_BELNR

*&---------------------------------------------------------------------*




FORM GET_BELNR  CHANGING P_GV_BELNR.

  CALL FUNCTION 'NUMBER_GET_NEXT'

    EXPORTING

      NR_RANGE_NR = '10'

      OBJECT = 'ZBELNR09'

    IMPORTING

      NUMBER = P_GV_BELNR.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SAVE_HEADER

*&---------------------------------------------------------------------*




FORM SAVE_HEADER .

    CLEAR : GS_RBKP.



   "#### ###

    GS_RBKP-MANDT = SY-MANDT.

    GS_RBKP-BELNR = GV_BELNR. "## ###

    GS_RBKP-GJAHR = GF_BUDAT+0(4). "#### - #### ##

    GS_RBKP-BLART = 'RE'.     "#### RE

    GS_RBKP-BLDAT = GF_BLDAT.

    GS_RBKP-BUDAT = GF_BUDAT.



    "####, ######

    SELECT SINGLE BUKRS LIFNR

    FROM ZEKKO_09

    INTO ( GS_RBKP-BUKRS, GS_RBKP-LIFNR )

    WHERE EBELN = P_EBELNC.



    GS_RBKP-WAERS = GF_WAERS.

    GS_RBKP-RMWWR = GF_RMWWR. "#####

    GS_RBKP-WMWST1 = GF_WMWST1. "## ##

    GS_RBKP-MWSKZ = GF_MWSKZ. "####

    GS_RBKP-ZTERM = GF_ZTERM. "#### #

    GS_RBKP-BKTXT = GF_BKTXT. "## ## ###

    GS_RBKP-STBLG = ''. "####### (###### ##)

    GS_RBKP-STJAH = ''. "##### ####

    GS_RBKP-RBSTAT = 5. "## ###

    GS_RBKP-ZFBDT = GF_ZFBDT. "###



    "## #### #### #### ##

    INSERT INTO ZRBKP09 VALUES GS_RBKP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  INSERT_ITEM

*&---------------------------------------------------------------------*




FORM INSERT_ITEM  USING    P_GS_ITEM_ALV STRUCTURE GS_ITEM_ALV.

  CLEAR : GS_RSEG.



  GS_RSEG-MANDT = SY-MANDT.

  GS_RSEG-BELNR = GV_BELNR.

  GS_RSEG-GJAHR = GF_BUDAT+0(4).

  GS_RSEG-BUZEI = P_GS_ITEM_ALV-BUZEI. "##### ####

  GS_RSEG-EBELN = P_EBELNC.

  GS_RSEG-EBELP = P_GS_ITEM_ALV-EBELP. "PO ####

  GS_RSEG-MATNR = P_GS_ITEM_ALV-MATNR.

  GS_RSEG-WERKS = P_GS_ITEM_ALV-WERKS.

  GS_RSEG-WRBTR = P_GS_ITEM_ALV-WRBTR. "####




*  GS_RSEG-SHKZG = 'H'.  "### ##




  GS_RSEG-MENGE = P_GS_ITEM_ALV-MENGE.

  GS_RSEG-MEINS = P_GS_ITEM_ALV-MEINS.

  GS_RSEG-BPRME = P_GS_ITEM_ALV-MEINS. "###### (######)

  GS_RSEG-NETPR = P_GS_ITEM_ALV-NETPR. "##

  GS_RSEG-MWSKZ = GF_MWSKZ.

  GS_RSEG-SGTXT = P_GS_ITEM_ALV-SGTXT.

  GS_RSEG-WAERS = P_GS_ITEM_ALV-WAERS.

  GS_RSEG-WMWST = P_GS_ITEM_ALV-WMWST. "##

  GS_RSEG-DBMTR = P_GS_ITEM_ALV-DBMTR. "##



  INSERT INTO ZRSEG09 VALUES GS_RSEG.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT_200

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT_200 .

 CREATE OBJECT GC_ITEM_200

    EXPORTING

      CONTAINER_NAME              = 'CON2'.



  CREATE OBJECT GC_GRID_200

    EXPORTING

      I_PARENT          = GC_ITEM_200.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALL_ALV_200

*&---------------------------------------------------------------------*




FORM CALL_ALV_200 .



CALL METHOD GC_GRID_200->SET_TABLE_FOR_FIRST_DISPLAY

  CHANGING

    IT_OUTTAB                     = GT_ITEM_ALV_200

    IT_FIELDCATALOG               = GT_FIELDCAT.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_200

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_200 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'LV_CHECK'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CHECKBOX = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'BELNR'.

  GS_FIELDCAT-COLTEXT = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'GJAHR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'BUZEI'.

  GS_FIELDCAT-COLTEXT = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'NETPR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'WRBTR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'WMWST'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'DBMTR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'SGTXT'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 15.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 16.

  GS_FIELDCAT-FIELDNAME = 'SHKZG'.

  GS_FIELDCAT-COLTEXT = '#/##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA_200

*&---------------------------------------------------------------------*




FORM GET_DATA_200 .



  "#### ### ####

  CLEAR : GS_MIRO_LIST, GT_MIRO_LIST.



  SELECT

        DISTINCT

        a~BELNR

        a~BUDAT

  INTO CORRESPONDING FIELDS OF TABLE GT_MIRO_LIST

  FROM ZRBKP09 AS a

  INNER JOIN ZRSEG09 AS b ON a~BELNR = b~BELNR

  WHERE b~EBELN = P_EBELNS

  AND   b~WERKS = P_WERKSS.



   IF SY-SUBRC <> 0.

    MESSAGE '## ##### #### #### ##### #### ####' TYPE 'I'.

    STOP.

  ENDIF.








*  CLEAR : GS_ITEM_ALV_200, GT_ITEM_ALV_200.

*

*  "####

*  SELECT a~BELNR

*         a~GJAHR

*         b~BUZEI

*         b~EBELN

*         b~EBELP

*         b~MATNR

*         c~ZMATNAME

*         b~MENGE

*         b~MEINS

*         b~NETPR

*         b~WRBTR

*         b~WMWST

*         b~DBMTR

*         b~SGTXT

*         b~WAERS

*         b~SHKZG

*  FROM ZRBKP09 AS a

*  INNER JOIN ZRSEG09 AS b ON a~BELNR = b~BELNR

*  INNER JOIN ZMARA09 AS c ON b~MATNR = c~ZMATNR

*  INTO CORRESPONDING FIELDS OF TABLE GT_ITEM_ALV_200

*  WHERE b~EBELN = P_EBELNS

*  AND   b~WERKS = P_WERKSS.

*" AND   b~SHKZG = 'H'. "##### # ####

*

*  SORT GT_ITEM_ALV_200 BY BELNR.




ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DETERMINE_CANCEL_TYPE

*&---------------------------------------------------------------------*




FORM DETERMINE_CANCEL_TYPE  USING    PT_ITEM LIKE GT_ITEM_ALV_200

                            CHANGING PT_DECISION LIKE GT_CANCEL_DEC.

  "####### #### ##

  "## BELNR ### ## ### ### ### ### ## ## ##



  DATA : LS_ITEM LIKE GS_ITEM_ALV_200,

         LT_BELNR_LIST TYPE SORTED TABLE OF ZRBKP09-BELNR WITH UNIQUE KEY TABLE_LINE,

         LV_BELNR TYPE ZRBKP09-BELNR,

         LT_ALL LIKE TABLE OF GS_ITEM_ALV_200,  "## ###

         LT_CHECK LIKE TABLE OF GS_ITEM_ALV_200, "### ###

         LS_FIRST LIKE GS_ITEM_ALV_200.



  CLEAR : PT_DECISION.



  "### ##### belnr distinct ### ##

  LOOP AT PT_ITEM INTO LS_ITEM.

    IF LS_ITEM-LV_CHECK = 'X'.

      INSERT LS_ITEM-BELNR INTO TABLE LT_BELNR_LIST.

    ENDIF.

  ENDLOOP.



  "# belnr## ##/## ## ##

  LOOP AT LT_BELNR_LIST INTO LV_BELNR. "1,2..

    "## ###

    CLEAR : LT_ALL.

    LOOP AT PT_ITEM INTO LS_ITEM WHERE BELNR = LV_BELNR.

      APPEND LS_ITEM TO LT_ALL.

    ENDLOOP.



    "### ###

    CLEAR : LT_CHECK.

    LOOP AT PT_ITEM INTO LS_ITEM WHERE BELNR = LV_BELNR AND LV_CHECK = 'X'.

      APPEND LS_ITEM TO LT_CHECK.

    ENDLOOP.



    "#### ## # ## ## ##

    READ TABLE LT_ALL INTO LS_FIRST INDEX 1.



    CLEAR : GS_CANCEL_DEC.

    GS_CANCEL_DEC-BELNR = LV_BELNR.

    GS_CANCEL_DEC-GJAHR = LS_FIRST-GJAHR.



    IF LINES( LT_ALL ) EQ LINES( LT_CHECK ). "####

      GS_CANCEL_DEC-IS_FULL = ABAP_TRUE.

    ELSE. "####

      GS_CANCEL_DEC-IS_FULL = ABAP_FALSE.

    ENDIF.



    APPEND GS_CANCEL_DEC TO PT_DECISION.

  ENDLOOP.





ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT_200

*&---------------------------------------------------------------------*




FORM CLASS_EVENT_200 .

  CREATE OBJECT GO_EVENT_200.



  "### ###

  CALL METHOD GC_GRID_200->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



     SET HANDLER GO_EVENT_200->HANDLER_DATA_CHANGED_200 FOR GC_GRID_200.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED_200

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED_200  USING    P_ER_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                            P_E_ONF4

                                            P_E_ONF4_BEFORE

                                            P_E_ONF4_AFTER

                                            P_E_UCOMM.



  DATA : LS_MODI TYPE LVC_S_MODI.



  CLEAR : GS_ITEM_ALV_200.



  LOOP AT P_ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    READ TABLE GT_ITEM_ALV_200 INTO GS_ITEM_ALV_200 INDEX LS_MODI-ROW_ID.



    IF LS_MODI-FIELDNAME = 'LV_CHECK' AND LS_MODI-VALUE = 'X'.

      GS_ITEM_ALV_200-LV_CHECK = 'X'.

      MODIFY GT_ITEM_ALV_200 FROM GS_ITEM_ALV_200 INDEX SY-TABIX.

    ENDIF.

  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  PROCESS_FULL_REVERSAL

*&---------------------------------------------------------------------*




FORM PROCESS_FULL_REVERSAL  USING    P_GS_CANCEL_DEC_BELNR

                                     P_GS_CANCEL_DEC_GJAHR.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  PROCESS_PART_REVERSAL

*&---------------------------------------------------------------------*




FORM PROCESS_PART_REVERSAL  USING    PV_BELNR

                                     PV_GJAHR.

  "##### ### ##, ### #### #### ####

  DATA : LS_ORI_H TYPE ZRBKP09, "####

         LS_ORI_I TYPE ZRSEG09, "#####

         LS_NEW_I TYPE ZRSEG09, "#######

         LV_NEW_BELNR TYPE ZRBKP09-BELNR,

         LV_SUM_DBMTR TYPE ZRSEG09-DBMTR,

         LV_SUM_WMWST TYPE ZRSEG09-WMWST.





  "#### ## ##

  SELECT SINGLE *

  FROM ZRBKP09

  INTO LS_ORI_H

  WHERE BELNR = PV_BELNR

  AND   GJAHR = PV_GJAHR.



  "# #### ## ##

  PERFORM GET_BELNR CHANGING LV_NEW_BELNR.



  "# #### ### - ### #### ### ###

  LOOP AT GT_ITEM_ALV_200 INTO GS_ITEM_ALV_200

    WHERE BELNR = PV_BELNR

    AND   LV_CHECK = 'X'.



  "##### ##

  SELECT SINGLE *

    FROM ZRSEG09

    INTO LS_ORI_I

    WHERE BELNR = PV_BELNR

    AND   GJAHR = PV_GJAHR

    AND   BUZEI = GS_ITEM_ALV_200-BUZEI.



    MOVE-CORRESPONDING LS_ORI_I TO LS_NEW_I.

    "# ####, ####(##/## ###, SHKZG# ###)

    LS_NEW_I-BELNR = LV_NEW_BELNR.

    LS_NEW_I-SHKZG = 'S'.

    LS_NEW_I-GJAHR = PV_GJAHR.



    "# #### ### insert

    INSERT ZRSEG09 FROM LS_NEW_I.



    "#### ###

    LV_SUM_DBMTR = LV_SUM_DBMTR + GS_ITEM_ALV_200-DBMTR.

    LV_SUM_WMWST = LV_SUM_WMWST + GS_ITEM_ALV_200-WMWST.



  ENDLOOP.



  "# #### ##

  DATA : LS_NEW_H TYPE ZRBKP09.

  LS_NEW_H-MANDT  = SY-MANDT.

  LS_NEW_H-BELNR  = LV_NEW_BELNR.

  LS_NEW_H-GJAHR  = PV_GJAHR.

  LS_NEW_H-BLART  = 'RC'.       "## ####

  LS_NEW_H-BLDAT  = SY-DATUM.

  LS_NEW_H-BUDAT  = SY-DATUM.

  LS_NEW_H-BUKRS  = LS_ORI_H-BUKRS.

  LS_NEW_H-LIFNR  = LS_ORI_H-LIFNR.

  LS_NEW_H-WAERS  = LS_ORI_H-WAERS.

  LS_NEW_H-RMWWR  = LV_SUM_DBMTR.

  LS_NEW_H-WMWST1 = LV_SUM_WMWST.

  LS_NEW_H-MWSKZ  = LS_ORI_H-MWSKZ.

  LS_NEW_H-ZTERM  = LS_ORI_H-ZTERM.

  LS_NEW_H-BKTXT  = |####-{ PV_BELNR }|.

  LS_NEW_H-RBSTAT = 5.          "###

  LS_NEW_H-STBLG  = ''.         "##### ##

  LS_NEW_H-STJAH  = ''.         "##### ##

  LS_NEW_H-ZFBDT  = LS_ORI_H-ZFBDT.



  INSERT ZRBKP09 FROM LS_NEW_H.



  MESSAGE |## { PV_BELNR }# #### ## { LV_NEW_BELNR } ####### | TYPE 'I'.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  VALIDATE_CANCEL

*&---------------------------------------------------------------------*




FORM VALIDATE_CANCEL  USING P_MATNAME P_REMAIN

                              CHANGING P_SUBRC.

  "###### ## ##

  DATA : LS_SELECTED LIKE GS_ITEM_ALV_200,

         LT_SELECTED LIKE TABLE OF LS_SELECTED,

         LV_H_SUM    TYPE MENGE_D,

         LV_S_SUM    TYPE MENGE_D,

         LV_REMAIN   TYPE MENGE_D.



  "### ## ###

  CLEAR : LS_SELECTED.

  LOOP AT GT_ITEM_ALV_200 INTO LS_SELECTED WHERE LV_CHECK = 'X'.

    APPEND LS_SELECTED TO LT_SELECTED.

  ENDLOOP.



  CLEAR : LS_SELECTED.

  LOOP AT LT_SELECTED INTO LS_SELECTED.



    "## ## ######## ##

    CLEAR : LV_H_SUM, LV_S_SUM, LV_REMAIN.

    BREAK-POINT.

    "### (H)

    SELECT SUM( MENGE )

    FROM ZRSEG09

    INTO LV_H_SUM

    WHERE EBELN = LS_SELECTED-EBELN

    AND   EBELP = LS_SELECTED-EBELP

    AND   SHKZG = 'H'.



    "### (S)

    SELECT SUM( MENGE )

    FROM ZRSEG09

    INTO LV_S_SUM

    WHERE EBELN = LS_SELECTED-EBELN

    AND   EBELP = LS_SELECTED-EBELP

    AND   SHKZG = 'S'.



    IF LV_H_SUM IS INITIAL. LV_H_SUM = 0. ENDIF.

    IF LV_S_SUM IS INITIAL. LV_S_SUM = 0. ENDIF.



    LV_REMAIN = LV_H_SUM - LV_S_SUM. "## ####



    "#### ##

    IF LV_REMAIN <= 0.

      P_SUBRC = 3.

      P_MATNAME = LS_SELECTED-ZMATNAME.

      RETURN.

    ENDIF.



    "### ## ### #### ##

    IF LS_SELECTED-MENGE > LV_REMAIN.

      P_SUBRC = 4.

      P_MATNAME = LS_SELECTED-ZMATNAME.

      P_REMAIN = LV_REMAIN.

      RETURN.

    ENDIF.



    P_SUBRC = 0. "####

  ENDLOOP.







ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHECK_BELNR

*&---------------------------------------------------------------------*




FORM CHECK_BELNR CHANGING P_SUBRC.



    DATA: LT_BELNR TYPE SORTED TABLE OF ZRBKP09-BELNR

                       WITH UNIQUE KEY table_line.



    CLEAR LT_BELNR.

    P_SUBRC = 0.



    LOOP AT GT_ITEM_ALV_200 INTO GS_ITEM_ALV_200 WHERE LV_CHECK = 'X'.

      INSERT GS_ITEM_ALV_200-BELNR INTO TABLE LT_BELNR.

    ENDLOOP.



    IF lines( LT_BELNR ) > 1.

      P_SUBRC = 1.

      RETURN.

    ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DELETE_DATA

*&---------------------------------------------------------------------*




FORM DELETE_DATA .

  DATA : LS_SELECTED LIKE GS_ITEM_ALV_200,

         LT_SELECTED LIKE TABLE OF LS_SELECTED,

         LT_ALL LIKE TABLE OF GS_ITEM_ALV_200, "## ###

         LT_CHECK LIKE TABLE OF GS_ITEM_ALV_200, "### ###

         IS_FULL_DELETE TYPE ABAP_BOOL,          "#### = 'X'

         LV_BELNR TYPE ZRBKP09-BELNR.



  "#### = ####

  IS_FULL_DELETE = ABAP_FALSE.



  "### BELNR ####

  CLEAR : LV_BELNR, GS_ITEM_ALV_200.

  READ TABLE GT_ITEM_ALV_200 WITH KEY LV_CHECK = 'X'

                             INTO GS_ITEM_ALV_200

                             TRANSPORTING BELNR.

  IF SY-SUBRC = 0.

    LV_BELNR = GS_ITEM_ALV_200-BELNR.

  ENDIF.



  "##/## ## ##

  CLEAR : GS_ITEM_ALV_200, LT_ALL.

  LOOP AT GT_ITEM_ALV_200 INTO GS_ITEM_ALV_200 WHERE BELNR = LV_BELNR.

    APPEND GS_ITEM_ALV_200 TO LT_ALL.

  ENDLOOP.



  CLEAR : GS_ITEM_ALV_200, LT_CHECK.

  LOOP AT GT_ITEM_ALV_200 INTO GS_ITEM_ALV_200 WHERE BELNR = LV_BELNR AND LV_CHECK = 'X'.

    APPEND GS_ITEM_ALV_200 TO LT_CHECK.

  ENDLOOP.



  IF LINES( LT_ALL ) EQ LINES( LT_CHECK ).

    IS_FULL_DELETE = ABAP_TRUE. "####

  ENDIF.



  IF IS_FULL_DELETE = ABAP_TRUE.

    "#### - #### ## ##

    DELETE FROM ZRBKP09 WHERE BELNR = LV_BELNR.

    DELETE FROM ZRSEG09 WHERE BELNR = LV_BELNR.

    DELETE GT_ITEM_ALV_200 WHERE BELNR = LV_BELNR.



  ELSEIF IS_FULL_DELETE = ABAP_FALSE.

    "####

     CLEAR : GS_ITEM_ALV_200.

     LOOP AT LT_CHECK INTO GS_ITEM_ALV_200.

       DELETE FROM ZRSEG09 WHERE BELNR = GS_ITEM_ALV_200-BELNR AND BUZEI = GS_ITEM_ALV_200-BUZEI.

       DELETE GT_ITEM_ALV_200 WHERE BELNR = GS_ITEM_ALV_200-BELNR AND BUZEI = GS_ITEM_ALV_200-BUZEI.

     ENDLOOP.



  ENDIF.



  IF SY-SUBRC = 0.

    IF IS_FULL_DELETE = ABAP_TRUE.

      MESSAGE '## BELNR ### #######.' TYPE 'S'.

      RETURN.

    ELSE.

      MESSAGE |{ LINES( LT_CHECK ) }# ### #######.| TYPE 'S'.

      RETURN.

    ENDIF.

  ELSE.

    MESSAGE '## ## # ### ######.' TYPE 'E'.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALCULATE_BALANCE

*&---------------------------------------------------------------------*




FORM CALCULATE_BALANCE .

  DATA: LV_SUM_TAX    TYPE P DECIMALS 2,

        LV_TOTAL_SUM  TYPE P DECIMALS 2.



  CLEAR: LV_SUM_TAX, LV_TOTAL_SUM.



  " ## ### ## ##

  LOOP AT GT_ITEM_ALV INTO GS_ITEM_ALV.

    LV_SUM_TAX    = LV_SUM_TAX    + GS_ITEM_ALV-WMWST.

    LV_TOTAL_SUM  = LV_TOTAL_SUM  + GS_ITEM_ALV-DBMTR.

  ENDLOOP.



" GF_WMWST1 = LV_SUM_TAX.

  GF_BALANCE = GF_RMWWR - LV_TOTAL_SUM.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_200

*&---------------------------------------------------------------------*




FORM MODIFY_DATA_200 .

  CLEAR : GS_MIRO_LIST.





  LOOP AT GT_MIRO_LIST INTO GS_MIRO_LIST.

    "#### ( ### )# ###



      CONCATENATE GS_MIRO_LIST-BELNR

             ' (' GS_MIRO_LIST-BUDAT ')'

        INTO GS_MIRO_ALV-DISP_TEXT.



      APPEND GS_MIRO_ALV TO GT_MIRO_ALV.



    CLEAR : GS_MIRO_LIST.



  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT_MIRO

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT_MIRO.

  CREATE OBJECT GC_CUSTOM_MIRO_LIST

    EXPORTING

      CONTAINER_NAME              = 'CON1'.



  CREATE OBJECT GC_GRID_MIRO_LIST

    EXPORTING

      I_PARENT          = GC_CUSTOM_MIRO_LIST.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_MIRO_LIST

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_MIRO_LIST .

  CLEAR : GS_FIELDCAT_200, GT_FIELDCAT_200.

  GS_FIELDCAT_200-COL_POS = 1.

  GS_FIELDCAT_200-FIELDNAME = 'DISP_TEXT'.

  GS_FIELDCAT_200-COLTEXT = '#### (###) '.

  GS_FIELDCAT_200-OUTPUTLEN = 50.

  APPEND GS_FIELDCAT_200 TO GT_FIELDCAT_200.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALL_ALV_MIRO_LIST

*&---------------------------------------------------------------------*




FORM CALL_ALV_MIRO_LIST .



  CALL METHOD GC_GRID_MIRO_LIST->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IT_TOOLBAR_EXCLUDING = GT_TOOLBAR

    CHANGING

      IT_OUTTAB                     = GT_MIRO_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT_200.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT_MIRO_LIST

*&---------------------------------------------------------------------*




FORM CLASS_EVENT_MIRO_LIST .

  CREATE OBJECT GO_EVENT_MIRO.



  SET HANDLER GO_EVENT_MIRO->HANDLER_DOUBLE_CLICK_MIRO FOR GC_GRID_MIRO_LIST.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DOUBLE_CLICK_MIRO

*&---------------------------------------------------------------------*




FORM ALV_HANDLER_DOUBLE_CLICK_MIRO  USING    P_E_ROW  TYPE LVC_S_ROW "Line ID

                                             P_E_COLUMN TYPE LVC_S_COL "Column Name

                                             P_ES_ROW_NO TYPE LVC_S_ROID.



  CLEAR : GS_MIRO_LIST.

  READ TABLE GT_MIRO_LIST INTO GS_MIRO_LIST INDEX P_ES_ROW_NO-ROW_ID.

   IF SY-SUBRC <> 0.

     MESSAGE '## ###### ##### ### ######' TYPE 'I'.

     RETURN.

   ENDIF.



  PERFORM GET_HEADER_AND_ITEMS USING GS_MIRO_LIST-BELNR.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_HEADER_AND_ITEMS

*&---------------------------------------------------------------------*




FORM GET_HEADER_AND_ITEMS  USING    P_GS_MIRO_LIST_BELNR.



  "#### ####

  CLEAR : GS_HEADER_ALV.



  SELECT SINGLE

    BELNR

    BLART

    BLDAT

    BUDAT

  FROM ZRBKP09

  INTO CORRESPONDING FIELDS OF GS_HEADER_ALV

  WHERE BELNR = P_GS_MIRO_LIST_BELNR.



  "##### ## ####





  CLEAR : GS_ITEM_ALV_200, GT_ITEM_ALV_200.



  "####

  SELECT a~BELNR

         a~GJAHR

         b~BUZEI

         b~EBELN

         b~EBELP

         b~MATNR

         c~ZMATNAME

         b~MENGE

         b~MEINS

         b~NETPR

         b~WRBTR

         b~WMWST

         b~DBMTR

         b~SGTXT

         b~WAERS

         b~SHKZG

  FROM ZRBKP09 AS a

  INNER JOIN ZRSEG09 AS b ON a~BELNR = b~BELNR

  INNER JOIN ZMARA09 AS c ON b~MATNR = c~ZMATNR

  INTO CORRESPONDING FIELDS OF TABLE GT_ITEM_ALV_200

  WHERE  a~BELNR = P_GS_MIRO_LIST_BELNR. "### ### ## ###

" AND   b~SHKZG = 'H'. "##### # ####





  CALL SCREEN 200.



ENDFORM.