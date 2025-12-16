
*&---------------------------------------------------------------------*

*&  Include           ZEDR20_PROJECT004_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.

  LOOP AT SCREEN.

    CHECK screen-name <> 'TAB1' AND screen-name <> 'TAB2' AND screen-name <> 'PACKAGE1'.

    SCREEN-INPUT = 0.

    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0102  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0102 OUTPUT.




*  SET PF-STATUS 'xxxxxxxx'.

*  SET TITLEBAR 'xxx'.




  LOOP AT SCREEN.

    CHECK SCREEN-NAME <> 'GS_AMOUNT_HEADER-ZAMOUNT'.

    CHECK SCREEN-NAME <> 'GS_AMOUNT_HEADER-MWSKZ'.

    SCREEN-INPUT = 0.

    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0101  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0101 OUTPUT.




*  SET PF-STATUS 'xxxxxxxx'.

*  SET TITLEBAR 'xxx'.




  LOOP AT SCREEN.

    SCREEN-INPUT = 0.

    MODIFY SCREEN.

  ENDLOOP.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  IF GC_CUSTOM IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELD_CATALOG.

    PERFORM ALV_LAYOUT.

    PERFORM ALV_SORT.

    PERFORM CLASS_EVENT.

    PERFORM CALL_ALV.

  ELSE.

    PERFORM REFRESH.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0110  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0110 OUTPUT.

  SET PF-STATUS 'STATUS_0110'.




*  SET TITLEBAR 'xxx'.




  LOOP AT SCREEN.

    IF SCREEN-NAME = 'GV_CREDIT' OR SCREEN-NAME = 'GV_DEBIT' OR SCREEN-NAME = 'GS_AMOUNT_HEADER-ZBALANCE'.

      SCREEN-INPUT = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_POPUP_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_POPUP_ALV OUTPUT.

  IF GC_POPUP IS INITIAL.

    PERFORM CREATE_POPUP_OBJECT.

    PERFORM POPUP_FIELD_CATALOG.

    PERFORM CALL_POPUP_ALV.

  ELSE.

    PERFORM REFRESH_POPUP.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T200'.

  LOOP AT SCREEN.

    SCREEN-INPUT = 0.

    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.