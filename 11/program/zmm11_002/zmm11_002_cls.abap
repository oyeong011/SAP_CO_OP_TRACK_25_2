
*&---------------------------------------------------------------------*

*& Include ZMM11_002_CLS

*&---------------------------------------------------------------------*




CLASS lcl_event_handler DEFINITION.

  PUBLIC SECTION.

    METHODS: on_f4_request FOR EVENT onf4 OF cl_gui_alv_grid

      IMPORTING e_fieldname es_row_no er_event_data.

ENDCLASS.



CLASS lcl_event_handler IMPLEMENTATION.

  METHOD on_f4_request.

    PERFORM exec_f4_matnr USING e_fieldname es_row_no er_event_data.

  ENDMETHOD.

ENDCLASS.