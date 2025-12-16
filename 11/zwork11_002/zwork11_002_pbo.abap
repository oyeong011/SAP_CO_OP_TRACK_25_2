
*&---------------------------------------------------------------------*

*& Include ZWORK11_002_PBO

*&---------------------------------------------------------------------*




MODULE status_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.

ENDMODULE.



MODULE set_alv OUTPUT.

  PERFORM init_alv.

ENDMODULE.