
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_004_PBO

*&---------------------------------------------------------------------*




MODULE status_0100 OUTPUT.

  SET PF-STATUS 'S0100'.

  SET TITLEBAR  'T0100'.

ENDMODULE.



MODULE init_0100 OUTPUT.

  p_budat = gv_budat.

  zedt17_rbkp-budat = gv_budat.

  " ## ##(EBELN/WERKS/BUDAT) ## ##

  PERFORM disable_header_fields.



  PERFORM get_data_for_invoice_0100.



  IF go_container IS INITIAL.

    PERFORM create_object_0100.

    PERFORM alv_display_0100.

  ELSE.

    PERFORM refresh_alv_0100.

  ENDIF.



ENDMODULE.



MODULE status_0200 OUTPUT.

  SET PF-STATUS 'S0200'.

  SET TITLEBAR  'T0200'.



  IF go_container_200 IS INITIAL.

    PERFORM create_object_0200.

    PERFORM alv_display_0200.

  ELSE.

    PERFORM refresh_alv_0200.

  ENDIF.

ENDMODULE.





MODULE init_0200 OUTPUT.



  " ## ## ## ## ##(###)

  PERFORM disable_header_fields.



  " ## ###

  PERFORM get_data_for_display_0200.



  " ALV ##/## ## ####

  IF go_container_200 IS INITIAL.

    PERFORM create_object_0200.

    PERFORM alv_display_0200.

  ELSE.

    PERFORM refresh_alv_0200.

  ENDIF.



ENDMODULE.