
*&---------------------------------------------------------------------*

*&  Include           ZMM09_003_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  GET_DATA OUTPUT

*&---------------------------------------------------------------------*




MODULE GET_DATA OUTPUT.

  "####



  "###

   GF_BUDAT = P_BUDAT.



  "####

  GF_MJAHR = GF_BUDAT+0(4).



  "###

  SELECT SINGLE BEDAT

  FROM ZEKKO_09

  INTO GF_BLDAT

  WHERE EBELN = P_EBELNC.



  "####

  GF_BLART = 'WE'.



  "###### ###

  IF G_ONCE IS INITIAL.

    PERFORM GET_ITAB.

    G_ONCE = 'X'.

  ENDIF.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  MODIFY_SCREEN  OUTPUT

*&---------------------------------------------------------------------*




MODULE MODIFY_SCREEN OUTPUT.

  CLEAR : OK_CODE.



  "## #### ###### ## ####

  DESCRIBE TABLE GT_ITEM LINES TC_ITEMS-LINES.



  "######## ###### #### ####

  READ TABLE GT_ITEM INTO GS_ITEM INDEX TC_ITEMS-CURRENT_LINE.



ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T200'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  SET_GOODS_LIST  OUTPUT

*&---------------------------------------------------------------------*




"#######

MODULE SET_GOODS_LIST OUTPUT.

  PERFORM CREATE_OBJECT_GOODS.

  PERFORM FIELD_CATALOG.

  PERFORM DELETE_TOOLBAR.

  PERFORM CLASS_EVENT.

  PERFORM CALL_ALV.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  SET_HEADER  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_HEADER OUTPUT.

  MBLNR_200 = GS_HEADER_ALV-MBLNR.

  BLART_200 = GS_HEADER_ALV-BLART.

  BLDAT_200 = GS_HEADER_ALV-BLDAT.

  BUDAT_200 = GS_HEADER_ALV-BUDAT.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  SET_ITEMS  OUTPUT

*&---------------------------------------------------------------------*




MODULE SET_ITEMS OUTPUT.



"#### ###

PERFORM FILL_CANCEL_STATUS.



IF GC_GRID_GOODS_ITEM IS INITIAL.

  PERFORM CREATE_OBJECT_ITEMS.

  PERFORM FIELD_CATALOG_ITEMS.

  PERFORM CLASS_EVENT_ITEMS.

  PERFORM LATOUT_ITEMS.



  "#### ###

  PERFORM FILL_CANCEL_STATUS.



  PERFORM CALL_ALV_ITEMS.

ELSE.

  PERFORM SET_CELL_STYLE. "### ##

  GC_GRID_GOODS_ITEM->REFRESH_TABLE_DISPLAY( ).

ENDIF.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  CONTROL_BUTTONS  OUTPUT

*&---------------------------------------------------------------------*




MODULE CONTROL_BUTTONS OUTPUT.

  "#### #### (101) -> FI## ### ##, ### ## ###

  "### ## (102# ### ##) -> # ## ## ##, ## # ### ## ####



  DATA : LV_CANCEL_EXISTS TYPE ABAP_BOOL,

         LV_TMP TYPE ZMSEG09-MBLNR,

         LV_HEADER_MBLNR TYPE ZMSEG09-MBLNR.



  CLEAR : LV_CANCEL_EXISTS.

  LV_HEADER_MBLNR = GS_HEADER_ALV-MBLNR.



  " #### ## ## ##

  SELECT SINGLE MBLNR

  FROM ZMSEG09

  INTO LV_TMP

  WHERE LFBNR = LV_HEADER_MBLNR "LFBNR : ### #### ##, ## ##### ####

  AND BWART = '102'.



  IF SY-SUBRC = 0. "##### ###

    LV_CANCEL_EXISTS = ABAP_TRUE.

  ENDIF.



  LOOP AT SCREEN.

    "FI ## ### ## ##

    IF SCREEN-NAME = 'BTN_FI'.

      SCREEN-ACTIVE = '1'.

      MODIFY SCREEN.

    ENDIF.



    "### ### ##### ## ## ##

    IF SCREEN-NAME = 'BTN_REVERSAL'.

      IF LV_CANCEL_EXISTS = ABAP_TRUE.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.



      MODIFY SCREEN.

    ENDIF.



  ENDLOOP.





ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  STATUS_0300  OUTPUT

