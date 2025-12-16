
*&---------------------------------------------------------------------*

*&  Include           ZPRO11_001_CLS

*&---------------------------------------------------------------------*

*& ALV Grid ### ### ### ##

*&---------------------------------------------------------------------*



*----------------------------------------------------------------------*

* CLASS lcl_alv_event_handler DEFINITION

*----------------------------------------------------------------------*




CLASS lcl_alv_event_handler DEFINITION.

  PUBLIC SECTION.

    METHODS:

      on_data_changed FOR EVENT data_changed OF cl_gui_alv_grid

        IMPORTING

          er_data_changed

          e_onf4

          e_onf4_before

          e_onf4_after

          e_ucomm.

ENDCLASS.






*----------------------------------------------------------------------*

* CLASS lcl_alv_event_handler IMPLEMENTATION

*----------------------------------------------------------------------*




CLASS lcl_alv_event_handler IMPLEMENTATION.

  METHOD on_data_changed.

    PERFORM handle_alv_data_changed

      USING er_data_changed

            e_onf4

            e_onf4_before

            e_onf4_after

            e_ucomm.

  ENDMETHOD.

ENDCLASS.