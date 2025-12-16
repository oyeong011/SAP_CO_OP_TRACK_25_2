
*&---------------------------------------------------------------------*

*&  Include           ZEDR11_014_PBO

*&---------------------------------------------------------------------*






MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS 0100'.

  SET TITLEBAR 'T100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  PERFORM field_catalog.

  PERFORM alv_layout.

  PERFORM alv_sort.

  PERFORM alv_display.

ENDMODULE.