
*&---------------------------------------------------------------------*

*&  Include           ZWORK25_002_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  " GUI STATUS 'S100' (PDF_DOWN ## ##)

  SET PF-STATUS 'S100'.

  SET TITLEBAR 'T100'.

ENDMODULE.



MODULE CREATE_ALV OUTPUT.

  PERFORM CREATE_ALV_OBJECT.

  PERFORM SET_ALV_LAYOUT.

  PERFORM SET_ALV_FIELDCAT.

  PERFORM DISPLAY_ALV.

ENDMODULE.