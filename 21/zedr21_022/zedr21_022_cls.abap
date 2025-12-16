
*&---------------------------------------------------------------------*

*&  Include           ZEDR21_022_CLS

*&---------------------------------------------------------------------*




CLASS event DEFINITION.

  PUBLIC SECTION.

  METHODS handler_toolbar FOR EVENT toolbar

    of cl_gui_alv_grid

    IMPORTING e_object

      e_interactive.



  METHODS handler_user_command FOR EVENT user_command

    of cl_gui_alv_grid

    IMPORTING e_ucomm.



  METHODS HANDLE_HOTSPOT_CLICK FOR EVENT HOTSPOT_CLICK

                              OF CL_GUI_ALV_GRID

                              IMPORTING E_ROW_ID

                                        E_COLUMN_ID

                                        ES_ROW_NO.

  METHODS HANDLE_DOUBLE_CLICK FOR EVENT DOUBLE_CLICK

                              OF CL_GUI_ALV_GRID

                              IMPORTING E_ROW

                                        E_COLUMN

                                        ES_ROW_NO.

  METHODS HANDLER_DATA_CHANGED FOR EVENT DATA_CHANGED

                               OF CL_GUI_ALV_GRID

                               IMPORTING ER_DATA_CHANGED

                                         E_ONF4

                                         E_ONF4_BEFORE

                                         E_ONF4_AFTER

                                         E_UCOMM.



ENDCLASS.



CLASS event IMPLEMENTATION.

  METHOD handler_toolbar.

    PERFORM alv_handler_toolbar USING e_object

          e_interactive.



  ENDMETHOD.



  METHOD handler_user_command.

    PERFORM alv_handler_user_command USING e_ucomm.

  ENDMETHOD.

  METHOD HANDLE_HOTSPOT_CLICK.

  PERFORM ALV_HANDLE_HOTSPOT_CLICK USING E_ROW_ID

                                            E_COLUMN_ID

                                            ES_ROW_NO.

  ENDMETHOD.

  METHOD HANDLE_DOUBLE_CLICK.

    PERFORM ALV_HANDLE_DOUBLE_CLICK USING E_ROW

                                          E_COLUMN

                                          ES_ROW_NO.

  ENDMETHOD.

  METHOD HANDLER_DATA_CHANGED.

    PERFORM ALV_HANDLER_DATA_CHANGED USING ER_DATA_CHANGED

                                           E_ONF4

                                           E_ONF4_BEFORE

                                           E_ONF4_AFTER

                                           E_UCOMM.

    ENDMETHOD.

ENDCLASS.