*&---------------------------------------------------------------------*




MODULE STATUS_0300 OUTPUT.

 "SET PF-STATUS 'STATUS_0300'.

  SET PF-STATUS 'STATUS_0300_2'.

  SET TITLEBAR 'T300'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  SET_FI_LIST  OUTPUT

*&---------------------------------------------------------------------*




MODULE SET_FI_LIST OUTPUT.

  PERFORM SHOW_FI_LIST.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  STATUS_0400  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0400 OUTPUT.

 "SET PF-STATUS 'STATUS_0400'.

  SET TITLEBAR 'T0400'.



  DATA : LS_SEL_MSEG TYPE ZMSEG09,

         LT_SEL_MSEG LIKE TABLE OF LS_SEL_MSEG.



  CLEAR : LS_SEL_MSEG, LT_SEL_MSEG.



  "### ##### ### ##

  LOOP AT GT_ITEM_ALV INTO GS_ITEM_ALV WHERE LV_CHECK = 'X'.

    SELECT SINGLE *

    FROM ZMSEG09

    INTO CORRESPONDING FIELDS OF LS_SEL_MSEG

    WHERE MBLNR = GS_HEADER_ALV-MBLNR

    AND   ZEILE = GS_ITEM_ALV-ZEILE.



    IF SY-SUBRC = 0.

      APPEND LS_SEL_MSEG TO LT_SEL_MSEG.

    ENDIF.

  ENDLOOP.



 "[### ## ##] ## ## ##

  DATA : LV_CANCEL TYPE ABAP_BOOL VALUE ABAP_FALSE.



  CLEAR : LV_CANCEL.



  LOOP AT LT_SEL_MSEG INTO LS_SEL_MSEG WHERE BWART = '101'. "## ## #### ####

    IF LS_SEL_MSEG-ZCANCEL_FLAG = 'X'.

      LV_CANCEL = ABAP_TRUE. "######## ### ##

      EXIT.

    ENDIF.

  ENDLOOP.





  IF LV_CANCEL = ABAP_TRUE.

    SET PF-STATUS 'S400_REV'.    "### ## ## & Cancel ##

  ELSE.

    SET PF-STATUS 'STATUS_0400'. "Cancel ###

  ENDIF.





ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  PBO_0400  OUTPUT

*&---------------------------------------------------------------------*




MODULE PBO_0400 OUTPUT.

  PERFORM PREPARE_FI_DISPLAY.

  PERFORM GET_BKPF.

  PERFORM GET_BSEG.

  PERFORM SHOW_BSEG_ALV.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  STATUS_0410  OUTPUT

*&---------------------------------------------------------------------*




MODULE STATUS_0410 OUTPUT.

  SET PF-STATUS 'STATUS_0410'.

  SET TITLEBAR 'T410'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  PBO_0410  OUTPUT

*&---------------------------------------------------------------------*




MODULE PBO_0410 OUTPUT.



  DATA : LT_TOOLBAR TYPE UI_FUNCTIONS.



  IF GO_CONT_410 IS INITIAL.



    CREATE OBJECT GO_CONT_410

      EXPORTING CONTAINER_NAME = 'CC_REV_LIST'.



    CREATE OBJECT GO_ALV_410

      EXPORTING I_PARENT = GO_CONT_410.



    PERFORM BUILD_FCAT_410.



    "## ### ###

    APPEND CL_GUI_ALV_GRID=>MC_FC_EXCL_ALL TO LT_TOOLBAR.



    "### ## ## ## -> #####, ### ##### #### ##### #### ## ####

    PERFORM CLASS_EVENT_410.



    CALL METHOD GO_ALV_410->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING

        IT_TOOLBAR_EXCLUDING = LT_TOOLBAR

      CHANGING

        IT_OUTTAB       = GT_REV_BELNR

        IT_FIELDCATALOG = GT_FCAT_410.



  ELSE.

    GO_ALV_410->REFRESH_TABLE_DISPLAY( ).

  ENDIF.



ENDMODULE.