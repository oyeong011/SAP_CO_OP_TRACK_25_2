
*&---------------------------------------------------------------------*

*&  Include           ZEDR07_022_CLS

*&---------------------------------------------------------------------*




CLASS event DEFINITION.

  PUBLIC SECTION.

  METHODS handler_toolbar FOR EVENT toolbar

    of cl_gui_alv_grid

    IMPORTING e_object

      e_interactive.



  METHODS handler_user_command FOR EVENT user_command

    of cl_gui_alv_grid

    IMPORTING e_ucomm.



  METHODS handler_hotspot_click FOR EVENT hotspot_click of cl_gui_alv_grid

                              IMPORTING e_row_id e_column_id es_row_no.



  METHODS handler_double_click FOR EVENT double_click OF cl_gui_alv_grid

                              IMPORTING e_row e_column es_row_no.



  METHODS handler_data_changed FOR EVENT data_changed of cl_gui_alv_grid

                              IMPORTING er_data_changed e_onf4 e_onf4_before e_onf4_after e_ucomm.



  METHODS handler_data_changed_finished FOR EVENT data_changed_finished of cl_gui_alv_grid

                              IMPORTING e_modified et_good_cells.

ENDCLASS.



CLASS event IMPLEMENTATION.

  METHOD handler_toolbar.

    PERFORM alv_handler_toolbar USING e_object

          e_interactive.



  ENDMETHOD.



  METHOD handler_user_command.

    PERFORM alv_handler_user_command USING e_ucomm.

  ENDMETHOD.



  METHOD handler_hotspot_click.

    PERFORM alv_handler_hotspot_clisk USING e_row_id e_column_id es_row_no.

  ENDMETHOD.



  METHOD handler_double_click.

    PERFORM alv_handler_double_click USING e_row e_column es_row_no.

  ENDMETHOD.



  METHOD handler_data_changed.

    PERFORM alv_handler_data_changed USING er_data_changed e_onf4 e_onf4_before e_onf4_after e_ucomm.

  ENDMETHOD.



  METHOD handler_data_changed_finished.

    PERFORM alv_data_changed_finished USING e_modified et_good_cells.

  ENDMETHOD.

ENDCLASS.