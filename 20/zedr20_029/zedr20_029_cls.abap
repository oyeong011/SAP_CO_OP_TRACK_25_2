
*&---------------------------------------------------------------------*

*&  Include           ZEDR20_029_CLS

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

ENDCLASS.

CLASS EVENT IMPLEMENTATION.

  METHOD HANDLE_TOOLBAR.

    PERFORM ALV_HANDLE_TOOLBAR USING E_OBJECT E_INTERACTIVE.

  ENDMETHOD.

  METHOD HANDLE_USER_COMMAND.

    PERFORM ALV_HANDLE_USER_COMMAND USING E_UCOMM.

  ENDMETHOD.

  METHOD HANDLE_HOTSPOT_CLICK.

    PERFORM ALV_HANDLE_HOTSPOT_CLICK USING E_ROW_ID E_COLUMN_ID ES_ROW_NO.

  ENDMETHOD.

  METHOD HANDLE_DOUBLE_CLICK.

    PERFORM ALV_HANDLE_DOUBLE_CLICK USING E_ROW E_COLUMN ES_ROW_NO.

  ENDMETHOD.

ENDCLASS.