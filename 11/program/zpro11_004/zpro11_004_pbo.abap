
*&---------------------------------------------------------------------*

*&  Include           ZPRO11_004_PBO

*&---------------------------------------------------------------------*

*& Process Before Output ##

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       ## ## ## ## ##

*----------------------------------------------------------------------*




MODULE status_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'TITLE_100'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  INIT_ALV_0100  OUTPUT

*&---------------------------------------------------------------------*

*       ## ## ALV ### # ##

*----------------------------------------------------------------------*




MODULE init_alv_0100 OUTPUT.

  IF go_dock_cont IS INITIAL.

    PERFORM init_alv_container.

    PERFORM build_fieldcat_process.

    PERFORM set_alv_layout.

    PERFORM set_alv_sort.

    PERFORM show_alv_process.

  ELSE.

    PERFORM refresh_alv_display.

  ENDIF.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       ## ## ## ## ##

*----------------------------------------------------------------------*




MODULE status_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'TITLE_200'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  INIT_ALV_0200  OUTPUT

*&---------------------------------------------------------------------*

*       ## ## ALV ### # ##

*----------------------------------------------------------------------*




MODULE init_alv_0200 OUTPUT.

  IF go_dock_cont IS INITIAL.

    PERFORM init_alv_container.

    PERFORM build_fieldcat_search.

    PERFORM set_alv_layout.

    PERFORM set_alv_sort.

    PERFORM show_alv_search.

  ELSE.

    PERFORM refresh_alv_display.

  ENDIF.

ENDMODULE.