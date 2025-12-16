
*&---------------------------------------------------------------------*

*&  Include           ZPRO11_002_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       ## ## ## ##

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       ## ## ## ##

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T200'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       #### ALV ##

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  IF go_dock IS INITIAL.

    PERFORM init_container.

    PERFORM set_fieldcat.

    PERFORM set_variant.

    PERFORM set_sort.

    PERFORM set_event_handler.

    PERFORM display_alv.

  ELSE.

    PERFORM refresh_alv.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_DISP  OUTPUT

*&---------------------------------------------------------------------*

*       #### ALV ##

*----------------------------------------------------------------------*




MODULE SET_ALV_DISP OUTPUT.

  PERFORM init_container.

  PERFORM set_fieldcat_disp.

  PERFORM set_variant.

  PERFORM set_sort.

  PERFORM display_alv_disp.

ENDMODULE.