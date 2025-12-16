
*&---------------------------------------------------------------------*

*&  Include           ZEDR17_023_CLS

*&---------------------------------------------------------------------*




class event definition. "### ##

  public section.

    methods handler_toolbar for event toolbar " ### ### #

                  of cl_gui_alv_grid " se24 -> cl_gui_grid ##### #### ### ###

      importing e_object " ### #### (se24 -> cl_gui_grid## toolbar ### ## # ###### ##)

                  e_interactive. " ### #### (se24 -> cl_gui_grid## toolbar ### ## # ###### ##)

    methods handler_user_command for event user_command " ### #### ##

                  of cl_gui_alv_grid " se24 -> cl_gui_grid ##### #### ### ###

      importing e_ucomm. " ### ####(se24->cl_gui_grid## user_command ### ## # #### ##)

    methods handler_double_click for event double_click

                  of cl_gui_alv_grid

      importing e_row

                  e_column

                  es_row_no.

endclass.




*&---------------------------------------------------------------------*

*&       Class (Implementation)  event

*&---------------------------------------------------------------------*




class event implementation. " ### ## - class event ## ###### ## ## ##

  method handler_toolbar. " ##### ### ##### ### ## ###

    perform alv_handler_toolbar using e_object " method ### perform ##

                                      e_interactive.

  endmethod.

  method handler_user_command.

    perform alv_handler_user_command using e_ucomm. " method ### perform ##

  endmethod.

  method handler_double_click.

    perform alv_handler_double_click using e_row

                                         e_column

                                         es_row_no.

  endmethod.

endclass.               "event