
*&---------------------------------------------------------------------*

*&  Include           ZEDR15_032_CLS

*&---------------------------------------------------------------------*




CLASS EVENT DEFINITION. "###

  PUBLIC SECTION.

  METHODS HANDLER_TOOLBAR FOR EVENT TOOLBAR

                          OF CL_GUI_ALV_GRID

                          IMPORTING E_OBJECT

                                    E_INTERACTIVE.



  METHODS HANDLER_USER_COMMAND FOR EVENT USER_COMMAND

                               OF CL_GUI_ALV_GRID

                               IMPORTING E_UCOMM.



  METHODS HANDLER_HOTSPOT_CLICK FOR EVENT HOTSPOT_CLICK

                                OF CL_GUI_ALV_GRID

                                IMPORTING E_ROW_ID

                                          E_COLUMN_ID

                                          ES_ROW_NO.



  METHODS HANDLER_DOUBLE_CLICK FOR EVENT DOUBLE_CLICK

                               OF CL_GUI_ALV_GRID

                               IMPORTING E_ROW

                                         E_COLUMN

                                         ES_ROW_NO.

ENDCLASS.



CLASS EVENT IMPLEMENTATION.

  METHOD HANDLER_TOOLBAR.

    PERFORM ALV_HANDLER_TOOLBAR USING E_OBJECT

                                      E_INTERACTIVE.

  ENDMETHOD.



  METHOD HANDLER_USER_COMMAND.

    PERFORM ALV_HANDLER_USER_COMMAND USING E_UCOMM.

  ENDMETHOD.



  METHOD HANDLER_HOTSPOT_CLICK.

    PERFORM ALV_HANDLER_HOTSPOT_CLICK USING E_ROW_ID

                                            E_COLUMN_ID

                                            ES_ROW_NO.

  ENDMETHOD.



  METHOD HANDLER_DOUBLE_CLICK.

    PERFORM ALV_HANDLER_DOUBLE_CLICK USING E_ROW

                                           E_COLUMN

                                           ES_ROW_NO.

  ENDMETHOD.

ENDCLASS.