
*&---------------------------------------------------------------------*

*&  Include           ZEDR19_052_PB0

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



MODULE SET_ALV OUTPUT.



  PERFORM FIELD_CATALOG.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM ALV_DISPLAY.

ENDMODULE.