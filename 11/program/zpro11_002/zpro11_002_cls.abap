
*&---------------------------------------------------------------------*

*&  Include           ZPRO11_002_CLS

*&---------------------------------------------------------------------*




CLASS lcl_event DEFINITION.

  PUBLIC SECTION.

    METHODS handle_f4 FOR EVENT onf4 OF cl_gui_alv_grid

      IMPORTING

        e_fieldname

        es_row_no

        er_event_data

        et_bad_cells

        e_display.

ENDCLASS.



CLASS lcl_event IMPLEMENTATION.

  METHOD handle_f4.

    PERFORM process_alv_f4 USING e_fieldname

                                 es_row_no-row_id

                                 er_event_data

                                 et_bad_cells

                                 e_display.

  ENDMETHOD.

ENDCLASS.