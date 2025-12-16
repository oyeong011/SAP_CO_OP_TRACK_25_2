
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_002_CLS

*&---------------------------------------------------------------------*






CLASS lcl_event_handler DEFINITION.

  PUBLIC SECTION.



    " ALV ### ## ###

    METHODS handler_data_changed

      FOR EVENT data_changed OF cl_gui_alv_grid

      IMPORTING er_data_changed.



ENDCLASS.





CLASS lcl_event_handler IMPLEMENTATION.



  METHOD handler_data_changed.

    " ## ### ## ### FORM## ##

    PERFORM alv_handle_data_changed USING er_data_changed.

  ENDMETHOD.



ENDCLASS.