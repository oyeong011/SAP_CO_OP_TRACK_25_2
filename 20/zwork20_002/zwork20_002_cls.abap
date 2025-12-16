
*&---------------------------------------------------------------------*

*&  Include           ZWORK20_002_CLS

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

ENDCLASS.

CLASS EVENT IMPLEMENTATION.

  METHOD HANDLE_TOOLBAR.

    PERFORM ALV_HANDLE_TOOLBAR USING E_OBJECT E_INTERACTIVE.

  ENDMETHOD.

  METHOD HANDLE_USER_COMMAND.

    PERFORM ALV_HANDLE_USERCMD USING E_UCOMM.

  ENDMETHOD.

ENDCLASS.