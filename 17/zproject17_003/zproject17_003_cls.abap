
CLASS lcl_alv_event_receiver DEFINITION.

  PUBLIC SECTION.

    METHODS handle_data_changed

      FOR EVENT data_changed OF cl_gui_alv_grid

      IMPORTING er_data_changed e_ucomm.

ENDCLASS.



CLASS lcl_alv_event_receiver IMPLEMENTATION.

  METHOD handle_data_changed.

    PERFORM alv_handle_data_changed USING er_data_changed.

  ENDMETHOD.

ENDCLASS.