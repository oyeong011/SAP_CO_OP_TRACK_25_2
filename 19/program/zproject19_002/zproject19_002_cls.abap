
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT19_002_CLS

*&---------------------------------------------------------------------*






TYPES: BEGIN OF ty_f4,

         value TYPE lgort_d,

         text  TYPE dd07v-ddtext,

       END OF ty_f4.



DATA gv_f4_value TYPE lgort_d.   " F4## ### # ### ## ##



CLASS lcl_event_handler DEFINITION.

  PUBLIC SECTION.

    METHODS: on_f4

      FOR EVENT onf4 OF cl_gui_alv_grid

      IMPORTING

        e_fieldname

        es_row_no

        er_event_data

        et_bad_cells.

ENDCLASS.



CLASS lcl_event_handler IMPLEMENTATION.

  METHOD on_f4.

    PERFORM handle_f4 USING e_fieldname es_row_no er_event_data.

  ENDMETHOD.

ENDCLASS.