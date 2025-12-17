
*&---------------------------------------------------------------------*

*&  Include           ZMM09_004_PBO

*&---------------------------------------------------------------------*






MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  SET_DYNNR  OUTPUT

*&---------------------------------------------------------------------*




MODULE SET_DYNNR OUTPUT.

  CASE TABSTRIP-ACTIVETAB.

    WHEN 'TAB1'.

      DYNNR = '0101'.

    WHEN 'TAB2'.

      DYNNR = '0102'.

    WHEN OTHERS.

      DYNNR = '0101'.

      TABSTRIP-ACTIVETAB = 'TAB1'.

  ENDCASE.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  SET_DROPDOWN  OUTPUT

*&---------------------------------------------------------------------*




MODULE SET_DROPDOWN OUTPUT.

  PERFORM SET_DROPDOWN_TAX.  "####

  PERFORM SET_DROPDOWN_ZTERM. "####

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  SET_HEADER_AND_ITEMS  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_HEADER_AND_ITEMS OUTPUT.

  PERFORM SET_HEADER.

  PERFORM SET_ITEMS.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  SET_ICON  OUTPUT

*&---------------------------------------------------------------------*




MODULE SET_ICON OUTPUT.

  DATA : LV_ICON_TEXT TYPE STRING.



  " ## ## ### ## ##

  IF gv_need_balance_calc = abap_true.

    PERFORM CALCULATE_BALANCE.

    gv_need_balance_calc = abap_false. "## ## # ####

  ENDIF.



  "### ### # ##

  PERFORM CHECK_BALANCE_STATUS CHANGING LV_ICON_TEXT.



  CALL FUNCTION 'ICON_CREATE'

    EXPORTING

      NAME = LV_ICON_TEXT

    IMPORTING

      RESULT = ICON_ST1.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T200'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  SET_ITEMS  OUTPUT

*&---------------------------------------------------------------------*




MODULE SET_ITEMS OUTPUT.

  IF GC_GRID_200 IS INITIAL.

    PERFORM CREATE_OBJECT_200.

    PERFORM FIELD_CATALOG_200.

    PERFORM CLASS_EVENT_200.

    PERFORM CALL_ALV_200.

  ELSE.

    CALL METHOD GC_GRID_200->REFRESH_TABLE_DISPLAY.

  ENDIF.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  SET_MIRO_LIST  OUTPUT

*&---------------------------------------------------------------------*




MODULE SET_MIRO_LIST OUTPUT.

"#### ### ##



  PERFORM CREATE_OBJECT_MIRO.

  PERFORM FIELD_CATALOG_MIRO_LIST.

  PERFORM DELETE_TOOLBAR.

  PERFORM CLASS_EVENT_MIRO_LIST.

  PERFORM CALL_ALV_MIRO_LIST.



ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  SET_HEADER  OUTPUT

*&---------------------------------------------------------------------*




MODULE SET_HEADER OUTPUT.



  BELNR_200 = GS_HEADER_ALV-BELNR.

  BLART_200 = GS_HEADER_ALV-BLART.

  BLDAT_200 = GS_HEADER_ALV-BLDAT.

  BUDAT_200 = GS_HEADER_ALV-BUDAT.

ENDMODULE.