
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_003_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE status_0100 OUTPUT.

  SET PF-STATUS 'S0100'.   " SE41## ## ## ##

  SET TITLEBAR 'T0100'.    " ### ## / ###



  IF go_container IS INITIAL.

    PERFORM create_object_0100.   " ####/ALV ##

    PERFORM alv_display_0100.     " ALV # ##

  ELSE.

    PERFORM refresh_alv_0100.     " ### ## # ####

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  INIT_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE init_0100 OUTPUT.



  " ## 0100 ## #, P_BUDAT # ## ###

  " selection-screen ## ### # gv_budat ### ## ##

  IF p_budat IS INITIAL AND gv_budat IS NOT INITIAL.

    p_budat = gv_budat.

  ENDIF.



  " ## ## ####

  PERFORM disable_header_fields.



  " 1) ### ##

    PERFORM get_data_for_receipt.



  " 2) ALV ##/## ## ####

  IF go_container IS INITIAL.

    PERFORM create_object_0100.

    PERFORM alv_display_0100.

  ELSE.

    PERFORM refresh_alv_0100.

  ENDIF.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE status_0200 OUTPUT.

  SET PF-STATUS 'S0200'.

  SET TITLEBAR 'T0200'.

   IF go_container_200 IS INITIAL.

    PERFORM create_object_0200.

    PERFORM alv_display_0200.

  ELSE.

    PERFORM refresh_alv_0200.

  ENDIF.

ENDMODULE.



MODULE init_0200 OUTPUT.



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