
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_001_CLS

*&---------------------------------------------------------------------*






CLASS lcl_event_handler DEFINITION.

  PUBLIC SECTION.



    " ### ## ###

    METHODS handler_data_changed

                  FOR EVENT data_changed OF cl_gui_alv_grid

      IMPORTING er_data_changed.



    " ## ## ###

    METHODS on_toolbar

                  FOR EVENT toolbar OF cl_gui_alv_grid

      IMPORTING e_object e_interactive.



    " ### ### ###

    METHODS on_user_command

                  FOR EVENT user_command OF cl_gui_alv_grid

      IMPORTING e_ucomm.



ENDCLASS.





CLASS lcl_event_handler IMPLEMENTATION.



  METHOD handler_data_changed.

    PERFORM alv_handle_data_changed USING er_data_changed.

  ENDMETHOD.



  METHOD on_toolbar.

    PERFORM alv_handle_toolbar USING e_object e_interactive.

  ENDMETHOD.



  METHOD on_user_command.

    PERFORM alv_handle_user_command USING e_ucomm.

  ENDMETHOD.



ENDCLASS.