
*&---------------------------------------------------------------------*

*&  Include           ZMM02_002_CLS

*&---------------------------------------------------------------------*




CLASS EVENT DEFINITION.

  PUBLIC SECTION.

  METHODS HANDLE_TOOLBAR FOR EVENT TOOLBAR

                         OF CL_GUI_ALV_GRID

                         IMPORTING E_OBJECT

                                   E_INTERACTIVE.

  METHODS HANDLE_USER_COMMAND FOR EVENT USER_COMMAND

                              OF CL_GUI_ALV_GRID

                              IMPORTING E_UCOMM.

  METHODS HANDLE_DATA_CHANGED FOR EVENT DATA_CHANGED "### ####

                          OF CL_GUI_ALV_GRID "### ###

                          IMPORTING ER_DATA_CHANGED

                                    E_ONF4

                                    E_ONF4_BEFORE

                                    E_ONF4_AFTER

                                    E_UCOMM.

ENDCLASS.

CLASS EVENT IMPLEMENTATION.

  METHOD HANDLE_TOOLBAR.

    PERFORM ALV_HANDLE_TOOLBAR USING E_OBJECT

                                     E_INTERACTIVE.

  ENDMETHOD.

  METHOD HANDLE_USER_COMMAND.

    PERFORM ALV_HANDLE_USER_COMMAND USING E_UCOMM.

  ENDMETHOD.

  METHOD HANDLE_DATA_CHANGED.

    PERFORM ALV_HANDLE_DATA_CHANGED USING ER_DATA_CHANGED

                                           E_ONF4

                                           E_ONF4_BEFORE

                                           E_ONF4_AFTER

                                           E_UCOMM.

  ENDMETHOD.

ENDCLASS.