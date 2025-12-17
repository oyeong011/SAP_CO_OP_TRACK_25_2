
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_001_PBO

*&---------------------------------------------------------------------*






module status_0100 output.



  SET PF-STATUS 'STATUS_0100'.          " SE41## ## ##

  IF gv_mode = c_mode_create.

    SET TITLEBAR 'T0100' WITH '##'.

  ELSE.

    SET TITLEBAR 'T0100' WITH '##'.

  ENDIF.



endmodule.



MODULE set_alv OUTPUT.



  IF go_container IS INITIAL.

    PERFORM create_object.

    PERFORM field_catalog_create.   " gv_mode # ## ## ## ###

    PERFORM alv_layout_create.

    PERFORM class_event_create.

    PERFORM alv_display_create.

  ELSE.

    PERFORM refresh_alv_create.

  ENDIF.



ENDMODULE.