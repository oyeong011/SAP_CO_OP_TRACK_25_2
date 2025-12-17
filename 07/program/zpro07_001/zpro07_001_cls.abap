
*&---------------------------------------------------------------------*

*&  Include           ZPRO07_001_CLS

*&---------------------------------------------------------------------*






CLASS event DEFINITION.

  PUBLIC SECTION.

  METHODS handler_data_changed FOR EVENT data_changed of cl_gui_alv_grid

                             IMPORTING er_data_changed e_onf4 e_onf4_before e_onf4_after e_ucomm.

ENDCLASS.



CLASS event IMPLEMENTATION.

  METHOD handler_data_changed.

    PERFORM alv_handler_data_changed USING er_data_changed e_onf4 e_onf4_before e_onf4_after e_ucomm.

  ENDMETHOD.

ENDCLASS.