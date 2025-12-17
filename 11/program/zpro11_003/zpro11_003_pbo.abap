
*&---------------------------------------------------------------------*

*&  Include           ZPRO11_003_PBO

*&---------------------------------------------------------------------*

*& Process Before Output ##

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Module  STATUS_100  OUTPUT

*&---------------------------------------------------------------------*




MODULE status_100 OUTPUT.

  SET PF-STATUS 'PF_100'.

  SET TITLEBAR 'TTL_100'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  STATUS_200  OUTPUT

*&---------------------------------------------------------------------*




MODULE status_200 OUTPUT.

  SET PF-STATUS 'PF_200'.

  SET TITLEBAR 'TTL_200'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  INIT_ALV_100  OUTPUT

*&---------------------------------------------------------------------*




MODULE init_alv_100 OUTPUT.

  IF go_dock IS INITIAL.

    PERFORM build_alv_container.

    PERFORM build_fcat_process.

    PERFORM set_alv_variant.

    PERFORM set_alv_sort.

    PERFORM show_alv_process.

  ELSE.

    PERFORM refresh_alv.

  ENDIF.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  INIT_ALV_200  OUTPUT

*&---------------------------------------------------------------------*




MODULE init_alv_200 OUTPUT.

  IF go_dock IS INITIAL.

    PERFORM build_alv_container.

    PERFORM build_fcat_history.

    PERFORM set_alv_variant.

    PERFORM set_alv_sort.

    PERFORM show_alv_history.

  ELSE.

    PERFORM refresh_alv.

  ENDIF.

ENDMODULE.