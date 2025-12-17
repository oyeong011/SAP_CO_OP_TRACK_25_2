
*&---------------------------------------------------------------------*

*&  Include           ZWORK17_002_CLS

*&---------------------------------------------------------------------*




CLASS event DEFINITION.

  PUBLIC SECTION.

    METHODS handler_toolbar

                  FOR EVENT toolbar OF cl_gui_alv_grid

      IMPORTING e_object e_interactive.



    METHODS handler_user_command

                  FOR EVENT user_command OF cl_gui_alv_grid

      IMPORTING e_ucomm.

ENDCLASS.



CLASS event IMPLEMENTATION.



  METHOD handler_toolbar.

    PERFORM alv_handler_toolbar USING e_object e_interactive.

  ENDMETHOD.



  METHOD handler_user_command.

    PERFORM alv_handler_user_command USING e_ucomm.

  ENDMETHOD.



ENDCLASS.