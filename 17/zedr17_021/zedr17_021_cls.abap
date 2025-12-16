
*&---------------------------------------------------------------------*

*&  Include           ZEDR17_021_CLS

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

endclass.




*&---------------------------------------------------------------------*

*&       Class (Implementation)  event

*&---------------------------------------------------------------------*

*        Text

*----------------------------------------------------------------------*




class event implementation. " ### ## - class event ## ###### ## ## ##

  method handler_toolbar. " ##### ### ##### ### ## ###

    perform alv_handler_toolbar using e_object " method ### perform ##

                                      e_interactive.

  endmethod.

  method handler_user_command.

    perform alv_hander_user_command using e_ucomm. " method ### perform ##

  endmethod.

endclass.               "event