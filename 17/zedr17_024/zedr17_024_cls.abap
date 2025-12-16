
*&---------------------------------------------------------------------*

*&  Include           ZEDR17_024_CLS

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

  methods handler_data_changed for event data_changed " ### ####

                              of cl_gui_alv_grid " ## #### ## ###

                              importing ER_DATA_CHANGED " ### #### (se24 -> cl_gui_grid## data_changed ### ## # ###### ##)

                                         E_ONF4

                                         E_ONF4_BEFORE

                                         E_ONF4_AFTER

                                         E_UCOMM.

  methods handler_data_changed_finished for event data_changed_finished

                                        of cl_gui_alv_grid

                                        importing E_MODIFIED

                                                  ET_GOOD_CELLS.



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

  method handler_data_changed.

    perform alv_handler_data_changed using ER_DATA_CHANGED

                                         E_ONF4

                                         E_ONF4_BEFORE

                                         E_ONF4_AFTER

                                         E_UCOMM.

  endmethod.

  method handler_data_changed_finished.

    perform alv_data_changed_finished using E_MODIFIED " #### 30# ##

                                            ET_GOOD_CELLS.

  endmethod.

endclass.               "event